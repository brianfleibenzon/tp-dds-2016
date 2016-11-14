package edu.tp2016.repositorio

import edu.tp2016.pois.POI
import edu.tp2016.procesos.ResultadoDeDarDeBajaUnPoi
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.hibernate.criterion.Restrictions
import org.hibernate.HibernateException
import org.hibernate.Criteria
import org.hibernate.FetchMode
import java.util.Set

@Accessors
class RepoPois extends RepoDefault<POI>{
	private static RepoPois instance = null
	List<ResultadoDeDarDeBajaUnPoi> poisDadosDeBaja = new ArrayList<ResultadoDeDarDeBajaUnPoi>

	override getEntityType() {
		typeof(POI)
	}
	
	def Set<POI> buscar(List<String> criterios) {
		val session = sessionFactory.openSession
		try {
			
			val StringBuilder query = new StringBuilder();
			
			query.append("SELECT poi.* FROM poi LEFT JOIN palabrasclave ON poi.id = clave_id LEFT JOIN poi_servicio ON CGP_id = id LEFT JOIN servicio ON servicio.id = servicios_id WHERE (")
			criterios.forEach[
				query.append(" poi.nombre LIKE '%"+it+"%' OR palabrasClave LIKE '%"+it+"%' OR servicio.nombre LIKE '%"+it+"%' OR")
				
			]
			query.append(" 1=0) AND poi.isActive = 1")	// PARA SACAR EL ULTIMO OR
			
			val criteria = session.createSQLQuery(query.toString).addEntity(POI);
			
			return criteria.list().toSet
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}
	
	override addQueryByExample(Criteria criteria, POI poi) {
		if (poi.nombre != null) {
			criteria.add(Restrictions.like("nombre", poi.nombre))			
		}
	}
	
	def isEmpty(){
		allInstances.size == 0
	}

	def agregarPoi(POI poi){
		poi.isActive = true
		this.create(poi)
	}
	
	def agregarVariosPois(ArrayList<POI> pois){
		pois.forEach [ poi | this.agregarPoi(poi)]
	}
	
	def eliminarPoi(POI poi){
		//this.delete(poi) --> Baja Física
		poi.isActive = false // --> Baja Lógica
		actualizarPoi(poi)
	}
	
	def actualizarPoi(POI poi){
		if (isNew(poi)) {
			agregarPoi(poi) // es un alta
		} else {
			this.update(poi) // es una modificación
		}
	}
	
	def POI get(Long id) {
		val session = sessionFactory.openSession
		try {
			return session.createCriteria(typeof(POI))
				.add(Restrictions.idEq(id))
				.setFetchMode("reviews", FetchMode.JOIN)
				.uniqueResult() as POI
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}
	
	def boolean isNew(POI poi){
		if (get(poi.id) == null){
			return true
		}
		return false
	}
	
	def registrarResultadoDeBaja(ResultadoDeDarDeBajaUnPoi resultado){
		poisDadosDeBaja.add(resultado)
	}
	
	static def getInstance() {
		if (instance == null) {
			instance = new RepoPois()
		}
		return instance
	}
	
	/** Genero una copia del objeto para no actualizar el que referencia el repo **/
	def getPoi(POI unPoi) {
		val result = get(unPoi.id)
		if (result == null) {
			null
		} else {
			result.copy
		} 
	}

	def createIfNotExists(POI poi) {
		val existe = getPoi(poi) != null
		if (!existe) {
			actualizarPoi(poi)
		}
		existe
	}
	
}
