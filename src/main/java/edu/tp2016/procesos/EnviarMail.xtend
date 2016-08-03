package edu.tp2016.procesos

import edu.tp2016.serviciosExternos.Mail
import edu.tp2016.usuarios.Administrador
import edu.tp2016.usuarios.Terminal

class EnviarMail extends Proceso {
	
	override iniciar(Administrador _usuarioAdministrador, Terminal unaTerminal){
		usuarioAdministrador = _usuarioAdministrador
		terminal = unaTerminal
		this.correr()
	}

	override correr() {
		terminal.mailSender.sendMail(new Mail(usuarioAdministrador.mailAdress, "un mensaje", "un asunto"))
	}

}
