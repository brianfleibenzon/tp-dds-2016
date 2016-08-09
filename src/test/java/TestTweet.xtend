import org.junit.Before
import org.junit.Test
import org.junit.Assert


class TestTweet {
	Tweet frase
	
	@Before
	
	def void setUp(){
		frase = new Tweet
		frase.setTextoEscrito("Hola que tal")
	}
	@Test
	
	def void testCaracteresQueQuedan(){
			
		Assert.assertEquals(128,frase.caracteresRestantes)
	}
}