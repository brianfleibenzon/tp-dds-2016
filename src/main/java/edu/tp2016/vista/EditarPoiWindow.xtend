package edu.tp2016.vista

import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import edu.tp2016.pois.POI
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.TextBox

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.Button
import edu.tp2016.mod.Servicio
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.widgets.tables.Column
import edu.tp2016.mod.DiaDeAtencion

abstract class EditarPoiWindow extends Dialog<POI> {
	
	new(WindowOwner owner, POI model) {
		super(owner, model)
	}
	
	override protected createFormPanel(Panel mainPanel) {
		val form = new Panel(mainPanel)
		form.layout = new ColumnLayout(2)
		
		new Label(form).text = "Nombre:"
		new TextBox(form) => [
			value <=> "nombre"
			width = 200
		]

		this.addFormPanel(form)
	}
	
	abstract def void addFormPanel(Panel panel)
	
	override protected void addActions(Panel actions) {
		new Button(actions)
			.setCaption("Aceptar")
			.onClick [ | this.accept ]
			.setAsDefault
			.disableOnError

		new Button(actions)
			.setCaption("Cancelar")
			.onClick[|this.cancel]
	}
}

class EditarBancoWindow extends EditarPoiWindow {
	
	new(WindowOwner owner, POI model) {
		super(owner, model)
		title = "Editar Banco"
		iconImage = "imagenes/banco1.jpg"
	}
	
	override addFormPanel(Panel panel) {
		
		new Label(panel).text = "Dirección:"
		new TextBox(panel) => [
			value <=> "direccion"
			width = 200
		]
		new Label(panel).text = "Zona:"
		new TextBox(panel) => [
			value <=> "zona"
			width = 200
		]
	}
	
}

class EditarCGPWindow extends EditarPoiWindow {
	
	new(WindowOwner owner, POI model) {
		super(owner, model)
		title = "Editar CGP"
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
				
        new Label(panel).text = "Lista de Servicios:"
        
        new Panel(panel)=> [
        	
			var table = new Table<Servicio>(it, typeof(Servicio)) => [
				value <=> "servicioSeleccionado"
				items <=> "servicios"
			]
			new Column<Servicio>(table) => [
				title = "Servicios"
				bindContentsToProperty("nombre")
				fixedSize = 250
			]
		]
		
		new Label(panel).text = "Horarios de atención:"
		
        new Panel(panel)=> [        	
			var table2 = new Table<DiaDeAtencion>(it,typeof(DiaDeAtencion)) => [
				items <=> "servicioSeleccionado.rangoDeAtencion"
			]
			new Column<DiaDeAtencion>(table2) => [
				title = "Dia"
				bindContentsToProperty("diaString")
				fixedSize = 100
			]
			new Column<DiaDeAtencion>(table2) => [
				title = "Inicio"
				bindContentsToProperty("fechaInicio")
				fixedSize = 50
			]
			new Column<DiaDeAtencion>(table2) => [
				title = "Fin"
				bindContentsToProperty("fechaFin")				
				fixedSize = 50
			]
		]
	}
}

class EditarComercioWindow extends EditarPoiWindow {
	
	new(WindowOwner owner, POI model) {
		super(owner, model)
		title = "Editar Comercio"
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
}
class EditarParadaWindow extends EditarPoiWindow {
	
	new(WindowOwner owner, POI model) {
		super(owner, model)
		title = "Editar Parada de Colectivo"
	    iconImage = "imagenes/coletivo.ico"
	}
	
	override addFormPanel(Panel panel) {		
	}
	
}