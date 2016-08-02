package edu.tp2016

import org.junit.Before
import org.junit.Test
import org.junit.Assert

class TestCalculadora {
	Calculadora calculadora

	@Before
	def void setUp() {
		calculadora = new Calculadora
	}

	@Test
	def void calcularCalculadoraConValores() {
		// Simula el ingreso del primer operando:
		calculadora.operando1 = 7
		// Simula que el ingreso del segundo operando:
		calculadora.operando2 = 3
		// Simula que el usuario presiona el botón multiplicar:
		// --> calculadora.calcular()
		Assert.assertEquals(21, calculadora.resultado)
	}

	/*@Test
	def void testMultiplicacion() {
		calculadora.operando1 = 7
		calculadora.operando2 = 3
		calculadora.calcular()
		
		Assert.assertEquals(21, calculadora.resultado)
	}*/
}