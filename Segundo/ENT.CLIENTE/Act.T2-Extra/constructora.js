function Coches(...values) {
    this.coches = [values];

    this.anyadirCoche = function(...coche) {
        this.coches.push(...coche);
    }
}

function CrearCoche(id, marca, modelo, precio) {
    this.id = id;
    this.marca = marca;
    this.modelo = modelo;
    this.precio = precio;

    this.ToString() = function() {
        let obj = {
            id,
            marca,
            modelo,
            precio,
            premium
        }
        return obj
    }

}



function ObtenerCochesConMarca(marca) {
    marca = marca.toLowerCase();
    return coches.filter(coche => coche.marca.toLowerCase() == marca)
}

function ObtenerCochesPorPrecioMenor(precio) {
    return coches.filter(coche => coche.precio < precio)
}

function ObtenerPrimerCochePorPrecioMayor(precio) {
    
    return coches.find(coche => coche.precio > precio)
}

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

let coche1 = new CrearCoche(1, "Seat", "Ibiza", 10000)
let coche2 = new CrearCoche(2, "Seat", "Ateca", 18000)
let coche3 = new CrearCoche(3, "Wolkswagen", "Golf", 21000)
let coche4 = new CrearCoche(4, "Kia", "Niro", 30000)
let coches = new Coches(coche1.ToString(), coche2.ToString(), coche3.ToString(), coche4.ToString());
// coches.anyadirCoche()
console.log(coches);