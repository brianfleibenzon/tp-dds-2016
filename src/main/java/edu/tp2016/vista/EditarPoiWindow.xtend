package edu.tp2016.vista

import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import edu.tp2016.pois.POI
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.List

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.Button
import edu.tp2016.mod.Servicio
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.widgets.tables.Column

abstract class EditarPoiWindow extends Dialog<POI> {
	
	new(WindowOwner owner, POI model) {
		super(owner, model)
	}
	
	override protected createFormPanel(Panel mainPanel) {
		val form = new Panel(mainPanel)
		form.layout = new ColumnLayout(2)
		
		new Label(form).text = "Nombre"
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

		new Button(actions) //
			.setCaption("Cancelar")
			.onClick[|this.cancel]
	}
}

class EditarBancoWindow extends EditarPoiWindow {
	
	new(WindowOwner owner, POI model) {
		super(owner, model)
		title = "Editar Banco"
		iconImage = "C:/Users/celeste/workspace/tp-dds-2016/imagenes/banco1.ico"
	}
	
	override addFormPanel(Panel panel) {
		
		new Label(panel).text = "Direccion"
		new TextBox(panel) => [
			value <=> "direccion"
			width = 200
		]

		
	}
	
}

class EditarCGPWindow extends EditarPoiWindow {
	
	new(WindowOwner owner, POI model) {
		super(owner, model)
		title = "Editar CGP"
		iconImage = "C:/Users/celeste/workspace/tp-dds-2016/imagenes/cgp.jpg"
	}
	
	override addFormPanel(Panel panel) {
		new Label(panel).text = "Direccion"
		new TextBox(panel) => [
			value <=> "direccion"
			width = 200
		]
		
		new Label(panel).text = "Zona"
		new TextBox(panel) => [
			value <=> "zonasIncluidas"
			width = 200
		]
        new Label(panel).text = "Lista De Servicios"
        new Panel(panel)=> [
		var table = new Table<Servicio>(it,typeof(Servicio)) => [
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
}

class EditarComercioWindow extends EditarPoiWindow {
	
	new(WindowOwner owner, POI model) {
		super(owner, model)
		title = "Editar comercio"
	    iconImage = "C:/Users/celeste/workspace/tp-dds-2016/imagenes/comercio.jpg"
	}
	
	override addFormPanel(Panel panel) {
		new Label(panel).text = "Direccion"
		new TextBox(panel) => [
			value <=> "direccion"
			width = 200
		]

		
	}
	
}

class EditarParadaWindow extends EditarPoiWindow {
	
	new(WindowOwner owner, POI model) {
		super(owner, model)
		title = "Editar parada de colectivo"
	    iconImage = "C:/Users/celeste/workspace/tp-dds-2016/imagenes/coletivo.ico"
	}
	
	override addFormPanel(Panel panel) {
		
	}
	
}