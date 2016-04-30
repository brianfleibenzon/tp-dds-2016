package edu.tp2016.interfacesExternas.cgp

import java.util.List
import edu.tp2016.pois.POI
import java.util.ArrayList
import edu.tp2016.pois.CGP
import edu.tp2016.interfacesExternas.InterfazExterna

class AdapterCGP extends InterfazExterna{
	InterfazCGP interfaz
	
	new(InterfazCGP _interfaz){
		interfaz = _interfaz
	}
	
	/**
	 * Adapter entre la busqueda medienta la interfaz externa y los datos locales
	 * Crea una lista de POIs a partir de la lista de CentroDTO que recibimos desde la interfaz externa
	 * Se busca con una cadena vacia ya que el parametro de busqueda de la interfaz externa es el barrio o la 
	 * calle, y no tenemos esos datos, por lo que necesito que me devuelva todos los disponibles
	 * 
	 * @param texto Cadena de busqueda
	 * @return Lista de POIs
	 */
	
	override def List<POI> buscar(String texto){ 
		val pois = new ArrayList<POI>
		interfaz.buscar("").forEach[unCentroDTO | 
			val unCGP = new CGP(unCentroDTO)
			pois.add(unCGP)
		]
		pois
	}
}