/*
	HAZ AQUÍ EL EJERCICIO...
	ESTE ES MÁS LARGO (A MÍ ME OCUPA
	UNAS 60-70 LÍNEAS), PERO OS IRÉ
	AYUDANDO CON LAS COSAS DIFÍCILES
	↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
*/


let tortuga = document.getElementsByClassName("tortugas")
let zonaTortugas = document.getElementById("zonaDerecha")

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

let button = document.getElementById("boton1")
button.addEventListener("click", addTortuga)

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



let pizza = document.getElementById("pizza")
let bottonIzq = document.getElementById("botonIzq")
let bottonDer = document.getElementById("botonDer")

let margin = 0;

bottonIzq.addEventListener("click", sumMargin)
bottonDer.addEventListener("click", subMargin)

function sumMargin() {
	margin -= 10
	pizza.style.marginLeft = `${margin}px`
}

function subMargin() {
	margin += 10;
	pizza.style.marginLeft = `${margin}px`

}