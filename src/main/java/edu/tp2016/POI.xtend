package edu.tp2016

import org.uqbar.geodds.Point
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
abstract class POI {
	String nombre
	Point ubicacion
	List<DiaDeAtencion> rangoDeAtencion
	Direccion direccion
	List<String> palabrasClave
	
	def boolean estaDisponible(){
		false //TODO: Eliminar linea
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
		 texto.equalsIgnoreCase(nombre) 
		 }
		 /* Por defecto, un POI coincide con la búsqueda si su nombre
		  * coincide con el texto buscado
		  */
	}