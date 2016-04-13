package edu.tp2016

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.ArrayList

@Accessors
class Servicio {
	String nombre
	List<DiaDeAtencion> rangoDeAtencion = new ArrayList<DiaDeAtencion>
	Iterable<DiaDeAtencion> horariosDelDia 
	
	def boolean contieneEnSuNombre(String texto){
		nombre.contains(texto)
	}
	
	def Iterable<DiaDeAtencion> losHorariosDelDia(int unDia){
		horariosDelDia = rangoDeAtencion.filter[ unRango | (unDia.equals(unRango.dia))]
	}
	
	def boolean tieneRangoDeAtencionDisponibleEn(FechaCompleta unaFecha){
		losHorariosDelDia(unaFecha.dia).exists[unRango | ((unRango.horaInicio)<unaFecha.hora)&&((unRango.horaFin)>unaFecha.hora)]			
	}
	
	def boolean estaDisponibleEn(FechaCompleta fecha){		
		tieneRangoDeAtencionDisponibleEn(fecha)
	}
}