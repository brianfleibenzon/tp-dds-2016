package edu.tp2016

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class Calculadora {
	long operando1
	long operando2
	long resultado 
	
	def void setOperando1(long op1) {
		this.operando1 = op1
		this.resultado = operando2 * operando1
	}
	
	def void setOperando2(long op2) {
		this.operando2 = op2
		this.resultado = operando1 * operando2
	}
	
	/*def calcular() {
		resultado = operando1 * operando2
	}*/
}