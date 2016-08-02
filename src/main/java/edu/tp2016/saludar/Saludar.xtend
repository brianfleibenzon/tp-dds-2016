package edu.tp2016.saludar

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable

class Saludar {
	String nombre
	String apellido
	String mensaje
	
	
	def void saludoCompleto(String nomb,String apell){
		
		nombre = nomb
		apellido= apell
		mensaje= "Hola"+" "+nombre + " " + apellido
	}
}