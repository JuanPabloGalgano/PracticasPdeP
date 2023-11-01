import expedicion.*
import vikingo.*

class Casta{
	
	method puedeIr(unVikingo) = true
	method ascender(unVikingo){
		unVikingo.premioPorAscenso()
		}
	
}

object jarl inherits Casta{
	
	override method puedeIr(unVikingo) = not unVikingo.tieneArmas()
	
	override method ascender(unVikingo){
	 unVikingo.convertirseEnKarl()
	 super(unVikingo)
	 } 
}

object karl inherits Casta{
	
	override method ascender(unVikingo){
		unVikingo.convertirseEnThrall()
		super(unVikingo)
	}
	
}

object thrall inherits Casta{
	
	override method ascender(unVikingo){}
}


