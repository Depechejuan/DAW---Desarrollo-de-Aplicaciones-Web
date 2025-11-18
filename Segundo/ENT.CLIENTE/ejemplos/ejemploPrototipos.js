"use strict";

function Animal(orden, peso) {
  this.come = true;
  this.orden = orden;
  this.peso = peso;
  this.mimetodo = function(){
    console.log("Este es un método creado dentro del constructor");
  } // cada instancia tiene su propia copia de este método
};

Animal.prototype.printOrden = function(){
    console.log(`Orden del animal: ${this.orden}`);
  }; // método asociado al prototipo. Todas las instancias comparten este método (no se crea una copia por instancia). Recomendado.

Animal.prototype.printPeso = function(){
    console.log(`Peso del animal: ${this.peso}`);
  };

function Vacas(orden, peso, anyos, nombre)
{
  Animal.call(this, orden, peso); // llama al constructor de Animal en el contexto de Vacas
  // esto crea las propiedades come, orden y peso en el objeto que se está creando
  // pero no se heredan los métodos asociados al prototipo de Animal
  // Es decir, este constructor hereda las propiedades pero no los métodos del prototipo de Animal
  // Sí hereda el método mimetodo porque se crea dentro del constructor de Animal
  this.anyos = anyos;
  this.nombre = nombre;
}

Object.setPrototypeOf(Vacas.prototype, Animal.prototype);
// establece el prototipo de Vacas.prototype a Animal.prototype
// de esta forma, las instancias de Vacas heredarán los métodos asociados al prototipo de Animal

Vacas.prototype.imprime = function()
{
  console.log(`Hola, soy la vaca ${this.nombre} y tengo ${this.anyos} años.
    No me gusta estudiar. `)
}
// crear un nuevo objeto con animal como prototipo
let rabbit = new Animal("reptil","3"); // lo mismo que {__proto__: animal}

console.log(`Prototipo de rabbit:`)
console.dir(Object.getPrototypeOf(rabbit)); // muestra el prototipo de rabbit que es Animal.prototype
console.dir(rabbit); //Esto muestra el objeto expandido con sus prototipos

rabbit.printOrden();
rabbit.printPeso();

console.log(`¿El conejo come?: ${rabbit.come}\n`); // true
console.dir(Object.getPrototypeOf(rabbit)); // muestra el prototipo de rabbit que es Animal.prototype

Animal.prototype.come = "hierba";
console.log(`¿El conejo come...?: ${rabbit.come}\n`);

let lola = new Vacas("mamífero", 500, 3, "Lola");

lola.imprime();
lola.printOrden();
lola.printPeso();

console.log(`\nPrototipo de lola:`)
console.dir(Object.getPrototypeOf(lola)); // muestra el prototipo de lola que es Vacas.prototype
console.dir(lola) // muestra el objeto lola expandido



Object.setPrototypeOf(rabbit, {}); // cambia el prototipo de rabbit a {} y ya no tiene los métodos asociados al prototipo
                                  // pero las propiedades que se crearon dentro del constructor son exclusivas de cada instancia
                                  // del objeto
console.log(`\nPrototipo de rabbit tras cambiarlo al objeto vacío {}:`)
console.dir(Object.getPrototypeOf(rabbit)); // muestra el nuevo prototipo de rabbit que es {}
console.dir(rabbit); // muestra el objeto rabbit expandido

function Clima(temperatura, humedad) {
    this.temperatura = temperatura;
    this.humedad = humedad;
    this.muestraClima = function() {
        console.log(`Temperatura: ${this.temperatura}°C, Humedad: ${this.humedad}%`);
    };
}

function Pronostico(temperatura, humedad, probabilidadLluvia) {
    Clima.call(this, temperatura, humedad);
    this.probabilidadLluvia = probabilidadLluvia;
}

let pronosticoHoy = new Pronostico(25, 80, 60);
pronosticoHoy.muestraClima(); // Muestra la temperatura y humedad
console.log(`\nPrototipo de pronosticoHoy:`);
console.dir(Object.getPrototypeOf(pronosticoHoy)); 
console.dir(pronosticoHoy);