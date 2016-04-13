package edu.tp2016

import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDateTime

@Accessors
class DiaDeAtencion {
	int dia
	int horaInicio
	int minutoInicio
	int horaFin
	int minutoFin
	
	def boolean fechaEstaEnRango(LocalDateTime unaFecha){
		unaFecha.getDayOfWeek == dia &&
		(horaInicio < unaFecha.getHourOfDay || (horaInicio == unaFecha.getHourOfDay && minutoInicio <= unaFecha.getMinuteOfHour)) && 
		(horaFin > unaFecha.getHourOfDay || (horaFin == unaFecha.getHourOfDay && minutoFin >= unaFecha.getMinuteOfHour))
	}
}