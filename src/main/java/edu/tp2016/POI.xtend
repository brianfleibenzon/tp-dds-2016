package edu.tp2016

import org.uqbar.geodds.Point
import java.util.Collection
import java.util.List

abstract class POI {
	String nombre
	Point ubicacion
	List<DiaDeAtencion> rangoDeAtencion
	Direccion direccion
	Collection palabrasClave
	
	def boolean estaDisponible(){
		false //TODO: Eliminar linea
	}
	
	def boolean estaCercano(Point ubicacionActual){
		false //TODO: Eliminar linea
	}
	
	def boolean coincide(String texto){
		false //TODO: Eliminar linea
	}
}