package edu.tp2016

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDateTime

@Accessors
class Servicio {
	String nombre
	List<DiaDeAtencion> rangoDeAtencion
	Iterable<DiaDeAtencion> horariosDelDia 
	
	def boolean contieneEnSuNombre(String texto){
		nombre.contains(texto)
	}
	
	def Iterable<DiaDeAtencion> losHorariosDelDia(int unDia){
		horariosDelDia = rangoDeAtencion.filter[ unRango | (unDia.equals(unRango.dia))]
	}
	
	def boolean tieneRangoDeAtencionDisponibleEn(LocalDateTime fecha){
		losHorariosDelDia(fecha.getDayOfWeek).exists[unRango | ((unRango.horaInicio)<fecha.getHourOfDay)&&((unRango.horaFin)>fecha.getHourOfDay)]			
	}
	
	def boolean estaDisponibleEn(LocalDateTime fecha){		
		tieneRangoDeAtencionDisponibleEn(fecha)
	}
}