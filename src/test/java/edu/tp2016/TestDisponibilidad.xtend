package edu.tp2016

import org.junit.Before
import org.junit.Test
import org.junit.Assert
import org.joda.time.LocalDateTime
import java.util.Arrays
import org.uqbar.geodds.Point
import org.uqbar.geodds.Polygon
import java.util.List
import com.google.common.collect.Lists
import edu.tp2016.mod.DiaDeAtencion
import edu.tp2016.pois.Banco
import edu.tp2016.pois.ParadaDeColectivo
import edu.tp2016.pois.CGP
import edu.tp2016.mod.Servicio
import edu.tp2016.mod.Rubro
import edu.tp2016.mod.Comuna
import edu.tp2016.pois.POI
import edu.tp2016.pois.Comercio

class TestDisponibilidad {

	Dispositivo unDispositivoConFechaDisponible
	Dispositivo unDispositivoConFechaNoDisponible
	Banco unBanco
	Comercio unComercio
	DiaDeAtencion lunesMan
	DiaDeAtencion martesMan
	DiaDeAtencion miercolesMan
	DiaDeAtencion juevesMan
	DiaDeAtencion viernesMan
	DiaDeAtencion sabadoMan
	DiaDeAtencion lunesTar
	DiaDeAtencion martesTar
	DiaDeAtencion miercolesTar
	DiaDeAtencion juevesTar
	DiaDeAtencion viernesTar
	DiaDeAtencion sabadoTar
	CGP unCGP
	DiaDeAtencion lunesRentas
	Dispositivo unDispositivoConFechaDisponibleParaRentas
	Dispositivo unDispositivoConFechaNODisponibleParaRentas
	Servicio unServicio
	ParadaDeColectivo unaParada
	Point ubicacionX
	Rubro rubroX
	Comuna comunaX
	List<POI> pois
	List<String> clavesX

	@Before
	def void setUp() {

		ubicacionX = new Point(-1, 1)
		rubroX = new Rubro("x", 1)
		clavesX = Arrays.asList(Lists.newArrayList("algunas", "palabras", "clave"))
		pois = Arrays.asList(Lists.newArrayList(unBanco, unCGP, unComercio, unaParada))
		comunaX = new Comuna => [
			poligono = new Polygon()
			poligono.add(new Point(-1, 1))
			poligono.add(new Point(-2, 2))
			poligono.add(new Point(-3, 3))
			poligono.add(new Point(-4, 4))
		]

		unDispositivoConFechaDisponible = new Dispositivo(ubicacionX, pois,
			new LocalDateTime().withDayOfWeek(3).withHourOfDay(12).withMinuteOfHour(59).withSecondOfMinute(0))

		unDispositivoConFechaNoDisponible = new Dispositivo(ubicacionX, pois,
			new LocalDateTime().withDayOfWeek(3).withHourOfDay(16).withMinuteOfHour(1).withSecondOfMinute(0))

		unBanco = new Banco("Santander", ubicacionX, clavesX, "Caballito", "Juan Pérez")

		unBanco = new Banco("Provincia", ubicacionX, clavesX, "Avellaneda", "Miguel Hernández")

		lunesMan = new DiaDeAtencion(1, 10, 13, 0, 0)
		martesMan = new DiaDeAtencion(2, 10, 13, 0, 0)
		miercolesMan = new DiaDeAtencion(3, 10, 13, 0, 0)
		juevesMan = new DiaDeAtencion(4, 10, 13, 0, 0)
		viernesMan = new DiaDeAtencion(5, 10, 13, 0, 0)
		sabadoMan = new DiaDeAtencion(6, 10, 13, 0, 0)
		lunesTar = new DiaDeAtencion(1, 17, 20, 0, 30)
		martesTar = new DiaDeAtencion(2, 17, 20, 0, 30)
		miercolesTar = new DiaDeAtencion(3, 17, 20, 0, 30)
		juevesTar = new DiaDeAtencion(4, 17, 20, 0, 30)
		viernesTar = new DiaDeAtencion(5, 17, 20, 0, 30)
		sabadoTar = new DiaDeAtencion(6, 17, 20, 0, 30)

		unComercio = new Comercio("Carrousel", ubicacionX, clavesX, rubroX,
			Arrays.asList(lunesMan, lunesTar, martesMan, martesTar, miercolesMan, miercolesTar, juevesMan, juevesTar,
				viernesMan, viernesTar, sabadoMan, sabadoTar))

		unaParada = new ParadaDeColectivo("114", ubicacionX, clavesX)

		lunesRentas = new DiaDeAtencion(1, 10, 19, 0, 0)
		unServicio = new Servicio("Rentas", Arrays.asList(lunesRentas))
		unCGP = new CGP("CentroDeGestión", ubicacionX, clavesX, comunaX, Arrays.asList(unServicio), "", "", "")

		unDispositivoConFechaDisponibleParaRentas = new Dispositivo(
			ubicacionX,
			pois,
			new LocalDateTime().withDayOfWeek(1).withHourOfDay(10).withMinuteOfHour(30).withSecondOfMinute(0)
		)

		unDispositivoConFechaNODisponibleParaRentas = new Dispositivo(ubicacionX, pois,
			new LocalDateTime().withDayOfWeek(6).withHourOfDay(12).withMinuteOfHour(0).withSecondOfMinute(0))

	}

	@Test
	def void paradaDeColectivoEstaDisponible() {
		Assert.assertTrue(unDispositivoConFechaDisponible.consultarDisponibilidad(unaParada, "114"))
	}

	@Test
	def void paradaDeColectivoTambienEstaDisponible() {
		Assert.assertTrue(unDispositivoConFechaNoDisponible.consultarDisponibilidad(unaParada, "114"))
	}

	@Test
	def void CGPEstaDisponible() {
		Assert.assertTrue(unDispositivoConFechaDisponibleParaRentas.consultarDisponibilidad(unCGP, "Rentas"))
	}

	@Test
	def void CGPEstaDisponibleParaAlgunServicio() {
		Assert.assertTrue(unDispositivoConFechaDisponibleParaRentas.consultarDisponibilidad(unCGP, ""))
	}

	@Test
	def void CGPNoEstaDisponible() {
		Assert.assertFalse(unDispositivoConFechaNODisponibleParaRentas.consultarDisponibilidad(unCGP, ""))
	}

	@Test
	def void bancoEstaDisponible() {
		Assert.assertTrue(unDispositivoConFechaDisponible.consultarDisponibilidad(unBanco, "Santander"))
	}

	@Test
	def void bancoNoEstaDisponible() {
		Assert.assertFalse(unDispositivoConFechaNoDisponible.consultarDisponibilidad(unBanco, "Provincia"))
	}

	@Test
	def void comercioEstaDisponible() {
		Assert.assertTrue(unDispositivoConFechaDisponible.consultarDisponibilidad(unComercio, "Jugueteria"))
	}

	@Test
	def void comercioNoEstaDisponible() {
		Assert.assertFalse(unDispositivoConFechaNoDisponible.consultarDisponibilidad(unBanco, "Jugueteria"))
	}
}
