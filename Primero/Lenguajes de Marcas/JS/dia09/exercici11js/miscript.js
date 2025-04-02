/*
	HAZ AQUÍ EL EJERCICIO...
	SE RESUELVE EN MENOS DE 40 LÍNEAS
	↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
*/

// Zonas
let zonaGris = document.getElementById("zonaGris")
let zonaAmarilla = document.getElementById("zonaAmarilla")


// Lista
let ol = document.createElement("ol")
let li1 = document.createElement("li")
let li2 = document.createElement("li")
let li3 = document.createElement("li")

li1.innerHTML = "Viajar a Luxeburgo"
li2.innerHTML = "Hacer un concierto"
li3.innerHTML = "Comer hamburguesas y kebabs"

ol.appendChild(li1)
ol.appendChild(li2)
ol.appendChild(li3)

zonaGris.appendChild(ol)

// Tabla
let table = document.createElement("table")
let th1 = document.createElement("th")
let th2 = document.createElement("th")
let tr1 = document.createElement("tr")
let tr2 = document.createElement("tr")
let td1 = document.createElement("td")
let td2 = document.createElement("td")

th1.innerHTML = "Nombre"
th2.innerHTML = "Apellido"
td1.innerHTML = "Juan"
td2.innerHTML = "León"

table.appendChild(tr1)
table.appendChild(th1)
table.appendChild(th2)
table.appendChild(tr2)
tr2.appendChild(td1)
tr2.appendChild(td2)

zonaAmarilla.appendChild(table)


table.style.border = "1px solid black"
th1.style.border = "2px solid black"
th2.style.border = "2px solid black" // Un poco más bonito
td1.style.border = "1px solid black"
td2.style.border = "1px solid black"

// table.style.border = "1"