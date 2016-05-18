package edu.tp2016.Builder

import edu.tp2016.pois.ParadaDeColectivo
import org.uqbar.geodds.Point
import java.util.List

class BuilderParada extends Builder {
	
	ParadaDeColectivo unaParada
		
	override construirParada(String unNombre, Point unaUbicacion, List<String> claves){
		unaParada.add(unNombre,unaUbicacion,claves)
		this
	}
}