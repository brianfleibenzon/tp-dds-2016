package edu.tp2016

import org.junit.Test
import org.junit.Assert

class TestConversor {
	Conversor conversor
	
@Test
def void convertirDeFahrenheitACelsius(){
	conversor.fahrenheit = 32
	Assert.assertEquals(0,conversor.celsius)
}

@Test
def void convertirDeCelsiusAFahrenheit(){
	conversor.celsius = 20
	Assert.assertEquals(68,conversor.fahrenheit)
}

}