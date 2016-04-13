package edu.tp2016

import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDateTime

@Accessors
class Banco extends POI{
	override boolean estaDisponible(LocalDateTime fecha, String nombre){
		this.tieneRangoDeAtencionDisponibleEn(fecha)
	}														
		
	
}