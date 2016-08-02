package edu.tp2016

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class Conversor {
	long celsius
	long fahrenheit
	
	def void setCelsius(double celsius){
		this.celsius = celsius
		this.fahrenheit = (celsius * 1.8) + 32
	}
	
	def void setFahrenheit(double fahrenheit){
		this.fahrenheit = fahrenheit
		this.celsius = (fahrenheit - 32) / 1.8
	}
}