package edu.tp2016.mod

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.GeneratedValue

@Entity
@Observable
@Accessors
class Rubro {
	@Id
	@GeneratedValue
	private Long id
	
	@Column(length=100)
	String nombre
	
	@Column()
	int radioDeCercania
	
	new(String unNombre, int unRadio){
		nombre = unNombre
		radioDeCercania = unRadio
	}
	
	new(){}
}
