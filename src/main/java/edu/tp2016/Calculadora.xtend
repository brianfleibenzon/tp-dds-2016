package edu.tp2016

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class Calculadora {
	double operando1
	double operando2
	double resultado 
	
	def void setOperando1(double op1) {
		this.operando1 = op1
		this.resultado = operando2 * operando1
	}
	
	def void setOperando2(double op2) {
		this.operando2 = op2
		this.resultado = operando1 * operando2
	}
	
	def limpiarNumericFields(){
		this.operando1 = 0
		this.operando2 = 0
		this.resultado = 0
	}

}