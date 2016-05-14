package edu.tp2016.sistema.decorators

import edu.tp2016.pois.POI
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDateTime
import org.joda.time.Duration

@Accessors
class SistemaConAlertaAAdministrador{
		
	SistemaConRegistroDeBusqueda sistema

	new(SistemaConRegistroDeBusqueda _sistema) {
		sistema = _sistema
	}

	def List<POI> buscar(String texto, String terminal, int timeout) {
		val LocalDateTime inicioBusqueda = new LocalDateTime()
		val list = sistema.buscar(texto, terminal)
		val LocalDateTime finBusqueda = new LocalDateTime()
		val tiempo = new Duration(inicioBusqueda.toDateTime, finBusqueda.toDateTime).standardSeconds
		if (tiempo > timeout){
			//TODO: Enviar correo a administrador
		}
		list
	}
	
	def generarReportePorFecha(){
		sistema.generarReportePorFecha()
	}
	
	def generarReportePorTerminal(){
		sistema.generarReportePorFecha()
	}
}