package edu.tp2016.Builder

import edu.tp2016.pois.ParadaDeColectivo
import org.uqbar.geodds.Point
import java.util.List

class BuilderParada {
	
	ParadaDeColectivo unPoi
		
	new(){
		unPoi = new ParadaDeColectivo
	}
	def build()
	{
		unPoi
	}
	def nombre (String nombreBanco)
	{
		unPoi.nombre=nombreBanco
		this
	}
	def ubicacion(Point unaUbicacion)
	{
		unPoi.ubicacion= unaUbicacion
		this
	}
	def claves(List<String>claves)
	{
		unPoi.palabrasClave=claves
		this
	}
}