package edu.tp2016.serviciosExternos.REST

import java.util.List
import edu.tp2016.serviciosExternos.InactivePOI

interface ServicioExternoREST {
	
	def List<InactivePOI> obtenerPoisInactivos()
		
		
}
