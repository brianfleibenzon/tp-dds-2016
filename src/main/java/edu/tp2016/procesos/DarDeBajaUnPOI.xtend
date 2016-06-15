package edu.tp2016.procesos

import com.fasterxml.jackson.databind.ObjectMapper
import edu.tp2016.pois.POI
import java.text.DateFormat
import java.text.SimpleDateFormat
import java.util.Date
import edu.tp2016.serviciosExternos.InactivePOI
import edu.tp2016.serviciosExternos.ServicioREST
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class DarDeBajaUnPOI extends Proceso {
	ServicioREST servicioREST
	ObjectMapper parser = new ObjectMapper()
	DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm")
	ResultadoDeDarDeBajaUnPoi resultado

	override correr() {
		parser.setDateFormat(df)
		val poisInactivos = servicioREST.obtenerPoisInactivos()
		poisInactivos.forEach [ poiDevuelto |

			val poiInactivo = parser.readValue(poiDevuelto, InactivePOI)

			buscarPoiEnRepo(poiInactivo)
		]
	}

	def buscarPoiEnRepo(InactivePOI poi) {

         resultado = new  ResultadoDeDarDeBajaUnPoi(poi.fecha,poi.id)
		
		val busquedaPOI = servidor.buscarPorId(poi.id)

		if (!busquedaPOI.isEmpty) {
			eliminarPOI(busquedaPOI.get(0), poi.fecha)
			servidor.registrarResultadoDeBaja( resultado)
			
		}
	// else... no hacer nada
	}

	def eliminarPOI(POI poi, Date fecha) {
		servidor.repo.eliminarPoi(poi)

	}

}
