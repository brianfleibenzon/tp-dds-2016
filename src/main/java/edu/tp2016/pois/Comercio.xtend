package edu.tp2016.pois

import org.uqbar.geodds.Point
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDateTime
import java.util.List
import edu.tp2016.mod.Rubro
import edu.tp2016.mod.DiaDeAtencion

@Accessors
class Comercio extends POI{
	Rubro rubro
	
	new(String unNombre, Point unaUbicacion, List<String> claves, Rubro unRubro, List<DiaDeAtencion> unRango) {
        super(unNombre, unaUbicacion, claves)
        rubro = unRubro
        rangoDeAtencion = unRango
    }
	
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
