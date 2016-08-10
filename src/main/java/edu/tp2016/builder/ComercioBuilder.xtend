package edu.tp2016.builder

import edu.tp2016.pois.Comercio
import edu.tp2016.mod.Rubro
import java.util.List
import edu.tp2016.mod.DiaDeAtencion
import org.uqbar.geodds.Point

class ComercioBuilder {
		Comercio unPoi
	
	new(){
		unPoi= new Comercio
	}
	
	def build(){
		unPoi
	}
	
	def nombre(String nombre){
		unPoi.nombre= nombre
		this
	}
	
	def ubicacion(Point ubicado){
		unPoi.ubicacion= ubicado
		this
	}

	def direccion(String unaDireccion){
		unPoi.direccion = unaDireccion
		this
	}
	
	def claves(List<String> claves){
		unPoi.palabrasClave.addAll(claves)
		this
		}
		
	def rubro(Rubro tipo){
		unPoi.rubro= tipo
		this
		}
	
	def rango(List<DiaDeAtencion> unRango){
		unPoi.rangoDeAtencion.addAll(unRango)
		this
	}
	}
