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
import edu.tp2016.sistema.Sistema
import edu.tp2016.sistema.Terminal
import edu.tp2016.Builder.BuilderParada
import edu.tp2016.Builder.BuilderBanco
import edu.tp2016.Builder.BuilderComercio
import edu.tp2016.Builder.BuilderCGP

class TestDisponibilidad {

	Sistema unSistemaConFechaDisponible
	Sistema unSistemaConFechaNoDisponible	
	
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
	
	DiaDeAtencion lunesRentas
	Sistema unSistemaConFechaDisponibleParaRentas
	Sistema unSistemaConFechaNODisponibleParaRentas
	Servicio unServicio	
	Point ubicacionX
	Rubro rubroX
	Comuna comunaX
	List<POI> pois
	List<String> clavesX
	
	Terminal terminalConFechaDisponible
	Terminal terminalConFechaNoDisponible
	Terminal terminalConFechaDisponibleParaRentas
	Terminal terminalConFechaNODisponibleParaRentas
	/*Builder */
	ParadaDeColectivo unaParada
	Banco unBanco
	Comercio unComercio
	CGP unCGP
	@Before
	def void setUp() {

		rubroX = new Rubro("x", 1)
		clavesX = Arrays.asList("algunas", "palabras", "clave")
		
		comunaX = new Comuna => [
			poligono = new Polygon()
			poligono.add(new Point(-1, 1))
			poligono.add(new Point(-2, 2))
			poligono.add(new Point(-3, 3))
			poligono.add(new Point(-4, 4))
		]

		unBanco = new BuilderBanco().nombre("Santander")
									.ubicacion(ubicacionX)
									.claves(clavesX)
									.sucursal("Caballito")
									.nombreDeGerente("Juan Pérez")
									.rangoDeAtencion
									.build

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

		unComercio = new BuilderComercio().nombre("Carrousel")
										  .ubicacion(ubicacionX)
										  .claves(clavesX)
										  .rubro(rubroX)
										  .rango(Arrays.asList(lunesMan, lunesTar, martesMan, martesTar, miercolesMan, miercolesTar, juevesMan, juevesTar,
				viernesMan, viernesTar, sabadoMan, sabadoTar))
										  .build
		
		unaParada =new BuilderParada().nombre("114")
									  .ubicacion(ubicacionX)
									  .claves(clavesX)
									  .build
		

		lunesRentas = new DiaDeAtencion(1, 10, 19, 0, 0)
		unServicio = new Servicio("Rentas", Arrays.asList(lunesRentas))
		unCGP = new BuilderCGP().nombre("CentroDeGestión")
								.ubicacion(ubicacionX)
								.claves(clavesX)
								.comuna(comunaX)
								.servicios( Arrays.asList(unServicio))
								.build

		pois = Arrays.asList(unBanco, unCGP, unComercio, unaParada)
		
		unSistemaConFechaDisponible = new Sistema(pois,
			new LocalDateTime().withDayOfWeek(3).withHourOfDay(12).withMinuteOfHour(59).withSecondOfMinute(0))

		unSistemaConFechaNoDisponible = new Sistema(pois,
			new LocalDateTime().withDayOfWeek(3).withHourOfDay(16).withMinuteOfHour(1).withSecondOfMinute(0))
			
		unSistemaConFechaDisponibleParaRentas = new Sistema(
			pois,
			new LocalDateTime().withDayOfWeek(1).withHourOfDay(10).withMinuteOfHour(30).withSecondOfMinute(0)
		)

		unSistemaConFechaNODisponibleParaRentas = new Sistema(pois,
			new LocalDateTime().withDayOfWeek(6).withHourOfDay(12).withMinuteOfHour(0).withSecondOfMinute(0))

		terminalConFechaDisponible = new Terminal("terminalAbasto", new Point(-1, -1), unSistemaConFechaDisponible, new LocalDateTime().withDayOfWeek(1).withHourOfDay(10).withMinuteOfHour(30).withSecondOfMinute(0))
		terminalConFechaNoDisponible = new Terminal("terminalChacarita", new Point(-1, -1), unSistemaConFechaNoDisponible, new LocalDateTime().withDayOfWeek(3).withHourOfDay(16).withMinuteOfHour(1).withSecondOfMinute(0))
		
		terminalConFechaDisponibleParaRentas = new Terminal("terminalChacarita", new Point(-1, -1), unSistemaConFechaNoDisponible, new LocalDateTime().withDayOfWeek(1).withHourOfDay(10).withMinuteOfHour(30).withSecondOfMinute(0))
		terminalConFechaNODisponibleParaRentas = new Terminal("terminalChacarita", new Point(-1, -1), unSistemaConFechaNoDisponible, new LocalDateTime().withDayOfWeek(6).withHourOfDay(12).withMinuteOfHour(0).withSecondOfMinute(0))
	}

	@Test
	def void paradaDeColectivoEstaDisponible() {
		Assert.assertTrue(terminalConFechaDisponible.consultarDisponibilidad(unaParada, "114"))
	}

	@Test
	def void paradaDeColectivoTambienEstaDisponible() {
		Assert.assertTrue(terminalConFechaNoDisponible.consultarDisponibilidad(unaParada, "114"))
	}

	@Test
	def void CGPEstaDisponible() {
		Assert.assertTrue(terminalConFechaDisponibleParaRentas.consultarDisponibilidad(unCGP, "Rentas"))
	}

	@Test
	def void CGPEstaDisponibleParaAlgunServicio() {
		Assert.assertTrue(terminalConFechaDisponibleParaRentas.consultarDisponibilidad(unCGP, ""))
	}

	@Test
	def void CGPNoEstaDisponible() {
		Assert.assertFalse(terminalConFechaNODisponibleParaRentas.consultarDisponibilidad(unCGP, ""))
	}

	@Test
	def void bancoEstaDisponible() {
		Assert.assertTrue(terminalConFechaDisponible.consultarDisponibilidad(unBanco, ""))
	}

	@Test
	def void bancoNoEstaDisponible() {
		Assert.assertFalse(terminalConFechaNoDisponible.consultarDisponibilidad(unBanco, ""))
	}

	@Test
	def void comercioEstaDisponible() {
		Assert.assertTrue(terminalConFechaDisponible.consultarDisponibilidad(unComercio, "Jugueteria"))
	}

	@Test
	def void comercioNoEstaDisponible() {
		Assert.assertFalse(terminalConFechaNoDisponible.consultarDisponibilidad(unBanco, "Jugueteria"))
	}
}
