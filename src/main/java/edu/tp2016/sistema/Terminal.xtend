package edu.tp2016.sistema

import org.uqbar.geodds.Point
import org.joda.time.LocalDateTime
import edu.tp2016.pois.POI
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Terminal {
	SistemaInterface sistema
	String nombreTerminal
	Point ubicacion
	boolean puedeGenerarReportes = true
	boolean notificaAlAdministrador = true
	LocalDateTime fechaActual
	int timeout
	
	new(String _terminal, Point _ubicacion, SistemaInterface _sistema) {
		ubicacion = _ubicacion
		nombreTerminal = _terminal
		sistema = _sistema
		fechaActual = new LocalDateTime
	}
	
	new(String _terminal, Point _ubicacion, SistemaInterface _sistema, LocalDateTime fecha) {
		ubicacion = _ubicacion
		nombreTerminal = _terminal
		sistema = _sistema
		fechaActual = fecha
	}
	
	def boolean consultarCercania(POI unPoi) {
		unPoi.estaCercaA(ubicacion)
	}

	def boolean consultarDisponibilidad(POI unPoi, String textoX) {
		unPoi.estaDisponible(fechaActual, textoX)
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
	
	def List<POI> buscar(String texto){
		
		sistema.buscar(texto, this)

	}
}