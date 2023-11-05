class Cerdito{
	
	method resistencia()
	
}

class Obrero inherits Cerdito{

	override method resistencia() = 50	
	
}

class Armado inherits Cerdito{
	
	const tipoDeExtra
	
	override method resistencia() = 10 * tipoDeExtra.resistenciaArma()
	
}

class ConCasco inherits Armado{
	
	const resistenciaCasco
	
	method resistenciaArma() = resistenciaCasco
}

class ConArmadura inherits Armado{
	
	const resistenciaArmadura
	
	method resistenciaArma() = resistenciaArmadura
}


