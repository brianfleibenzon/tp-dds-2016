package edu.tp2016.sistema.decorators

import edu.tp2016.pois.POI
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDateTime
import org.joda.time.Duration
import edu.tp2016.sistema.SistemaInterface
import edu.tp2016.sistema.Terminal
import edu.tp2016.serviciosExternos.MailSender

@Accessors
class SistemaConAlertaAAdministrador extends SistemaDecorator{
	
	MailSender mailSender
		
	new(SistemaInterface _sistema, MailSender _mailSender) {
		super(_sistema)
		mailSender = _mailSender
	}

	override List<POI> buscar(String texto, Terminal terminal) {
		val LocalDateTime inicioBusqueda = new LocalDateTime()
		val list = sistema.buscar(texto, terminal)
		val LocalDateTime finBusqueda = new LocalDateTime()
		val tiempo = new Duration(inicioBusqueda.toDateTime, finBusqueda.toDateTime).standardSeconds
		if (tiempo >= terminal.timeout && terminal.activarNotificacionesAlAdministardor){
			mailSender.send(terminal.emailAdministrador)
		}
		list
	}

}