package edu.tp2016.serviciosExternos

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Mail {
	String from
	String to
	String message
	String subject
	
	new(String destinatario, String mensaje, String asunto){
		from = "terminal@tppois.com"
		to = destinatario
		message = mensaje
		subject = asunto
	}
}
