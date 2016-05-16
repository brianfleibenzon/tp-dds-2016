package edu.tp2016.serviciosExternos

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Mail {
	String from
	String to
	String message
	String subject
	
	new(String emisor, String destinatario, String mensaje, String asunto){
		from = emisor
		to = destinatario
		message = mensaje
		subject = asunto
	}
}