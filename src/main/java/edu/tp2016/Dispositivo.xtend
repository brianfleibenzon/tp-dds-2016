package edu.tp2016

import org.uqbar.geodds.Point
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import com.google.common.collect.Lists //Importada a través de una dependencia en el 'pom'.
import java.util.Arrays

@Accessors
class Dispositivo {
	Point ubicacionActual
	FechaCompleta fechaActual
	List<POI> pois
	Direccion direccion
		
	def  filtrarBancos(Banco unBanco){
		pois.filter[unPOI | (unPOI.class).equals(unBanco.class)]
	}
		
	def boolean consultarCercania(POI unPoi){
		
		unPoi.estaCercaA(ubicacionActual)
	}
	
	def boolean consultarDisponibilidad(POI unPoi, String valorX){
		unPoi.estaDisponible(fechaActual,valorX)
	}
	
	def Iterable<POI> encontradosPorBusqueda(String texto){
		pois.filter [poi | (poi.tienePalabraClave(texto)) || (poi.coincide(texto))]
	}
	
		def List<POI> buscar(String texto){
		Arrays.asList(Lists.newArrayList(this.encontradosPorBusqueda(texto)))
	}/* Dado que el filter retorna una colección de tipo ITERATOR, en este método se convierte la colección
	 * de ITERARTOR a ARRAYLIST, y finamente de ARRAYLIST a LIST, que es el tipo que usamos.
	 */
	
	
}