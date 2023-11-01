object inmobiliaria{
	var property empleados = #{}
	
	method mejorEmpleadoSegun(criterio) = empleados.max{empleado => criterio.ponderacion(empleado)}
	
}

object comisionesDeOperaciones{
	
	method ponderacion(unEmpleado){
		unEmpleado.totalComisiones()	
	}
}

object cantidadOperaciones{
	
	method ponderacion(unEmpleado){
		unEmpleado.cantidadOperacionesCerradas()
	}
}

object cantidadDeReservas{
	
	method cantidadDeReservas(unEmpleado){
		unEmpleado.cantidadDeReservas()
	}
}