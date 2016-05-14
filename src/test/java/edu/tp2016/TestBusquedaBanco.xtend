package edu.tp2016

import org.junit.Before
import java.util.Arrays
import org.joda.time.LocalDateTime
import org.junit.Test
import org.junit.Assert
import edu.tp2016.pois.Banco
import edu.tp2016.serviciosExternos.banco.AdapterBanco
import edu.tp2016.serviciosExternos.banco.StubInterfazBanco
import edu.tp2016.sistema.Sistema

class TestBusquedaBanco {
	Sistema unSistema
	LocalDateTime fechaX
	
	@Before
	def void setUp() {
		fechaX = new LocalDateTime()
		unSistema = new Sistema(Arrays.asList(), fechaX)
		unSistema.interfacesExternas.add(new AdapterBanco(new StubInterfazBanco))	
	}
	
	@Test
	def void buscarBancoLlamadoSantanderRío() {
		val bancoEncontrado = (unSistema.buscar("Santander Rio")).get(0) as Banco

		Assert.assertEquals("María Luna", bancoEncontrado.nombreGerente)
		Assert.assertTrue(bancoEncontrado.palabrasClave.contains("seguros"))
	}

	@Test
	def void buscarBancoLlamadoBancoDeLaPlazaYVerSiEstáSucursalAvellaneda() {
		val resultadoBusqueda = unSistema.buscar("Banco de la Plaza")
		val bancosEncontrados = resultadoBusqueda.map[ banco | banco as Banco ]
		
		Assert.assertTrue(bancosEncontrados.exists[ banco |
			(banco.sucursal == "Avellaneda") && (banco.nombreGerente == "Javier Loeschbor") ] )
	}

	@Test
	def void buscarBancoLlamadoBancoDeLaPlazaYVerSiEstáSucursalCaballito() {
		val resultadoBusqueda = unSistema.buscar("Banco de la Plaza")
		val bancosEncontrados = resultadoBusqueda.map[ banco | banco as Banco ]
		
		Assert.assertTrue(bancosEncontrados.exists[ banco |
			(banco.sucursal == "Caballito") && (banco.palabrasClave.contains("transferencias")) ] )
	}

	@Test
	def void buscarBancoLlamadoGaliciaYQueDevuelvaListaVacía() {
		val resultadoBusqueda = unSistema.buscar("Galicia")
		
		Assert.assertTrue(resultadoBusqueda.empty)
	}
	
	}
