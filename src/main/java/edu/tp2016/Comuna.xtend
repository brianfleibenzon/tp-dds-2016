package edu.tp2016

import org.uqbar.geodds.Polygon
import java.util.Collection
import org.uqbar.geodds.Point
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Comuna {
	Polygon poligono
	int numero
	Collection barrios
	
	def boolean pertenecePunto(Point unPunto){
		poligono.isInside(unPunto)
	}
}