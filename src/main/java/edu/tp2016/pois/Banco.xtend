package edu.tp2016.pois

import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDateTime
import org.uqbar.geodds.Point
import java.util.List
import edu.tp2016.mod.DiaDeAtencion

@Accessors
class Banco extends POI{
	
	new(String unNombre, Point unaUbicacion, List<String> claves, List<DiaDeAtencion> unRango) {
        super(unNombre, unaUbicacion, claves)
        rangoDeAtencion = unRango
    } // Constructor
	
	override boolean estaDisponible(LocalDateTime fecha, String nombre){
		this.tieneRangoDeAtencionDisponibleEn(fecha)
	}														
		
	
}
