package edu.tp2016

import org.uqbar.arena.windows.MainWindow
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.NumericField
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import java.awt.Color

class ConversorWindow extends MainWindow<Conversor> {
	new(){
		super(new Conversor)
	}
	
	def static main(String[] args){
		new ConversorWindow().startApplication
	}
	
	override createContents(Panel mainPanel) {
		this.title = "Conversor de Celsius a Fahrenheit, y viceversa"
		
		new Label(mainPanel) => [
			background = Color.BLUE
			text = "Celsius"
			]
		new NumericField(mainPanel).value <=> "celsius"
		
		new Label(mainPanel) => [
			background = Color.RED
			text = "Fahrenheit"
			]
		new NumericField(mainPanel).value <=> "fahrenheit"
		
	}	
}