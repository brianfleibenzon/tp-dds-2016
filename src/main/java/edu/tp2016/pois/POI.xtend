package edu.tp2016.pois

import org.uqbar.geodds.Point
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDateTime
import java.util.ArrayList
import edu.tp2016.mod.DiaDeAtencion

@Accessors
abstract class POI {
	String nombre
	Point ubicacion
	List<DiaDeAtencion> rangoDeAtencion= new ArrayList<DiaDeAtencion> 
	String direccion
	List<String> palabrasClave= new ArrayList<String>
	
	new(String unNombre, Point unaUbicacion, List<String> claves){
		nombre = unNombre
		ubicacion = unaUbicacion
		palabrasClave = claves
	} // Constructor de POI, será implementado en las subclases como 'super'.
	
	def boolean estaDisponible(LocalDateTime unaFecha,String nombre)

	def boolean tieneRangoDeAtencionDisponibleEn(LocalDateTime fecha){
		rangoDeAtencion.exists[unRango | unRango.fechaEstaEnRango(fecha)]			
	}
	
	def boolean estaCercaA(Point ubicacionDispositivo){
		distanciaA(ubicacionDispositivo) < 5
	}
	
	def double distanciaA(Point unPunto){
		unPunto.distance(ubicacion) * 10
	}
	
	def boolean tienePalabraClave(String texto){
		palabrasClave.contains(texto)
	} // La búsqueda por palabra clave es igual para todos los POI.
	
	def boolean coincide(String texto){
		texto.equalsIgnoreCase(nombre) 
	}
	/* Por defecto, un POI coincide con la búsqueda si su nombre
		* coincide con el texto buscado.
	*/
	
}
