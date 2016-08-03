package edu.tp2016

import org.junit.Before
import org.junit.Test
import org.junit.Assert
import org.joda.time.LocalDateTime
import java.util.Arrays
import org.uqbar.geodds.Point
import org.uqbar.geodds.Polygon
import java.util.List
import edu.tp2016.mod.DiaDeAtencion
import edu.tp2016.pois.Banco
import edu.tp2016.pois.ParadaDeColectivo
import edu.tp2016.pois.CGP
import edu.tp2016.mod.Servicio
import edu.tp2016.mod.Rubro
import edu.tp2016.mod.Comuna
import edu.tp2016.pois.POI
import edu.tp2016.pois.Comercio
import edu.tp2016.builder.CGPBuilder
import edu.tp2016.builder.ParadaBuilder
import edu.tp2016.builder.ComercioBuilder
import edu.tp2016.builder.BancoBuilder
import edu.tp2016.usuarios.Terminal
import com.google.common.collect.Lists
import java.util.ArrayList

class TestDisponibilidad {

	Terminal unaTerminalConFechaDisponible
	Terminal unaTerminalConFechaNoDisponible
	Terminal unaTerminalConFechaDisponibleParaRentas
	Terminal unaTerminalConFechaNODisponibleParaRentas
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
	Servicio unServicio
	ParadaDeColectivo unaParada
	Point ubicacionX
	Rubro rubroX
	Comuna comunaX
	ArrayList<POI> pois
	List<String> clavesX

	@Before
	def void setUp() {

		ubicacionX = new Point(-1, 1)
		rubroX = new Rubro("x", 1)
		clavesX = Arrays.asList("algunas", "palabras", "clave")
		
		comunaX = new Comuna => [
			poligono = new Polygon()
			poligono.add(new Point(-1, 1))
			poligono.add(new Point(-2, 2))
			poligono.add(new Point(-3, 3))
			poligono.add(new Point(-4, 4))
		]

		unBanco = new BancoBuilder().nombre("Santander").
		ubicacion(ubicacionX).
		claves(clavesX).
		sucursal("Caballito").
		nombreGerente("Juan Pérez").
		setearHorarios.
		build

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

		unComercio = new ComercioBuilder().nombre("Carrousel").
		ubicacion(ubicacionX).
		claves(clavesX).
		rubro(rubroX).
		rango(Arrays.asList(lunesMan, lunesTar, martesMan, martesTar, miercolesMan, miercolesTar, juevesMan, juevesTar,
				viernesMan, viernesTar, sabadoMan, sabadoTar)).
		build

		unaParada = new ParadaBuilder().nombre("114").
		ubicacion(ubicacionX).
		claves(clavesX).
		build

		lunesRentas = new DiaDeAtencion(1, 10, 19, 0, 0)
		unServicio = new Servicio("Rentas", Arrays.asList(lunesRentas))
		unCGP = new CGPBuilder().nombre("CentroDeGestión").
		ubicacion(ubicacionX).
		claves(clavesX).
		comuna(comunaX).
		servicio(Arrays.asList(unServicio)).
		zonasIncluidas("").
		nombreDirector("").
		telefono("").
		build

		pois = Lists.newArrayList(unBanco, unCGP, unComercio, unaParada)
		
		unaTerminalConFechaDisponible = new Terminal(ubicacionX, "t1",
			new LocalDateTime().withDayOfWeek(3).withHourOfDay(12).withMinuteOfHour(59).withSecondOfMinute(0))

		unaTerminalConFechaNoDisponible = new Terminal(ubicacionX, "t2",
			new LocalDateTime().withDayOfWeek(3).withHourOfDay(16).withMinuteOfHour(1).withSecondOfMinute(0))
			
		unaTerminalConFechaDisponibleParaRentas = new Terminal(ubicacionX, "t3",
			new LocalDateTime().withDayOfWeek(1).withHourOfDay(10).withMinuteOfHour(30).withSecondOfMinute(0)
		)

		unaTerminalConFechaNODisponibleParaRentas = new Terminal(ubicacionX, "servidorLocal",
			new LocalDateTime().withDayOfWeek(6).withHourOfDay(12).withMinuteOfHour(0).withSecondOfMinute(0))
			
		unaTerminalConFechaDisponible.repo.agregarVariosPois(pois)
		unaTerminalConFechaNoDisponible.repo.agregarVariosPois(pois)
		unaTerminalConFechaDisponibleParaRentas.repo.agregarVariosPois(pois)
		unaTerminalConFechaNODisponibleParaRentas.repo.agregarVariosPois(pois)

	}

	@Test
	def void paradaDeColectivoEstaDisponible() {
		Assert.assertTrue(unaTerminalConFechaDisponible.consultarDisponibilidad(unaParada, "114"))
	}

	@Test
	def void paradaDeColectivoTambienEstaDisponible() {
		Assert.assertTrue(unaTerminalConFechaNoDisponible.consultarDisponibilidad(unaParada, "114"))
	}

	@Test
	def void CGPEstaDisponible() {
		Assert.assertTrue(unaTerminalConFechaDisponibleParaRentas.consultarDisponibilidad(unCGP, "Rentas"))
	}

	@Test
	def void CGPEstaDisponibleParaAlgunServicio() {
		Assert.assertTrue(unaTerminalConFechaDisponibleParaRentas.consultarDisponibilidad(unCGP, ""))
	}

	@Test
	def void CGPNoEstaDisponible() {
		Assert.assertFalse(unaTerminalConFechaNODisponibleParaRentas.consultarDisponibilidad(unCGP, ""))
	}

	@Test
	def void bancoEstaDisponible() {
		Assert.assertTrue(unaTerminalConFechaDisponible.consultarDisponibilidad(unBanco, ""))
	}

	@Test
	def void bancoNoEstaDisponible() {
		Assert.assertFalse(unaTerminalConFechaNoDisponible.consultarDisponibilidad(unBanco, ""))
	}

	@Test
	def void comercioEstaDisponible() {
		Assert.assertTrue(unaTerminalConFechaDisponible.consultarDisponibilidad(unComercio, "Jugueteria"))
	}

	@Test
	def void comercioNoEstaDisponible() {
		Assert.assertFalse(unaTerminalConFechaNoDisponible.consultarDisponibilidad(unBanco, "Jugueteria"))
	}
}
