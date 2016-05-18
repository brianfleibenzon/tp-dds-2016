package edu.tp2016.builder

import edu.tp2016.pois.CGP
import org.uqbar.geodds.Point
import java.util.List
import edu.tp2016.mod.Comuna
import edu.tp2016.mod.Servicio

class CGPBuilder {
	
		CGP unPoi
	
	new(){
		unPoi= new CGP
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
	
	def claves(List<String> claves){
		unPoi.palabrasClave= claves
		this
		}
		
	def comuna(Comuna _comuna){
		unPoi.comuna= _comuna
		this
		}
	
	def servicio(List<Servicio> _servicio){
		unPoi.servicios= _servicio
		this
	}
	
	def zonasIncluidas(String _zonasIncluidas){
		unPoi.zonasIncluidas= _zonasIncluidas
		this
	}
	
	def nombreDirector( String _nombreDirector){
		unPoi.nombreDirector= _nombreDirector
		this
	}
	
	def telefono(String numTelefono){
		unPoi.telefono= numTelefono
		this
	}	
	}
	