package edu.tp2016.pois

import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDateTime
import org.uqbar.geodds.Point
import java.util.List
import edu.tp2016.mod.DiaDeAtencion
import java.util.Arrays
import org.uqbar.commons.utils.Observable
import javax.persistence.Entity
import javax.persistence.Column
import javax.persistence.DiscriminatorValue

@Entity
@DiscriminatorValue("1")
@Observable
@Accessors
class Banco extends POI {
	@Column(length=100)
	String sucursal
	
	@Column(length=100)
	String nombreGerente

	def void setRangoDeAtencionBancario() {
		val lunes = new DiaDeAtencion(1, 10, 15, 0, 0)
		val martes = new DiaDeAtencion(2, 10, 15, 0, 0)
		val miercoles = new DiaDeAtencion(3, 10, 15, 0, 0)
		val jueves = new DiaDeAtencion(4, 10, 15, 0, 0)
		val viernes = new DiaDeAtencion(5, 10, 15, 0, 0)

		rangoDeAtencion.addAll(Arrays.asList(lunes, martes, miercoles, jueves, viernes))
	}

	/**
	 * Constructores para la creación de Bancos:
	 * El primero es el constructor original de la Primer Entrega.
	 * El segundo es necesario para crear un Banco de nuestro dominio, a partir del Banco que nos devuelve
	 * la interfaz externa de búsqueda y que debemos seguidamente parsear
	 * 
	 * @param Atributos de un Banco
	 * @return Nuevo Banco, con todos sus atributos instanciados
	 */
	new(String nombreBanco, double x, double y, String unaSucursal, String gerente, List<String> claves_servicios) {
		super(nombreBanco, new Point(x, y), claves_servicios)
		sucursal = unaSucursal
		nombreGerente = gerente
		setRangoDeAtencionBancario
	}

	new() {
	} // default

	override boolean estaDisponible(LocalDateTime fecha, String nombre) {
		this.tieneRangoDeAtencionDisponibleEn(fecha)
	}

}
