class MiTarjeta extends HTMLElement {
    constructor() {
        super()
    }


    connectedCallback() {
        const shadow = this.attachShadow({mode: "open"})
        const tpl = document.getElementById("tpl")
        const clon = tpl.content.cloneNode(true);

        // logica


        shadow.append(clon)
    }
}

customElements.define("mi-tarjeta", MiTarjeta)

