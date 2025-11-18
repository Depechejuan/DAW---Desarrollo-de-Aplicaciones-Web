// SET es una colección de elementos únicos, sin índices ni claves
// no es un objeto, es una estructura de datos
// se puede iterar con for...of, forEach, etc.
// tampoco es un array, aunque se puede convertir a array fácilmente
// mediante el operador de propagación (...) o Array.from()

const numeros = new Set([1, 2, 2, 3]);
console.log(numeros); // Set { 1, 2, 3 }
numeros.add(4);
numeros.has(3); // true
numeros.delete(2); // borra el 2

// recorrer un set
for (let num of numeros) {
  console.log(num);
}

//convertir un set a array
const arrayNumeros = [...numeros];
console.log(arrayNumeros); // [1, 3, 4]
//otra forma de convertir un set a array
const otroArray = Array.from(numeros);
console.log(otroArray); // [1, 3, 4]

// MAP es una colección de pares clave-valor
// las claves pueden ser de cualquier tipo (objetos, funciones, etc.)
// se puede iterar con for...of, forEach, etc.
// tampoco es un objeto, es una estructura de datos
// tampoco es un array, aunque se puede convertir a array fácilmente
// mucho más potente y flexible que un objeto {} normal.
// Crear un Map
const capitales = new Map();
capitales.set('España', 'Madrid');
capitales.set('Francia', 'París');
// Obtener un valor
console.log(capitales.get('España')); // Madrid
// Comprobar si una clave existe
console.log(capitales.has('Italia')); // false
// has solo puede ser usado con map y set (no con objetos normales)
// Eliminar una clave
capitales.delete('Francia');
capitales.set('Italia', 'Roma');
// Recorrer un Map
for (let [pais, capital] of capitales) {
  console.log(`${pais}: ${capital}`);
}
// Otra forma de recorrer un Map
capitales.forEach((capital, pais) => {
  console.log(`${pais}: ${capital}`);
});

//forEach solo puede ser usado con map, set y arrays (no con objetos normales)
// Convertir un Map a array
const arrayCapitales = [...capitales];
console.log(arrayCapitales); // [ [ 'España', 'Madrid' ], [ 'Italia', 'Roma' ] ]
// Otra forma de convertir un Map a array
const otroArrayCapitales = Array.from(capitales);
console.log(otroArrayCapitales); // [ [ 'España', 'Madrid' ], [ 'Italia', 'Roma' ] ]
//Convertir map a objeto normal
const objCapitales = Object.fromEntries(capitales);
console.log(objCapitales); // { España: 'Madrid', Italia: 'Roma' }

// Claves que sí puede tener un Map
const mapaDiverso = new Map();
mapaDiverso.set('claveString', 'valor1');
mapaDiverso.set(42, 'valor2');
mapaDiverso.set(true, 'valor3');
const objClave = { id: 1 };
mapaDiverso.set(objClave, 'valor4');
console.log(mapaDiverso); 
// Map { 'claveString' => 'valor1', 42 => 'valor2', true => 'valor3', { id: 1 } => 'valor4' }
// En un objeto normal, las claves son strings

// Recorrer propiedades (keys) y valores de un objeto
const persona = { nombre: 'Ana', edad: 30, ciudad: 'Madrid' };
for (let clave of Object.keys(persona)) {
    console.log(`Clave: ${clave}`);
}
// Recorrer valores de un objeto
for (let valor of Object.values(persona)) {
    console.log(`Valor: ${valor}`);
}
// Recorrer propiedades y valores de un objeto
for (let [clave, valor] of Object.entries(persona)) {
    console.log(`${clave}: ${valor}`);
}

// Object.entries() también puede usarse con Maps y Sets
// Convierte Map, Set o Objeto a array de pares [clave, valor]
const mapaEjemplo = new Map();
mapaEjemplo.set('a', 1);
mapaEjemplo.set('b', 2);
console.log(Object.entries(mapaEjemplo)); // [ [ 'a', 1 ], [ 'b', 2 ] ]

// Métodos de arrays
// forEach
const frutas = ['manzana', 'plátano', 'cereza'];
frutas.forEach((fruta, indice) => {
    console.log(`${indice}: ${fruta}`);
});
// map
const frutasMayusculas = frutas.map(fruta => fruta.toUpperCase());
console.log(frutasMayusculas); // [ 'MANZANA', 'PLÁTANO', 'CEREZA' ]
// filter
const frutasConA = frutas.filter(fruta => fruta.includes('a'));
console.log(frutasConA); // [ 'manzana', 'plátano' ]
// reduce
const numerosArray = [1, 2, 3, 4];
const suma = numerosArray.reduce((acumulador, valorActual) => acumulador + valorActual, 0);
console.log(suma); // 10
// some
const hayCereza = frutas.some(fruta => fruta === 'cereza');
console.log(hayCereza); // true
// every
const todasTienenA = frutas.every(fruta => fruta.includes('a'));
console.log(todasTienenA); // false
// find
const frutaConE = frutas.find(fruta => fruta.includes('e'));
console.log(frutaConE); // 'cereza'
// findIndex
const indicePlatanos = frutas.findIndex(fruta => fruta === 'plátano');
console.log(indicePlatanos); // 1
