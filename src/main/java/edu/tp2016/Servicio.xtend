package edu.tp2016

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

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
	
	def boolean tieneRangoDeAtencionDisponibleEn(int unDia, int unaHora){
		losHorariosDelDia(unDia).exists[unRango | ((unRango.horaInicio)<unaHora)&&((unRango.horaFin)>unaHora)]			
	}
	
	def boolean estaDisponibleEn(int unDia, int unaHora){		
		tieneRangoDeAtencionDisponibleEn(unDia,unaHora)
	}
}