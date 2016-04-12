package edu.tp2016

import org.uqbar.geodds.Point
import org.joda.time.LocalDate
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import com.google.common.collect.Lists //Importada a través de una dependencia en el 'pom'.
import java.util.Arrays

@Accessors
class Dispositivo {
	Point ubicacionActual
	LocalDate fechaActual
	List<POI> pois
	Direccion direccion
	
	def boolean consultarCercania(POI unPoi){
		unPoi.estaCercaA(ubicacionActual)
	}
	
	def boolean consultarDisponibilidad(POI unPoi){
		false //TODO: Eliminar línea
	}
	
	def Iterable<POI> encontradosPorBusqueda(String texto){
		pois.filter [poi | (poi.tienePalabraClave(texto)) || (poi.coincide(texto))]
	}
	
	def List<POI> buscar(String texto){
		Arrays.asList(Lists.newArrayList(this.encontradosPorBusqueda(texto)))
	}/* Hice este método porque el filter me devuelve una colección de tipo de dato ITERATOR, entonces debo pasar del
	 * ITERARTOR a un ARRAYLIST, y finamente del ARRAYLIST auna LIST (no encontré una forma más feliz)
	 */
}