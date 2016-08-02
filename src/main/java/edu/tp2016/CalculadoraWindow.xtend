package edu.tp2016

import org.uqbar.arena.windows.MainWindow
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.NumericField
//import org.uqbar.arena.widgets.Button
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import java.awt.Color
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.windows.ErrorsPanel

class CalculadoraWindow extends MainWindow<Calculadora>{
	
	new() {
		super(new Calculadora)
	}

	def static main(String[] args) {
		new CalculadoraWindow().startApplication
	}
	
	override createContents(Panel mainPanel) {
		this.title = "Calculadora Multiplicadora"
		mainPanel.layout = new VerticalLayout
		
		new ErrorsPanel(mainPanel, "Ingrese valores enteros positivos")	
		
		new Label(mainPanel).text = "Operando 1:"
		new NumericField(mainPanel).value <=> "operando1"
		
		new Label(mainPanel).text = "Operando 2:"
		new NumericField(mainPanel).value <=> "operando2"
		/*new Button(mainPanel) => [
			caption = "Multiplicar"
			onClick [ | this.modelObject.calcular ]
			]*/
		new Label(mainPanel).text = "Producto:"
		/*new Label(mainPanel) => [
			background = Color.ORANGE
			value <=> "resultado"
			]*/
		new NumericField(mainPanel) => [
			background = Color.GREEN
			value <=> "resultado"
			]
	}
	
}