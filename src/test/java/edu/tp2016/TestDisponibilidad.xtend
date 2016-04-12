package edu.tp2016
import org.junit.Before
import org.junit.Test
import org.junit.Assert

class TestDisponibilidad {
	Dispositivo unDispositivoConFechaDisponible
	Dispositivo unDispositivoConFechaNoDisponible
	Banco unBanco
	DiaDeAtencion lunes
	DiaDeAtencion martes
	DiaDeAtencion miercoles
	DiaDeAtencion jueves
	DiaDeAtencion viernes
	DiaDeAtencion sabado
	DiaDeAtencion domingo
	
	@Before
	def void SetUp(){
	unDispositivoConFechaDisponible = new Dispositivo()=> [
			//fechaActual= (PONER UNA FECHA NO DISPONIBLE, HAY QUE VER EL FORMATO DE FECHA)
		]
	lunes= new DiaDeAtencion()=> [
			dia = 1
			horaInicio=10
			horaFin=15
		]
	martes= new DiaDeAtencion()=> [
			dia = 2
			horaInicio=10
			horaFin=15
		]
	miercoles= new DiaDeAtencion()=> [
			dia = 3
			horaInicio=10
			horaFin=15
		]
	jueves= new DiaDeAtencion()=> [
			dia = 4
			horaInicio=10
			horaFin=15
		]
	viernes= new DiaDeAtencion()=> [
			dia = 5
			horaInicio=10
			horaFin=15
		]
	unBanco = new Banco() => [
			nombre = "Santander"
			rangoDeAtencion.add(lunes)
			rangoDeAtencion.add(martes)
			rangoDeAtencion.add(miercoles)
			rangoDeAtencion.add(jueves)
			rangoDeAtencion.add(viernes)
		]
					}
@Test
def void bancoEstaDisponible() {
		Assert.assertEquals(true, unDispositivoConFechaDisponible.consultarDisponibilidad(unBanco))
	}
@Test
def void bancoNoEstaDisponible() {
		Assert.assertEquals(false, unDispositivoConFechaNoDisponible.consultarDisponibilidad(unBanco))
	}

}