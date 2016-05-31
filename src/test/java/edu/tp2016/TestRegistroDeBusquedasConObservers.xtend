package edu.tp2016

import org.junit.Before
import edu.tp2016.servidores.ServidorLocal
import edu.tp2016.servidores.ServidorCentral
import edu.tp2016.mod.Rubro
import edu.tp2016.pois.Comercio
import edu.tp2016.pois.ParadaDeColectivo
import edu.tp2016.mod.DiaDeAtencion
import java.util.List
import java.util.Arrays
import org.joda.time.LocalDateTime
import com.google.common.collect.Lists
import org.uqbar.geodds.Point
import edu.tp2016.serviciosExternos.banco.AdapterBanco
import edu.tp2016.serviciosExternos.cgp.StubInterfazCGP
import edu.tp2016.serviciosExternos.banco.StubInterfazBanco
import edu.tp2016.serviciosExternos.cgp.AdapterCGP
import org.junit.Assert
import org.junit.Test
import edu.tp2016.builder.ParadaBuilder
import edu.tp2016.builder.ComercioBuilder
import edu.tp2016.serviciosExternos.MailSender
import static org.mockito.Matchers.*
import static org.mockito.Mockito.*
import edu.tp2016.serviciosExternos.Mail
import edu.tp2016.observersBusqueda.RegistrarBusquedaObserver
import edu.tp2016.observersBusqueda.EnviarMailObserver

class TestRegistroDeBusquedasConObservers {

	ServidorLocal terminalAbasto
	ServidorLocal terminalFlorida
	ServidorLocal terminalTeatroColon
	ServidorCentral servidorCentral
	ServidorCentral mockServidorCentral
	ServidorLocal mockTerminal
	Rubro rubroFarmacia
	Rubro rubroLibreria
	Comercio comercioFarmacity
	Comercio comercioLoDeJuan
	ParadaDeColectivo utn7parada
	ParadaDeColectivo miserere7parada
	ParadaDeColectivo utn114parada
	LocalDateTime fechaDeHoy
	LocalDateTime unaFechaPasada
	DiaDeAtencion unDiaX
	Point ubicacionX
	List<DiaDeAtencion> rangoX
	
	MailSender mockedMailSender

	@Before
	def void setUp() {
		ubicacionX = new Point(-1, 1)
		rangoX = Arrays.asList(Lists.newArrayList(unDiaX))
		fechaDeHoy = new LocalDateTime()
		unaFechaPasada = new LocalDateTime(2016, 5, 11, 12, 0)

		utn7parada = new ParadaBuilder().nombre("7").ubicacion(ubicacionX).claves(Arrays.asList("utn", "campus")).build

		miserere7parada = new ParadaBuilder().nombre("7").ubicacion(ubicacionX).claves(
			Arrays.asList("utn", "plaza miserere", "once")).build

		utn114parada = new ParadaBuilder().nombre("114").ubicacion(ubicacionX).claves(Arrays.asList("utn", "campus")).
			build

		rubroFarmacia = new Rubro("Farmacia", 1)
		rubroLibreria = new Rubro("Libreria", 2)

		comercioFarmacity = new ComercioBuilder().nombre("Farmacity").ubicacion(ubicacionX).claves(
			Arrays.asList("medicamentos", "salud")).rubro(rubroFarmacia).rango(rangoX).build

		comercioLoDeJuan = new ComercioBuilder().nombre("Libreria Juan").ubicacion(ubicacionX).claves(
			Arrays.asList("fotocopias", "utiles", "libros")).rubro(rubroLibreria).rango(rangoX).build

		servidorCentral = new ServidorCentral(Arrays.asList())

		servidorCentral.repo.create(utn7parada)
		servidorCentral.repo.create(utn114parada)
		servidorCentral.repo.create(miserere7parada)
		servidorCentral.repo.create(comercioFarmacity)
		servidorCentral.repo.create(comercioLoDeJuan)

		servidorCentral.interfacesExternas.add(new AdapterBanco(new StubInterfazBanco))
		servidorCentral.interfacesExternas.add(new AdapterCGP(new StubInterfazCGP))

		terminalAbasto = new ServidorLocal(ubicacionX, "terminalAbasto", servidorCentral, fechaDeHoy)
		terminalFlorida = new ServidorLocal(ubicacionX, "terminalFlorida", servidorCentral, fechaDeHoy)
		terminalTeatroColon = new ServidorLocal(ubicacionX, "terminalTeatroColon", servidorCentral, fechaDeHoy)

		mockedMailSender = mock(typeof(MailSender))

		terminalAbasto.adscribirObserver(new RegistrarBusquedaObserver)
		terminalAbasto.adscribirObserver(new EnviarMailObserver(5, mockedMailSender))

		terminalTeatroColon.adscribirObserver(new RegistrarBusquedaObserver)
		terminalTeatroColon.adscribirObserver(new EnviarMailObserver(5, mockedMailSender))

		terminalFlorida.adscribirObserver(new RegistrarBusquedaObserver)
		terminalFlorida.adscribirObserver(new EnviarMailObserver(5, mockedMailSender))

		// Setup para mockear demora excedida y envío de mail al administrador:
		mockServidorCentral = new ServidorCentral(Arrays.asList())
		mockServidorCentral.repo.create(utn7parada)
		mockTerminal = new ServidorLocal(ubicacionX, "mockTerminal", mockServidorCentral)
		mockTerminal.adscribirObserver(new EnviarMailObserver(0, mockedMailSender))
	}

	def busquedasEnVariasTerminalesYEnDistintasFechas() {
		terminalAbasto.buscar("114") // encuentra
		terminalAbasto.buscar("Banco Nacion") // no encuentra
		terminalFlorida.buscar("plaza miserere") // encuentra
		terminalFlorida.buscar("Libreria Juan") // encuentra
		terminalTeatroColon.buscar("seguros") // encuentra
		terminalTeatroColon.buscar("plaza miserere") // encuentra
		terminalAbasto.fechaActual = unaFechaPasada
		terminalFlorida.fechaActual = unaFechaPasada
		terminalTeatroColon.fechaActual = unaFechaPasada
		terminalAbasto.buscar("Banco de la Plaza") // encuentra
		terminalAbasto.buscar("utn") // encuentra
		terminalFlorida.buscar("Farmacity") // encuentra
		terminalFlorida.buscar("facultad de medicina") // no encuentra 
		terminalTeatroColon.buscar("Atencion ciudadana") // encuentra
		terminalTeatroColon.buscar("cine") // no encuentra
		// En total 12 terminales
	}

	@Test
	def void testRegistroDeFrasesBuscadas() {
		terminalAbasto.buscar("114")
		terminalAbasto.buscar("7")
		terminalFlorida.buscar("plaza miserere")
		terminalFlorida.buscar("Libreria Juan")
		
		val frasesBuscadasDeAbasto = servidorCentral.busquedas
			.filter[ registro | registro.nombreTerminal == terminalAbasto.nombreTerminal]
			.map[registro | registro.textoBuscado].toList
			
		val frasesBuscadasDeFlorida = servidorCentral.busquedas
			.filter[ registro | registro.nombreTerminal == terminalFlorida.nombreTerminal]
			.map[registro | registro.textoBuscado].toList
			
		Assert.assertTrue(frasesBuscadasDeAbasto.containsAll(Arrays.asList("114","7"))
			&& frasesBuscadasDeFlorida.containsAll(Arrays.asList("plaza miserere","Libreria Juan"))
		)
	}

	@Test
	def void testRegistroDeCantidadDeResultadosDevueltos() {
		terminalAbasto.buscar("utn")

		val cantResultadosRegistrada = servidorCentral.busquedas
			.filter[ registro | registro.nombreTerminal == terminalAbasto.nombreTerminal]
			.map[registro | registro.cantidadDeResultados].toList.get(0)
		
		Assert.assertEquals( 3, cantResultadosRegistrada)	
	}

	@Test
	def void testRegistroDeDemoraDeConsulta() {
		terminalAbasto.buscar("7")
		val demoraRegistrada = (servidorCentral.busquedas.head).demoraConsulta

		Assert.assertTrue(demoraRegistrada < (1).longValue())
	}

	@Test
	def void testRegistroDeDemoraDeConsultaConMailAlAdministrador() {
		mockTerminal.buscar("7")

		verify(mockedMailSender, times(1)).sendMail(any(typeof(Mail)))
	}

	@Test
	def void testReporteDeBusquedasPorFecha() {

		busquedasEnVariasTerminalesYEnDistintasFechas()

		val reporteGenerado = servidorCentral.generarReporteCantidadTotalDeBusquedasPorFecha()

		Assert.assertEquals(6, reporteGenerado.get(fechaDeHoy.toDate))
		Assert.assertEquals(6, reporteGenerado.get(unaFechaPasada.toDate))
	}

	@Test
	def void testReporteDeResultadosParcialesPorTerminal() {
		busquedasEnVariasTerminalesYEnDistintasFechas()
		val reporteGenerado = servidorCentral.generarReporteCantidadDeResultadosParcialesPorTerminal()

		Assert.assertEquals(Arrays.asList(1, 0, 2, 3), reporteGenerado.get("terminalAbasto"))
		Assert.assertEquals(Arrays.asList(1, 1, 1, 0), reporteGenerado.get("terminalFlorida"))
		Assert.assertEquals(Arrays.asList(3, 1, 1, 0), reporteGenerado.get("terminalTeatroColon"))

	}

	@Test
	def void testReporteDeResultadosParcialesDeTerminalEspecifica() {
		busquedasEnVariasTerminalesYEnDistintasFechas()
		val reporteGenerado = servidorCentral.
			generarReporteCantidadDeResultadosParcialesDeUnaTerminalEspecifica("terminalAbasto")

		Assert.assertEquals(Arrays.asList(1, 0, 2, 3), reporteGenerado)

	}

	@Test
	def void testReporteDeResultadosTotalesPorTerminal() {
		busquedasEnVariasTerminalesYEnDistintasFechas()
		val reporteGenerado = servidorCentral.generarReporteCantidadTotalDeResultadosPorTerminal()

		Assert.assertEquals(6, reporteGenerado.get("terminalAbasto"))
		Assert.assertEquals(3, reporteGenerado.get("terminalFlorida"))
		Assert.assertEquals(5, reporteGenerado.get("terminalTeatroColon"))

	}
}
