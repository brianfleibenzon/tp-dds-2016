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
	// Y así se va jugando con el fixture de datos hecho en el StubInterfazBanco
	
}