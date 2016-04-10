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
	
	def boolean consultarCercania(POI unPoi){
		unPoi.estaCercaA(ubicacionActual)
	}
	
	def boolean consultarDisponibilidad(POI unPoi){
		false //TODO: Eliminar línea
	}
	
	def Iterable<POI> buscar(String texto){
		pois.filter [poi | (poi.tienePalabraClave(texto)) || (poi.coincide(texto))]
	}
}