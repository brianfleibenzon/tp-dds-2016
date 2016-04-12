package edu.tp2016

import org.uqbar.geodds.Point
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDate

@Accessors
class Dispositivo {
	Point ubicacionActual
	LocalDate fechaActual
	List<POI> pois
	Direccion direccion
	
	def formatoFechaYHora(LocalDate fechaActual){
		fechaActual.toDate
	}
	def boolean consultarCercania(POI unPoi){
		unPoi.estaCercaA(ubicacionActual)
	}
	
	def boolean consultarDisponibilidad(POI unPoi, String valorX){
		unPoi.estaDisponible(fechaActual,valorX)
	}
	
	def Iterable<POI> buscar(String texto){
		pois.filter [poi | (poi.tienePalabraClave(texto)) || (poi.coincide(texto))]
	}
}