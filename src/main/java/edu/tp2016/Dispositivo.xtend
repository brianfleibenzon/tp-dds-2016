package edu.tp2016

import org.uqbar.geodds.Point
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import com.google.common.collect.Lists //Importada a través de una dependencia en el 'pom'.
import java.util.Arrays
import org.joda.time.LocalDateTime
import java.util.ArrayList
import edu.tp2016.pois.POI
import edu.tp2016.interfacesExternas.InterfazExterna

@Accessors
class Dispositivo {
	Point ubicacionActual
	LocalDateTime fechaActual
	List<POI> pois = new ArrayList<POI>
	String direccion
	List<InterfazExterna> interfacesExternas = new ArrayList<InterfazExterna>

	new(Point unaUbicacion, List<POI> listaPois, LocalDateTime unaFecha) {
		ubicacionActual = unaUbicacion
		pois = listaPois
		fechaActual = unaFecha
	}

	def boolean consultarCercania(POI unPoi) {
		unPoi.estaCercaA(ubicacionActual)
	}

	def boolean consultarDisponibilidad(POI unPoi, String valorX) {
		unPoi.estaDisponible(fechaActual, valorX)
	}
	
	def void obtenerPoisDeInterfacesExternas(String texto, List<POI> poisBusqueda){
		interfacesExternas.forEach[unaInterfaz|
			poisBusqueda.addAll(unaInterfaz.buscar(texto))
		]
	}

	def Iterable<POI> encontradosPorBusqueda(String texto) {
		val poisBusqueda = new ArrayList<POI>
		poisBusqueda.addAll(pois)
		
		obtenerPoisDeInterfacesExternas(texto, poisBusqueda)

		poisBusqueda.filter[poi|!texto.equals("") && (poi.tienePalabraClave(texto) || poi.coincide(texto))]
	
	}

	def List<POI> buscar(String texto) {
		Arrays.asList(Lists.newArrayList(this.encontradosPorBusqueda(texto)))
	}
/* Dado que el filter retorna una colección de tipo ITERATOR, en este método se convierte la colección
 * de ITERARTOR a ARRAYLIST, y finamente de ARRAYLIST a LIST, que es el tipo que usamos.
 */
}
