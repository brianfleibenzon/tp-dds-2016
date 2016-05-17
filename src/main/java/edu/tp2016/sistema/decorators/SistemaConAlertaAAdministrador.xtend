package edu.tp2016.sistema.decorators

import edu.tp2016.pois.POI
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDateTime
import org.joda.time.Duration
import edu.tp2016.sistema.SistemaInterface
import edu.tp2016.sistema.Terminal

@Accessors
class SistemaConAlertaAAdministrador extends SistemaDecorator{
		
	new(SistemaInterface _sistema) {
		super(_sistema)
	}

	override List<POI> buscar(String texto, Terminal terminal) {
		val LocalDateTime inicioBusqueda = new LocalDateTime()
		val list = sistema.buscar(texto, terminal)
		val LocalDateTime finBusqueda = new LocalDateTime()
		val tiempo = new Duration(inicioBusqueda.toDateTime, finBusqueda.toDateTime).standardSeconds
		if (tiempo > terminal.timeout && terminal.activarNotificacionesAlAdministardor){
			sendMail()
		}
		list
	}
	
	def sendMail(){
		//Enviar mail a administrador
	}
}