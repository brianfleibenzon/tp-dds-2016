package edu.tp2016

import org.uqbar.arena.windows.MainWindow
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import java.awt.Color
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.ErrorsPanel
import org.uqbar.arena.layout.VerticalLayout

class ConversorWindow extends MainWindow<Conversor> {
	new(){
		super(new Conversor)
	}
	
	def static main(String[] args){
		new ConversorWindow().startApplication
	}
	
	override createContents(Panel mainPanel) {
		this.title = " Conversor [ Celsius - Fahrenheit ] "
		
		new ErrorsPanel(mainPanel, "Ingrese valores numéricos")
		
		mainPanel.layout = new VerticalLayout
		
		new Label(mainPanel) => [
			background = Color.BLUE
			text = " Celsius  "
			]
		new TextBox(mainPanel).value <=> "celsius"
		
		new Label(mainPanel) => [
			background = Color.RED
			text = " Fahrenheit "
			]
		new TextBox(mainPanel).value <=> "fahrenheit"
		
	}	
}