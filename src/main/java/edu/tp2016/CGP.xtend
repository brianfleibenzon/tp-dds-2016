package edu.tp2016

import org.uqbar.geodds.Point
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDate

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
	
	def boolean hayAlgunServicioAtendiendoEnElMomento(int unDia,int unaHora){
		servicios.exists[servicio | servicio.tieneRangoDeAtencionDisponibleEn(unDia,unaHora)]
	}
	
	override boolean estaDisponible(LocalDate fecha,String nombreServicio){
		if(nombreServicio.equals(void)){
			hayAlgunServicioAtendiendoEnElMomento(fecha.getDayOfWeek,fecha.)
		}
		else{
			incluyeServicio(nombreServicio)&& obtenerServicio(nombreServicio).estaDisponibleEn(fecha.getDayOfMonth,fecha.)
		}
	}
	
	def boolean incluyeServicio(String texto){
		servicios.exists [servicio | servicio.contieneEnSuNombre(texto)]
	}
	
	override boolean coincide(String texto){
		(texto.equals(nombre)) || (this.incluyeServicio(texto))
	}
}