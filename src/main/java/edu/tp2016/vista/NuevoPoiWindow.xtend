package edu.tp2016.vista

import org.uqbar.arena.windows.Dialog
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import edu.tp2016.pois.POI
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.Button
import edu.tp2016.pois.CGP
import edu.tp2016.pois.Banco
import edu.tp2016.pois.Comercio
import edu.tp2016.pois.ParadaDeColectivo
import edu.tp2016.applicationModel.Buscador
import org.uqbar.arena.widgets.tables.Table
import edu.tp2016.mod.Servicio
import org.uqbar.arena.widgets.tables.Column

abstract class NuevoPoiWindow extends Dialog<POI>{
	
	public Buscador parentBuscador
	
	new(WindowOwner owner, POI model, Buscador buscador) {
		super(owner, model)
		parentBuscador = buscador
		this.delegate.errorViewer = this
	}
	
	override protected createFormPanel(Panel mainPanel) {
		val form = new Panel(mainPanel)
		form.layout = new ColumnLayout(2)
		
		new Label(form).text = "Nombre:"
		new TextBox(form) => [
			width = 170
			value <=> "nombre"
		]
		new Label(form).text = "Dirección:"
		new TextBox(form) => [
			width = 170
			value <=> "direccion"
		]
		new Label(form).text = "Ícono:"
		new TextBox(form) => [
			width = 170
			value <=> "icono"
		]
		
		addFormPanel(form) // aquí las subclases agregan funcionalidad
		
		new Button(mainPanel) 
			.setCaption("Aceptar")
			.onClick [ | this.accept ]
			.setAsDefault
			.disableOnError

		new Button(mainPanel)
			.setCaption("Cancelar")
			.onClick[ | this.cancel ]
	}
	
	abstract def void addFormPanel(Panel panel)
	
	abstract def void actualizarPoiSegunTipo()

	override accept() {
		actualizarPoiSegunTipo
		super.accept
	}
}

class NuevoCGPWindow extends NuevoPoiWindow {
	
	new(WindowOwner owner, CGP model, Buscador buscador){
		super(owner, model, buscador)
		title = "Crear CGP"
	}
	
	override addFormPanel(Panel panel) {
		
		new Label(panel).text = "Barrios:"
		new TextBox(panel) => [
			value <=> "barriosIncluidos"
			width = 170
		]
		new Label(panel).text = "Servicios:"
        new Panel(panel)=> [
		var table = new Table<Servicio>(it, typeof(Servicio)) => [
			value <=> "servicioSeleccionado"
			items <=> "servicios"
			width = 200
		]
		new Column<Servicio>(table) => [
			title = "Servicios"
			bindContentsToProperty("nombre")
		]
	]
	}
	
	override actualizarPoiSegunTipo(){
		parentBuscador.repo.actualizarPoi(modelObject as CGP)
	}
}

class NuevoBancoWindow extends NuevoPoiWindow {
	
	new(WindowOwner owner, Banco model, Buscador buscador){
		super(owner, model, buscador)
		title = "Crear Banco"
	}
	
	override addFormPanel(Panel panel) {
		
		new Label(panel).text = "Sucursal:"
		new TextBox(panel) => [
			value <=> "sucursal"
			width = 170
		]
		new Label(panel).text = "Servicios:"
		new TextBox(panel) => [
			value <=> "palabrasClave"
			width = 170
		]
	}
	
	override actualizarPoiSegunTipo() {
		parentBuscador.repo.actualizarPoi(modelObject as Banco)
	}
	
}

class NuevoComercioWindow extends NuevoPoiWindow {
	
	new(WindowOwner owner, Comercio model, Buscador buscador){
		super(owner, model, buscador)
		title = "Crear Comercio"
	}
	
	override addFormPanel(Panel panel) {
		
		new Label(panel).text = "Nombre:"
		new TextBox(panel) => [
			value <=> "nombre"
			width = 170
		]
		new Label(panel).text = "Rubro:"
		new TextBox(panel) => [
			value <=> "rubro.nombre"
			width = 170
		]
	}
	
	override actualizarPoiSegunTipo() {
		parentBuscador.repo.actualizarPoi(modelObject as Comercio)
	}
	
}

class NuevaParadaWindow extends NuevoPoiWindow {
	
	new(WindowOwner owner, ParadaDeColectivo model, Buscador buscador){
		super(owner, model, buscador)
		title = "Crear Parada de Colectivo"
	}
	
	override addFormPanel(Panel panel) {
		
		new Label(panel).text = "Línea:"
		new TextBox(panel) => [
			value <=> "linea"
			width = 170
		]
	}
	
	override actualizarPoiSegunTipo() {
		parentBuscador.repo.actualizarPoi(modelObject as ParadaDeColectivo)
	}
	
}