package edu.tp2016

import org.eclipse.xtend.lib.annotations.Accessors


@Accessors
class Banco extends POI{
		override boolean estaDisponible(FechaCompleta fecha, String nombre){
		
			
		this.tieneRangoDeAtencionDisponibleEn(fecha.dia,fecha.hora)
	}														
		
	
}