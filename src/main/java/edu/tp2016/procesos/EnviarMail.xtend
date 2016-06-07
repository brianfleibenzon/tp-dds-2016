package edu.tp2016.procesos

import edu.tp2016.serviciosExternos.Mail
import edu.tp2016.servidores.ServidorCentral
import edu.tp2016.usuarios.Administrador

class EnviarMail extends Proceso {

	override String correr() {
		servidor.mailSender.sendMail(new Mail(usuarioAdministrador.mailAdress, "un mensaje", "un asunto"))
		
		return "ok" // TODO: Ver bien qué y cómo lo devuelve
	}
	
	new(ServidorCentral _servidor, Administrador admin){
		usuarioAdministrador = admin
		servidor = _servidor
	}

}
