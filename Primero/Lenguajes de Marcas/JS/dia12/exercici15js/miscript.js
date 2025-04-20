/*
	HAZ AQUÍ EL EJERCICIO...
	ESTE ES MÁS LARGO (A MÍ ME OCUPA
	UNAS 90-100 LÍNEAS), PERO OS IRÉ
	AYUDANDO CON LAS COSAS DIFÍCILES
	↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
*/

// Ejercicio 1
setTimeout(cambiarColor, 3000) 

function cambiarColor() {
	let divArriba = document.getElementById("arriba")
	divArriba.style.color = "yellow"
}

// Ejercicio 2
setTimeout(cambioSemaforos, 5000)

let semaforos = document.getElementsByClassName("semaforos")
function cambioSemaforos() {
	for(let i = 0; i < semaforos.length; i++) {
		semaforos[i].src = "./imagenes/semaforo2.png"
	}
}

// Ejercicio 3
console.log("???");
setInterval(cambioBoton, 500)
let button1 = document.getElementById("boton1")
let button2 = document.getElementById("boton2")
let button3 = document.getElementById("boton3")
button1.style.backgroundColor = "";
button2.style.backgroundColor = "";
button3.style.backgroundColor = "";

function cambioBoton() {
	if (button1.style.backgroundColor == "") {
		button1.style.backgroundColor = "pink"
		button2.style.backgroundColor = "pink"
		button3.style.backgroundColor = "pink"
	} else {
		button1.style.backgroundColor = ""
		button2.style.backgroundColor = ""
		button3.style.backgroundColor = ""
	}
}

// Ejercicio 4 y 5
let botonDetener = document.getElementById("boton1")
botonDetener.addEventListener("click", stopVirus)
let virusInterval = setInterval(virus, 1000)
let zonaIzquierda = document.getElementById("izquierda")
function virus() {
	let img = document.createElement("img")
	img.src = "./imagenes/virus.png"
	zonaIzquierda.append(img)
}
function stopVirus() {
	clearInterval(virusInterval)
}

//Ejercicio 6
let boton2 = document.getElementById("boton2")
let zonaDerecha = document.getElementById("derecha")
boton2.addEventListener("click", autoDestruccion)
let autodestruccion;
function autoDestruccion() {
	autodestruccion = setInterval(countDown, 1000)
	
}
let contador = 5
function countDown() {
	if (contador == 0) {
		document.body.remove();
	} else {
		let p = document.createElement("p")
		p.innerHTML = `Esta página se autodestruirá en ${contador--}`
		zonaDerecha.append(p)
	}
}

// Ejercicio 7
boton3.addEventListener("click", pararDestruccion)
function pararDestruccion() {
	clearInterval(autodestruccion)
	let p = document.createElement("p")
	p.innerHTML = "CANCELADO"
	zonaDerecha.append(p)
	contador = 5
}