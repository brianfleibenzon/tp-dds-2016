package edu.tp2016

import edu.tp2016.sistema.Sistema
import org.junit.Before
import org.junit.Test
import org.joda.time.LocalDateTime
import java.util.Arrays
import edu.tp2016.pois.ParadaDeColectivo
import edu.tp2016.pois.Comercio
import edu.tp2016.mod.Rubro
import org.uqbar.geodds.Point
import edu.tp2016.mod.DiaDeAtencion
import java.util.List
import edu.tp2016.serviciosExternos.banco.AdapterBanco
import edu.tp2016.serviciosExternos.cgp.AdapterCGP
import edu.tp2016.serviciosExternos.banco.StubInterfazBanco
import edu.tp2016.serviciosExternos.cgp.StubInterfazCGP
import com.google.common.collect.Lists
import org.junit.Assert
import edu.tp2016.sistema.decorators.SistemaConAlertaAAdministrador
import edu.tp2016.sistema.decorators.SistemaConRegistroDeBusqueda
import edu.tp2016.sistema.Terminal

import static org.mockito.Matchers.*
import static org.mockito.Mockito.*
import org.mockito.ArgumentMatcher
import edu.tp2016.serviciosExternos.MailSender

class TestSistemaConRegistroYAlerta {
	Sistema unSistema
	SistemaConRegistroDeBusqueda unSistemaConRegistro
	SistemaConAlertaAAdministrador unSistemaConAlerta
	LocalDateTime fechaX
	Rubro rubroFarmacia
	Rubro rubroLibreria
	Comercio comercioFarmacity
	Comercio comercioLoDeJuan
	ParadaDeColectivo utn7parada
	ParadaDeColectivo miserere7parada
	ParadaDeColectivo utn114parada
	DiaDeAtencion unDiaX
	Point ubicacionX
	List<DiaDeAtencion> rangoX
	Terminal terminalAbasto
	Terminal terminalFlorida
	Terminal terminalTeatroColon
	MailSender mockedMailSender	

	@Before
	def void setUp() {
		fechaX = new LocalDateTime()

		rangoX = Arrays.asList(Lists.newArrayList(unDiaX))

		utn7parada = new ParadaDeColectivo("7", ubicacionX, Arrays.asList("utn", "campus"))

		miserere7parada = new ParadaDeColectivo("7", ubicacionX, Arrays.asList("utn", "plaza miserere", "once"))

		utn114parada = new ParadaDeColectivo("114", ubicacionX, Arrays.asList("utn", "campus"))

		rubroFarmacia = new Rubro("Farmacia", 1)

		rubroLibreria = new Rubro("Libreria", 2)

		comercioFarmacity = new Comercio("Farmacity", ubicacionX, Arrays.asList("medicamentos", "salud"), rubroFarmacia,
			rangoX)

		comercioLoDeJuan = new Comercio("Libreria Juan", ubicacionX, Arrays.asList("fotocopias", "utiles", "libros"),
			rubroLibreria, rangoX)

		unSistema = new Sistema(Arrays.asList(), fechaX)

		unSistema.repo.create(utn7parada)
		unSistema.repo.create(utn114parada)
		unSistema.repo.create(miserere7parada)
		unSistema.repo.create(comercioFarmacity)
		unSistema.repo.create(comercioLoDeJuan)

		unSistema.interfacesExternas.add(new AdapterBanco(new StubInterfazBanco))
		unSistema.interfacesExternas.add(new AdapterCGP(new StubInterfazCGP))
		
		mockedMailSender = mock(typeof(MailSender))
		
		unSistemaConAlerta = new SistemaConAlertaAAdministrador(unSistema, mockedMailSender)
		
		unSistemaConRegistro = new SistemaConRegistroDeBusqueda(
			unSistemaConAlerta
		) => [
			fechaActual = fechaX
		]
		
		terminalAbasto = new Terminal("terminalAbasto", ubicacionX, unSistemaConRegistro, fechaX)
		terminalFlorida = new Terminal("terminalFlorida", ubicacionX, unSistemaConRegistro, fechaX)		
		terminalTeatroColon = new Terminal("terminalTeatroColon", ubicacionX, unSistemaConRegistro, fechaX)
	}

	@Test
	def void testRegistroDeFrasesBuscadas(){
		terminalAbasto.buscar("114")
		terminalAbasto.buscar("7")
		terminalFlorida.buscar("plaza miserere")
		terminalFlorida.buscar("Libreria Juan")
		
		val frasesBuscadasDeAbasto = unSistemaConRegistro.busquedas
			.filter[ registro | registro.terminal == terminalAbasto.nombreTerminal]
			.map[registro | registro.busqueda].toList
			
		val frasesBuscadasDeFlorida = unSistemaConRegistro.busquedas
			.filter[ registro | registro.terminal == terminalFlorida.nombreTerminal]
			.map[registro | registro.busqueda].toList
			
		Assert.assertTrue(frasesBuscadasDeAbasto.containsAll(Arrays.asList("114","7"))
			&& frasesBuscadasDeFlorida.containsAll(Arrays.asList("plaza miserere","Libreria Juan"))
		)
	}	
	
	@Test
	def void testRegistroDeCantidadDeResultadosDevueltos(){
		terminalAbasto.buscar("utn")
		
		val cantResultadosRegistrada = unSistemaConRegistro.busquedas
			.filter[ registro | registro.terminal == terminalAbasto.nombreTerminal]
			.map[registro | registro.resultados].toList.get(0)
		
		Assert.assertEquals( 3, cantResultadosRegistrada)	
	}	
	
	@Test	
	def void testReporteDeBusquedasPorFecha(){
		terminalAbasto.buscar("Farmacia")
		terminalFlorida.buscar("114")
		terminalTeatroColon.buscar("plaza miserere")
		
		val reporteGenerado = unSistemaConRegistro.generarReportePorFecha()
		
		Assert.assertEquals( 3, reporteGenerado.get(fechaX.toLocalDate))
	}	
	
	@Test	
	def void testEnvioMail(){
		terminalAbasto.timeout = 0
		terminalAbasto.buscar("Farmacia")
		verify(mockedMailSender, times(1)).send(any(typeof(String)))
	}
}
