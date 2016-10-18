package edu.tp2016.pois

import edu.tp2016.mod.Comuna
import edu.tp2016.mod.Servicio
import java.util.ArrayList
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDateTime
import org.uqbar.geodds.Point
import edu.tp2016.serviciosExternos.cgp.CentroDTO
import java.util.Arrays
import edu.tp2016.mod.DiaDeAtencion
import org.uqbar.commons.utils.Observable
import javax.persistence.Entity
import javax.persistence.Column
import javax.persistence.ManyToOne
import javax.persistence.OneToMany
import javax.persistence.FetchType
import javax.persistence.DiscriminatorValue
import javax.persistence.CascadeType
import java.util.Set
import java.util.HashSet
import edu.tp2016.mod.Punto

@Entity
@DiscriminatorValue("2")
@Observable
@Accessors
class CGP extends POI {
	@OneToMany(fetch=FetchType.EAGER, cascade=CascadeType.ALL)
	Set<Servicio> servicios = new HashSet<Servicio>
	
	@ManyToOne(cascade=CascadeType.ALL)
	Comuna comuna
	
	@Column(length=100)
	String barriosIncluidos
	
	@Column(length=100)
	String nombreDirector
	
	@Column(length=100)
	String telefono
	
	new(CentroDTO unCentro) {
		super("CGP " + unCentro.numeroComuna, new Point(unCentro.x, unCentro.y), Arrays.asList())

		unCentro.servicios.forEach [ unServicio |
			val rangos = new ArrayList<DiaDeAtencion>
			unServicio.rangos.forEach [ unRango |
				rangos.add(
					new DiaDeAtencion(unRango.numeroDia, unRango.horarioDesde, unRango.horarioHasta,
						unRango.minutosDesde, unRango.minutosHasta))
			]
			servicios.add(new Servicio(unServicio.nombreServicio, rangos))

		]
		
		comuna = new Comuna()=>[
			numero = unCentro.numeroComuna
		]

	}

    new(){ } // default
    
	override boolean estaCercaA(Punto ubicacionDispositivo) {
		comuna.pertenecePunto(ubicacionDispositivo)
	}

	def Servicio obtenerServicio(String nombre) {
		servicios.findFirst[servicio|nombre.equals(servicio.nombre)]
	}

	def boolean hayAlgunServicioAtendiendoEnElMomento(LocalDateTime fecha) {
		servicios.exists[servicio|servicio.tieneRangoDeAtencionDisponibleEn(fecha)]
	}

	override boolean estaDisponible(LocalDateTime fecha, String nombreServicio) {
		if (nombreServicio.equals("")) {
			hayAlgunServicioAtendiendoEnElMomento(fecha)
		} else {
			incluyeServicio(nombreServicio) && (obtenerServicio(nombreServicio)).tieneRangoDeAtencionDisponibleEn(fecha)
		}
	}

	def boolean incluyeServicio(String texto) {
		servicios.exists[servicio|servicio.contieneEnSuNombre(texto)]
	}

	override boolean coincide(String texto) {
		(super.coincide(texto)) || (this.incluyeServicio(texto))
	}

}
