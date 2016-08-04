package edu.tp2016

import org.junit.Before
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
import edu.tp2016.usuarios.Terminal
import edu.tp2016.applicationModel.Buscador
import java.util.ArrayList
import edu.tp2016.pois.POI

class TestRegistroDeBusquedasConObservers {

	Buscador buscadorAbasto
	Buscador buscadorFlorida
	Buscador buscadorTeatroColon
	Buscador mockBuscador
	Terminal terminalAbasto
	Terminal terminalFlorida
	Terminal terminalTeatroColon
	Terminal mockTerminal
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
	ArrayList<POI> pois
	
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
			
		pois = Lists.newArrayList(utn7parada,
								  utn114parada,
								  miserere7parada,
								  comercioFarmacity,
								  comercioLoDeJuan)

		mockedMailSender = mock(typeof(MailSender))

		terminalAbasto = new Terminal("terminalAbasto") => [
			mailSender = mockedMailSender
			adscribirObserver(new RegistrarBusquedaObserver)
			adscribirObserver(new EnviarMailObserver(5))
		]
		terminalFlorida = new Terminal("terminalFlorida") => [
			mailSender = mockedMailSender
			adscribirObserver(new RegistrarBusquedaObserver)
			adscribirObserver(new EnviarMailObserver(5))
		]
		terminalTeatroColon = new Terminal("terminalTeatroColon") => [
			mailSender = mockedMailSender
			adscribirObserver(new RegistrarBusquedaObserver)
			adscribirObserver(new EnviarMailObserver(5))
		]
		
		buscadorFlorida = new Buscador() => [
			repo.agregarVariosPois(pois)
			interfacesExternas.addAll(new AdapterBanco(new StubInterfazBanco),
									  new AdapterCGP(new StubInterfazCGP))
			usuarioActual = terminalFlorida
		]
		buscadorAbasto = new Buscador() => [
			repo.agregarVariosPois(pois)
			interfacesExternas.addAll(new AdapterBanco(new StubInterfazBanco),
									  new AdapterCGP(new StubInterfazCGP))
			usuarioActual = terminalAbasto
		]
		buscadorTeatroColon = new Buscador() => [
			repo.agregarVariosPois(pois)
			interfacesExternas.addAll(new AdapterBanco(new StubInterfazBanco),
									  new AdapterCGP(new StubInterfazCGP))
			usuarioActual = terminalTeatroColon
		]

		// Setup para mockear demora excedida y envío de mail al administrador:
		mockTerminal = new Terminal("mockTerminal") => [
			mailSender = mockedMailSender
			adscribirObserver(new EnviarMailObserver(0))
		]
		mockBuscador = new Buscador() => [
			repo.create(utn7parada)
			usuarioActual = mockTerminal
		]
	}

	def busquedasEnVariasTerminalesYEnDistintasFechas() {
		buscadorAbasto.buscar("114") // encuentra
		buscadorAbasto.buscar("Banco Nacion") // no encuentra
		buscadorFlorida.buscar("plaza miserere") // encuentra
		buscadorFlorida.buscar("Libreria Juan") // encuentra
		buscadorTeatroColon.buscar("seguros") // encuentra
		buscadorTeatroColon.buscar("plaza miserere") // encuentra
		buscadorAbasto.fechaActual = unaFechaPasada
		buscadorFlorida.fechaActual = unaFechaPasada
		buscadorTeatroColon.fechaActual = unaFechaPasada
		buscadorAbasto.buscar("Banco de la Plaza") // encuentra
		buscadorAbasto.buscar("utn") // encuentra
		buscadorFlorida.buscar("Farmacity") // encuentra
		buscadorFlorida.buscar("facultad de medicina") // no encuentra 
		buscadorTeatroColon.buscar("Atencion ciudadana") // encuentra
		buscadorTeatroColon.buscar("cine") // no encuentra
		// En total 12 terminales
	}

	@Test
	def void testRegistroDeFrasesBuscadas() {
		buscadorAbasto.buscar("114")
		buscadorAbasto.buscar("7")
		buscadorFlorida.buscar("plaza miserere")
		buscadorFlorida.buscar("Libreria Juan")
		
		val frasesBuscadasDeAbasto = buscadorAbasto.busquedas
			.filter[ registro | registro.nombreUsuario == terminalAbasto.userName]
			.map[registro | registro.textoBuscado].toList
			
		val frasesBuscadasDeFlorida = buscadorFlorida.busquedas
			.filter[ registro | registro.nombreUsuario == terminalFlorida.userName]
			.map[registro | registro.textoBuscado].toList
			
		Assert.assertTrue(frasesBuscadasDeAbasto.containsAll(Arrays.asList("114","7"))
			&& frasesBuscadasDeFlorida.containsAll(Arrays.asList("plaza miserere","Libreria Juan"))
		)
	}

	@Test
	def void testRegistroDeCantidadDeResultadosDevueltos() {
		buscadorAbasto.buscar("utn")

		val cantResultadosRegistrada = buscadorAbasto.busquedas
			.filter[ registro | registro.nombreUsuario == terminalAbasto.userName]
			.map[registro | registro.cantidadDeResultados].toList.get(0)
		
		Assert.assertEquals( 3, cantResultadosRegistrada)	
	}

	@Test
	def void testRegistroDeDemoraDeConsulta() {
		buscadorAbasto.buscar("7")
		val demoraRegistrada = (buscadorAbasto.busquedas.head).demoraConsulta

		Assert.assertTrue(demoraRegistrada < (1).longValue())
	}

	@Test
	def void testRegistroDeDemoraDeConsultaConMailAlAdministrador() {
		mockBuscador.buscar("7")

		verify(mockedMailSender, times(1)).sendMail(any(typeof(Mail)))
	}

	// TODO: Hay que ver estas búsquedas y sus reportes
	/*@Test
	def void testReporteDeBusquedasPorFecha() {

		busquedasEnVariasTerminalesYEnDistintasFechas()

		val reporteGenerado = buscador.generarReporteCantidadTotalDeBusquedasPorFecha()

		Assert.assertEquals(6, reporteGenerado.get(fechaDeHoy.toDate))
		Assert.assertEquals(6, reporteGenerado.get(unaFechaPasada.toDate))
	}

	@Test
	def void testReporteDeResultadosParcialesPorTerminal() {
		busquedasEnVariasTerminalesYEnDistintasFechas()
		val reporteGenerado = buscador.generarReporteCantidadDeResultadosParcialesPorTerminal()

		Assert.assertEquals(Arrays.asList(1, 0, 2, 3), reporteGenerado.get("terminalAbasto"))
		Assert.assertEquals(Arrays.asList(1, 1, 1, 0), reporteGenerado.get("terminalFlorida"))
		Assert.assertEquals(Arrays.asList(3, 1, 1, 0), reporteGenerado.get("terminalTeatroColon"))

	}

	@Test
	def void testReporteDeResultadosParcialesDeTerminalEspecifica() {
		busquedasEnVariasTerminalesYEnDistintasFechas()
		val reporteGenerado = buscador.
			generarReporteCantidadDeResultadosParcialesDeUnaTerminalEspecifica("terminalAbasto")

		Assert.assertEquals(Arrays.asList(1, 0, 2, 3), reporteGenerado)

	}

	@Test
	def void testReporteDeResultadosTotalesPorTerminal() {
		busquedasEnVariasTerminalesYEnDistintasFechas()
		val reporteGenerado = buscador.generarReporteCantidadTotalDeResultadosPorTerminal()

		Assert.assertEquals(6, reporteGenerado.get("terminalAbasto"))
		Assert.assertEquals(3, reporteGenerado.get("terminalFlorida"))
		Assert.assertEquals(5, reporteGenerado.get("terminalTeatroColon"))

	}*/
}
