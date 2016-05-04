package edu.tp2016.serviciosExternos.cgp

import java.util.List

interface ServicioExternoCGP{
	def List<CentroDTO> buscar(String texto)
}
