package edu.tp2016.builder

import edu.tp2016.pois.ParadaDeColectivo
import org.uqbar.geodds.Point
import java.util.List

class ParadaBuilder {
	
	ParadaDeColectivo unPoi
	
	new(){
		unPoi= new ParadaDeColectivo
	}
	
	def build(){
		unPoi
	}
	
	def nombre(String nombre){
		unPoi.nombre= nombre
		this
	}
	
	def ubicacion(Point ubicacion){
		unPoi.ubicacion= ubicacion
		this
	}
	
	def claves(List<String> claves){
		unPoi.palabrasClave= claves
		this
		
		
	}
	
	
	}
