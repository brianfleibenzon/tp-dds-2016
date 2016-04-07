package edu.tp2016

import org.uqbar.geodds.Point
import java.util.List

class CGP extends POI{
	List<Servicio> servicios
	Comuna comuna
	
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