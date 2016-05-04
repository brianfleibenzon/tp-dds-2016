package edu.tp2016

import org.junit.Before
import org.uqbar.geodds.Point
import java.util.Arrays
import org.joda.time.LocalDateTime
import org.junit.Test
import org.junit.Assert
import edu.tp2016.pois.Banco
import edu.tp2016.interfacesExternas.banco.AdapterBanco
import edu.tp2016.interfacesExternas.banco.StubInterfazBanco

class TestBusquedaBanco {
	Dispositivo unDispositivo
	LocalDateTime fechaX
	Point ubicacionX
	
	@Before
	def void setUp() {
		ubicacionX = new Point(-1, 1)
		fechaX = new LocalDateTime()
		unDispositivo = new Dispositivo(ubicacionX, Arrays.asList(), fechaX)
		unDispositivo.interfacesExternas.add(new AdapterBanco(new StubInterfazBanco))	
	}
	
	@Test
	def void buscarBancoLlamadoSantanderRío() {
		val bancoEncontrado = (unDispositivo.buscar("Santander Rio")).get(0) as Banco

		Assert.assertEquals("María Luna", bancoEncontrado.nombreGerente)
		Assert.assertTrue(bancoEncontrado.palabrasClave.contains("seguros"))
	}

	@Test
	def void buscarBancoLlamadoBancoDeLaPlazaYVerSiEstáSucursalAvellaneda() {
		val resultadoBusqueda = unDispositivo.buscar("Banco de la Plaza")
		val bancosEncontrados = resultadoBusqueda.map[ banco | banco as Banco ]
		
		Assert.assertTrue(bancosEncontrados.exists[ banco |
			(banco.sucursal == "Avellaneda") && (banco.nombreGerente == "Javier Loeschbor") ] )
	}

	@Test
	def void buscarBancoLlamadoBancoDeLaPlazaYVerSiEstáSucursalCaballito() {
		val resultadoBusqueda = unDispositivo.buscar("Banco de la Plaza")
		val bancosEncontrados = resultadoBusqueda.map[ banco | banco as Banco ]
		
		Assert.assertTrue(bancosEncontrados.exists[ banco |
			(banco.sucursal == "Caballito") && (banco.palabrasClave.contains("transferencias")) ] )
	}

	@Test
	def void buscarBancoLlamadoGaliciaYQueDevuelvaListaVacía() {
		val resultadoBusqueda = unDispositivo.buscar("Galicia")
		
		Assert.assertTrue(resultadoBusqueda.empty)
	}
	
	}
