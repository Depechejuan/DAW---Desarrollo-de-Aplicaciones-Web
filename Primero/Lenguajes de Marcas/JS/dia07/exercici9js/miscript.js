/*
	HAZ AQUÍ EL EJERCICIO...
	SE RESUELVE EN UNAS 30 LÍNEAS
	↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
*/

// 1
/*
	Hola pascu!
	No se si prefieres que eliminemos una a una las respuestas, o que hagamos algún tipo de "juego"
	en el cual eliminamos algunas bajo criterios via "inputs"
	Siendo tan facil como preguntaA[1].remove() - preguntaB[2].remove() como he hecho abajo.

	Si quieres, también te he dejado abajo comentado un pequeño "juego" en el cual 
	te va preguntando cuál prefieres, y te elimina la otra :) 
	Si quieres, comenta le código de abajo y descomenta el siguiente! 
*/

// document.getElementsByClassName("opcionB")[0].remove()
// document.getElementsByClassName("opcionB")[0].remove()
// document.getElementsByClassName("opcionB")[0].remove()
// document.getElementsByClassName("opcionA")[3].remove()
// document.getElementsByClassName("opcionB")[1].remove()
// document.getElementsByClassName("opcionA")[4].remove()
// document.getElementsByClassName("opcionB")[2].remove()
// document.getElementsByClassName("opcionB")[2].remove()
// document.getElementsByClassName("opcionA")[6].remove()
// document.getElementsByClassName("opcionA")[6].remove()


let pregunta = document.getElementsByClassName("pregunta")
for (let i = pregunta.length - 1; i >= 0 ; i--) {
	const a = document.getElementById(`opcion${i + 1}A`).innerHTML
	const b = document.getElementById(`opcion${i + 1}B`).innerHTML

	const AoB = prompt(`¿Qué prefieres? Opcion A: ${a} - Opcion B: ${b}`)
	if (AoB == 'a' || AoB == 'A'){
		document.getElementById(`opcion${i + 1}B`).remove()
	}
	else if (AoB == 'b' || AoB == 'B')
		{
			document.getElementById(`opcion${i + 1}A`).remove()
	}
	else {
		i++;
		alert("Valor introducido no válido. Se volverá a preguntar. (Responde solo A o B")
	}
}


// 2
let perros = document.getElementsByClassName("perros");

for (let i = perros.length -1; i >= 0; i--) {
	perros[0].remove(); // puedes poner "i" para eliminar el que toca en el bucle, o 0 y elimna siempre la posición 0
}

const h3 = document.getElementsByTagName("h3")

for (let i = h3.length -1; i >= 0; i--) {
	h3[0].remove();
}