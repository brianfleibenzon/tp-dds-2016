package edu.tp2016.vista

import org.uqbar.arena.widgets.Panel

import org.uqbar.arena.widgets.Label
import org.uqbar.arena.windows.MainWindow
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.TextBox

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.tables.Table
import edu.tp2016.applicationModel.BuscadorApplication
import edu.tp2016.pois.POI
import org.uqbar.arena.widgets.tables.Column

class BuscadorWindow extends MainWindow<BuscadorApplication>{
	
	new() {
		super(new BuscadorApplication)
		title = "Busqueda"
	}
	
	override createContents(Panel mainPanel) {
		new Label(mainPanel) => [
			text = "Criterio de busqueda"
			fontSize = 12
		]		
		new Panel(mainPanel) => [
			layout = new HorizontalLayout
			new Panel(it) => [
				new Label(it) => [
					text = "Nombre"
				]
				new TextBox(it) => [
					width = 200
					value <=> "busqueda"	
				]
			]		
			new Panel(it) => [
				new Button(it) => [
					caption = "Agregar"	
				]
				new Button(it) => [
					caption = "Buscar"	
					onClick[| modelObject.buscar ]
				]
			]
		]
		new Label(mainPanel) => [
			text = "Resultado"
			fontSize = 12
		]
		var table = new Table<POI>(mainPanel, typeof(POI)) => [
			items <=> "resultados"
			value <=> "poiSeleccionado"
			
		]
		new Column<POI>(table) => [
			title = "Nombre"
			fixedSize = 150
			bindContentsToProperty("nombre")
		]
		new Column<POI>(table) => [
			title = "Direccion"
			fixedSize = 150
			bindContentsToProperty("direccion")
		]
	}
	
	def static void main(String[] args){
		new BuscadorWindow().startApplication
	}
	
}