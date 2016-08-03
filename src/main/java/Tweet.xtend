import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class Tweet {
	static int longitudMaxima=140
	int caracteresEscritos
	int caracteresRestantes
	String textoEscrito
	
	def void setTextoEscrito(String texto){
		
		this.textoEscrito = texto
		this.caracteresEscritos = textoEscrito.length
		
		this.caracteresRestantes = longitudMaxima-caracteresEscritos
		}
	
	
}
