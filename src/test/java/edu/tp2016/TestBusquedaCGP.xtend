package edu.tp2016

import org.junit.Before
import org.uqbar.geodds.Point
import org.joda.time.LocalDateTime
import edu.tp2016.serviciosExternos.cgp.AdapterCGP
import edu.tp2016.serviciosExternos.cgp.StubInterfazCGP
import org.junit.Test
import org.junit.Assert
import edu.tp2016.pois.CGP
import edu.tp2016.usuarios.Terminal

class TestBusquedaCGP {
	Terminal unaTerminal
	LocalDateTime fechaX
	Point ubicacionX
	
	@Before
	def void setUp() {
		ubicacionX = new Point(-1, 1)
		fechaX = new LocalDateTime()
		unaTerminal = new Terminal(ubicacionX, "terminalX")
		unaTerminal.interfacesExternas.add(new AdapterCGP(new StubInterfazCGP))	
	}
	
	@Test
	def void buscarCGPConRentas() {
		val resultado = unaTerminal.buscar("Rentas")
		val unCGP = resultado.get(0) as CGP
		Assert.assertEquals(2, unCGP.comuna.numero)
	}
	
	@Test
	def void buscarCGPConAtencionCiudadana() {
		val resultado = unaTerminal.buscar("Atencion ciudadana")
		val unCGP = resultado.get(0) as CGP
		Assert.assertEquals(3, unCGP.comuna.numero)
	}
	
	@Test
	def void buscarCGPConVeterinaria() {
		val resultado = unaTerminal.buscar("Veterinaria")
		Assert.assertEquals(0, resultado.size)
	}
}
