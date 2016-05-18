package edu.tp2016.serviciosExternos.cgp

import java.util.List
import edu.tp2016.pois.POI
import java.util.ArrayList
import edu.tp2016.pois.CGP
import edu.tp2016.serviciosExternos.ExternalServiceAdapter

class AdapterCGP extends ExternalServiceAdapter{
	ServicioExternoCGP servicio
	
	new(ServicioExternoCGP _servicio){
		servicio = _servicio
	}
	
	/**
	 * Adapter entre la búsqueda mediente la interfaz externa y los datos locales
	 * Crea una lista de POIs a partir de la lista de CentroDTO que recibimos desde la interfaz externa
	 * Se busca con una cadena vacía ya que el parámetro de búsqueda de la interfaz externa es el barrio o la 
	 * calle, y no tenemos esos datos, por lo que necesito que me devuelva todos los coincidentes
	 * 
	 * @param texto cadena de búsqueda
	 * @return Lista de POIs (que incluye solo CGPs)
	 */
	
	override def List<POI> buscar(String texto){ 
		val pois = new ArrayList<POI>
		servicio.buscar("").forEach[unCentroDTO | 
			val unCGP = new CGP(unCentroDTO)
			pois.add(unCGP)
		]
		pois
	}
}