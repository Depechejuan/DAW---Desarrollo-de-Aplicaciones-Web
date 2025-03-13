/*
	HAZ AQUÍ EL EJERCICIO...
	SE RESUELVE EN MENOS DE 20 LÍNEAS
	↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
*/

const h2 = document.getElementsByTagName("h2")
for (let i = 0; i < h2.length; i++) {
	h2[i].innerHTML = `Mundo ${i+1}`
	h2[i].style.textAlign="center"
	h2[i].style.color="white"
	
}


const img = document.getElementsByTagName("img")
for (let i = 0; i < img.length; i++) {
	img[i].src = `./imagenes/mundo${i+1}.png`
	img[i].style.border = '3px solid white'
}

// Si, podría ser document.body, pero ya que estamos usando esta función...
document.getElementsByTagName("body")[0].style.backgroundColor = "darkblue"