package edu.tp2016.pois

import edu.tp2016.mod.Comuna
import edu.tp2016.mod.Servicio
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDateTime
import org.uqbar.geodds.Point

@Accessors
class CGP extends POI{
	List<Servicio> servicios = new ArrayList<Servicio>
	Comuna comuna
	
	new(String unNombre, Point unaUbicacion, List<String> claves, Comuna unaComuna, List<Servicio> listaServicios) {
        super(unNombre, unaUbicacion, claves)
        comuna = unaComuna
        servicios = listaServicios
    }
	

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
		}else{
			incluyeServicio(nombreServicio) && (obtenerServicio(nombreServicio)).tieneRangoDeAtencionDisponibleEn(fecha)
		}
	}
	
	def boolean incluyeServicio(String texto){
		servicios.exists [servicio | servicio.contieneEnSuNombre(texto)]
	}
	
	override boolean coincide(String texto){
		(super.coincide(texto)) || (this.incluyeServicio(texto))
	}
	
}
