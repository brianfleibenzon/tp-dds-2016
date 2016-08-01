package edu.tp2016.procesos

import com.fasterxml.jackson.databind.ObjectMapper
import edu.tp2016.pois.POI
import java.text.DateFormat
import java.text.SimpleDateFormat
import edu.tp2016.serviciosExternos.InactivePOI
import edu.tp2016.serviciosExternos.ServicioREST
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDateTime

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
		
		var LocalDateTime fecha = new LocalDateTime(poi.fecha)

		resultado = new ResultadoDeDarDeBajaUnPoi(fecha, poi.id)

		val busquedaPOI = servidor.buscarPorId(poi.id)

		if (!busquedaPOI.isEmpty) {
			eliminarPOI(busquedaPOI.get(0), fecha)
			servidor.registrarResultadoDeBaja(resultado)

		}
	}

	def eliminarPOI(POI poi, LocalDateTime fecha) {
		servidor.repo.eliminarPoi(poi)

	}

}
