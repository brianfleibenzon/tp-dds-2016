package edu.tp2016.serviciosExternos.cgp

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List

@Accessors
class ServicioDTO {
	String nombreServicio
	List<RangoServicioDTO> rangos
}