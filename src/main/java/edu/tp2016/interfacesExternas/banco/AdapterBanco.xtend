package edu.tp2016.interfacesExternas.banco

import java.util.List
import edu.tp2016.pois.POI
import java.util.ArrayList
import edu.tp2016.pois.Banco
import edu.tp2016.interfacesExternas.InterfazExterna
import java.util.Arrays
import com.eclipsesource.json.Json
import com.eclipsesource.json.JsonValue

class AdapterBanco extends InterfazExterna{
	InterfazBanco interfazExternaBancos
	
	new(InterfazBanco _interfaz){
		interfazExternaBancos = _interfaz
}

/**
	 * Adapter entre la búsqueda mediante la interfaz externa para búsqueda de Bancos y el repositorio local.
	 * Genera una lista de POIs a partir de la lista de SucursalBanco (objetos JSON) que recibimos desde la interfaz externa.
	 * Dicha interfaz necesita como parámetro de búsqueda un String que represente el nombre del Banco,
	 * y devuelve todas las sucursales que cumplen con ese criterio.
	 * 
	 * @param nombreBanco cadena de texto que representa el nombre de un Banco
	 * @return Lista de POIs (que incluye solo Bancos)
	 */

	override def List<POI> buscar(String nombreBanco){ 
		val pois = new ArrayList<POI>
		
		interfazExternaBancos.buscar(nombreBanco).forEach[sucursalEncontrada | 
			val sucursalParseada = parsearSucursal(sucursalEncontrada)
			pois.add(sucursalParseada)
		]
		pois
	}
	
/**
	 * ParsearSucursal convierte una SucursalBanco, que es un objeto Banco pero en formato JSON,
	 * a un objeto Banco en el formato de nuestro dominio.
	 * 
	 * @param sucursal banco de tipo SucursalBanco
	 * @return Banco, un banco en el formato de nuestro dominio
	 */
	def Banco parsearSucursal(SucursalBanco sucursal){
		val nombreBanco = sucursal.get("banco").asString()
		val x = sucursal.get("x").asInt()
		val y = sucursal.get("y").asInt()
		val _sucursal = sucursal.get("sucursal").asString()
		val gerente = sucursal.get("gerente").asString()
		val claves_servicios = this.parsearArrayServicios(sucursal)
		
		val sucursalParseada = new Banco(nombreBanco, x, y, _sucursal, gerente, claves_servicios)
		
		sucursalParseada
	}
	
/**
	 * Los servicios en el objeto JSON SucursalBancaria son un 'array', y no pueden obtenerse en forma directa.
	 * Por tal motivo, se utiliza la siguiente función que recorre el array JSON y pone todos sus valores
	 * una lista de strings, que sí es un objeto de nuestro dominio.
	 * 
	 * @param sucursal banco de tipo SucursalBanco
	 * @return Lista de strings, los servicios (o palabras claves) de un banco
	 */
	def List<String> parsearArrayServicios(SucursalBanco sucursal){
		val palabras_servicios = new ArrayList
		val servicios = Json.parse("servicios").asArray()
		
		for(JsonValue servicio : servicios){
			palabras_servicios.add(servicio.asString())
		}
		Arrays.asList(palabras_servicios)
	}
	
}
