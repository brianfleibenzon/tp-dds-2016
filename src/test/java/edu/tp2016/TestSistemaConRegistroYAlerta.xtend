package edu.tp2016

import com.google.common.collect.Lists
import edu.tp2016.Builder.BuilderParada
import edu.tp2016.mod.DiaDeAtencion
import edu.tp2016.mod.Rubro
import edu.tp2016.pois.Comercio
import edu.tp2016.pois.ParadaDeColectivo
import edu.tp2016.serviciosExternos.banco.AdapterBanco
import edu.tp2016.serviciosExternos.banco.StubInterfazBanco
import edu.tp2016.serviciosExternos.cgp.AdapterCGP
import edu.tp2016.serviciosExternos.cgp.StubInterfazCGP
import edu.tp2016.sistema.Sistema
import edu.tp2016.sistema.Terminal
import edu.tp2016.sistema.decorators.SistemaConAlertaAAdministrador
import edu.tp2016.sistema.decorators.SistemaConRegistroDeBusqueda
import java.util.Arrays
import java.util.List
import org.joda.time.LocalDateTime
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point
import edu.tp2016.Builder.BuilderComercio

class TestSistemaConRegistroYAlerta {
	Sistema unSistema
	SistemaConRegistroDeBusqueda unSistemaConRegistro
	LocalDateTime fechaX
	Rubro rubroFarmacia
	Rubro rubroLibreria
	DiaDeAtencion unDiaX
	Point ubicacionX
	List<DiaDeAtencion> rangoX
	Terminal terminalAbasto
	Terminal terminalFlorida
	Terminal terminalTeatroColon	
	/*Builder */
	ParadaDeColectivo utn7parada
	ParadaDeColectivo miserere7parada
	ParadaDeColectivo utn114parada
	Comercio comercioFarmacity
	Comercio comercioLoDeJuan	
	
	@Before
	def void setUp() {
		fechaX = new LocalDateTime()

		rangoX = Arrays.asList(Lists.newArrayList(unDiaX))

		utn7parada = new BuilderParada().nombre("7")
						.ubicacion(ubicacionX)
						.claves(Arrays.asList("utn", "campus"))
						.build

		miserere7parada= new BuilderParada().nombre("7")
							.ubicacion(ubicacionX)
							.claves(Arrays.asList("utn","plaza miserere" , "once"))
							.build
		utn114parada = new BuilderParada().nombre("114")
										  .ubicacion(ubicacionX)
										  .claves(Arrays.asList("utn","campus"))
										  .build
		rubroFarmacia = new Rubro("Farmacia", 1)

		rubroLibreria = new Rubro("Libreria", 2)

		comercioFarmacity = new BuilderComercio().nombre("Farmacity")
												 .ubicacion(ubicacionX)
												 .claves(Arrays.asList("medicamentos", "salud"))
												 .rubro(rubroFarmacia)
												 .rango(rangoX)
												 .build
		
		comercioLoDeJuan = new BuilderComercio().nombre("Libreria Juan")
												.ubicacion(ubicacionX)
												.claves(Arrays.asList("fotocopias", "utiles", "libros"))
												.rubro(rubroLibreria)
												.rango(rangoX)
												.build												
	

		unSistema = new Sistema(Arrays.asList(), fechaX)

		unSistema.repo.create(utn7parada)
		unSistema.repo.create(utn114parada)
		unSistema.repo.create(miserere7parada)
		unSistema.repo.create(comercioFarmacity)
		unSistema.repo.create(comercioLoDeJuan)

		unSistema.interfacesExternas.add(new AdapterBanco(new StubInterfazBanco))
		unSistema.interfacesExternas.add(new AdapterCGP(new StubInterfazCGP))

		unSistemaConRegistro = new SistemaConRegistroDeBusqueda(
			new SistemaConAlertaAAdministrador(unSistema)
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
}
