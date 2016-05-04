package edu.tp2016.serviciosExternos.banco

import java.util.List
import edu.tp2016.pois.POI
import java.util.ArrayList
import edu.tp2016.pois.Banco
import com.eclipsesource.json.JsonValue
import edu.tp2016.serviciosExternos.ExternalServiceAdapter
import edu.tp2016.serviciosExternos.banco.ServicioExternoBanco

class AdapterBanco extends ExternalServiceAdapter{
	ServicioExternoBanco servicio
	
	new(ServicioExternoBanco _servicio){
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

	override def List<POI> buscar(String nombreBanco){ 
		val pois = new ArrayList<POI>
		
		servicio.buscar(nombreBanco).forEach[sucursalEncontrada | 
			val sucursalParseada = parsearSucursal(sucursalEncontrada)
			pois.add(sucursalParseada)
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
	def Banco parsearSucursal(SucursalBanco sucursal){
		val nombreBanco = sucursal.get("banco").asString()
		val x = sucursal.get("x").asDouble()
		val y = sucursal.get("y").asDouble()
		val nombreSucursal = sucursal.get("sucursal").asString()
		val gerente = sucursal.get("gerente").asString()
		val claves_servicios = this.parsearArrayServicios(sucursal)
		
		val sucursalParseada = new Banco(nombreBanco, x, y, nombreSucursal, gerente, claves_servicios)
		
		sucursalParseada
	}
	
/**
	 * Los servicios (o palabras clave) en el objeto JSON SucursalBanco son un 'array', y no pueden obtenerse en forma
	 * directa. Por tal motivo, se utiliza la siguiente función que recorre el array JSON y pone todos sus valores
	 * una lista de strings, que sí es un objeto de nuestro dominio.
	 * 
	 * @param sucursalBanco banco en formato JSON
	 * @return lista de strings de los servicios (o palabras claves) de un banco
	 */
	def List<String> parsearArrayServicios(SucursalBanco sucursal){
		val palabras_servicios = new ArrayList()
		
		val servicios = (sucursal.get("servicios").asArray()).values()
		
		for(JsonValue servicio : servicios){
			palabras_servicios.add(servicio.asString())
		}
		palabras_servicios
	}
	
}
