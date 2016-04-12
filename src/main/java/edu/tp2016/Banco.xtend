package edu.tp2016

import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDate

@Accessors
class Banco extends POI{
	override boolean estaDisponible(LocalDate fecha, String nombre){
		this.tieneRangoDeAtencionDisponibleEn(fecha.getDayOfWeek,fecha.hora)
	}
}