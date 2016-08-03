package edu.tp2016

import org.uqbar.arena.windows.MainWindow
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.NumericField
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import java.awt.Color
import org.uqbar.arena.windows.ErrorsPanel
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Button

class CalculadoraWindow extends MainWindow<Calculadora>{
	
	new() {
		super(new Calculadora)
	}

	def static main(String[] args) {
		new CalculadoraWindow().startApplication
	}
	
	override createContents(Panel mainPanel) {
		
		this.title = "Multiplicadora"
		new ErrorsPanel(mainPanel, "Ingrese valores enteros positivos")
		
		val editorPanel = new Panel(mainPanel)
		editorPanel.layout = new ColumnLayout(2)
	
		new Label(editorPanel).text = "Operando 1:"
		new NumericField(editorPanel, true) => [
			background = Color.PINK
			width = 110
			value <=> "operando1"
		]
		
		new Label(editorPanel).text = "Operando 2:"
		new NumericField(editorPanel, true) => [
			background = Color.PINK
			width = 110
			value <=> "operando2"
		]
		
		new Label(editorPanel) => [
			foreground = Color.RED
			text = "Producto:"
		]
		new NumericField(editorPanel, true) => [
			background = Color.GREEN
			width = 110
			value <=> "resultado"
		]
		
		new Button(mainPanel) => [
			caption = "Clean All"
			onClick [ | this.modelObject.limpiarNumericFields ]
		]
		
	}
	
}