package edu.tp2016

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