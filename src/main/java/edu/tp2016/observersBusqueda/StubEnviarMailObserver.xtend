package edu.tp2016.observersBusqueda

import edu.tp2016.servidores.ServidorCentral
import java.util.List
import edu.tp2016.pois.POI
import edu.tp2016.serviciosExternos.MailSender
import edu.tp2016.servidores.ServidorLocal

class StubEnviarMailObserver extends EnviarMailObserver {
	new(long timeout, MailSender _sender) {
		super(timeout, _sender)
	}
	
	override def void registrarBusqueda(String texto, List<POI> poisDevueltos, long demora, ServidorLocal terminal, ServidorCentral servidor) {

		val stubDemora = (11).longValue()

		verificarTiempoDeConsulta(stubDemora)

	}

	override boolean enviarMail() {
		super.enviarMail()
	}
}
