/*
	HAZ AQUÍ EL EJERCICIO...
	SE RESUELVE EN MENOS DE 20 LÍNEAS
	↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
*/

const doraemon = document.createElement("img")
doraemon.src = "./imagenes/doraemon.png"
const cielo = document.getElementById("zonaCielo")
cielo.appendChild(doraemon)

const nobita = document.createElement("img")
nobita.src = "./imagenes/nobita.png"
const habitacion = document.getElementById("zonaHabitacion")
habitacion.appendChild(nobita)

const central = document.getElementById("zonaCentral")
const h1 = document.createElement("h1")
h1.innerHTML = "Juan León Medina"
h1.style.color = "darkblue"
central.appendChild(h1)

const p = document.createElement("p")
p.innerHTML = "Que llegue el verano ya please..."
document.body.appendChild(p)