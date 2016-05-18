package edu.tp2016.Builder

import edu.tp2016.pois.Comercio
import org.uqbar.geodds.Point
import java.util.List
import edu.tp2016.mod.DiaDeAtencion
import edu.tp2016.mod.Rubro

class BuilderComercio {
		Comercio unPoi
	
	new(){
		unPoi = new Comercio
	}
	def build()
	{
		unPoi
	}
	def nombre (String unNombre)
	{
		unPoi.nombre=unNombre
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
	def rango(List<DiaDeAtencion> unRango){
		unPoi.rangoDeAtencion=unRango
		this
	}
	def rubro(Rubro unRubro){
		unPoi.rubro=unRubro
		this
	}
}