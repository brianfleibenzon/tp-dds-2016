package edu.tp2016.interfacesExternas.banco

import java.util.List

interface InterfazBanco {
	def List<SucursalBanco> buscar(String texto)
}