package edu.tp2016.vista

import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.PasswordField
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.ErrorsPanel
import org.uqbar.arena.windows.MainWindow
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import edu.tp2016.applicationModel.UserLogin
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.windows.Dialog
import edu.tp2016.buscador.Buscador
import java.awt.Color

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
				onClick [ |
					if (modelObject.validarLogin) {
						new Label(mainPanel) => [
							foreground = Color.GREEN
							value <=> "resultadoLogin"
						]
						this.openDialog(new BuscadorWindow(this, new Buscador()))
					}
					else{
						new Label(mainPanel)  => [
							foreground = Color.RED
							value <=> "resultadoLogin"
						]
					}
				]
				setAsDefault
			]
			new Button(it) => [ 
				caption = "Cancelar"
				onClick [ | modelObject.cancelarLogin ]
			]
		]
		
	}
	
	def openDialog(Dialog<?> dialog) {
		dialog.open
	}

	def static main(String[] args) {
		new LoginWindow().startApplication
	}
	
}