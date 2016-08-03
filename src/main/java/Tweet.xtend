import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class Tweet {
	int longitudMaxima=140
	int caracteresEscritos
	int caracteresQueQuedan
	String textoEscrito
	
	def int caracteresQueQuedan(String texto){
		
		textoEscrito=texto
		caracteresEscritos=textoEscrito.length
	
		caracteresQueQuedan=longitudMaxima-caracteresEscritos
		
		}
	
	
}
