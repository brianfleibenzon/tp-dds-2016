package edu.tp2016.observersBusqueda

import edu.tp2016.servidores.ServidorLocal
import edu.tp2016.observersBusqueda.RegistroDeBusqueda

interface BusquedaObserver {
def void registrarBusqueda(String texto, RegistroDeBusqueda busqueda, ServidorLocal servidor)

}