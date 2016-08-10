package edu.tp2016.mod

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class Rubro {
	String nombre
	int radioDeCercania
	
	new(String unNombre, int unRadio){
		nombre = unNombre
		radioDeCercania = unRadio
	}
}
