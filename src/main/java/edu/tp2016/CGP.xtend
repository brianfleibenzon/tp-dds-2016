package edu.tp2016

import org.uqbar.geodds.Point
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class CGP extends POI{
	List<Servicio> servicios
	//COMENTO LINEA PORQUE nombre ES NULO AL CREAR CLASE
	//List<String> serviciosNombres = servicios.map [ nombre ]
	Comuna comuna
	
	override boolean estaCercaA(Point ubicacionDispositivo){
		comuna.pertenecePunto(ubicacionDispositivo)
	}
	
	override boolean estaDisponible(){
		false //TODO: Eliminar linea
	}
	
	def boolean incluyeServicio(String texto){
		servicios.exists [servicio | servicio.contieneEnSuNombre(texto)]
	}
	
	override boolean coincide(String texto){
		(texto.equals(nombre)) || (this.incluyeServicio(texto))
	}
}