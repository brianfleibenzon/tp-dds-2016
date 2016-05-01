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
	InterfazBanco interfaz
	
	new(InterfazBanco _interfaz){
		interfaz = _interfaz
}

/**
	 * Adapter entre la búsqueda mediante la interfaz externa y el repositorio local
	 * Crea una lista de POIs a partir de la lista de SucursalBanco (objetos JSON) que recibimos desde la interfaz externa
	 * La interfaz externa necesita como parámetro de búsqueda un string que represente el nombre del banco,
	 * y nos devolverá todas las sucursales que cumplan con ese criterio.
	 * 
	 * @param Cadena de texto que representa el nombre de un Banco
	 * @return Lista de POIs (que incluye solo Bancos)
	 */

	override def List<POI> buscar(String nombreBanco){ 
		val pois = new ArrayList<POI>
		
		interfaz.buscar(nombreBanco).forEach[sucursalEncontrada | 
			val sucursalParseada = parsearSucursal(sucursalEncontrada)
			pois.add(sucursalParseada)
		]
		pois
	}
	
	// Uso el parser de minimal-json
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
	
	// Parseo un array del objeto JSON sucursal
	def List<String> parsearArrayServicios(SucursalBanco sucursal){
		val palabras_servicios = new ArrayList
		val servicios = Json.parse("servicios").asArray()
		
		for(JsonValue servicio : servicios){
			palabras_servicios.add(servicio.asString())
		}
		Arrays.asList(palabras_servicios)
	}
	
}
