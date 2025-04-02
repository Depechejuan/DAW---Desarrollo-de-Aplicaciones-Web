/*
	HAZ AQUÍ EL EJERCICIO...
	SE RESUELVE EN MENOS DE 40 LÍNEAS
	↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
*/

let botonh1 = document.getElementById("boton2")
botonh1.onclick = cambiarColor

function cambiarColor() {
	let h1 = document.getElementById("titulo")
	h1.style.color = 'darkgreen'
}

let badbunny = document.getElementById("badbunny")
badbunny.addEventListener("dblclick", eliminar)

function eliminar() {
	badbunny.remove();
}

let pregunta = document.getElementById("pregunta")
pregunta.addEventListener("mouseover", cambio)

function cambio() {
	pregunta.innerHTML = "ESPECTACULAR"
}

let subtitulo = document.getElementById("subtitulo")
let boton3 = document.getElementById("boton3")
boton3.addEventListener("click", nombre)

function nombre() {
	let formulario = document.getElementById("cajaTexto").value
	subtitulo.innerHTML = formulario
}