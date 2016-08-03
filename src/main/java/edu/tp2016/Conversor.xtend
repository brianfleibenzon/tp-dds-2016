package edu.tp2016

import org.uqbar.commons.utils.Observable
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
@Observable
class Conversor {
	double celsius
	double fahrenheit
	
	def void setCelsius(double celsius){
		this.celsius = celsius
		this.fahrenheit = (celsius * 1.8) + 32
	}
	
	def void setFahrenheit(double fahrenheit){
		this.fahrenheit = fahrenheit
		this.celsius = (fahrenheit - 32) / 1.8
	}
}