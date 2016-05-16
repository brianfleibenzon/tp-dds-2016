package edu.tp2016.servidores

import org.uqbar.geodds.Point
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.ArrayList
import edu.tp2016.pois.POI
import edu.tp2016.observersBusqueda.RegistroDeBusqueda
import org.joda.time.LocalDateTime

@Accessors
class ServidorLocal{
	
	ServidorCentral servidorCentral
	List<RegistroDeBusqueda> busquedas = new ArrayList<RegistroDeBusqueda>
	String nombreTerminal

/**
	 * Constructor para un ServidorLocal. Lo creo con su nombre (ej.: "terminalAbasto")
	 * y le indico quién es su ServidorCentral (que es único).
	 * 
	 * @param nombre cadena de texto que representa el nombre de un ServidorLocal
	 * @return servidorCentral el servidor central de todos los servidores locales
	 */
	new(String terminal, ServidorCentral servidor) {
		nombreTerminal = terminal
		servidorCentral.agregarServidorLocal(this)
	}

	def boolean consultarCercania(POI unPoi, Point ubicacion) {
		unPoi.estaCercaA(ubicacion)
	}

	def boolean consultarDisponibilidad(POI unPoi, String valorX) {
		val fechaActual = new LocalDateTime
		unPoi.estaDisponible(fechaActual,valorX)
	}
	
	def List<POI> buscar(String texto){
		
		val busquedaActual = new RegistroDeBusqueda(new LocalDateTime, nombreTerminal)
		
		val searchResult = servidorCentral.buscarEnRepoCentral(texto, busquedaActual)
		
		busquedas.add(busquedaActual)
		
		searchResult
		
	}
	
}