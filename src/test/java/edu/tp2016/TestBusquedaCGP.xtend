package edu.tp2016

import org.junit.Before
import org.uqbar.geodds.Point
import java.util.Arrays
import org.joda.time.LocalDateTime
import edu.tp2016.interfacesExternas.cgp.AdapterCGP
import edu.tp2016.interfacesExternas.cgp.StubInterfazCGP
import org.junit.Test
import org.junit.Assert
import edu.tp2016.pois.CGP

class TestBusquedaCGP {
	Dispositivo unDispositivo
	LocalDateTime fechaX
	Point ubicacionX
	
	@Before
	def void setUp() {
		ubicacionX = new Point(-1, 1)
		fechaX = new LocalDateTime()
		unDispositivo = new Dispositivo(ubicacionX, Arrays.asList(), fechaX)
		unDispositivo.interfacesExternas.add(new AdapterCGP(new StubInterfazCGP))	
	}
	
	@Test
	def void buscarCGPConRentas() {
		val resultado = unDispositivo.buscar("Rentas")
		val unCGP = resultado.get(0) as CGP
		Assert.assertEquals(2, unCGP.comuna.numero)
	}
	
	@Test
	def void buscarCGPConAtencionCiudadana() {
		val resultado = unDispositivo.buscar("Atencion ciudadana")
		val unCGP = resultado.get(0) as CGP
		Assert.assertEquals(3, unCGP.comuna.numero)
	}
	
	@Test
	def void buscarCGPConVeterinaria() {
		val resultado = unDispositivo.buscar("Veterinaria")
		Assert.assertEquals(0, resultado.size)
	}
}