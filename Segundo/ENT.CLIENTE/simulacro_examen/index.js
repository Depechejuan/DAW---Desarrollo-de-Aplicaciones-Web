function Album(nombre, anyo, ...canciones) {
    this.nombre = nombre;
    this.anyo = anyo;
    this.canciones = [...canciones]
}

let lista = []

lista.push(new Album("1981", "Speak and spell", "new life", "just cant get", "nodisco", "photographic"), new Album("1982", "A borken frame", "leave in silence", "my secret garden", "monument"),new Album("1983", "Construction Time Again", "everything counts", "pipeline", "nodisco"),)


function pintar() {
    let fragment = new DocumentFragment();
    let template = document.getElementById("tpl");

    for (let album in lista) {
        let clone = template.content.cloneNode(true)

        let nombre = clone.querySelector(".nombre")
        nombre.textContent = album.nombre;
        let anyo = clone.querySelector(".anyo")
        anyo.textContent = album.anyo

        let ul = clone.querySelector("listado")
        for (let cancion in album.canciones) {
            let li = document.createElement("li")
            li.textContent = cancion;
            ul.append(li)
        }
        fragment.append(clone)

    }
    return fragment
}

let doc = document.getElementById("discografia")
doc.append(pintar())