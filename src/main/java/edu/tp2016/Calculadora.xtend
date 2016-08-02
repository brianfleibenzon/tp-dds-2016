package edu.tp2016

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class Calculadora {
	long operando1
	long operando2
	long resultado 
	
	def calcular() {
		resultado = operando1 * operando2
	}
}