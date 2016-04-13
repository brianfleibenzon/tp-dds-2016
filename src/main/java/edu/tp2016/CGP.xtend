package edu.tp2016

import org.uqbar.geodds.Point
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors


@Accessors
class CGP extends POI{
	List<Servicio> servicios
	Comuna comuna

	
	override boolean estaCercaA(Point ubicacionDispositivo){
		comuna.pertenecePunto(ubicacionDispositivo)
	}
	
	def Servicio obtenerServicio(String nombre){
		servicios.findFirst[servicio | nombre.equals(servicio.nombre)]
	}
	
	def boolean hayAlgunServicioAtendiendoEnElMomento(FechaCompleta unaFecha){
		servicios.exists[servicio | servicio.tieneRangoDeAtencionDisponibleEn(unaFecha)]
	}
	
	override boolean estaDisponible(FechaCompleta unaFecha,String nombreServicio){
		if(nombreServicio.equals(void)){
			hayAlgunServicioAtendiendoEnElMomento(unaFecha)
		}
		else{
			incluyeServicio(nombreServicio) && obtenerServicio(nombreServicio).estaDisponibleEn(unaFecha)
		}
	}
	
	def boolean incluyeServicio(String texto){
		servicios.exists [servicio | servicio.contieneEnSuNombre(texto)]
	}
	
	override boolean coincide(String texto){
		(super.coincide(texto)) || (this.incluyeServicio(texto))
	}
	
}