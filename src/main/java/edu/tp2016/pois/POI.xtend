package edu.tp2016.pois

import edu.tp2016.mod.DiaDeAtencion
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDateTime
import org.uqbar.geodds.Point
import org.uqbar.commons.model.Entity

@Accessors
abstract class POI extends Entity {
	String nombre
	double ID
	Point ubicacion
	List<DiaDeAtencion> rangoDeAtencion = new ArrayList<DiaDeAtencion>
	String direccion
	List<String> palabrasClave = new ArrayList<String>

	/**
	 * Constructor de POI, será redefinido en las subclases, por lo que hay que llamar a 'super'
	 * 
	 * @param unNombre nombre del POI
	 * @param unaUbicacion la ubicacion del POI en formato Point(x, y)
	 * @param claves lista de strings con etiquetas
	 */
	new(String unNombre, Point unaUbicacion, List<String> claves) {
		nombre = unNombre
		ubicacion = unaUbicacion
		palabrasClave = claves
	}
	
	new(){
		
	}

	def boolean estaDisponible(LocalDateTime unaFecha, String nombre)

	def boolean tieneRangoDeAtencionDisponibleEn(LocalDateTime fecha) {
		rangoDeAtencion.exists[unRango|unRango.fechaEstaEnRango(fecha)]
	}

	def boolean estaCercaA(Point ubicacionDispositivo) {
		distanciaA(ubicacionDispositivo) < 5
	}

	def double distanciaA(Point unPunto) {
		unPunto.distance(ubicacion) * 10
	}

	/**
	 * Busca el texto en las palabras claves del POI
	 * La búsqueda por palabra clave es igual para todos los POI.
	 * 
	 * @param texto cadena de busqueda
	 * @return valor de verdad si se encuentra el texto en alguna palabra clave
	 */
	def boolean tienePalabraClave(String texto) {
		palabrasClave.contains(texto)

	}

	/**
	 * Busca el texto en el nombre del POI
	 * 
	 * @param texto cadena de busqueda
	 * @return valor de verdad si el nombre coincide con el texto
	 */
	def boolean coincide(String texto) {
		texto.equalsIgnoreCase(nombre)
	}

}
