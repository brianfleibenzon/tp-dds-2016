package edu.tp2016

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Banco extends POI{
	override boolean estaDisponible(){
		false //TODO: Eliminar linea
	}
	
	override boolean coincide(String texto){
		false //TODO: Eliminar linea
	}
}