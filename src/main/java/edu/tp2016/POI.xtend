package edu.tp2016

import org.uqbar.geodds.Point
import java.util.Collection
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
abstract class POI {
	String nombre
	Point ubicacion
	List<DiaDeAtencion> rangoDeAtencion
	Direccion direccion
	Collection palabrasClave
	
	def boolean estaDisponible(){
		false //TODO: Eliminar linea
	}
	
	def boolean estaCercaA(Point ubicacionDispositivo){
		distanciaA(ubicacionDispositivo) < 5
	}
	
	def double distanciaA(Point unPunto){
		unPunto.distance(ubicacion) * 10
	}
	
	def boolean coincide(String texto){
		false //TODO: Eliminar linea
	}
}