package edu.tp2016

import edu.tp2016.applicationModel.Buscador
import edu.tp2016.pois.Banco
import edu.tp2016.repositorio.RepoPois
import edu.tp2016.serviciosExternos.banco.AdapterBanco
import edu.tp2016.serviciosExternos.banco.StubInterfazBanco
import edu.tp2016.usuarios.Terminal
import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class TestBusquedaBanco {
	Buscador buscador

	@Before
	def void setUp() {
		buscador = new Buscador() => [
			repo = RepoPois.instance
			repo.borrarDatos();			
			interfacesExternas.add(new AdapterBanco(new StubInterfazBanco))
			usuarioActual = new Terminal("terminal")
		]
	}
	
	@After
	def void finalizar(){
		RepoPois.instance.borrarDatos()
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
