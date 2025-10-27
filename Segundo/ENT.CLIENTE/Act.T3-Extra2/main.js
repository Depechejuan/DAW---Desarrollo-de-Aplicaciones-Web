const alumnos = [
    {
        n: "Laura",
        nota: 8.0
    },
        {
        n: "Pablo",
        nota: 4.5
    },
        {
        n: "Sara",
        nota: 6.0
    },
        {
        n: "Nora",
        nota: 3.8
    }
]


function pintarAlumno() {
    let fragment = new DocumentFragment();
    let template = document.getElementById("tpl");

    for (let obj of alumnos) {
        let clone = template.content.cloneNode(true);

        let li = clone.querySelector(".alumno");
        let name = clone.querySelector(".nombre");
        let nota = clone.querySelector(".nota");

        name.textContent = obj.n;
        nota.textContent = obj.nota;

        li.dataset.aprobado = obj.nota >= 5 ? "si" : "no";
        
        fragment.append(li);
    }

    return fragment
}

let lista = document.getElementById("lista");
lista.append(pintarAlumno())