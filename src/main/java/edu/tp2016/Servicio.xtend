package edu.tp2016

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Servicio {
	String nombre
	List<DiaDeAtencion> rangoDeAtencion
	
	def boolean contieneEnSuNombre(String texto){
		nombre.contains(texto)
	}
}