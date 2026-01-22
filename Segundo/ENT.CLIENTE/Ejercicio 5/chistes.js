let chistes = [
    {
	enunciado: "¿Qué le dice un bit a otro?",
	respuesta: "Nos vemos en el bus."
    },
    {
	enunciado: "¿Qué es un terapeuta?",
	respuesta: "1024 GigaPeutas."
    },
    {
    enunciado: "¿Qué son 8 bocabits?",
	respuesta: "1 bocabyte"   
    },
    {
	enunciado: "¿Cuántos programadores hacen falta para cambiar una bombilla?",
	respuesta: "Ninguno, porque es un problema de hardware."
    }
]



class MiElemento extends HTMLElement {
    constructor() {
        super()
        this.shadow = this.attachShadow({mode: "open"}) // crear shadow en constructor
    }

    connectedCallback() {
        const tpl = document.getElementById("tpl")
        const clon = tpl.content.cloneNode(true)
        let enunciado = clon.querySelector(".chiste")
        enunciado.textContent = this.enunciado;
        let btn = clon.querySelector("button")

        btn.addEventListener("click", (e) => {
            alert(this.punchline)
        })
        this.shadow.append(clon)
    }
}

customElements.define("mi-elemento", MiElemento)

for(let chiste of chistes) {
    let joke = document.createElement("mi-elemento")
    joke.enunciado = chiste.enunciado
    joke.punchline = chiste.respuesta
    let div = document.getElementById("listado")
    div.append(joke)
}