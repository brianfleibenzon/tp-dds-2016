package edu.tp2016.interfacesExternas.cgp

import java.util.List
import edu.tp2016.pois.POI
import java.util.ArrayList
import edu.tp2016.pois.CGP
import edu.tp2016.interfacesExternas.InterfazExterna

class BusquedaCGP extends InterfazExterna{
	InterfazCGP interfaz
	
	new(InterfazCGP _interfaz){
		interfaz = _interfaz
	}
	
	override def List<POI> buscar(String texto){ 
	//TODO: Se busca con "" para recibir todos los CGPs, ya que	previamente no tengo ni el barrio ni la calle
		val pois = new ArrayList<POI>
		interfaz.buscar("").forEach[unCentroDTO | 
			val unCGP = new CGP(unCentroDTO)
			pois.add(unCGP)
		]
		pois
	}
}