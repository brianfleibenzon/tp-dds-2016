package edu.tp2016.procesos

import edu.tp2016.serviciosExternos.Mail
import edu.tp2016.servidores.ServidorCentral
import edu.tp2016.usuarios.Administrador

class EnviarMail extends Proceso {
	
	override iniciar(Administrador _usuarioAdministrador, ServidorCentral _servidor){
		usuarioAdministrador = _usuarioAdministrador
		servidor = _servidor
		this.correr()
	}

	override correr() {
		servidor.mailSender.sendMail(new Mail(usuarioAdministrador.mailAdress, "un mensaje", "un asunto"))
	}

}
