package edu.tp2016.pois

import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDateTime
import org.uqbar.geodds.Point
import java.util.List
import edu.tp2016.mod.DiaDeAtencion
import java.util.Arrays

@Accessors
class Banco extends POI {
String sucursal
String nombreGerente
List<DiaDeAtencion> rangoDeAtencion

	def void setRangoDeAtencionBancario(){
		val lunes = new DiaDeAtencion(1, 10, 15, 0, 0)
		val martes = new DiaDeAtencion(2, 10, 15, 0, 0)
		val miercoles = new DiaDeAtencion(3, 10, 15, 0, 0)
		val jueves = new DiaDeAtencion(4, 10, 15, 0, 0)
		val viernes = new DiaDeAtencion(5, 10, 15, 0, 0)
		
		rangoDeAtencion = Arrays.asList(lunes,martes, miercoles,jueves,viernes)
	}

/**
	 * Constructores para la creación de Bancos
	 * El primero es el constructor original de la Primera Entrega.
	 * El segundo es necesario para crear un Banco de nuestro dominio, a partir del Banco que nos devuelve
	 * la interfaz externa y que debemos antes parsear
	 * 
	 * @param Atributos de un Banco
	 * @return Nuevo Banco con todos sus atributos instanciados
	 */
	// Modifico constructor a los datos Entrega 2
	new(String nombreBanco, Point ubicacion, List<String> claves_servicios, String unaSucursal, String gerente){
		super(nombreBanco, ubicacion, claves_servicios)
		sucursal = unaSucursal
		nombreGerente = gerente
		setRangoDeAtencionBancario
	}
	// constructor para banco parseado
	new(String nombreBanco, int x, int y, String unaSucursal, String gerente, List<String> claves_servicios){
		super(nombreBanco, new Point(x,y), claves_servicios)
		sucursal = unaSucursal
		nombreGerente = gerente
		setRangoDeAtencionBancario
	}

	override boolean estaDisponible(LocalDateTime fecha, String nombre) {
		this.tieneRangoDeAtencionDisponibleEn(fecha)
	}

}
