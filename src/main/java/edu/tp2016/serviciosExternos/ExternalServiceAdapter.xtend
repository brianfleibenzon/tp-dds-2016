package edu.tp2016.serviciosExternos

import java.util.List
import edu.tp2016.pois.POI

abstract class ExternalServiceAdapter {
	def List<POI> buscar(String texto)
}