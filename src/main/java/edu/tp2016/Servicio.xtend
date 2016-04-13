package edu.tp2016

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDateTime
import java.util.ArrayList

@Accessors
class Servicio {
	String nombre
	List<DiaDeAtencion> rangoDeAtencion = new ArrayList<DiaDeAtencion>

	def boolean contieneEnSuNombre(String texto){
		nombre.contains(texto)
	}

	def boolean tieneRangoDeAtencionDisponibleEn(LocalDateTime fecha){
		rangoDeAtencion.exists[unRango | unRango.fechaEstaEnRango(fecha) ]			
	}
}