package edu.tp2016

import edu.tp2016.applicationModel.Buscador
import edu.tp2016.pois.CGP
import edu.tp2016.repositorio.RepoPois
import edu.tp2016.serviciosExternos.cgp.AdapterCGP
import edu.tp2016.serviciosExternos.cgp.StubInterfazCGP
import edu.tp2016.usuarios.Terminal
import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class TestBusquedaCGP {
	Buscador buscador
	
	@Before
	def void setUp() {
		buscador = new Buscador() => [
			repo = RepoPois.newInstance
			repo.borrarDatos();	
			interfacesExternas.add(new AdapterCGP(new StubInterfazCGP))
			usuarioActual = new Terminal("terminal")
		]
	}
	
	@After
	def void finalizar(){
		RepoPois.instance.borrarDatos()
	}
	
	@Test
	def void buscarCGPConRentas() {
		val resultado = buscador.buscar("Rentas")
		val unCGP = resultado.get(0) as CGP
		Assert.assertEquals(2, unCGP.comuna.numero)
	}
	
	@Test
	def void buscarCGPConAtencionCiudadana() {
		val resultado = buscador.buscar("Atencion ciudadana")
		val unCGP = resultado.get(0) as CGP
		Assert.assertEquals(3, unCGP.comuna.numero)
	}
	
	@Test
	def void buscarCGPConVeterinaria() {
		val resultado = buscador.buscar("Veterinaria")
		Assert.assertEquals(0, resultado.size)
	}
}
