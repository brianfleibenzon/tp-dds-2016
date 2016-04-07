package edu.tp2016

import org.uqbar.geodds.Point

class Comercio extends POI{
	Rubro rubro
	
	override boolean estaCercano(Point ubicacionActual){
		 false //TODO: Eliminar linea
	}
	
	override boolean estaDisponible(){
		 false //TODO: Eliminar linea
	}
	
	override boolean coincide(String texto){
		 false //TODO: Eliminar linea
	}
}