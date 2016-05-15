package edu.tp2016.sistema

import edu.tp2016.pois.POI
import java.util.List
import org.uqbar.geodds.Point

interface SistemaInterface {
	
	def boolean consultarCercania(POI unPoi, Point ubicacion)
	
	def boolean consultarDisponibilidad(POI unPoi, String valorX)

	def List<POI> buscar(String texto) 

}