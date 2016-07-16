package edu.tp2016

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import java.awt.Color

@Observable
@Accessors
class Convertor {
	String frase
	String fraseReves
	Color color

	def void setFrase(String texto) {
		frase = texto
		fraseReves = new StringBuffer(frase).reverse().toString()
		
		if (esPalindroma()){
			color = Color.BLUE
		}else{
			color = Color.RED
		}
	}
	
	def boolean esPalindroma(){
		frase.replace(" ", "").equalsIgnoreCase(fraseReves.replace(" ", ""))
	}
}
