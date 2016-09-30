package edu.tp2016.mod

import edu.tp2016.usuarios.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class Review {
	int calificacion
	Usuario usuario
	String comentario
	
	new (int calificacion, Usuario usuario, String comentario){
		this.calificacion = calificacion
		this.usuario = usuario
		this.comentario = comentario
	}
}