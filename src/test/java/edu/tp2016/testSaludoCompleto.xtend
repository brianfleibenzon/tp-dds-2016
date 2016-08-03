package edu.tp2016

import edu.tp2016.saludar.Saludar
import org.junit.Before
import org.junit.Test
import org.junit.Assert

class testSaludoCompleto {
	Saludar saludo
	
	@Before
	
	def void setUp(){
		
		saludo = new Saludar
	}
	
	@Test
	
	def void testSaludoCompleto(){
		
		saludo.nombre="Camila"
		saludo.apellido ="Sabino"
		
		Assert.assertEquals("Hola Camila Sabino", saludo.mensaje)
	}
	
}