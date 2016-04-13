package edu.tp2016

import org.uqbar.geodds.Polygon
import org.uqbar.geodds.Point
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List

@Accessors
class Comuna {
	Polygon poligono
	int numero
	List<String> barrios
	
	def boolean pertenecePunto(Point unPunto){
		poligono.isInside(unPunto)
	}
}