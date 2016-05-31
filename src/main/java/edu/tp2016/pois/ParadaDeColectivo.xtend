package edu.tp2016.pois

import org.uqbar.geodds.Point
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDateTime


@Accessors
class ParadaDeColectivo extends POI{
	    
    new()
    {}
	
	override boolean estaCercaA(Point ubicacionDispositivo){
		 distanciaA(ubicacionDispositivo) < 1
	}
	
	override boolean estaDisponible(LocalDateTime fecha,String Nombre){
		 true
	}	
}
