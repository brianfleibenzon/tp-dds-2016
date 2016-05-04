package edu.tp2016

import edu.tp2016.pois.Banco
import edu.tp2016.pois.CGP
import edu.tp2016.pois.Comercio
import edu.tp2016.pois.POI
import edu.tp2016.pois.ParadaDeColectivo
import edu.tp2016.repositorioExterno.Repositorio
import java.util.List
import org.joda.time.LocalDateTime
import org.junit.Before
import org.uqbar.geodds.Point
import org.junit.Test
import org.junit.Assert

class TestRepositorio {
	Dispositivo unDispositivo
	ParadaDeColectivo unaParada
	Banco unBanco
	Comercio unComercio
	CGP unCGP
	List<POI> pois
	List<String> clavesX
	Point ubicacion
	Repositorio repo = Repositorio.newInstance
	
	@Before
	def void setUp() {
		ubicacion=new Point(10,15)
		
		unDispositivo = new Dispositivo(ubicacion, pois,
			new LocalDateTime().withDayOfWeek(6).withHourOfDay(20).withMinuteOfHour(45).withSecondOfMinute(0))
		
		/*Agrego los POIS al repo externo */	
		val unBanco = repo.createExample()
		val unComercio =repo.createExample()
		val unCGP =repo.createExample()
		val unaParada=repo.createExample()
	}
	
	}