package edu.tp2016.sistema

import edu.tp2016.pois.POI
import java.util.List

interface SistemaInterface {
	
	def List<POI> buscar(String texto, Terminal terminal) 

}