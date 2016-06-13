package edu.tp2016.procesos

import edu.tp2016.repositorio.Repositorio
import serviciosExternos.REST.ServicioExternoREST
import java.util.List
import edu.tp2016.pois.POI

class BajaPOI extends Proceso{
	 
	Repositorio repo
	ServicioExternoREST servicioREST
	
	override correr(){
		val poisInactivos = servicioREST.obtenerPoisInactivos()
	
	}
	
	
	
	
	
	
	
}