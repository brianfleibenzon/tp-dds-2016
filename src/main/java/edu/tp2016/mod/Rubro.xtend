package edu.tp2016.mod

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Rubro {
	String nombre
	int radioDeCercania
	
	new(String unNombre, int unRadio){
		nombre = unNombre
		radioDeCercania = unRadio
	}
}
