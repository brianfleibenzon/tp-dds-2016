import org.junit.Before
import org.junit.Test
import org.junit.Assert


class TestTweet {
	Tweet frase
	
	@Before
	
	def void setUp(){
		frase = new Tweet
	}
	@Test
	
	def void testFrase(){
		
		
		Assert.assertEquals(128,frase.caracteresQueQuedan("Hola que tal"))
	}
}