package edu.tp2016.pois

import org.uqbar.geodds.Point
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDateTime

import edu.tp2016.mod.Rubro
import javax.persistence.Entity
import javax.persistence.ManyToOne
import javax.persistence.DiscriminatorValue
import edu.tp2016.mod.Punto
import javax.persistence.CascadeType

@Entity
@DiscriminatorValue("3")
@Accessors
class Comercio extends POI{
	@ManyToOne(cascade=CascadeType.ALL)
	Rubro rubro
	
	new(){ } // default
	
	override boolean estaCercaA(Punto ubicacionDispositivo){
		 distanciaA(ubicacionDispositivo) < rubro.radioDeCercania
	}
	
	override boolean estaDisponible(LocalDateTime fecha, String nombre){
		this.tieneRangoDeAtencionDisponibleEn(fecha)
	}
	
	override boolean coincide(String texto){
		 (super.coincide(texto)) || (texto.equalsIgnoreCase(rubro.nombre))
	}
}
