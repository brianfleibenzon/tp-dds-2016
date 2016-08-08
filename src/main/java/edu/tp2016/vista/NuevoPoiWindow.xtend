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
import edu.tp2016.buscador.Buscador

class NuevoPoiWindow extends Dialog<POI>{
	
	Buscador parentBuscador
	
	new(WindowOwner owner, POI model, Buscador buscador) {
		super(owner, model)
		parentBuscador = buscador
		this.delegate.errorViewer = this
		title = "Agregar nuevo POI"
	}
	
	override protected createFormPanel(Panel mainPanel) {
		val form = new Panel(mainPanel)
		form.layout = new ColumnLayout(2)
		
		new Label(form).text = "Nombre:"
		new TextBox(form).value <=> "nombre"

		new Label(form).text = "Dirección:"
		new TextBox(form) => [
			width = 200
			value <=> "direccion"
		]
	}

	override protected void addActions(Panel actions) {
		new Button(actions)
			.setCaption("Aceptar")
			.onClick [ | this.accept ]
			.setAsDefault
			.disableOnError

		new Button(actions)
			.setCaption("Cancelar")
			.onClick[ | this.cancel ]
	}

	override accept() {
		parentBuscador.repo.actualizarPoi(this.modelObject)
		super.accept
	}
	
}