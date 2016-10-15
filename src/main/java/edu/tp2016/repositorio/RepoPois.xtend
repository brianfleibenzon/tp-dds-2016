package edu.tp2016.repositorio

import com.google.common.collect.Lists
import edu.tp2016.builder.BancoBuilder
import edu.tp2016.builder.CGPBuilder
import edu.tp2016.builder.ComercioBuilder
import edu.tp2016.builder.ParadaBuilder
import edu.tp2016.mod.Comuna
import edu.tp2016.mod.DiaDeAtencion
import edu.tp2016.mod.Rubro
import edu.tp2016.mod.Servicio
import edu.tp2016.pois.POI
import edu.tp2016.procesos.ResultadoDeDarDeBajaUnPoi
import java.util.ArrayList
import java.util.Arrays
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point
import org.uqbar.geodds.Polygon
import org.hibernate.criterion.Restrictions
import org.hibernate.HibernateException
import org.hibernate.Criteria
import edu.tp2016.mod.Punto
import org.hibernate.FetchMode

@Accessors
class RepoPois extends RepoDefault<POI>{
	private static RepoPois instance = null
	List<ResultadoDeDarDeBajaUnPoi> poisDadosDeBaja = new ArrayList<ResultadoDeDarDeBajaUnPoi>

	override getEntityType() {
		typeof(POI)
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
		this.create(poi)
	}
	
	def agregarVariosPois(ArrayList<POI> pois){
		pois.forEach [ poi | this.agregarPoi(poi)]
	}
	
	def eliminarPoi(POI poi){
		this.delete(poi)
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
			return false
		}
		return true
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
