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
import edu.tp2016.servidores.ServidorLocal
import edu.tp2016.servidores.ServidorCentral
import builder.CGPBuilder
import builder.ParadaBuilder
import builder.ComercioBuilder
import builder.BancoBuilder

class TestDisponibilidad {

	ServidorLocal unServidorLocalConFechaDisponible
	ServidorLocal unServidorLocalConFechaNoDisponible
	ServidorCentral servidorCentral
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
	ServidorLocal unServidorLocalConFechaDisponibleParaRentas
	ServidorLocal unServidorLocalConFechaNODisponibleParaRentas
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

		pois = Arrays.asList(unBanco, unCGP, unComercio, unaParada)
		
		servidorCentral = new ServidorCentral(pois) 
		unServidorLocalConFechaDisponible = new ServidorLocal(ubicacionX,"servidorLocal1" ,servidorCentral ,
			new LocalDateTime().withDayOfWeek(3).withHourOfDay(12).withMinuteOfHour(59).withSecondOfMinute(0))

		unServidorLocalConFechaNoDisponible = new ServidorLocal(ubicacionX,"servidorLocal2" ,servidorCentral,
			new LocalDateTime().withDayOfWeek(3).withHourOfDay(16).withMinuteOfHour(1).withSecondOfMinute(0))
			
		unServidorLocalConFechaDisponibleParaRentas = new ServidorLocal(
			ubicacionX,
			"servidorLocal" ,
			servidorCentral,
			new LocalDateTime().withDayOfWeek(1).withHourOfDay(10).withMinuteOfHour(30).withSecondOfMinute(0)
		)

		unServidorLocalConFechaNODisponibleParaRentas = new ServidorLocal(ubicacionX,"servidorLocal" ,servidorCentral,
			new LocalDateTime().withDayOfWeek(6).withHourOfDay(12).withMinuteOfHour(0).withSecondOfMinute(0))

	}

	@Test
	def void paradaDeColectivoEstaDisponible() {
		Assert.assertTrue(unServidorLocalConFechaDisponible.consultarDisponibilidad(unaParada, "114"))
	}

	@Test
	def void paradaDeColectivoTambienEstaDisponible() {
		Assert.assertTrue(unServidorLocalConFechaNoDisponible.consultarDisponibilidad(unaParada, "114"))
	}

	@Test
	def void CGPEstaDisponible() {
		Assert.assertTrue(unServidorLocalConFechaDisponibleParaRentas.consultarDisponibilidad(unCGP, "Rentas"))
	}

	@Test
	def void CGPEstaDisponibleParaAlgunServicio() {
		Assert.assertTrue(unServidorLocalConFechaDisponibleParaRentas.consultarDisponibilidad(unCGP, ""))
	}

	@Test
	def void CGPNoEstaDisponible() {
		Assert.assertFalse(unServidorLocalConFechaNODisponibleParaRentas.consultarDisponibilidad(unCGP, ""))
	}

	@Test
	def void bancoEstaDisponible() {
		Assert.assertTrue(unServidorLocalConFechaDisponible.consultarDisponibilidad(unBanco, ""))
	}

	@Test
	def void bancoNoEstaDisponible() {
		Assert.assertFalse(unServidorLocalConFechaNoDisponible.consultarDisponibilidad(unBanco, ""))
	}

	@Test
	def void comercioEstaDisponible() {
		Assert.assertTrue(unServidorLocalConFechaDisponible.consultarDisponibilidad(unComercio, "Jugueteria"))
	}

	@Test
	def void comercioNoEstaDisponible() {
		Assert.assertFalse(unServidorLocalConFechaNoDisponible.consultarDisponibilidad(unBanco, "Jugueteria"))
	}
}
