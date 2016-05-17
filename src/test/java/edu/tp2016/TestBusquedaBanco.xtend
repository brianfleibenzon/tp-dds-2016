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
import java.util.List
import edu.tp2016.mod.DiaDeAtencion
import com.google.common.collect.Lists

class TestBusquedaBanco {
	ServidorLocal unServidorLocal
	ServidorCentral servidorCentral
	DiaDeAtencion unDiaX
	Point ubicacionX
	List<DiaDeAtencion> rangoX

	@Before
	def void setUp() {
		ubicacionX = new Point(-1, 1)
		rangoX = Arrays.asList(Lists.newArrayList(unDiaX))
		
		servidorCentral = new ServidorCentral(Arrays.asList())
		unServidorLocal = new ServidorLocal(ubicacionX,"servidorLocal",servidorCentral)
		
		servidorCentral.interfacesExternas.add(new AdapterBanco(new StubInterfazBanco))

	}
	
	@Test
	def void buscarBancoLlamadoSantanderRío() {
		val bancoEncontrado = (unServidorLocal.buscar("Santander Rio")).get(0) as Banco

		Assert.assertEquals("María Luna", bancoEncontrado.nombreGerente)
		Assert.assertTrue(bancoEncontrado.palabrasClave.contains("seguros"))
	}

	@Test
	def void buscarBancoLlamadoBancoDeLaPlazaYVerSiEstáSucursalAvellaneda() {
		val resultadoBusqueda = unServidorLocal.buscar("Banco de la Plaza")
		val bancosEncontrados = resultadoBusqueda.map[ banco | banco as Banco ]
		
		Assert.assertTrue(bancosEncontrados.exists[ banco |
			(banco.sucursal == "Avellaneda") && (banco.nombreGerente == "Javier Loeschbor") ] )
	}

	@Test
	def void buscarBancoLlamadoBancoDeLaPlazaYVerSiEstáSucursalCaballito() {
		val resultadoBusqueda = unServidorLocal.buscar("Banco de la Plaza")
		val bancosEncontrados = resultadoBusqueda.map[ banco | banco as Banco ]
		
		Assert.assertTrue(bancosEncontrados.exists[ banco |
			(banco.sucursal == "Caballito") && (banco.palabrasClave.contains("transferencias")) ] )
	}

	@Test
	def void buscarBancoLlamadoGaliciaYQueDevuelvaListaVacía() {
		val resultadoBusqueda = unServidorLocal.buscar("Galicia")
		
		Assert.assertTrue(resultadoBusqueda.empty)
	}
	
	}
