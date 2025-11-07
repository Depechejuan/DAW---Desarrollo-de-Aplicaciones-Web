let chistes = [
    {
        enunciado: "¿Qué le dice un bit a otro?",
        respuesta: "Nos vemos en el bus"
    },
    {
        enunciado: "Qué es un terapeuta?",
        respuesta: "1024 GigaPeutas"
    },
    {
        enunciado: "Cuántos programadores hacen falta para cambiar una bombilla?",
        respuesta: "Ninguno, porque es un problema de hardware"
    },
]

let count = 1

let showChiste = {
    handleEvent: function(e) {
        alert(e.target.dataset.respuesta);
    }
}

for (let chiste of chistes) {
    let body = document.body;
    let div = document.createElement("div")
    div.setAttribute("id", `chiste${count}`)
    count++;
    let joke = document.createElement("p");
    joke.textContent = chiste.enunciado;
    body.append(div);
    div.append(joke)

    let button = document.createElement("button")
    button.innerHTML = "mostrar punchline"
    button.setAttribute("class", "showChiste")
    button.dataset.respuesta = chiste.respuesta;
    div.append(button);
    button.addEventListener("click", showChiste);
}

