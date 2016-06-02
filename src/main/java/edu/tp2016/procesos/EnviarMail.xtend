package edu.tp2016.procesos

import edu.tp2016.serviciosExternos.Mail

class EnviarMail extends Proceso {

	override correr() {
		servidor.mailSender.sendMail(new Mail(usuario.mailAdress, "un mensaje", "un asunto"))
	}

}
