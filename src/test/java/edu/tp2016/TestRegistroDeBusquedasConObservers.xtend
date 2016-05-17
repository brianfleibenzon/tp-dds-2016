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
import edu.tp2016.observersBusqueda.CantidadDeResultadosObserver
import edu.tp2016.observersBusqueda.DemoraConsultaObserver
import edu.tp2016.observersBusqueda.FraseBuscadaObserver
import edu.tp2016.observersBusqueda.StubDemoraConsultaObserver

class TestRegistroDeBusquedasConObservers {
	
	ServidorLocal terminalAbasto 
	ServidorLocal terminalFlorida
	ServidorLocal terminalTeatroColon
	ServidorLocal terminalAbastoEnFechaPasada
	ServidorLocal terminalFloridaEnFechaPasada
	ServidorLocal terminalTeatroColonEnFechaPasada
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
	
	
	@Before
	def void setUp(){
		ubicacionX = new Point(-1, 1)
		rangoX = Arrays.asList(Lists.newArrayList(unDiaX))
		fechaDeHoy = new LocalDateTime()
		unaFechaPasada = new LocalDateTime(2016, 5, 11, 12, 0)

		utn7parada = new ParadaDeColectivo("7", ubicacionX, Arrays.asList("utn", "campus"))
		miserere7parada = new ParadaDeColectivo("7", ubicacionX, Arrays.asList("utn", "plaza miserere", "once"))
		utn114parada = new ParadaDeColectivo("114", ubicacionX, Arrays.asList("utn", "campus"))
		rubroFarmacia = new Rubro("Farmacia", 1)
		rubroLibreria = new Rubro("Libreria", 2)
		comercioFarmacity = new Comercio("Farmacity", ubicacionX, Arrays.asList("medicamentos", "salud"), rubroFarmacia,
			rangoX)
		comercioLoDeJuan = new Comercio("Libreria Juan", ubicacionX, Arrays.asList("fotocopias", "utiles", "libros"),
			rubroLibreria, rangoX)
		
		servidorCentral = new ServidorCentral(Arrays.asList())

		servidorCentral.repo.create(utn7parada)
		servidorCentral.repo.create(utn114parada)
		servidorCentral.repo.create(miserere7parada)
		servidorCentral.repo.create(comercioFarmacity)
		servidorCentral.repo.create(comercioLoDeJuan)
		
		servidorCentral.interfacesExternas.add(new AdapterBanco(new StubInterfazBanco))
		servidorCentral.interfacesExternas.add(new AdapterCGP(new StubInterfazCGP))
		
		servidorCentral.adscribirObserver(new CantidadDeResultadosObserver)
		servidorCentral.adscribirObserver(new FraseBuscadaObserver)		
		servidorCentral.adscribirObserver(new DemoraConsultaObserver)
		
		servidorCentral.inicializarTiempoLimiteDeBusqueda(5)

		terminalAbasto = new ServidorLocal(ubicacionX, "terminalAbasto", servidorCentral)
		terminalFlorida = new ServidorLocal(ubicacionX, "terminalFlorida", servidorCentral)
		terminalTeatroColon = new ServidorLocal(ubicacionX, "terminalTeatroColon", servidorCentral)
		terminalAbastoEnFechaPasada = new ServidorLocal(ubicacionX, "terminalAbasto", servidorCentral, unaFechaPasada)
		terminalFloridaEnFechaPasada = new ServidorLocal(ubicacionX, "terminalFlorida", servidorCentral, unaFechaPasada)
		terminalTeatroColonEnFechaPasada = new ServidorLocal(ubicacionX, "terminalTeatroColon", servidorCentral, unaFechaPasada)
		
		// Setup para mockear:
		mockServidorCentral = new ServidorCentral(Arrays.asList())
		mockServidorCentral.repo.create(utn7parada)
		mockServidorCentral.adscribirObserver(new StubDemoraConsultaObserver)
		mockServidorCentral.inicializarTiempoLimiteDeBusqueda(10)
		mockTerminal = new ServidorLocal(ubicacionX, "mockTerminal", mockServidorCentral)
	}
	

	def busquedasEnVariasTerminalesYEnDistintasFechas(){
		terminalAbasto.buscar("114") // encuentra
		terminalAbasto.buscar("Banco Nacion") // no encuentra
		terminalFlorida.buscar("plaza miserere") // encuentra
		terminalFlorida.buscar("Libreria Juan") // encuentra
		terminalTeatroColon.buscar("seguros") // encuentra
		terminalTeatroColon.buscar("plaza miserere") // encuentra
		terminalAbastoEnFechaPasada.buscar("Banco de la Plaza") // encuentra
		terminalAbastoEnFechaPasada.buscar("utn") // encuentra
		terminalFloridaEnFechaPasada.buscar("Farmacity") // encuentra
		terminalFloridaEnFechaPasada.buscar("facultad de medicina") // no encuentra 
		terminalTeatroColonEnFechaPasada.buscar("Atencion ciudadana") // encuentra
		terminalTeatroColonEnFechaPasada.buscar("cine") // no encuentra
		// En total 12 terminales
		}
	
	@Test
	def void testRegistroDeFrasesBuscadas(){
		terminalAbasto.buscar("114")
		terminalAbasto.buscar("7")
		terminalFlorida.buscar("plaza miserere")
		terminalFlorida.buscar("Libreria Juan")
		
		val frasesBuscadasDeAbasto = terminalAbasto.busquedasTerminal.map[ busqueda | busqueda.textoBuscado]
		val frasesBuscadasDeFlorida = terminalFlorida.busquedasTerminal.map[ busqueda | busqueda.textoBuscado]
		
		Assert.assertTrue(frasesBuscadasDeAbasto.containsAll(Arrays.asList("114","7"))
					   && frasesBuscadasDeFlorida.containsAll(Arrays.asList("plaza miserere","Libreria Juan"))
		)
	}	
	
	@Test
	def void testRegistroDeCantidadDeResultadosDevueltos(){
		terminalAbasto.buscar("utn")
		
		val cantResultadosRegistrada = terminalAbasto.busquedasTerminal.map[ busqueda
			| busqueda.cantidadDeResultados].get(0)
		 
		Assert.assertEquals( 3, cantResultadosRegistrada)	
	}	
	
	@Test	
	def void testRegistroDeDemoraDeConsulta(){
		terminalAbasto.buscar("7")
		val demoraRegistrada = (terminalAbasto.busquedasTerminal.head).demoraConsulta
		
		Assert.assertTrue( demoraRegistrada < (1).longValue())	
		}

	@Test
	def void testRegistroDeDemoraDeConsultaConMailAlAdministrador(){
		mockTerminal.buscar("7")
		val demoraConsulta = (mockTerminal.busquedasTerminal.head).demoraConsulta
		
		Assert.assertEquals((11).longValue(), demoraConsulta)
		// TODO: mockear el envío de mail al admin
	}
	
	@Test	
	def void testReporteDeBusquedasPorFecha(){
		
		busquedasEnVariasTerminalesYEnDistintasFechas()
	
		val reporteGenerado = servidorCentral.generarReporteCantidadTotalDeBusquedasPorFecha()
		
		Assert.assertEquals( 6, reporteGenerado.get(fechaDeHoy.toDate))
		Assert.assertEquals( 6, reporteGenerado.get(unaFechaPasada.toDate))
	}	
	
	@Test	
	def void testReporteDeResultadosParcialesPorTerminal(){
		
		busquedasEnVariasTerminalesYEnDistintasFechas()
		
	}	
	
	// Test auxiliar para ver si anda esta función
	@Test	
	def void testObtenerBusquedasDeTerminalesAReportar(){
		
	busquedasEnVariasTerminalesYEnDistintasFechas()
	
	val cantidadDeTerminalesAReportar = (servidorCentral.obtenerBusquedasDeTerminalesAReportar()).size
	Assert.assertEquals( 12, cantidadDeTerminalesAReportar)
		
	}
	
	@Test
	def void testReporteDeResultadosParcialesDeTerminalEspecifica(){
		
		busquedasEnVariasTerminalesYEnDistintasFechas()
		
	}	
	
	@Test
	def void testReporteDeResultadosTotalesPorTerminal(){
		
		busquedasEnVariasTerminalesYEnDistintasFechas()
		
	}	
}	

	