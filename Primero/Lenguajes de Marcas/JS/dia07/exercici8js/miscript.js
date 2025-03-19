/*
	HAZ AQUÍ EL EJERCICIO...
	SE RESUELVE EN MENOS DE 30 LÍNEAS
	↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
*/

// 1
const body = document.body;
body.style.backgroundColor = 'lightgray'
body.style.fontFamily = 'Arial'

// 2
const titulo = document.getElementById("titulo")
titulo.style.color = 'darkred'

// 3
const sub = document.getElementById("subtitulo")
sub.style.textDecoration = 'underline'

// 4
const links = document.getElementsByTagName("a")
for (let i = 0; i < links.length; i++) {
	const pokemon = links[i].innerHTML;
	// console.log(pokemon);
	links[i].href = `https://www.wikidex.net/wiki/${pokemon}`
}


// 6
const mew = document.getElementById("misterioso")
// console.log(mew[mew.length -1].innerHTML)
mew.className = 'capturados';



// 5
const capturados = document.getElementsByClassName("capturados")
for (let i = 0; i < capturados.length; i++) {
	capturados[i].style.textTransform = 'uppercase';
	capturados[i].style.listStyleImage = `url('./imagenes/pokeball2.png')`
}


/*
NO funciona hacerlo en el orden que dice los ejercicios, por lo que hay que hacer primero la captura de MEW y luego cambiar todos los estilos de los capturados.
Otra manera sería una función que se llama al final del script con el código, así siempre se hará el cambio al finalizar todo el código.
*/