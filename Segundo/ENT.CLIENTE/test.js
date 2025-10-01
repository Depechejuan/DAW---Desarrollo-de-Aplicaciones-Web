"use strict"

console.log(null == 0);
console.log(null === 0);
console.log(null >= 0);
console.log(null <= 0);
// console.log(null !== 0);
// console.log(null != 0);
// console.log(isNaN(null));
// console.log(null > 0);
// console.log(null >= <0);
// console.log(null < 0);

let edad = "10"
edad -= 0;
edad += 10;
console.log(edad);

console.log(+'3' + 5);

let convert = 3
console.log(typeof(String(convert)));




let result = true;
if (result) {
    console.log("True")
} else {
    console.log("False")
}
console.log(3>4 ? true : false)

// let message;
// if (login == 'Employee') {
//     message = 'Hello';
// } else if (login == 'Director') {
//     message = 'Greetings';
// } else if (login == '') {
//     message = 'No login';
// } else {
//     message = '';
// }

let login = "Director"
let message = (login == 'Employee') ? 'Hello' :
    (login == 'Director') ? 'Greetings' :
    (login == '') ? 'No login' :
    '';
    console.log(message);

let object1 = {name: "Juan"}
let object2 = {}
Object.assign(object1, object2)


// REVISAR
function saludar(prev, post) {
    return prev + this.nombre + post
}
let nombre = {nombre: "Juan"}
let saludos = ["Hola, ", " ¿Qué tal?"]

console.log(saludar.apply(nombre, saludos));
console.log(saludar.apply(nombre, ["Hola, ", " ¿Qué tal?"]));


console.log("--------------------------");
let usuario = {
    nombre: "Miguel",
    saluda: function() {

        return this.nombre;
    }
}

let a = usuario.saluda();
console.log(a);

let ciudadano = {
    nombre: "David", 
    saludaConRetardo: function() {
        setTimeout(function() {
            console.log(this.nombre);
        }, 1000)
    }
}

ciudadano.saludaConRetardo();


// Al usar bind, setTimeOut tendrá el mismo contexto que "ciudadano"
ciudadano = {
    nombre: "David", 
    saludaConRetardo: function() {
        setTimeout(function() {
            console.log(this.nombre);
        }.bind(this), 1000)
    }
}
ciudadano.saludaConRetardo();

ciudadano = {
    nombre: "Paco", 
    saludaConRetardo: function() {
        setTimeout(() => {
            console.log(this.nombre);
        }, 1000);
    }
}
ciudadano.saludaConRetardo();


