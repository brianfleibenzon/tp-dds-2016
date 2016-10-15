package edu.tp2016.builder

import edu.tp2016.pois.CGP
import org.uqbar.geodds.Point
import java.util.List
import edu.tp2016.mod.Comuna
import edu.tp2016.mod.Servicio
import edu.tp2016.mod.Punto

class CGPBuilder {

	CGP unPoi

	new() {
		unPoi = new CGP
	}

	def build() {
		unPoi
	}

	def nombre(String nombre) {
		unPoi.nombre = nombre
		this
	}

	def ubicacion(Punto ubicado) {
		unPoi.ubicacion = ubicado
		this
	}

	def direccion(String unaDireccion){
		unPoi.direccion = unaDireccion
		this
	}

	def claves(List<String> claves) {
		unPoi.palabrasClave.addAll(claves)
		this
	}

	def comuna(Comuna _comuna) {
		unPoi.comuna = _comuna
		this
	}

	def servicio(List<Servicio> _servicio) {
		unPoi.servicios.addAll(_servicio)
		this
	}

	def zonasIncluidas(String barrios) {
		unPoi.barriosIncluidos = barrios
		this
	}

	def nombreDirector(String _nombreDirector) {
		unPoi.nombreDirector = _nombreDirector
		this
	}

	def telefono(String numTelefono) {
		unPoi.telefono = numTelefono
		this
	}
}
