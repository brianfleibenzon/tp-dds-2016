package edu.tp2016.pois

import org.uqbar.geodds.Point
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDateTime
import java.util.List

@Accessors
class ParadaDeColectivo extends POI{
	
	new(String unNombre, Point unaUbicacion, List<String> claves) {
       	super(unNombre, unaUbicacion, claves)
    }
	
	
	
	override boolean estaCercaA(Point ubicacionDispositivo){
		 distanciaA(ubicacionDispositivo) < 1
	}
	
	override boolean estaDisponible(LocalDateTime fecha,String Nombre){
		 true
	}
	
	def add(String unNombre, Point unaUbicacion, List<String> claves) {
		this.nombre=unNombre
		this.ubicacion = unaUbicacion
		this.palabrasClave = claves
	}
		
}
