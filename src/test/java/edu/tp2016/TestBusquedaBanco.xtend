package edu.tp2016

import org.junit.Before
import org.junit.Test
import org.junit.Assert
import edu.tp2016.pois.Banco
import edu.tp2016.serviciosExternos.banco.AdapterBanco
import edu.tp2016.serviciosExternos.banco.StubInterfazBanco
import edu.tp2016.usuarios.Terminal
import edu.tp2016.applicationModel.Buscador
import edu.tp2016.repositorio.RepoPois

class TestBusquedaBanco {
	Buscador buscador

	@Before
	def void setUp() {
		buscador = new Buscador() => [
			repo = RepoPois.newInstance
			interfacesExternas.add(new AdapterBanco(new StubInterfazBanco))
			usuarioActual = new Terminal("terminal")
		]
	}
	
	@Test
	def void buscarBancoLlamadoSantanderRío() {
		val bancoEncontrado = (buscador.buscar("Santander Rio")).get(0) as Banco

		Assert.assertEquals("María Luna", bancoEncontrado.nombreGerente)
		Assert.assertTrue(bancoEncontrado.palabrasClave.contains("seguros"))
	}

	@Test
	def void buscarBancoLlamadoBancoDeLaPlazaYVerSiEstáSucursalAvellaneda() {
		val resultadoBusqueda = buscador.buscar("Banco de la Plaza")
		val bancosEncontrados = resultadoBusqueda.map [ banco | banco as Banco ]
		
		Assert.assertTrue(bancosEncontrados.exists [ banco |
			(banco.sucursal.equals("Avellaneda")) && (banco.nombreGerente.equals("Javier Loeschbor")) ] )
	}

	@Test
	def void buscarBancoLlamadoBancoDeLaPlazaYVerSiEstáSucursalCaballito() {
		val resultadoBusqueda = buscador.buscar("Banco de la Plaza")
		val bancosEncontrados = resultadoBusqueda.map [ banco | banco as Banco ]
		
		Assert.assertTrue(bancosEncontrados.exists [ banco |
			(banco.sucursal.equals("Caballito")) && (banco.palabrasClave.contains("transferencias")) ] )
	}

	@Test
	def void buscarBancoLlamadoGaliciaYQueDevuelvaListaVacía() {
		val resultadoBusqueda = buscador.buscar("Galicia")
		
		Assert.assertTrue(resultadoBusqueda.empty)
	}
	
}
