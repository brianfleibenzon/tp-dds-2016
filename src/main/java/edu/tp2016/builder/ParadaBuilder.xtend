package edu.tp2016.builder

import edu.tp2016.pois.ParadaDeColectivo
import org.uqbar.geodds.Point
import java.util.List
import edu.tp2016.mod.Punto

class ParadaBuilder {

	ParadaDeColectivo unPoi

	new() {
		unPoi = new ParadaDeColectivo
	}

	def build() {
		unPoi
	}
	
	def nombre(String nombre) {
		unPoi.nombre = nombre
		this
	}
	
	def lineaColectivo(String unaLinea){
		unPoi.linea = unaLinea
		this
	}

	def ubicacion(Punto ubicacion) {
		unPoi.ubicacion = ubicacion
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

}
