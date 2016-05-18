package edu.tp2016.Builder

import edu.tp2016.mod.Comuna
import edu.tp2016.mod.Servicio
import edu.tp2016.pois.CGP
import java.util.List
import org.uqbar.geodds.Point

class BuilderCGP{
	CGP unPoi
	new(){
		unPoi = new CGP
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
	def comuna(Comuna unaComuna){
		unPoi.comuna=unaComuna
		this
	}
	def servicios(List<Servicio> listaServicios)
	{
		unPoi.servicios=listaServicios
		this
	}
	def zonas(String zonas)
	{
		unPoi.zonasIncluidas=zonas
		this
	}
	def nombreDeDirector(String unNombre)
	{
		unPoi.nombreDirector=unNombre
		this
	}
	def telefono(String unTelefono)
	{	unPoi.telefono=unTelefono
		this
		
	}
}