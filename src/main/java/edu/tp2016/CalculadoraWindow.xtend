package edu.tp2016

import org.uqbar.arena.windows.MainWindow
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.NumericField
import org.uqbar.arena.widgets.Button
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import java.awt.Color

class CalculadoraWindow extends MainWindow<Calculadora>{
	new() {
		super(new Calculadora)
	}

	def static main(String[] args) {
		new CalculadoraWindow().startApplication
	}
	
	override createContents(Panel mainPanel) {
		this.title = "Calculadora multiplicadora"
		new Label(mainPanel).text = "Ingrese el primer operando:"
		new NumericField(mainPanel).value <=> "operando1"
		new Label(mainPanel).text = "Ingrese el segundo operando:"
		new NumericField(mainPanel).value <=> "operando2"
		new Button(mainPanel) => [
			caption = "Multiplicar"
			onClick [ | this.modelObject.calcular ]
			]
		new Label(mainPanel).text = "Resultado:"
		new Label(mainPanel) => [
			background = Color.ORANGE
			value <=> "resultado"
			]
	}
	
}