package edu.tp2016

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class DiaDeAtencion {
	int dia
	int horaInicio
	int minutoInicio
	int horaFin
	int minutoFin
	
	def boolean contieneLaHora(int unaHora)
		
	{ unaHora>this.horaInicio && unaHora<this.horaFin
	}
}