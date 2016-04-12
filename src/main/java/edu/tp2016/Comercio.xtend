package edu.tp2016

import org.uqbar.geodds.Point
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Comercio extends POI{
	Rubro rubro
	
	override boolean estaCercaA(Point ubicacionDispositivo){
		 distanciaA(ubicacionDispositivo) < rubro.radioDeCercania
	}
	
	override boolean estaDisponible(){
		 false // TODO: Eliminar linea
	}
	
	override boolean coincide(String texto){
		 (texto.equalsIgnoreCase(nombre)) || (texto.equalsIgnoreCase(rubro.nombre))
	}
}