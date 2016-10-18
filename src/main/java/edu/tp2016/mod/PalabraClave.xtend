package edu.tp2016.mod

import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.Column

@Entity
class PalabraClave {
	@Id
	@Column(name="clave_id")
	int id
	
	@Column(length = 100)
	String clave
	
	new(){}
	
	new (String palabra){
		clave = palabra
	}	
}