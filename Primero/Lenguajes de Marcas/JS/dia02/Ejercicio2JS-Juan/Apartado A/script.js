let edad = 38;
let nota = 5;
let nombre = "Juan";
const pi = 3.14159

document.write("Me llamo <b>" + nombre + "</b>, tengo <b>" + edad + "</b> y me conformo con un <b>" + nota + "</b> en JavaScript. <br>");
document.write("El número PI es igual a <u>" + pi + "</u>");

document.write(`<br> <br> Otra forma de hacerlo: <br>`)
document.write(`Me llamo <b>${nombre}</b>, tengo <b>${edad}</b> y me conformo con un <b>${nota}</b> en JavaScript. \n El número PI es igual a <u>${pi}</u>`)