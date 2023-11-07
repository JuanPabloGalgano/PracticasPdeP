import nave.*


object troll{
	
	method votar() = nave.jugadoresNoSospechosos().anyOne()
}

object detective{
	
	method votar() = nave.jugadorConMayorSospecha()
}

object materialista{
	
	method votar() = nave.jugadoresSinMateriales().anyOne()
}