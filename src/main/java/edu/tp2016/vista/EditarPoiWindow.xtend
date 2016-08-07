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

		new Label(form).text = "Direccion"
		new TextBox(form) => [
			value <=> "direccion"
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
	}
	
	override addFormPanel(Panel panel) {
		
	}
	
}

class EditarCGPWindow extends EditarPoiWindow {
	
	new(WindowOwner owner, POI model) {
		super(owner, model)
		title = "Editar CGP"
	}
	
	override addFormPanel(Panel panel) {
		
	}
	
}

class EditarComercioWindow extends EditarPoiWindow {
	
	new(WindowOwner owner, POI model) {
		super(owner, model)
		title = "Editar comercio"
	}
	
	override addFormPanel(Panel panel) {
		
	}
	
}

class EditarParadaWindow extends EditarPoiWindow {
	
	new(WindowOwner owner, POI model) {
		super(owner, model)
		title = "Editar parada de colectivo"
	}
	
	override addFormPanel(Panel panel) {
		
	}
	
}