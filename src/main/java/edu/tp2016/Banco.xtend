package edu.tp2016

import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDate
import java.util.List

@Accessors
class Banco extends POI{
	//AL IGUAL QUE EN LO OTRO FALTA VER TEMA DEL FORMATO DE FECHAs
	override boolean estaDisponible(LocalDate fechaActual, String texto){
		if (texto ==""){
			estaEnElRango(int diaActual, int horaActual)
		}
		else 
		{
			//ESPERAR A QUE CLARA CONTESTE EL MAIL CON RESPECTO A ESTO
		}
	}
	
	boolean estaEnElRango(int diaActual, int horaActual){
	
	rangoDeAtencion.exists[unDiaDeAtencion | unDiaDeAtencion.dia==diaActual && unDiaDeAtencion.contieneLaHora(horaActual)]
	
	}
														
		
}