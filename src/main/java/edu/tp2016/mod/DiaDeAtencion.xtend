package edu.tp2016.mod

import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDateTime
import org.uqbar.commons.utils.Observable
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.GeneratedValue

@Entity
@Observable
@Accessors
class DiaDeAtencion {
	@Id
	@GeneratedValue
	private Long id
	
	@Column()
	int dia
	
	@Column()
	int horaInicio
	
	@Column()
	int minutoInicio
	
	@Column()
	int horaFin
	
	@Column()
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
    			return "Domingo"
    		case 2:
    			return "Lunes"
    		case 3:
    			return "Martes"
    		case 4:
    			return "Miércoles"
    		case 5:
    			return "Jueves"
    		case 6:
    			return "Viernes"
    		case 7:
    			return "Sábado"
    	}
    }
	
	
	def boolean fechaEstaEnRango(LocalDateTime unaFecha){
		unaFecha.getDayOfWeek == dia &&
		(horaInicio < unaFecha.getHourOfDay || (horaInicio == unaFecha.getHourOfDay && minutoInicio <= unaFecha.getMinuteOfHour)) && 
		(horaFin > unaFecha.getHourOfDay || (horaFin == unaFecha.getHourOfDay && minutoFin >= unaFecha.getMinuteOfHour))
	}
	
	new(){}
}
				