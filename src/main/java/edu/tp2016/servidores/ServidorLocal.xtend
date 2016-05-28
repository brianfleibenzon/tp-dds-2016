package edu.tp2016.servidores

import org.uqbar.geodds.Point
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import edu.tp2016.pois.POI
import org.joda.time.LocalDateTime
import java.util.ArrayList
import com.google.common.collect.Lists
import edu.tp2016.observersBusqueda.BusquedaObserver
import org.joda.time.Duration

@Accessors
class ServidorLocal{
	
	ServidorCentral servidorCentral
	String nombreTerminal
	Point ubicacion
	LocalDateTime fechaActual
	List<BusquedaObserver> busquedaObservers = new ArrayList<BusquedaObserver>
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
		fechaActual = new LocalDateTime
	}

	new(Point _ubicacion, String terminal, ServidorCentral servidor, LocalDateTime _fecha) {
		ubicacion = _ubicacion
		nombreTerminal = terminal
		servidorCentral = servidor
		fechaActual = _fecha
	} // Constructor con fecha parametrizable (solo para test de Disponibilidad)
	
	def adscribirObserver(BusquedaObserver observador){
		busquedaObservers.add(observador)
	}
	
	def quitarObserver(BusquedaObserver observador){
		busquedaObservers.remove(observador)
	}

	def boolean consultarCercania(POI unPoi) {
		unPoi.estaCercaA(ubicacion)
	}

	def boolean consultarDisponibilidad(POI unPoi, String textoX) {
		unPoi.estaDisponible(fechaActual, textoX)
	}
	
	def List<POI> buscar(String texto){
		
		val t1 = new LocalDateTime()
		val listaDePoisDevueltos = Lists.newArrayList(servidorCentral.buscarPor(texto))
		val t2 = new LocalDateTime()
		
		val demora = (new Duration(t1.toDateTime, t2.toDateTime)).standardSeconds
		
		busquedaObservers.forEach [ observer |
			observer.registrarBusqueda(texto, listaDePoisDevueltos, demora, this, servidorCentral) ]

		listaDePoisDevueltos
	}
	
}