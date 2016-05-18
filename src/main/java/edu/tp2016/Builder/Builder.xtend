package edu.tp2016.Builder

import java.util.List
import org.uqbar.geodds.Point

class Builder {
		
	BuilderParada constructorParada
	
	def construirParada(String unNombre, Point unaUbicacion, List<String> claves){
	
	constructorParada= new BuilderParada()
	}
	def void construirBanco(){}
	def void construirCGP(){}
	def void construirComercio(){}
}