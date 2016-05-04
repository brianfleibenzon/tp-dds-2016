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
	def void buscarBancoLlamadoSantanderRio() {
		val bancoEncontrado = (unDispositivo.buscar("Santander Rio")).get(0) as Banco

		Assert.assertEquals("María Luna", bancoEncontrado.nombreGerente)
		Assert.assertTrue(bancoEncontrado.palabrasClave.contains("seguros"))
	}

	@Test
	def void buscarBancoLlamadoBandoDeLaPlazaSucursal2() {
		val bancoEncontrado = (unDispositivo.buscar("Banco de la Plaza")).get(0) as Banco

		Assert.assertEquals("Javier Loeschbor", bancoEncontrado.nombreGerente)
		Assert.assertTrue(bancoEncontrado.palabrasClave.contains("seguros"))
	}

	@Test
	def void buscarBancoLlamadoBandoDeLaPlazaSucursal3() {
		val bancoEncontrado = (unDispositivo.buscar("Banco de la Plaza")).get(1) as Banco

		Assert.assertEquals("Fabian Fataguzzi", bancoEncontrado.nombreGerente)
		Assert.assertTrue(bancoEncontrado.palabrasClave.contains("seguros"))
	}

	@Test
	def void buscarBancoLlamadoBandoaPlazaPorGerenteFabian() {
		val bancosEncontrados = (unDispositivo.buscar("Banco de la Plaza"))
		val bancos = bancosEncontrados.map[banco|banco as Banco]
		bancos.exists[banco|banco.nombreGerente.contains("Fabian Fataguzzi")]

	}

	@Test
	def void buscarBancoLlamadoBandoaPlazaPorSucursalAvellaneda() {
		val bancosEncontrados = (unDispositivo.buscar("Banco de la Plaza"))
		val bancos = bancosEncontrados.map[banco|banco as Banco]
		bancos.exists[banco|banco.sucursal.contains("Avellaneda")]

	}

	@Test
	def void buscarBancoLlamadoBandoaPlazaPorSucursaCaballito() {
		val bancosEncontrados = (unDispositivo.buscar("Banco de la Plaza"))
		val bancos = bancosEncontrados.map[banco|banco as Banco]
		bancos.exists[banco|banco.sucursal.contains("Caballito")]

	}
	
	
}