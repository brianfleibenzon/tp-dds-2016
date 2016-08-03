package edu.tp2016.saludar

import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.MainWindow
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class SaludarWindow extends MainWindow<Saludar> {

	new() {
		super(new Saludar)
		title = "Saludo"
	}

	def static main(String[] args) {
		new SaludarWindow().startApplication
	}

	override createContents(Panel mainPanel) {

		new Label(mainPanel).text = "Nombre"
		new TextBox(mainPanel) => [
			value <=> "nombre"
			width = 200
		]
		new Label(mainPanel).text = "Apellido"
		new TextBox(mainPanel) => [
			value <=> "apellido"
			width = 200
		]

		new Label(mainPanel) => [value <=> "mensaje"]

	}

}
