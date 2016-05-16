package edu.tp2016

import org.junit.Before
import org.uqbar.geodds.Point
import org.junit.Test
import org.junit.Assert
import edu.tp2016.pois.Banco
import edu.tp2016.serviciosExternos.banco.AdapterBanco
import edu.tp2016.serviciosExternos.banco.StubInterfazBanco
import edu.tp2016.servidores.ServidorLocal
import edu.tp2016.servidores.ServidorCentral
import java.util.Arrays

class TestBusquedaBanco {
	ServidorLocal servidorLocal
	ServidorCentral servidorCentral
	Point ubicacionX
	Banco banco
	
	@Before
	def void setUp() {
		ubicacionX = new Point(-1, 1)
		servidorCentral = new ServidorCentral(Arrays.asList())
		servidorLocal = new ServidorLocal(ubicacionX,"servLocalGenerico", servidorCentral)
		servidorCentral.interfacesExternas.add(new AdapterBanco(new StubInterfazBanco))	
	}
	
	@Test
	def void buscarBancoLlamadoSantanderRío() {
		val bancoEncontrado = (servidorLocal.buscar("Santander Rio")).get(0) as Banco

		Assert.assertEquals("María Luna", bancoEncontrado.nombreGerente)
		Assert.assertTrue(bancoEncontrado.palabrasClave.contains("seguros"))
	}

	@Test
	def void buscarBancoLlamadoBancoDeLaPlazaYVerSiEstáSucursalAvellaneda() {
		val resultadoBusqueda = servidorLocal.buscar("Banco de la Plaza")
		val bancosEncontrados = resultadoBusqueda.map[ banco | banco as Banco ]
		
		Assert.assertTrue(bancosEncontrados.exists[ banco |
			(banco.sucursal == "Avellaneda") && (banco.nombreGerente == "Javier Loeschbor") ] )
	}

	@Test
	def void buscarBancoLlamadoBancoDeLaPlazaYVerSiEstáSucursalCaballito() {
		val resultadoBusqueda = servidorLocal.buscar("Banco de la Plaza")
		val bancosEncontrados = resultadoBusqueda.map[ banco | banco as Banco ]
		
		Assert.assertTrue(bancosEncontrados.exists[ banco |
			(banco.sucursal == "Caballito") && (banco.palabrasClave.contains("transferencias")) ] )
	}

	@Test
	def void buscarBancoLlamadoGaliciaYQueDevuelvaListaVacía() {
		val resultadoBusqueda = servidorLocal.buscar("Galicia")
		
		Assert.assertTrue(resultadoBusqueda.empty)
	}
	
	}
