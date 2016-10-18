package edu.tp2016.builder

import edu.tp2016.pois.Banco
import java.util.List
import edu.tp2016.mod.Punto

class BancoBuilder {
	Banco unPoi

	new() {
		unPoi = new Banco
	}

	def build() {
		unPoi.isActive = true
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

	def nombreGerente(String nombre) {
		unPoi.nombreGerente = nombre
		this
	}

	def sucursal(String sucursal) {
		unPoi.sucursal = sucursal
		this
	}

	def setearHorarios() {
		unPoi.setRangoDeAtencionBancario
		this

	}

}
