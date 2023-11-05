class Posicion{
	
	var property elementosCerca
	
	method tieneCerca(unaCosa) = elementosCerca.contains(unaCosa)
	
	method acercarElemento(unaCosa) = elementosCerca.add(unaCosa)
	
	method alejarElemento(unaCosa) = elementosCerca.remove(unaCosa)
	
	method cantidadDeElementosCerca() = elementosCerca.size()
}