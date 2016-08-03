package edu.tp2016.saludar

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable

class Saludar {
	String nombre
	String apellido
	String mensaje
	
	def void setNombre(String nomb){
		nombre = nomb
		saludoCompleto()
		
	}
	def void setApellido(String apell){
		apellido = apell
		saludoCompleto()
	}
	
	def void saludoCompleto(){
		
		
		mensaje= "Hola"+" "+nombre + " " + apellido
	}
}