class Mision{
	
	var property habilidadesRequeridas
	var property peligrosidad
	
	method laPuedeCumplir(unaPersona) = habilidadesRequeridas.all{habilidad => unaPersona.tieneHabilidad(habilidad)}
	
	method enseniarHabilidades(unEmpleado){
		self.habilidadesQueNoPosee(unEmpleado).forEach{habilidad => unEmpleado.aprenderHabilidad(habilidad)}
	}
	
	method habilidadesQueNoPosee(unEmpleado) = habilidadesRequeridas.filter{habilidad => not unEmpleado.poseeHabilidad(habilidad)}
}