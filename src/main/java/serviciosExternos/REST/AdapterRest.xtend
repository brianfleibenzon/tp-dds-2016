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

/**
	 * Adapter entre la búsqueda mediante la interfaz externa para búsqueda de Bancos y el repositorio local.
	 * Genera una lista de POIs a partir de la lista de SucursalBanco (objetos JSON) que recibimos desde la interfaz externa.
	 * Dicha interfaz necesita como parámetro de búsqueda un String que represente el nombre del Banco,
	 * y devuelve todas las sucursales que cumplen con ese criterio.
	 * 
	 * @param nombreBanco cadena de texto que representa el nombre de un Banco
	 * @return lista de POIs (que incluye solo Bancos)
	 */

	override def List<POI> buscar(String nombrePOI){ 
		val pois = new ArrayList<POI>
		
		servicio.buscar(nombrePOI).forEach[POIEncontrado | 
			val POIParseada = parsearPOI(POIEncontrado)
			pois.add(POIParseada)
		]
		pois
	}
	
/**
	 * ParsearSucursal convierte una SucursalBanco, que es un objeto Banco pero en formato JSON,
	 * a un objeto Banco en el formato de nuestro dominio.
	 * 
	 * @param sucursalBanco banco en formato JSON
	 * @return banco un banco en el formato de nuestro dominio
	 */
	def POI parsearPOI(unPOI _POI){
		val nombre = _POI.get("nombre").asString()
		val x = _POI.get("x").asDouble()
		val y = _POI.get("y").asDouble()
		val claves = this.parsearArrayPalabrasClaves(_POI)
		
		val POIParseado = new POI(nombre, new Point(x,y), claves)
		
		POIParseado
	}
	
/**
	 * Los servicios (o palabras clave) en el objeto JSON SucursalBanco son un 'array', y no pueden obtenerse en forma
	 * directa. Por tal motivo, se utiliza la siguiente función que recorre el array JSON y pone todos sus valores
	 * una lista de strings, que sí es un objeto de nuestro dominio.
	 * 
	 * @param sucursalBanco banco en formato JSON
	 * @return lista de strings de los servicios (o palabras claves) de un banco
	 */
	def List<String> parsearArrayPalabrasClaves(unPOI _POI){
		val palabras_claves = new ArrayList()
		
		val palabraClave = (_POI.get("palabrasClave").asArray()).values()
		
		for(JsonValue clave : palabraClave){
			palabras_claves.add(clave.asString())
		}
		palabras_claves
	}
	
}
	