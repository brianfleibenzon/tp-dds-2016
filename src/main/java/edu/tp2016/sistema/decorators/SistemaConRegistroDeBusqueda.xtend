package edu.tp2016.sistema.decorators

import java.util.List
import edu.tp2016.pois.POI
import java.util.ArrayList
import org.joda.time.LocalDateTime
import org.joda.time.Duration
import org.eclipse.xtend.lib.annotations.Accessors
import edu.tp2016.sistema.Sistema

@Accessors
class SistemaConRegistroDeBusqueda {

	List<RegistroBusqueda> busquedas = new ArrayList<RegistroBusqueda>
	Sistema sistema

	new(Sistema _sistema) {
		sistema = _sistema
	}

	def List<POI> buscar(String texto, String terminal) {
		val LocalDateTime inicioBusqueda = new LocalDateTime()
		val list = sistema.buscar(texto)
		val LocalDateTime finBusqueda = new LocalDateTime()
		val tiempo = new Duration(inicioBusqueda.toDateTime, finBusqueda.toDateTime).standardSeconds
		busquedas.add(new RegistroBusqueda(sistema.fechaActual, terminal, texto, list.length, tiempo))
		list
	}
	
	def generarReportePorFecha(){
		//TODO: 
	}
	
	def generarReportePorTerminal(){
		//TODO: 
	}
}
