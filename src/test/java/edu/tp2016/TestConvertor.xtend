package edu.tp2016

import org.junit.Before
import org.junit.Test
import junit.framework.Assert
import java.awt.Color

class TestConvertor {
	
	Convertor convertor

	@Before
	def void setUp() {
		convertor = new Convertor
	}
	

	@Test
	def void testEjemplo() {
		convertor.frase = "Ese mece me se"
		Assert.assertEquals("es em ecem esE", convertor.fraseReves)
		Assert.assertEquals(Color.BLUE, convertor.color)
	}
	
	@Test
	def void testNoPalindromo() {
		convertor.frase = "buen dia"
		Assert.assertEquals("aid neub", convertor.fraseReves)
		Assert.assertEquals(Color.RED, convertor.color)
	}
	
}
