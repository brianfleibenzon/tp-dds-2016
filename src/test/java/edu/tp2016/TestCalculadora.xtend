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
	def void calcularSincronizadoConValoresEnteros() {
		// Simula el ingreso del primer operando:
		calculadora.operando1 = 7
		
		// Simula que el ingreso del segundo operando:
		calculadora.operando2 = 3
		
		// Simula que el usuario presiona el botón multiplicar:
		// --> calculadora.calcular()
		Assert.assertEquals(21, calculadora.resultado, 0)
	}
	
	@Test
	def void calcularSincronizadoConValoresDecimales() {
		calculadora.operando1 = 0.25
		calculadora.operando2 = 6.99
		
		// --> calculadora.calcular()
		Assert.assertEquals(1.7475, calculadora.resultado, 0)
	}
	
	@Test
	def void limpiarInputsYOutputDeLaVista() {
		calculadora.operando1 = 100
		calculadora.operando2 = 200
		calculadora.resultado = 20000
		
		calculadora.limpiarNumericFields
		
		Assert.assertEquals(0, calculadora.operando1, 0)
		Assert.assertEquals(0, calculadora.operando2, 0)
		Assert.assertEquals(0, calculadora.resultado, 0)
	}
	
}