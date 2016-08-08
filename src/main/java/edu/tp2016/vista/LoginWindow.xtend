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

class LoginWindow extends MainWindow<UserLogin>{
	
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
				onClick [ | modelObject.validarLogin ]
			]
			new Button(it) => [ 
				caption = "Cancel"
				onClick [ | modelObject.cancelarLogin ]
			]
		]

		new Label(mainPanel) => [
			(foreground <=> "loginOk").transformer = new LoginOkTransformer 
			value <=> "loginOk"	
		]
	}

	def static main(String[] args) {
		new LoginWindow().startApplication
	}
	
}

class LoginOkTransformer implements ValueTransformer<String, Object> {
	
	override getModelType() {
		typeof(String)
	}
	
	override getViewType() {
		typeof(Object)
	}
	
	override modelToView(String valorDelModelo) {
		if(valorDelModelo.equals("Login exitoso.")) Color.GREEN.darker
			else Color.RED
	}
	
	override viewToModel(Object valorDeLaVista) {
		null	
	}
}