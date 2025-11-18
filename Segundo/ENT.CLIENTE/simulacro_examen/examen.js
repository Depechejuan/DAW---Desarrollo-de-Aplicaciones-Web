function Persona(nombre, apellido, nif, edad) {
    this.nombre = nombre
    this.apellidos = apellido
    this.nif = nif
    this.edad = edad;
}

function Cliente(persona, fechaAlta, tipoCliente) {
    this.fechaAlta = fechaAlta;
    this.tipoCliente = tipoCliente;
}

