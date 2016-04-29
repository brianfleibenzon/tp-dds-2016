package edu.tp2016.interfacesExternas.cgp

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List

@Accessors
class CentroDTO {
	int numeroComuna
	String zonasIncluidas
	String nombreDirector
	String domicilio
	String telefono
	List<ServicioDTO> servicios	
	int x
	int y
}