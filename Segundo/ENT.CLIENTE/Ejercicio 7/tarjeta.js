class MiTarjeta extends HTMLElement {
    constructor() {
        super()
        this.shadow = this.attachShadow({mode: "open"})
    }


    connectedCallback() {
        const tpl = document.getElementById("tpl")
        const clon = tpl.content.cloneNode(true);

        // logica
        let btn = clon.querySelector("button")
        btn.style.backgroundColor = "green"

        btn.addEventListener("click", () => {
            this.dispatchEvent(new CustomEvent("seleccionado", {
                bubbles: true,
                composed: true,
                detail: { value: this.titulo }
            }));
        });

        let div = clon.querySelector("div")
        div.style.backgroundColor = "grey";
        div.style.border = "1px solid blue";
        div.style.padding = "10px";

        let h1 = clon.querySelector(".titulo")
        h1.textContent = "Título:"
        let p = clon.querySelector(".text")
        p.textContent = this.titulo

        this.shadow.append(clon)
    }

}

customElements.define("mi-tarjeta", MiTarjeta)


let tarjeta = document.createElement("mi-tarjeta")
tarjeta.setAttribute("titulo", "Producto A")

tarjeta.titulo = tarjeta.getAttribute("titulo")
tarjeta.addEventListener("seleccionado", (e) => { console.log(e.detail)})
let body = document.body;
console.log(tarjeta);
body.append(tarjeta)