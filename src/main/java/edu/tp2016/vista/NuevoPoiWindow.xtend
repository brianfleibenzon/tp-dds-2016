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
import edu.tp2016.mod.DiaDeAtencion
import org.uqbar.arena.widgets.List

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
			width = 200
			value <=> "nombre"
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
		iconImage = "imagenes/cgp.jpg"
	}
	
	override addFormPanel(Panel panel) {
		new Label(panel).text = "Dirección"
		new TextBox(panel) => [
			value <=> "direccion"
			width = 200
		]
		
		new Label(panel).text = "Barrios:"
		new TextBox(panel) => [
			value <=> "barriosIncluidos"
			width = 200
		]
		new Label(panel).text = "" /* Labels nulos para alinear */
		new Label(panel).text = ""
        new Label(panel).text = "Lista de Servicios:"
        
        new Panel(panel)=> [
        	
			var table = new Table<Servicio>(it, typeof(Servicio)) => [
				value <=> "servicioSeleccionado"
				items <=> "servicios"
			]
			new Column<Servicio>(table) => [
				title = "Servicios"
				bindContentsToProperty("nombre")
				fixedSize = 350
			]
		]
		new Label(panel).text = "" /* Labels nulos para alinear */
		new Label(panel).text = ""
		new Label(panel).text = "Horarios de Atención:"
		
        new Panel(panel)=> [        	
			var table2 = new Table<DiaDeAtencion>(it,typeof(DiaDeAtencion)) => [
				items <=> "servicioSeleccionado.rangoDeAtencion"
			]
			new Column<DiaDeAtencion>(table2) => [
				title = "Día"
				bindContentsToProperty("diaString")
				fixedSize = 90
			]
			new Column<DiaDeAtencion>(table2) => [
				title = "Inicio"
				bindContentsToProperty("fechaInicio")
				fixedSize = 60
			]
			new Column<DiaDeAtencion>(table2) => [
				title = "Fin"
				bindContentsToProperty("fechaFin")				
				fixedSize = 60
			]
		]
		new Label(panel).text = "" /* Labels nulos para alinear */
		new Label(panel).text = ""
	}
	
	override actualizarPoiSegunTipo(){
		parentBuscador.repo.actualizarPoi(modelObject as CGP)
	}
}

class NuevoBancoWindow extends NuevoPoiWindow {
	
	new(WindowOwner owner, Banco model, Buscador buscador){
		super(owner, model, buscador)
		title = "Crear Banco"
		iconImage = "imagenes/banco1.jpg"
	}
	
	override addFormPanel(Panel panel) {
		
		new Label(panel).text = "Dirección:"
		new TextBox(panel) => [
			value <=> "direccion"
			width = 200
		]
		new Label(panel).text = "Sucursal:"
		new TextBox(panel) => [
			value <=> "sucursal"
			width = 200
		]
		new Label(panel).text = "Servicios:"
        new Panel(panel)=> [
        	new List(it) => [
        		bindItemsToProperty("palabrasClave")
        		width = 150
        		height = 100		
        	]
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
		iconImage = "imagenes/comercio.jpg"
	}
	
	override addFormPanel(Panel panel) {
		new Label(panel).text = "Dirección:"
		new TextBox(panel) => [
			value <=> "direccion"
			width = 200
		]
	

    new Label(panel).text = "Rubro:"
		new TextBox(panel) => [
			value <=> "rubro.nombre"
			width = 200
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
		iconImage = "imagenes/coletivo.ico"
	}
	
	override addFormPanel(Panel panel) {		
		new Label(panel).text = "Línea:"
		new TextBox(panel) => [
			value <=> "linea"
			width = 200
		]   
	}
	
	override actualizarPoiSegunTipo() {
		parentBuscador.repo.actualizarPoi(modelObject as ParadaDeColectivo)
	}
	
}