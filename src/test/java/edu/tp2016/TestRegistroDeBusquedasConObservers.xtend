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

class TestRegistroDeBusquedasConObservers {
	
	ServidorLocal terminalAbasto 
	ServidorLocal terminalFlorida
	ServidorLocal terminalTeatroColon
	ServidorCentral servidorCentral
	CantidadDeResultadosObserver cantResultadosObserver
	DemoraConsultaObserver demoraConsultaObserver
	FraseBuscadaObserver fraseBuscadaObserver
	Rubro rubroFarmacia
	Rubro rubroLibreria
	Comercio comercioFarmacity
	Comercio comercioLoDeJuan
	ParadaDeColectivo utn7parada
	ParadaDeColectivo miserere7parada
	ParadaDeColectivo utn114parada
	LocalDateTime fechaX
	DiaDeAtencion unDiaX
	Point ubicacionX
	List<DiaDeAtencion> rangoX
	
	
	@Before
	def void setUp(){
		ubicacionX = new Point(-1, 1)
		rangoX = Arrays.asList(Lists.newArrayList(unDiaX))
		fechaX = new LocalDateTime()

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
		
		servidorCentral.adscribirObserver(cantResultadosObserver)
		servidorCentral.adscribirObserver(demoraConsultaObserver)		
		servidorCentral.adscribirObserver(fraseBuscadaObserver)
		
		servidorCentral.inicializarTiempoLimiteDeBusqueda(10)

		terminalAbasto = new ServidorLocal(ubicacionX, "terminalAbasto", servidorCentral)
		
		terminalFlorida = new ServidorLocal(ubicacionX, "terminalFlorida", servidorCentral)
		
		terminalTeatroColon = new ServidorLocal(ubicacionX, "terminalTeatroColon", servidorCentral)
		
	}
	
	@Test
	def void testRegistroDeFrasesBuscadas(){
		terminalAbasto.buscar("libreria")
		terminalAbasto.buscar("rentas")
		terminalFlorida.buscar("114")
		terminalFlorida.buscar("plaza miserere")
		
		val frasesBuscadasDeAbasto = terminalAbasto.busquedasTerminal.map[ busqueda | busqueda.textoBuscado]
		val frasesBuscadasDeFlorida = terminalFlorida.busquedasTerminal.map[ busqueda | busqueda.textoBuscado]
		Assert.assertTrue(frasesBuscadasDeAbasto.containsAll(Arrays.asList("libreria","rentas")) &&
						  frasesBuscadasDeFlorida.containsAll(Arrays.asList("144","plaza miserere"))
		)
	}
		
	def void testRegistroDeCantidadDeResultadosDevueltos(){
		terminalAbasto.buscar("utn")
		
		val cantResultados = terminalAbasto.busquedasTerminal.map[ busqueda | busqueda.cantidadDeResultados ].get(0) 
		Assert.assertEquals(3,cantResultados)	
	}	
	
	def void testRegistroDeDemoraDeConsulta(){
		val demoraDeBusquedaEnSegundos = 11
		
	}
	
	def void testRegistroDeDemoraDeConsultaConMailAlAdministrador(){
		
	}
		
	def void testReporteDeBusquedasPorFecha(){
		terminalAbasto.buscar("rentas")
		terminalFlorida.buscar("114")
		val reporteGenerado= servidorCentral.generarReporteCantidadTotalDeBusquedasPorFecha()		
	}	
		
	def void testReporteDeResultadosParcialesPorTerminal(){
		
	}	

	def void testReporteDeResultadosParcialesDeTerminalEspecifica(){
		
	}	
	
	def void testReporteDeResultadosTotalesPorTerminal(){
		
	}	
	
	
	}	
	
	