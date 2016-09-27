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
import org.uqbar.arena.widgets.List
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.CheckBox
import org.uqbar.arena.widgets.Spinner
import edu.tp2016.usuarios.Usuario
import edu.tp2016.mod.Review

abstract class EditarPoiWindow extends Dialog<POI> {
	
	new(WindowOwner owner, POI model, Usuario usuario) {
		super(owner, model)
		model.inicializar(usuario)
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
		
		new Panel(mainPanel) => [
			layout = new ColumnLayout(2)
			new Label(it).bindValueToProperty("calificacionGeneral")
			new Panel(it) => [
				layout = new HorizontalLayout
				new Label(it).text = "Favorito: "
				new CheckBox(it).bindValueToProperty("favorito")
			]
		]
		
		new Panel(mainPanel) => [
			layout = new ColumnLayout(3)
			new Label(it).text = "Tu opinión:"
			new TextBox(it) => [
				bindValueToProperty("comentario")
				height = 40
				width = 140
			]
			new Panel(it)=> [
				new Spinner(it) => [
					minimumValue = 1
					maximumValue = 5
					bindValueToProperty("calificacion")
				]
				new Button(it) => [
					caption = "Enviar"
					onClick([ | modelObject.guardarCalificacion ])
				]
			]			
		]
		
		new Panel(mainPanel) => [
			new Label(it).text = "Opiniones: "
			var table = new Table<Review>(mainPanel, typeof(Review)) => [
				items <=> "reviews"
			]
			new Column<Review>(table) => [
				title = "Usuario"
				fixedSize = 150
				bindContentsToProperty("usuario.userName")
			]
			new Column<Review>(table) => [
				title = "Comentario"
				fixedSize = 150
				bindContentsToProperty("comentario")
			]
			new Column<Review>(table) => [
				title = "Calificación"
				fixedSize = 150
				bindContentsToProperty("calificacion")
			]
		]
		
		new Button(mainPanel)
			.setCaption("Aceptar")
			.onClick [ | this.accept ]
			.setAsDefault
			.disableOnError

		new Button(mainPanel)
			.setCaption("Cancelar")
			.onClick[|this.cancel]
	}
	
	abstract def void addFormPanel(Panel panel)
	
}

class EditarBancoWindow extends EditarPoiWindow {
	
	new(WindowOwner owner, POI model, Usuario usuario) {
		super(owner, model, usuario)
		title = "Editar Banco"
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
	
}

class EditarCGPWindow extends EditarPoiWindow {
	
	new(WindowOwner owner, POI model, Usuario usuario) {
		super(owner, model, usuario)
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
}

class EditarComercioWindow extends EditarPoiWindow {
	
	new(WindowOwner owner, POI model, Usuario usuario) {
		super(owner, model, usuario)
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
	
	new(WindowOwner owner, POI model, Usuario usuario) {
		super(owner, model, usuario)
		title = "Editar Parada de Colectivo"
	    iconImage = "imagenes/coletivo.ico"
	}
	
	override addFormPanel(Panel panel) {		
		new Label(panel).text = "Línea:"
		new TextBox(panel) => [
			value <=> "linea"
			width = 200
		]   
	}
}