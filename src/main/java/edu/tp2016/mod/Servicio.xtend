package edu.tp2016.mod

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDateTime
import java.util.ArrayList
import org.uqbar.commons.utils.Observable
import javax.persistence.Entity
import javax.persistence.Column
import javax.persistence.OneToMany
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.CascadeType

@Entity
@Observable
@Accessors
class Servicio {
	@Id
	@GeneratedValue
	private Long id
	
	@Column(length=100)
	String nombre
	
	@OneToMany(cascade=CascadeType.ALL)
	List<DiaDeAtencion> rangoDeAtencion = new ArrayList<DiaDeAtencion>
	
	new(String unNombre, List<DiaDeAtencion> unRango) {
        nombre = unNombre
        rangoDeAtencion = unRango
    }
	

	def boolean contieneEnSuNombre(String texto){
		nombre.contains(texto)
	}

	def boolean tieneRangoDeAtencionDisponibleEn(LocalDateTime fecha){
		rangoDeAtencion.exists[unRango | unRango.fechaEstaEnRango(fecha) ]			
	}
	
	new(){}
}
