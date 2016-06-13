package edu.tp2016.serviciosExternos.REST

import java.util.List
import edu.tp2016.pois.POI
import java.util.ArrayList
import java.util.Date
import java.text.DateFormat
import java.text.SimpleDateFormat

class AdapterRest {
	
<<<<<<< HEAD
	serviciosExternos.REST.ServicioExternoREST servicio
	
	new(serviciosExternos.REST.ServicioExternoREST _servicio){
		servicio = _servicio
}


	override def List<POI> buscar(String nombrePOI){ 
		val pois = new ArrayList<POI>
		
		servicio.buscar(nombrePOI).forEach[POIEncontrado | 
			val POIParseada = parsearPOI(POIEncontrado)
			pois.add(POIParseada)
		]
		pois
	}
	

	def double parsearPOI(serviciosExternos.REST.unPOI _POI){
		val IDPoi = _POI.get("ID").asDouble()
			
		IDPoi
	}
	
	def String parsearFecha()
	
	}
=======
	
	}
	
>>>>>>> 8a8bf0ecd717cdb89a61a0f7e0c68983941c16df
