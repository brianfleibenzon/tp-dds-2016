package edu.tp2016.vista

import java.awt.Color
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.PasswordField
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.ErrorsPanel
import org.uqbar.arena.windows.MainWindow
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.bindings.ValueTransformer
import edu.tp2016.applicationModel.UserLogin
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Button
import edu.tp2016.applicationModel.BuscadorApplication
import org.uqbar.arena.windows.Dialog

class LoginWindow extends MainWindow<UserLogin>{
	
	public boolean busquedaHabilitada = false
	
	new() {
		super(new UserLogin())
		title = "Login al sistema"
	}

	override createContents(Panel mainPanel) {
		
		mainPanel.layout = new VerticalLayout
		new ErrorsPanel(mainPanel, "Ingrese usuario y contraseña")	
		
		new Panel(mainPanel) => [
			it.layout = new ColumnLayout(2)
			
			new Label(it).text = "Usuario:"
			new TextBox(it) => [
				value <=> "usuario"
				width = 110
			]
			
			new Label(it).text = "Contraseña:"
			new PasswordField(it) => [
				value <=> "password"
				width = 110
			]
		]
		
		new Panel(mainPanel) => [
			it.layout = new ColumnLayout(4)
			
			new Label(it).text = ""
			new Button(it) => [ 
				caption = "Login"
				onClick [ |
					busquedaHabilitada = false
					modelObject.validarLogin
				]
			]
			new Button(it) => [ 
				caption = "Cancel"
				onClick [ |
					busquedaHabilitada = false
					modelObject.cancelarLogin
				]
			]
		]

		new Label(mainPanel) => [
			(foreground <=> "loginOk").transformer = new LoginOkTransformer(this)
			value <=> "loginOk"
		]
		
		new Panel(mainPanel) => [
			it.layout = new ColumnLayout(3)
			new Label(it).text = ""
			new Button(it) =>  [
			setCaption("Ingresar a Búsqueda")
			onClick [ | 
				if(busquedaHabilitada){
					this.openDialog(new BuscadorWindow(this, new BuscadorApplication())) }
				]
			]
		]
		new ErrorsPanel(mainPanel, "                (El botón se habilitará cuando el Login sea válido)")
	}
	
	def openDialog(Dialog<?> dialog) {
		dialog.open
	}

	def static main(String[] args) {
		new LoginWindow().startApplication
	}
	
}

class LoginOkTransformer implements ValueTransformer<String, Object> {
	
	LoginWindow ventanaPrincipal
	
	new(LoginWindow window){
		ventanaPrincipal = window
	}
	
	override getModelType() {
		typeof(String)
	}
	
	override getViewType() {
		typeof(Object)
	}
	
	override modelToView(String valorDelModelo) {
		if(valorDelModelo.equals("<< Login exitoso >>")){
			//Color.GREEN.darker
			ventanaPrincipal.busquedaHabilitada = true
			
		}// else Color.RED
		// TODO: VER COLORES DE VALIDACIÓN
	}
	
	override viewToModel(Object valorDeLaVista) {
		null	
	}
}