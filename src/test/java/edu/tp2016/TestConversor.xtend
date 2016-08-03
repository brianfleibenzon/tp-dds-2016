package edu.tp2016


import org.junit.Before
import org.junit.Test
import org.junit.Assert

class TestConversor {
	Conversor conversor
	
@Before
def void setUp() {
	conversor = new Conversor
}

	
@Test
def void convertirDeFahrenheitACelsius(){
	conversor.fahrenheit = 32
	Assert.assertEquals(0,conversor.celsius,0)
}

@Test
def void convertirDeCelsiusAFahrenheit(){
	conversor.celsius = 20
	Assert.assertEquals(68,conversor.fahrenheit,0)
}

}