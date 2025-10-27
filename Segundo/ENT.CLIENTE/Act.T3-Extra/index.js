let body = document.getElementById("main")
let mainDiv = document.createElement("div");
mainDiv.setAttribute("class", "tarjeta")

body.append(mainDiv)

let divTitulo = document.createElement("div")
divTitulo.setAttribute("class", "tarjeta-titulo")
mainDiv.append(divTitulo);

let h2 = document.createElement("h2");
h2.textContent = "Datos de contacto";
divTitulo.append(h2);

let divCuerpo = document.createElement("div");
divCuerpo.setAttribute("class", "tarjeta-cuerpo")
mainDiv.append(divCuerpo);

let p1 = document.createElement("p")
p1.setAttribute("class", "tarjeta-nombre")
let span1 = document.createElement("span");
span1.setAttribute("class", "negrita")
span1.innerHTML = "nombre:"
p1.append(span1);
p1.append(" Laura Pérez")
divCuerpo.append(p1)

let p2 = document.createElement("p");
p2.setAttribute("class", "tarjeta-email")
let span2 = document.createElement("span")
span2.setAttribute("class", "negrita")
span2.innerHTML = "Email:"
p2.append(span2)
p2.append(" laura@noexiste.com")
divCuerpo.append(p2)

let p3 = document.createElement("p");
p3.setAttribute("class", "tarjeta-telefono")
let span3 = document.createElement("span")
span3.setAttribute("class", "negrita")
span3.innerHTML = "Teléfono:"
p3.append(span3)
p3.append(" 612123123")
divCuerpo.append(p3)