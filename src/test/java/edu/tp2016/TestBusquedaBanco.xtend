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
import edu.tp2016.pois.Comercio
import edu.tp2016.mod.Rubro
import java.util.List
import edu.tp2016.mod.DiaDeAtencion

class TestBusquedaBanco {
	ServidorLocal servidorLocal
	ServidorCentral servidorCentral
	Point ubicacionX
	
	Comercio comercioCerca
	Comercio comercioLejos	
	Rubro rubroTest
	List<String> clavesX
	List<DiaDeAtencion> rangoX
	
	@Before
	def void setUp() {
		ubicacionX = new Point(-1, 1)

		comercioCerca = new Comercio("test", new Point(-34.597768, -58.419860), clavesX, rubroTest, rangoX)

		comercioLejos = new Comercio("test", new Point(-34.597824, -58.423415), clavesX, rubroTest, rangoX)


		servidorCentral = new ServidorCentral(Arrays.asList(comercioCerca, comercioLejos))
		servidorCentral.interfacesExternas.add(new AdapterBanco(new StubInterfazBanco))
		servidorLocal = new ServidorLocal(ubicacionX,"servLocalGenerico", servidorCentral)
			
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
