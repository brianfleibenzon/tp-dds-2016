package edu.tp2016

import org.uqbar.geodds.Point
import org.joda.time.LocalDate
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Dispositivo {
	Point ubicacionActual
	LocalDate fechaActual
	List<POI> pois
	Direccion direccion
	
	def consultarCercania(POI unPoi){
		unPoi.estaCercaA(ubicacionActual)
	}
	
	def consultarDisponibilidad(POI unPoi){
		
	}
	
	def buscar(String texto){
		
	}
}