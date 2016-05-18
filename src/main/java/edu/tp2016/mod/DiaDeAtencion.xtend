package edu.tp2016.mod

import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDateTime

@Accessors
class DiaDeAtencion {
	int dia
	int horaInicio
	int minutoInicio
	int horaFin
	int minutoFin
	
	new(int unDia, int startHour, int endHour, int startMinute, int endMinute) {
        dia = unDia
        horaInicio = startHour
        horaFin = endHour
        minutoInicio = startMinute
        minutoFin = endMinute
    }
	
	
	def boolean fechaEstaEnRango(LocalDateTime unaFecha){
		unaFecha.getDayOfWeek == dia &&
		(horaInicio < unaFecha.getHourOfDay || (horaInicio == unaFecha.getHourOfDay && minutoInicio <= unaFecha.getMinuteOfHour)) && 
		(horaFin > unaFecha.getHourOfDay || (horaFin == unaFecha.getHourOfDay && minutoFin >= unaFecha.getMinuteOfHour))
	}
}
				