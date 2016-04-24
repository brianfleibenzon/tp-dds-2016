package edu.tp2016.serviciosExternos

import java.util.List

interface ServicioCGP {
	def List<CentroDTO> buscar(String texto)
}

class CentroDTO {
	int numeroComuna
	String zonasIncluidas
	String nombreDirector
	String domicilio
	String telefono
	List<ServiciosDTO> servicios	
	int x
	int y
}

class ServiciosDTO {
	String nombreServicio
	List<RangoServicioDTO> rangos
}

class RangoServicioDTO {
	int numeroDia
	int horarioDesde
	int minutosDesde
	int horarioHasta
	int minutosHasta
}




