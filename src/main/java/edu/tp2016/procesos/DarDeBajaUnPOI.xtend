package edu.tp2016.procesos

import edu.tp2016.serviciosExternos.REST.EjemploServicioREST
import com.fasterxml.jackson.databind.ObjectMapper
import edu.tp2016.serviciosExternos.REST.InactivePOI
import edu.tp2016.pois.POI
import java.text.DateFormat
import java.text.SimpleDateFormat
import java.util.Date

class DarDeBajaUnPOI extends Proceso{
	EjemploServicioREST servicioREST = new EjemploServicioREST()
	ObjectMapper parser = new ObjectMapper()
	DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm")
	
	override correr(){
		parser.setDateFormat(df)
		val poisInactivos = servicioREST.obtenerPoisInactivos()
		poisInactivos.forEach [ poiDevuelto | 
			
			val poiInactivo = parser.readValue(poiDevuelto, InactivePOI)
			
			buscarPoiEnRepo(poiInactivo)
		]
	}
	
	def buscarPoiEnRepo(InactivePOI poi){
		
	 	val busquedaPOI = servidor.buscarPorId(poi.id)
	 	
	 	if(!busquedaPOI.isEmpty){
	 		eliminarPOI(busquedaPOI.get(0), poi.fecha)
	 	}
	 	// else... no hacer nada, jaja :P
	 }
	 
	def eliminarPOI(POI poi, Date fecha){

		// COMPLETAR ELIMINAR, tenés la fecha y el poi encontrado en el repo (borrarlo)
	}
	
}