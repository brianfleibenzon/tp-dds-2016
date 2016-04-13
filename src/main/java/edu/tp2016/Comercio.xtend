package edu.tp2016

import org.uqbar.geodds.Point
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDateTime

@Accessors
class Comercio extends POI{
	Rubro rubro
	
	override boolean estaCercaA(Point ubicacionDispositivo){
		 distanciaA(ubicacionDispositivo) < rubro.radioDeCercania
	}
	
	override boolean estaDisponible(LocalDateTime fecha, String nombre){
		this.tieneRangoDeAtencionDisponibleEn(fecha)
	}
	
	override boolean coincide(String texto){
		 (super.coincide(texto)) || (texto.equalsIgnoreCase(rubro.nombre))
	}
}