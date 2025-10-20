let coches = [
    {
        id: 1,
        marca: "Seat",
        modelo: "Ibiza",
        precio: 10000
    },
        {
        id: 2,
        marca: "Seat",
        modelo: "Ateca",
        precio: 18000
    },
        {
        id: 3,
        marca: "Wolkswagen",
        modelo: "Golf",
        precio: 21000
    },
        {
        id: 4,
        marca: "Kia",
        modelo: "Niro",
        precio: 30000
    }
]



let marca = "Seat"
function ObtenerCochesConMarca(marca) {
    marca = marca.toLowerCase();
    return coches.filter(coche => coche.marca.toLowerCase() == marca)
}


let precio = 25000
function ObtenerCochesPorPrecioMenor(precio) {
    return coches.filter(coche => coche.precio < precio)
}

let precio2 = 20000
function ObtenerPrimerCochePorPrecioMayor(precio) {
    
    return coches.find(coche => coche.precio > precio)
}

let precioCochePremium = 20000
function transformarArrayAPremiun() {
    coches = coches.map((coche) => {
        coche.premium = coche.precio > precioCochePremium
        return coche;
    })
}

function CalcularPrecioMedioCoches() {
    let precio = coches.reduce((acum, coche) => {
            return acum += coche.precio
        },0)
    let cantidadCoches = coches.length;
    let precioMedio = precio / cantidadCoches

    return precioMedio
}


console.log("Coches con marca 'Seat'");
console.log(ObtenerCochesConMarca(marca));
console.log("Coches con Precio menor de 25000");
console.log(ObtenerCochesPorPrecioMenor(precio));
console.log("Primer coche con Precio mayor de 20000");
console.log(ObtenerPrimerCochePorPrecioMayor(precio2));
console.log("Transformamos el array y convertimos los coches si son premium");
transformarArrayAPremiun();
console.log(coches);
console.log("Precio medio de los coches");
console.log(CalcularPrecioMedioCoches());