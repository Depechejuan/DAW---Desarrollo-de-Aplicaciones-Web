class MiElemento extends HTMLElement {
    constructor() {
        super()
    }

    connectedCallback() {
        const shadow = this.attachShadow({mode: "open"})
        const tpl = document.getElementById("tpl")
        const clon = tpl.content.cloneNode(true)
        let btn = clon.querySelector("button")
        btn.textContent = this.contador
        
        btn.addEventListener("click", (e) => {
            this.contador += 1;
            btn.textContent = this.contador;
        })

        btn.style.backgroundColor = "blue"
        btn.style.border = "2px solid red"
        btn.style.padding = "200px"
        btn.style.color = "white"


        shadow.append(clon)
    }

}



customElements.define("mi-elemento", MiElemento)

let contador = document.createElement("mi-elemento")
contador.contador = 0
let body = document.getElementById("component")
console.log(contador);
body.append(contador)
