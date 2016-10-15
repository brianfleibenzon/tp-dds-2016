package edu.tp2016.pois

import org.uqbar.geodds.Point
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDateTime
import javax.persistence.Entity
import javax.persistence.Column
import javax.persistence.DiscriminatorValue
import edu.tp2016.mod.Punto

@Entity
@DiscriminatorValue("4")
@Accessors
class ParadaDeColectivo extends POI{
	@Column(length=100)
	String linea
	    
    new(){ } // default
	
	override boolean estaCercaA(Punto ubicacionDispositivo){
		 distanciaA(ubicacionDispositivo) < 1
	}
	
	override boolean estaDisponible(LocalDateTime fecha,String Nombre){
		 true
	}	
}
