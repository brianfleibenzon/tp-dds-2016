package edu.tp2016

import org.uqbar.geodds.Point
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class CGP extends POI{
	List<Servicio> servicios
	Comuna comuna
	
	override boolean estaCercaA(Point ubicacionDispositivo){
		super.estaCercaA(ubicacionDispositivo) && comuna.pertenecePunto(ubicacionDispositivo)
	}
	
	override boolean estaDisponible(){
		false //TODO: Eliminar linea
	}
	
	override boolean coincide(String texto){
		false //TODO: Eliminar linea
	}
}