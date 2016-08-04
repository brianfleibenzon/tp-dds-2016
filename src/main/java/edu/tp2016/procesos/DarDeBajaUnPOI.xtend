package edu.tp2016.procesos

import edu.tp2016.pois.POI
import java.text.DateFormat
import java.text.SimpleDateFormat
import edu.tp2016.serviciosExternos.InactivePOI
import edu.tp2016.serviciosExternos.ServicioREST
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDateTime
import edu.tp2016.applicationModel.Buscador
import org.codehaus.jackson.map.ObjectMapper

@Accessors
class DarDeBajaUnPOI extends Proceso {
	ServicioREST servicioREST
	ObjectMapper parser = new ObjectMapper()
	DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm")
	ResultadoDeDarDeBajaUnPoi resultado
	Buscador buscador
	
	new(Buscador nuevo_buscador){
		buscador = nuevo_buscador
	}

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

		val busquedaPOI = buscador.buscarPorId(poi.id)

		if (!busquedaPOI.isEmpty) {
			eliminarPOI(busquedaPOI.get(0), fecha)
			buscador.repo.registrarResultadoDeBaja(resultado)

		}
	}

	def eliminarPOI(POI poi, LocalDateTime fecha) {
		buscador.repo.eliminarPoi(poi)

	}

}
