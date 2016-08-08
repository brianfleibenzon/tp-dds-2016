package edu.tp2016.vista

import org.uqbar.arena.widgets.Panel

import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.TextBox

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.tables.Table
import edu.tp2016.applicationModel.BuscadorApplication
import edu.tp2016.pois.POI
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.bindings.NotNullObservable
import java.util.HashMap
import edu.tp2016.pois.Banco
import edu.tp2016.pois.CGP
import edu.tp2016.pois.Comercio
import edu.tp2016.pois.ParadaDeColectivo
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner

class BuscadorWindow extends Dialog<BuscadorApplication>{
	
	new(WindowOwner owner, BuscadorApplication model) {
		super(owner, model)
		this.delegate.errorViewer = this
		title = "Búsqueda"
	}
	
	override protected createFormPanel(Panel mainPanel) {

		new Panel(mainPanel) => [
			new Label(it) => [			
				text = "Criterio de búsqueda"
				fontSize = 10
			]
		]
		new Panel(mainPanel) => [
			it.layout = new ColumnLayout(2)
			new Panel(it) => [
				new Panel(it)=> [
					new Label(it) => [			
						text = "Nombre"
					]
				]
				new TextBox(it) => [
					width = 200
					value <=> "busqueda"	
				]
			]
			
			new Panel(it) => [
				it.layout = new ColumnLayout(2)
				new Label(it) => [ text = "" ] // (Dejarlo porque alinea)
				new Label(it) => [ text = "" ] // (Dejarlo porque alinea)
				new Button(it) => [
					caption = "Agregar"	
					onClick[|]					
				]
				new Button(it) => [
					caption = "Buscar"	
					onClick[| modelObject.buscar ]
				]
			]
				
		]
		
		new Panel(mainPanel)=>[
			new Label(it) => [			
				text = "Resultado"
				fontSize = 10
			]
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
		new Button(mainPanel) => [
			caption = "Editar"	
			onClick[| this.editarPoi ]
			bindEnabled(new NotNullObservable("poiSeleccionado"))
		]
		
	}
	
	def editarPoi(){
		val bloqueQueConstruyeVentana = mapaVentanas.get(modelObject.poiSeleccionado.class)
		this.openDialog(bloqueQueConstruyeVentana.apply)
	}
	
	def getMapaVentanas() {
		return new HashMap<Class<? extends POI>, () => EditarPoiWindow> => [
			put(typeof(Banco), [ | new EditarBancoWindow(this, modelObject.poiSeleccionado) ] )
			put(typeof(CGP), [ | new EditarCGPWindow(this, modelObject.poiSeleccionado) ] )
			put(typeof(Comercio), [ | new EditarComercioWindow(this, modelObject.poiSeleccionado)] )
			put(typeof(ParadaDeColectivo), [ | new EditarParadaWindow(this, modelObject.poiSeleccionado)] )
		]
	}
	
	def openDialog(Dialog<?> dialog) {
		dialog.onAccept[ |	modelObject.buscar ]
		dialog.open
	}
	
}