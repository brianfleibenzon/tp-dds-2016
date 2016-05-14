package edu.tp2016

import org.junit.Before
import java.util.Arrays
import org.joda.time.LocalDateTime
import edu.tp2016.serviciosExternos.cgp.AdapterCGP
import edu.tp2016.serviciosExternos.cgp.StubInterfazCGP
import org.junit.Test
import org.junit.Assert
import edu.tp2016.pois.CGP
import edu.tp2016.sistema.Sistema

class TestBusquedaCGP {
	Sistema unSistema
	LocalDateTime fechaX
	
	@Before
	def void setUp() {
		fechaX = new LocalDateTime()
		unSistema = new Sistema(Arrays.asList(), fechaX)
		unSistema.interfacesExternas.add(new AdapterCGP(new StubInterfazCGP))	
	}
	
	@Test
	def void buscarCGPConRentas() {
		val resultado = unSistema.buscar("Rentas")
		val unCGP = resultado.get(0) as CGP
		Assert.assertEquals(2, unCGP.comuna.numero)
	}
	
	@Test
	def void buscarCGPConAtencionCiudadana() {
		val resultado = unSistema.buscar("Atencion ciudadana")
		val unCGP = resultado.get(0) as CGP
		Assert.assertEquals(3, unCGP.comuna.numero)
	}
	
	@Test
	def void buscarCGPConVeterinaria() {
		val resultado = unSistema.buscar("Veterinaria")
		Assert.assertEquals(0, resultado.size)
	}
}