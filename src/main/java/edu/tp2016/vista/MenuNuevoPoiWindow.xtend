package edu.tp2016.vista

import org.uqbar.arena.windows.Dialog
import edu.tp2016.pois.POI
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import edu.tp2016.pois.Banco
import edu.tp2016.pois.ParadaDeColectivo
import edu.tp2016.pois.Comercio
import edu.tp2016.pois.CGP
import edu.tp2016.applicationModel.Buscador

class MenuNuevoPoiWindow extends Dialog<POI> {
	
	Buscador parentBuscador
	
	new(WindowOwner owner, POI model, Buscador buscador) {
		super(owner, model)
		parentBuscador = buscador
		this.delegate.errorViewer = this
		title = "Agregar nuevo POI"
	}
	
	override protected createFormPanel(Panel mainPanel) {
		new Panel(mainPanel) => [
			new Label(mainPanel)
				.text = ""
			new Button(mainPanel)
				.setCaption("Nuevo Banco")
				.onClick[ | openDialog(new NuevoBancoWindow(this, new Banco(), parentBuscador)) ]
			
			new Button(mainPanel)
				.setCaption("Nuevo CGP")
				.onClick[ | openDialog(new NuevoCGPWindow(this, new CGP(), parentBuscador)) ]
			
			new Button(mainPanel)
				.setCaption("Nuevo Comercio")
				.onClick[ | openDialog(new NuevoComercioWindow(this, new Comercio(), parentBuscador)) ]
			
			new Button(mainPanel)
				.setCaption("Nueva Parada")
				.onClick[ | openDialog(new NuevaParadaWindow(this, new ParadaDeColectivo(), parentBuscador)) ]
		
			new Label(mainPanel) => [ text = "" ]
			new Button(mainPanel)
				.setCaption("Salir")
				.onClick[ | this.cancel ]
		]
	}
	
	def openDialog(Dialog<?> dialog) {
		dialog.open
	}
}