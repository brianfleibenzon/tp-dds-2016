package edu.tp2016.usuarios

import org.uqbar.geodds.Point
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import edu.tp2016.pois.POI
import org.joda.time.LocalDateTime
import java.util.ArrayList
import com.google.common.collect.Lists
import edu.tp2016.observersBusqueda.BusquedaObserver
import org.joda.time.Duration
import edu.tp2016.servidores.ServidorCentral

@Accessors
class Terminal implements Cloneable{
	
	ServidorCentral servidorCentral
	String nombreTerminal
	Point ubicacion
	LocalDateTime fechaActual
	List<BusquedaObserver> busquedaObservers = new ArrayList<BusquedaObserver>
	
/**
	 * Constructor para una Terminal (léase Usuario). La creo con su nombre (ej.: "terminalAbasto")
	 * y le indico quién es el Servidor Central (que es único).
	 * 
	 * @param
	 * @return una terminal
	 */

	new(Point _ubicacion, String terminal, ServidorCentral servidor) {
		ubicacion = _ubicacion
		nombreTerminal = terminal
		servidorCentral = servidor
		fechaActual = new LocalDateTime
	}

/**
	 * Constructor para una Terminal (léase Usuario). La creo con su nombre (ej.: "terminalAbasto")
	 * y le indico quién es el Servidor Central (que es único). Le tengo que indicar también la fecha actual.
	 * 
	 * @param
	 * @return una terminal con fecha actual parametrizable
	 */
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
	
	@Override
    override clone() throws CloneNotSupportedException {
        return super.clone();
    }
    
    def copyFrom(Terminal usuarioBefore){
    	servidorCentral = usuarioBefore.servidorCentral
		nombreTerminal = usuarioBefore.nombreTerminal
		ubicacion = usuarioBefore.ubicacion
		fechaActual = usuarioBefore.fechaActual
		busquedaObservers.addAll(usuarioBefore.busquedaObservers)
    }
}