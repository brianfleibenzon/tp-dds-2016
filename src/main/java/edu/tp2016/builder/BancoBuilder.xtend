package edu.tp2016.builder

import edu.tp2016.pois.Banco
import org.uqbar.geodds.Point
import java.util.List

class BancoBuilder {
	Banco unPoi

	new() {
		unPoi = new Banco
	}

	def build() {
		unPoi
	}

	def nombre(String nombre) {
		unPoi.nombre = nombre
		this
	}

	def ubicacion(Point ubicado) {
		unPoi.ubicacion = ubicado
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