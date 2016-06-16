package edu.tp2016

import org.junit.Before
import org.uqbar.geodds.Point
import java.util.Arrays
import org.joda.time.LocalDateTime
import edu.tp2016.serviciosExternos.cgp.AdapterCGP
import edu.tp2016.serviciosExternos.cgp.StubInterfazCGP
import org.junit.Test
import org.junit.Assert
import edu.tp2016.pois.CGP
import edu.tp2016.servidores.ServidorCentral
import edu.tp2016.usuarios.Terminal

class TestBusquedaCGP {
	Terminal unServidorLocal
	ServidorCentral servidorCentral
	LocalDateTime fechaX
	Point ubicacionX
	
	@Before
	def void setUp() {
		ubicacionX = new Point(-1, 1)
		fechaX = new LocalDateTime()
		servidorCentral= new ServidorCentral(Arrays.asList())
		servidorCentral.interfacesExternas.add(new AdapterCGP(new StubInterfazCGP))	
		unServidorLocal = new Terminal(ubicacionX, "servidorLocal", servidorCentral)
	}
	
	@Test
	def void buscarCGPConRentas() {
		val resultado = unServidorLocal.buscar("Rentas")
		val unCGP = resultado.get(0) as CGP
		Assert.assertEquals(2, unCGP.comuna.numero)
	}
	
	@Test
	def void buscarCGPConAtencionCiudadana() {
		val resultado = unServidorLocal.buscar("Atencion ciudadana")
		val unCGP = resultado.get(0) as CGP
		Assert.assertEquals(3, unCGP.comuna.numero)
	}
	
	@Test
	def void buscarCGPConVeterinaria() {
		val resultado = unServidorLocal.buscar("Veterinaria")
		Assert.assertEquals(0, resultado.size)
	}
}
