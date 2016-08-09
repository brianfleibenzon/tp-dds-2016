import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import java.awt.Color

@Accessors
@Observable
class Tweet {
	static int longitudMaxima=140
	int caracteresEscritos
	int caracteresRestantes
	String textoEscrito
	Color color 
	
	def void setTextoEscrito(String texto){
		
		this.textoEscrito = texto
		this.caracteresEscritos = textoEscrito.length
		this.caracteresRestantes = longitudMaxima-caracteresEscritos
		
		if(caracteresRestantes <= 5){
			color = Color.RED
		} else {
			color= Color.BLACK
		}
	}

}
