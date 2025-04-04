/*
	HAZ AQUÍ EL EJERCICIO...
	ESTE ES MÁS LARGO (A MÍ ME OCUPA
	UNAS 60-70 LÍNEAS), PERO OS IRÉ
	AYUDANDO CON LAS COSAS DIFÍCILES
	↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
*/


let tortuga = document.getElementsByClassName("tortugas")
let zonaTortugas = document.getElementById("zonaDerecha")
let zonaIzquierda = document.getElementById("zonaIzquierda")
let pizza = document.getElementById("pizza")
let bottonIzq = document.getElementById("botonIzq")
let bottonDer = document.getElementById("botonDer")
bottonIzq.addEventListener("click", sumMargin)
bottonDer.addEventListener("click", subMargin)
document.body.addEventListener("keydown", listenTecla)
let button = document.getElementById("boton1")
button.addEventListener("click", addTortuga)

let margin = 0;

for (let i = 0; i < tortuga.length; i++) {
	tortuga[i].addEventListener("dblclick", removeTortuga)
	tortuga[i].addEventListener("mouseenter", addBorder)
	tortuga[i].addEventListener("mouseout", removeBorder)
}

function removeTortuga() {
	event.target.remove()
}

function addBorder() {
	event.target.style.border = "3px solid white"
}

function removeBorder() {
	event.target.style.border = ""
}

function addTortuga() {
	let input = document.getElementById("cajaTexto").value
	if (input == "raphael" || input == "leonardo" 
		|| input == "donatello" || input == "michelangelo" ) {
			let img = document.createElement("img")
			img.src = `./img/${input}.jpg`
			img.addEventListener("dblclick", removeTortuga)
			img.addEventListener("mouseenter", addBorder)
			img.addEventListener("mouseout", removeBorder)
			zonaTortugas.appendChild(img)
		}
		else {
		alert("¡Esa tortuga ninja no existe!")
	}
}

function sumMargin() {
	margin -= 10
	pizza.style.marginLeft = `${margin}px`
}

function subMargin() {
	margin += 10;
	pizza.style.marginLeft = `${margin}px`
}

function listenTecla() {
	let tecla = event.key
	
	console.log(tecla);
	if (tecla == 'a' || tecla == 'A') {
		margin -= 10
		pizza.style.marginLeft = `${margin}px`
	}
	if (tecla == 's' || tecla == 'S') {
		margin += 10;
		pizza.style.marginLeft = `${margin}px`
	}

	if (tecla == "2") {
		zonaIzquierda.style.backgroundColor = "lightgray"
		zonaTortugas.style.backgroundColor = "black"
	}

	if (tecla == '1') {
		zonaIzquierda.style.backgroundColor = "yellow"
		zonaTortugas.style.backgroundColor = "pink"
	}
	if (tecla == 'ñ' || tecla == "Ñ") {
		alert("Tu madre es tan gorda")
		alert("Que necesita dos alerts para hacer el chiste")
	}
}
