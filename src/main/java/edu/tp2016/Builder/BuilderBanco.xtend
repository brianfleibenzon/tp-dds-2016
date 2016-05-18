package edu.tp2016.Builder

import edu.tp2016.pois.Banco
import java.util.List
import org.uqbar.geodds.Point

class BuilderBanco {
	Banco unPoi
	
	new(){
		unPoi = new Banco
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
	def sucursal(String unaSucursal)
	{
		unPoi.sucursal=unaSucursal
		this
	}
	def nombreDeGerente(String nombreGerente)
	{
		unPoi.nombreGerente=nombreGerente
		this
	}
	def rangoDeAtencion()
	{
		unPoi.setRangoDeAtencionBancario()
		this
	}
}