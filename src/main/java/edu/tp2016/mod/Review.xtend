package edu.tp2016.mod

import edu.tp2016.usuarios.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import javax.persistence.Entity
import javax.persistence.ManyToOne
import javax.persistence.Column
import javax.persistence.Id
import javax.persistence.GeneratedValue

@Entity
@Observable
@Accessors
class Review {
	@Id
	@GeneratedValue
	private Long id
	
	@Column()
	int calificacion
	
	@ManyToOne()
	Usuario usuario
	
	@Column(length=100)
	String comentario
	
	new (int calificacion, Usuario usuario, String comentario){
		this.calificacion = calificacion
		this.usuario = usuario
		this.comentario = comentario
	}
	
	new(){}
}