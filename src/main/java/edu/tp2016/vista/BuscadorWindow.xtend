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
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.windows.ErrorsPanel
import java.awt.Color

class BuscadorWindow extends MainWindow<BuscadorApplication>{
	
	new() {
		super(new BuscadorApplication)
		title = "Búsqueda"
	}
	
	override createContents(Panel mainPanel) {
		
		val panelIzquierdo1 = new Panel(mainPanel)
		panelIzquierdo1.layout = new ColumnLayout(2)
		new Label(panelIzquierdo1) => [
			text = "Criterio de búsqueda"
			fontSize = 10
		]
		
		new Panel(mainPanel) => [
			layout = new HorizontalLayout

			new Panel(it) => [
				val subPanelIzquierdo1 = new Panel(it)
				subPanelIzquierdo1.layout = new ColumnLayout(2)
				new Label(subPanelIzquierdo1) => [
					text = "Nombre"
				]
				new TextBox(it) => [
					width = 200
					value <=> "busqueda"	
				]
			]
			
			new Panel(it) => [
				layout = new ColumnLayout(2)
				new Label(it) => [ text = "" ]
				new Label(it) => [ text = "" ]
				new Button(it) => [
					caption = "Agregar"	
				]
				new Button(it) => [
					caption = "Buscar"	
					onClick[| modelObject.buscar ]
				]
			]
		]
		
		val panelIzquierdo2 = new Panel(mainPanel)
		panelIzquierdo2.layout = new ColumnLayout(2)
		new Label(panelIzquierdo2) => [
			text = "Resultado"
			fontSize = 10
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
			title = "Dirección"
			fixedSize = 150
			bindContentsToProperty("direccion")
		]
	}
	
	def static void main(String[] args){
		new BuscadorWindow().startApplication
	}
	
}