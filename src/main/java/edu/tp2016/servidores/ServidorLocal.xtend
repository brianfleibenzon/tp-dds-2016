package edu.tp2016.servidores

import org.uqbar.geodds.Point
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import edu.tp2016.pois.POI
import edu.tp2016.observersBusqueda.RegistroDeBusqueda
import org.joda.time.LocalDateTime
import java.util.ArrayList

@Accessors
class ServidorLocal{
	
	ServidorCentral servidorCentral
	String nombreTerminal
	Point ubicacion
	List<RegistroDeBusqueda> busquedasTerminal = new ArrayList<RegistroDeBusqueda>
	LocalDateTime fechaActual
	boolean puedeGenerarReportes = true
	boolean notificaAlAdministrador = true

/**
	 * Constructor para un ServidorLocal. Lo creo con su nombre (ej.: "terminalAbasto")
	 * y le indico quién es su ServidorCentral (que es único).
	 * 
	 * @param nombre cadena de texto que representa el nombre de un ServidorLocal
	 * @return servidorCentral el servidor central de todos los servidores locales
	 */

	new(Point _ubicacion, String terminal, ServidorCentral servidor) {
		ubicacion = _ubicacion
		nombreTerminal = terminal
		servidorCentral = servidor
		servidor.agregarServidorLocal(this)
		fechaActual = new LocalDateTime
	}

	new(Point _ubicacion, String terminal, ServidorCentral servidor, LocalDateTime _fecha) {
		ubicacion = _ubicacion
		nombreTerminal = terminal
		servidorCentral = servidor
		servidor.agregarServidorLocal(this)
		fechaActual = _fecha
	} // Constructor con fecha parametrizable (solo para test de Disponibilidad)


	def boolean consultarCercania(POI unPoi) {
		unPoi.estaCercaA(ubicacion)
	}

	def boolean consultarDisponibilidad(POI unPoi, String textoX) {
		unPoi.estaDisponible(fechaActual, textoX)
	}
	
	def List<POI> buscar(String texto){
		
		val busquedaActual = new RegistroDeBusqueda(fechaActual, nombreTerminal, notificaAlAdministrador)
		
		val searchResult = servidorCentral.buscarEnRepoCentral(texto, busquedaActual)
		
		busquedasTerminal.add(busquedaActual)
		
		searchResult
	}
	
	def activarNotificacionesAlAdministardor(){
		notificaAlAdministrador = true
	}
	
	def desactivarNotificacionesAlAdministardor(){
		notificaAlAdministrador = false
	}
	
	def desactivarGeneracionDeReportes(){
		puedeGenerarReportes = false
	}
	
	def activarGeneracionDeReportes(){
		puedeGenerarReportes = true
	}
	
}