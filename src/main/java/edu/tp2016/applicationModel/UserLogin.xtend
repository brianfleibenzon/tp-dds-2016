package edu.tp2016.applicationModel

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Dependencies
import org.uqbar.commons.utils.Observable
import java.util.ArrayList
import edu.tp2016.usuarios.Usuario
import java.util.List
import edu.tp2016.usuarios.Terminal
import edu.tp2016.usuarios.Administrador

@Accessors
@Observable
class UserLogin {
	String usuario
	String password
	int loginStatus = VACIO
	public static final int VACIO = 1
	public static final int OK = 2
	public static final int INVALIDO = 3
	List<Usuario> usuariosDelSistema = new ArrayList<Usuario>
	
	@Dependencies("loginStatus")	
	def getLoginOk() {
		if(loginStatus.equals(VACIO)){
			return ""
		} else if(loginStatus.equals(OK)){
			return "Login exitoso."
		} else{
			return "Login inválido."
		}
	}
	
	def validarLogin(){
		
		crearJuegoDeDatos()
		
		if(inputsNotNull){
			val userFiltrado = usuariosDelSistema.filter [ user |
				user.userName.equalsIgnoreCase(usuario) && user.password.equalsIgnoreCase(password) ]
				
				if(!userFiltrado.isEmpty) loginStatus = OK
					else loginStatus = INVALIDO
		}
		else{
			loginStatus = VACIO
		}
	}
	
	def cancelarLogin(){
		usuariosDelSistema.clear
		this.usuario = ""
		this.password = ""
		loginStatus = VACIO
	}
	
	def boolean inputsNotNull(){
		val userNotNull = usuario != null && !usuario.isEmpty
		val passwordNotNull = password != null && !password.isEmpty
		
		userNotNull && passwordNotNull
	}
	
	def crearJuegoDeDatos(){
		val usuarioTerminal = new Terminal("juanPerez", "1234")
		val usuarioAdministrador = new Administrador("anaFlores", "hello")
		usuariosDelSistema.addAll(usuarioTerminal, usuarioAdministrador)
	}
}