package edu.tp2016

import org.junit.Before
import org.junit.Test
import org.junit.Assert
import org.joda.time.LocalDateTime

class TestDisponibilidad {

	Dispositivo unDispositivoConFechaDisponible
	Dispositivo unDispositivoConFechaNoDisponible
	Banco unBanco
	DiaDeAtencion lunes
	DiaDeAtencion martes
	DiaDeAtencion miercoles
	DiaDeAtencion jueves
	DiaDeAtencion viernes
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
	LocalDateTime fecha

	@Before
	def void SetUp() {
		unDispositivoConFechaDisponible = new Dispositivo() => [
			fecha = new LocalDateTime().withDayOfWeek(3).withHourOfDay(12).withMinuteOfHour(59).withSecondOfMinute(0)
			fechaActual = fecha
		]
		unDispositivoConFechaNoDisponible = new Dispositivo() => [
			fecha = new LocalDateTime().withDayOfWeek(3).withHourOfDay(16).withMinuteOfHour(1).withSecondOfMinute(0)
			fechaActual = fecha
		]

		lunes = new DiaDeAtencion() => [
			dia = 1
			horaInicio = 10
			horaFin = 15
			minutoInicio = 0
			minutoFin = 0
		]
		martes = new DiaDeAtencion() => [
			dia = 2
			horaInicio = 10
			horaFin = 15
			minutoInicio = 0
			minutoFin = 0
		]
		miercoles = new DiaDeAtencion() => [
			dia = 3
			horaInicio = 10
			horaFin = 15
			minutoInicio = 0
			minutoFin = 0
		]
		jueves = new DiaDeAtencion() => [
			dia = 4
			horaInicio = 10
			horaFin = 15
			minutoInicio = 0
			minutoFin = 0
		]
		viernes = new DiaDeAtencion() => [
			dia = 5
			horaInicio = 10
			horaFin = 15
			minutoInicio = 0
			minutoFin = 0
		]
		unBanco = new Banco() => [
			nombre = "Santander"
			rangoDeAtencion.addAll(lunes, martes, miercoles, jueves, viernes)
		]
		unBanco = new Banco() => [
			nombre = "Provincia"
			rangoDeAtencion.addAll(lunes, martes, miercoles, jueves, viernes)
		]
		lunesMan = new DiaDeAtencion() => [
			dia = 1
			horaInicio = 10
			horaFin = 13
			minutoInicio = 0
			minutoFin = 0
		]
		martesMan = new DiaDeAtencion() => [
			dia = 2
			horaInicio = 10
			horaFin = 13
			minutoInicio = 0
			minutoFin = 0
		]
		miercolesMan = new DiaDeAtencion() => [
			dia = 3
			horaInicio = 10
			horaFin = 13
			minutoInicio = 0
			minutoFin = 0
		]
		juevesMan = new DiaDeAtencion() => [
			dia = 4
			horaInicio = 10
			horaFin = 13
			minutoInicio = 0
			minutoFin = 0
		]
		viernesMan = new DiaDeAtencion() => [
			dia = 5
			horaInicio = 10
			horaFin = 13
			minutoInicio = 0
			minutoFin = 0
		]
		sabadoMan = new DiaDeAtencion() => [
			dia = 6
			horaInicio = 10
			horaFin = 13
			minutoInicio = 0
			minutoFin = 0
		]
		lunesTar = new DiaDeAtencion() => [
			dia = 1
			horaInicio = 17
			horaFin = 20
			minutoInicio = 0
			minutoFin = 30
		]
		martesTar = new DiaDeAtencion() => [
			dia = 2
			horaInicio = 17
			horaFin = 20
			minutoInicio = 0
			minutoFin = 30
		]
		miercolesTar = new DiaDeAtencion() => [
			dia = 3
			horaInicio = 17
			horaFin = 20
			minutoInicio = 0
			minutoFin = 30
		]
		juevesTar = new DiaDeAtencion() => [
			dia = 4
			horaInicio = 17
			horaFin = 20
			minutoInicio = 0
			minutoFin = 30
		]
		viernesTar = new DiaDeAtencion() => [
			dia = 5
			horaInicio = 17
			horaFin = 20
			minutoInicio = 0
			minutoFin = 30
		]
		sabadoTar = new DiaDeAtencion() => [
			dia = 6
			horaInicio = 17
			horaFin = 20
			minutoInicio = 0
			minutoFin = 30
		]
		unComercio = new Comercio() =>
			[
				nombre = "Carrousel"
				rangoDeAtencion.addAll(lunesMan, lunesTar, martesMan, martesTar, miercolesMan, miercolesTar, juevesMan,
					juevesTar, viernesMan, viernesTar, sabadoMan, sabadoTar)
			]
		unaParada = new ParadaDeColectivo() => [
			nombre = "114"
		]

		lunesRentas = new DiaDeAtencion() => [
			dia = 1
			horaInicio = 10
			horaFin = 19
			minutoInicio = 0
			minutoFin = 0
		]
		unServicio = new Servicio() => [
			nombre = "Rentas"
			rangoDeAtencion.add(lunesRentas)
		]
		unCGP = new CGP() => [
			nombre = "CentroDeGestión"
			servicios.add(unServicio)
		]
		unDispositivoConFechaDisponibleParaRentas = new Dispositivo() => [
			fecha = new LocalDateTime().withDayOfWeek(1).withHourOfDay(10).withMinuteOfHour(30).withSecondOfMinute(0)
			fechaActual = fecha
		]
		unDispositivoConFechaNODisponibleParaRentas = new Dispositivo() => [
			fecha = new LocalDateTime().withDayOfWeek(6).withHourOfDay(12).withMinuteOfHour(0).withSecondOfMinute(0)
			fechaActual = fecha
		]

	}

	@Test
	def void paradaDeColectivoEstaDisponible() {
		Assert.assertEquals(true, unDispositivoConFechaDisponible.consultarDisponibilidad(unaParada, "114"))
	}

	@Test
	def void paradaDeColectivoTambienEstaDisponible() {
		Assert.assertEquals(true, unDispositivoConFechaNoDisponible.consultarDisponibilidad(unaParada, "114"))
	}

	@Test
	def void CGPEstaDisponible() {
		Assert.assertEquals(true, unDispositivoConFechaDisponibleParaRentas.consultarDisponibilidad(unCGP, "Rentas"))
	}

	@Test
	def void CGPEstaDisponibleParaAlgunServicio() {
		Assert.assertEquals(true, unDispositivoConFechaDisponibleParaRentas.consultarDisponibilidad(unCGP, ""))
	}

	@Test
	def void CGPNoEstaDisponible() {
		Assert.assertEquals(false, unDispositivoConFechaNODisponibleParaRentas.consultarDisponibilidad(unCGP, ""))
	}

	@Test
	def void bancoEstaDisponible() {
		Assert.assertEquals(true, unDispositivoConFechaDisponible.consultarDisponibilidad(unBanco, "Santander"))
	}

	@Test
	def void bancoNoEstaDisponible() {
		Assert.assertEquals(false, unDispositivoConFechaNoDisponible.consultarDisponibilidad(unBanco, "Provincia"))
	}

	@Test
	def void comercioEstaDisponible() {
		Assert.assertEquals(true, unDispositivoConFechaDisponible.consultarDisponibilidad(unComercio, "Jugueteria"))
	}

	@Test
	def void comercioNoEstaDisponible() {
		Assert.assertEquals(false, unDispositivoConFechaNoDisponible.consultarDisponibilidad(unBanco, "Jugueteria"))
	}
}
