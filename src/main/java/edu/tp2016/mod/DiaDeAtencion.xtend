package edu.tp2016.mod

import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDateTime
import org.uqbar.commons.utils.Observable

@Observable
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
    
    def getFechaInicio(){
    	return (agregarCeros(horaInicio) + ":" + agregarCeros(minutoInicio))
    }
    
    def getFechaFin(){
    	return (agregarCeros(horaFin) + ":" + agregarCeros(minutoFin))
    }
    
    def agregarCeros(int num){
    	var String conCeros = num.toString
    	if (conCeros.length == 1) conCeros = "0" + conCeros
    	return conCeros
    }
    
    def getDiaString(){
    	switch (dia) {
    		case 1:
    			return "Do"
    		case 2:
    			return "Lu"
    		case 3:
    			return "Ma"
    		case 4:
    			return "Mi"
    		case 5:
    			return "Ju"
    		case 6:
    			return "Vi"
    		case 7:
    			return "Sa"
    	}
    }
	
	
	def boolean fechaEstaEnRango(LocalDateTime unaFecha){
		unaFecha.getDayOfWeek == dia &&
		(horaInicio < unaFecha.getHourOfDay || (horaInicio == unaFecha.getHourOfDay && minutoInicio <= unaFecha.getMinuteOfHour)) && 
		(horaFin > unaFecha.getHourOfDay || (horaFin == unaFecha.getHourOfDay && minutoFin >= unaFecha.getMinuteOfHour))
	}
}
				