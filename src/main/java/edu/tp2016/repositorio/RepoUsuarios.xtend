package edu.tp2016.repositorio

import edu.tp2016.usuarios.Usuario
import java.util.ArrayList
import edu.tp2016.usuarios.Terminal
import org.hibernate.Criteria
import org.hibernate.criterion.Restrictions
import org.hibernate.FetchMode
import org.hibernate.HibernateException

class RepoUsuarios extends RepoDefault<Usuario>{
	private static RepoUsuarios instance = null

	override def getEntityType() {
		typeof(Usuario)
	}
	
	def agregarUsuario(Usuario usuario){
		this.create(usuario)
	}
	
	static def getInstance() {
		if (instance == null) {
			instance = new RepoUsuarios
		}
		instance
	}
	
	def agregarVariosUsuarios(ArrayList<Terminal> usuarios){
		usuarios.forEach [ usuario | this.agregarUsuario(usuario)]
	}
	
	
	def Usuario buscar(String username, String clave) {
	    allInstances.findFirst [it.userName.equals(username) && 
	        it.password.equals(clave)]
	}
	
	override addQueryByExample(Criteria criteria, Usuario usuario) {
		if (usuario.userName != null) {
			criteria.add(Restrictions.eq("userName", usuario.userName))
		}
	}
	
	def Usuario get(Long id) {
		val session = sessionFactory.openSession
		try {
			return session.createCriteria(typeof(Usuario))
				.add(Restrictions.idEq(id))
				.setFetchMode("poisFavoritos", FetchMode.JOIN)
				.uniqueResult() as Usuario
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}
	
}