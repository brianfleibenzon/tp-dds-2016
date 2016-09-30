package edu.tp2016.observersBusqueda

import org.joda.time.LocalDateTime
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import java.util.ArrayList

@ Accessors
class Busqueda{
	LocalDateTime fecha
	String nombreUsuario
	int cantidadDeResultados
	long demoraConsulta
	List<String> palabrasBuscadas = new ArrayList<String>
}
