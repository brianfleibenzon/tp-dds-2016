package edu.tp2016.sistema.decorators

import edu.tp2016.sistema.SistemaInterface
import edu.tp2016.pois.POI
import org.uqbar.geodds.Point
import org.joda.time.LocalDateTime
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
abstract class SistemaDecorator implements SistemaInterface{
	
	SistemaInterface sistema
	LocalDateTime fechaActual
	
	override consultarCercania(POI unPoi, Point ubicacion) {
		sistema.consultarCercania(unPoi, ubicacion)
	}
	
	override consultarDisponibilidad(POI unPoi, String valorX) {
		sistema.consultarDisponibilidad(unPoi, valorX)
	}
	
	override buscar(String texto) {
		sistema.buscar(texto)
	}
	
	new(SistemaInterface _sistema) {
		sistema = _sistema
	}
	
}