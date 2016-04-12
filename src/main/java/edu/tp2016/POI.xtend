package edu.tp2016

import org.uqbar.geodds.Point
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDate

@Accessors
abstract class POI {
	String nombre
	Point ubicacion
	List<DiaDeAtencion> rangoDeAtencion
	Direccion direccion
	List<String> palabrasClave
	Iterable<DiaDeAtencion> horariosDelDia
	
	def boolean estaDisponible(LocalDate unaFecha,String nombre){
		false
		}

	def Iterable<DiaDeAtencion> losHorariosDelDia(int unDia){
		horariosDelDia = rangoDeAtencion.filter[ unRango | (unDia.equals(unRango.dia))]
	}
	
	def boolean tieneRangoDeAtencionDisponibleEn(int unDia, int unaHora){
		losHorariosDelDia(unDia).exists[unRango | ((unRango.horaInicio)<unaHora)&&((unRango.horaFin)>unaHora)]			
	}
	
	def boolean estaCercaA(Point ubicacionDispositivo){
		distanciaA(ubicacionDispositivo) < 5
	}
	
	def double distanciaA(Point unPunto){
		unPunto.distance(ubicacion) * 10
	}
	
	def boolean tienePalabraClave(String texto){
		palabrasClave.contains(texto)
	} // La búsqueda por palabra clave es igual para todos los POI
	
	def boolean coincide(String texto){
		 texto.equals(nombre) 
		 }
		 /* Por defecto, un POI coincide con la búsqueda si su nombre
		  * coincide con el texto buscado
		  */
	}