package edu.tp2016

import org.uqbar.arena.windows.MainWindow
import org.uqbar.arena.widgets.Panel
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.TextBox

class ConvertorWindow extends MainWindow<Convertor> {
	new() {
		super(new Convertor)
		title = "Convertor"
	}
	
	def static void main(String[] args){
		new ConvertorWindow().startApplication
	}

	override createContents(Panel mainPanel) {
		val panel = new Panel(mainPanel)
		new Label(panel).text = "Frase"
		new TextBox(panel) => [
			value <=> "frase"
			width = 200
		]
		new Label(panel) => [
			value <=> "fraseReves"
			foreground <=> "color"
		]
	}
}
