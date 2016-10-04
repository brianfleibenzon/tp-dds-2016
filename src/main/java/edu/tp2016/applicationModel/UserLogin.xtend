package edu.tp2016.applicationModel

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import edu.tp2016.usuarios.Usuario
import edu.tp2016.repositorio.RepoUsuarios

@Accessors
@Observable
class UserLogin {
	String usuario
	String password
	String resultadoLogin
	RepoUsuarios repo = RepoUsuarios.getInstance
	Usuario usuarioLoggeado
	boolean recordar
	
	def boolean validarLogin(){		
		if(inputsNotNull){
			usuarioLoggeado = repo.buscar(usuario, password)
			if (usuarioLoggeado != null){
				resultadoLogin = "<< Acceso exitoso >>"
				return true	
			}
		}
		resultadoLogin = "<< Usuario o contraseña inválidos >>"
		return false
	}
	
	def limpiarLogin(){
		usuario = ""
		password = ""
		resultadoLogin = ""
	}
	
	def salirLogin(){
		if(!recordar) limpiarLogin
	}
	
	def boolean inputsNotNull(){
		val userNotNull = usuario != null && !usuario.isEmpty
		val passwordNotNull = password != null && !password.isEmpty
		
		userNotNull && passwordNotNull
	}
	
	new(){
		recordar = false
	}

}