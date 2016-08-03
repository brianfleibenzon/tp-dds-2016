package edu.tp2016

import org.junit.Before
import org.uqbar.geodds.Point
import org.junit.Test
import org.junit.Assert
import edu.tp2016.pois.Banco
import edu.tp2016.serviciosExternos.banco.AdapterBanco
import edu.tp2016.serviciosExternos.banco.StubInterfazBanco
import java.util.Arrays
import java.util.List
import edu.tp2016.mod.DiaDeAtencion
import com.google.common.collect.Lists
import edu.tp2016.usuarios.Terminal

class TestBusquedaBanco {
	Terminal unaTerminal
	DiaDeAtencion unDiaX
	Point ubicacionX
	List<DiaDeAtencion> rangoX

	@Before
	def void setUp() {
		ubicacionX = new Point(-1, 1)
		rangoX = Arrays.asList(Lists.newArrayList(unDiaX))
		unaTerminal = new Terminal(ubicacionX,"servidorLocal")
		unaTerminal.interfacesExternas.add(new AdapterBanco(new StubInterfazBanco))
	}
	
	@Test
	def void buscarBancoLlamadoSantanderRío() {
		val bancoEncontrado = (unaTerminal.buscar("Santander Rio")).get(0) as Banco

		Assert.assertEquals("María Luna", bancoEncontrado.nombreGerente)
		Assert.assertTrue(bancoEncontrado.palabrasClave.contains("seguros"))
	}

	@Test
	def void buscarBancoLlamadoBancoDeLaPlazaYVerSiEstáSucursalAvellaneda() {
		val resultadoBusqueda = unaTerminal.buscar("Banco de la Plaza")
		val bancosEncontrados = resultadoBusqueda.map[ banco | banco as Banco ]
		
		Assert.assertTrue(bancosEncontrados.exists[ banco |
			(banco.sucursal.equals("Avellaneda")) && (banco.nombreGerente.equals("Javier Loeschbor")) ] )
	}

	@Test
	def void buscarBancoLlamadoBancoDeLaPlazaYVerSiEstáSucursalCaballito() {
		val resultadoBusqueda = unaTerminal.buscar("Banco de la Plaza")
		val bancosEncontrados = resultadoBusqueda.map[ banco | banco as Banco ]
		
		Assert.assertTrue(bancosEncontrados.exists[ banco |
			(banco.sucursal.equals("Caballito")) && (banco.palabrasClave.contains("transferencias")) ] )
	}

	@Test
	def void buscarBancoLlamadoGaliciaYQueDevuelvaListaVacía() {
		val resultadoBusqueda = unaTerminal.buscar("Galicia")
		
		Assert.assertTrue(resultadoBusqueda.empty)
	}
	
	}
