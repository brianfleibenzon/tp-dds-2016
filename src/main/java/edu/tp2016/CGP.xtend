package edu.tp2016

import org.uqbar.geodds.Point
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDateTime
import java.util.ArrayList

@Accessors
class CGP extends POI{
	List<Servicio> servicios = new ArrayList<Servicio>
	Comuna comuna

	override boolean estaCercaA(Point ubicacionDispositivo){
		comuna.pertenecePunto(ubicacionDispositivo)
	}
	
	def Servicio obtenerServicio(String nombre){
		servicios.findFirst[servicio | nombre.equals(servicio.nombre)]
	}
	
	def boolean hayAlgunServicioAtendiendoEnElMomento(LocalDateTime fecha){
		servicios.exists[servicio | servicio.tieneRangoDeAtencionDisponibleEn(fecha)]
	}
	
	override boolean estaDisponible(LocalDateTime fecha,String nombreServicio){
		if(nombreServicio.equals("")){
			hayAlgunServicioAtendiendoEnElMomento(fecha)
		}
		else{
			incluyeServicio(nombreServicio)&& (obtenerServicio(nombreServicio)).tieneRangoDeAtencionDisponibleEn(fecha)
		}
	}
	
	def boolean incluyeServicio(String texto){
		servicios.exists [servicio | servicio.contieneEnSuNombre(texto)]
	}
	
	override boolean coincide(String texto){
		(super.coincide(texto)) || (this.incluyeServicio(texto))
	}
	
}