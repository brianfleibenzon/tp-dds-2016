package edu.tp2016

import org.uqbar.geodds.Point
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDateTime

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
	
	def boolean hayAlgunServicioAtendiendoEnElMomento(LocalDateTime fecha){
		servicios.exists[servicio | servicio.tieneRangoDeAtencionDisponibleEn(fecha)]
	}
	
	override boolean estaDisponible(LocalDateTime fecha,String nombreServicio){
		if(nombreServicio.equals(void)){
			hayAlgunServicioAtendiendoEnElMomento(fecha)
		}
		else{
			incluyeServicio(nombreServicio)&& obtenerServicio(nombreServicio).estaDisponibleEn(fecha)
		}
	}
	
	def boolean incluyeServicio(String texto){
		servicios.exists [servicio | servicio.contieneEnSuNombre(texto)]
	}
	
	override boolean coincide(String texto){
		(texto.equalsIgnoreCase(nombre)) || (this.incluyeServicio(texto))
	}
	
	def List<String> serviciosNombres(){
		servicios.map [ nombre ]
	}
}