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
import edu.tp2016.sistema.Terminal
import org.uqbar.geodds.Point

class TestBusquedaCGP {
	Sistema unSistema
	LocalDateTime fechaX
	Terminal terminal
	
	@Before
	def void setUp() {
		fechaX = new LocalDateTime()
		unSistema = new Sistema(Arrays.asList(), fechaX)
		unSistema.interfacesExternas.add(new AdapterCGP(new StubInterfazCGP))
		terminal = new Terminal("terminalAbasto", new Point(-1, -1), unSistema)	
	}
	
	@Test
	def void buscarCGPConRentas() {
		val resultado = terminal.buscar("Rentas")
		val unCGP = resultado.get(0) as CGP
		Assert.assertEquals(2, unCGP.comuna.numero)
	}
	
	@Test
	def void buscarCGPConAtencionCiudadana() {
		val resultado = terminal.buscar("Atencion ciudadana")
		val unCGP = resultado.get(0) as CGP
		Assert.assertEquals(3, unCGP.comuna.numero)
	}
	
	@Test
	def void buscarCGPConVeterinaria() {
		val resultado = terminal.buscar("Veterinaria")
		Assert.assertEquals(0, resultado.size)
	}
}