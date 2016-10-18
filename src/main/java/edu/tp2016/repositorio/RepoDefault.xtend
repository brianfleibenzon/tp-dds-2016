package edu.tp2016.repositorio

import edu.tp2016.mod.Comuna
import edu.tp2016.mod.DiaDeAtencion
import edu.tp2016.mod.Punto
import edu.tp2016.mod.Review
import edu.tp2016.mod.Rubro
import edu.tp2016.mod.Servicio
import edu.tp2016.observersBusqueda.Busqueda
import edu.tp2016.observersBusqueda.BusquedaObserver
import edu.tp2016.observersBusqueda.EnviarMailObserver
import edu.tp2016.observersBusqueda.RegistrarBusquedaObserver
import edu.tp2016.pois.Banco
import edu.tp2016.pois.CGP
import edu.tp2016.pois.Comercio
import edu.tp2016.pois.POI
import edu.tp2016.pois.ParadaDeColectivo
import edu.tp2016.usuarios.Terminal
import edu.tp2016.usuarios.Usuario
import java.util.List
import org.hibernate.Criteria
import org.hibernate.HibernateException
import org.hibernate.SessionFactory
import org.hibernate.cfg.Configuration

abstract class RepoDefault<T> {
	protected static final SessionFactory sessionFactory = new Configuration().configure()
		.addAnnotatedClass(POI)
		.addAnnotatedClass(Banco)
		.addAnnotatedClass(CGP)
		.addAnnotatedClass(Comercio)
		.addAnnotatedClass(ParadaDeColectivo)
		.addAnnotatedClass(Comuna)
		.addAnnotatedClass(Servicio)
		.addAnnotatedClass(DiaDeAtencion)
		.addAnnotatedClass(Review)
		.addAnnotatedClass(Rubro)
		.addAnnotatedClass(Usuario)
		.addAnnotatedClass(Terminal)
		.addAnnotatedClass(Punto)
		.addAnnotatedClass(Busqueda)
		.addAnnotatedClass(BusquedaObserver)
		.addAnnotatedClass(EnviarMailObserver)
		.addAnnotatedClass(RegistrarBusquedaObserver)
		.buildSessionFactory()

	def List<T> allInstances() {
		val session = sessionFactory.openSession
		try {
			return session.createCriteria(getEntityType).list()
		} finally {
			session.close
		}
	}
	
	def List<T> searchByExample(T t) {
		val session = sessionFactory.openSession
		try {
			val criteria = session.createCriteria(getEntityType)
			this.addQueryByExample(criteria, t)
			return criteria.list()
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}
	
	def void create(T t) {
		val session = sessionFactory.openSession
		try {
			session.beginTransaction
			session.save(t)
			session.getTransaction.commit
		} catch (HibernateException e) {
			session.getTransaction.rollback
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}

	def void update(T t) {
		val session = sessionFactory.openSession
		try {
			session.beginTransaction
			session.update(t)
			session.getTransaction.commit
		} catch (HibernateException e) {
			session.getTransaction.rollback
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}
	
	def void delete(T t) {
		val session = sessionFactory.openSession
		try {
			session.beginTransaction
			session.delete(t)
			session.getTransaction.commit
		} catch (HibernateException e) {
			session.getTransaction.rollback
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}	
	

	def abstract Class<T> getEntityType()

	def abstract void addQueryByExample(Criteria criteria, T t)

	def openSession() {
		sessionFactory.openSession
	}
}