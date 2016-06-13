package serviciosExternos.REST

import edu.tp2016.serviciosExternos.ExternalServiceAdapter
import java.util.List
import edu.tp2016.pois.POI
import java.util.ArrayList
import org.uqbar.geodds.Point
import com.eclipsesource.json.JsonValue

class AdapterRest extends ExternalServiceAdapter {
	
	ServicioExternoREST servicio
	
	new(ServicioExternoREST _servicio){
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
	

	def double parsearPOI(unPOI _POI){
		val IDPoi = _POI.get("ID").asDouble()
			
		IDPoi
	}
	
	def String parsearFecha()
	
	}
	}