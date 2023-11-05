class IslaPajaro{
	
	var property pajaros
	
	method pajarosFuertes() = pajaros.filter{pajaro => pajaro.esFuerte()}
	
	method fuerzaDeLaIsla() = pajaros.sum{pajaro => pajaro.fuerza()}
	
	method sucedeEvento(unEvento) = pajaros.forEach{pajaro => pajaro.esAfectadoPor(unEvento)}
	
	method atacarA(islaCerdito) = pajaros.forEach{pajaro => pajaro.lanzarA(islaCerdito)}
	
	method seRecuperaronLosHuevos(islaCerdito) = islaCerdito.noTieneObstaculos()
}

class IslaCerdito{
	
	const obstaculos = []

	method noTieneObstaculos() = obstaculos.isEmpty()
}