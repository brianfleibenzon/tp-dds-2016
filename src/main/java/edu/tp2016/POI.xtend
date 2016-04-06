package edu.tp2016

import org.uqbar.geodds.Point
import java.util.Collection

abstract class POI {
	String nombre
	Point ubicacion
	Collection rangoDeAtencion
	Direccion direccion
	Collection palabrasClave
	
	def Boolean estaDisponible(){
		
	}
	
	def Boolean estaCercano(Point ubicacionActual){
	
	}
	
	def Boolean coincide(String texto){
		
	}
}