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
    let aprobados = 0;
    let total = 0;
    let notas = [];

    for (let obj of alumnos) {
        let clone = template.content.cloneNode(true);

        let li = clone.querySelector(".alumno");
        let name = clone.querySelector(".nombre");
        let nota = clone.querySelector(".nota");

        name.textContent = obj.n;
        nota.textContent = obj.nota;
        notas.push(obj.nota)

        if (obj.nota >= 5) {
            aprobados++;
            total++;
            li.dataset.aprobado = "si"
        } else {
            total++;
            li.dataset.aprobado = "no"
        }
        
        fragment.append(li);
    }
    let resumen = document.getElementById("resumen");
    let media = calcularMedia(notas)
    resumen.textContent = `${aprobados}/${total} - media ${media}`
    return fragment
}

function calcularMedia(notas) {
    let media = 0;
    for (let i = 0; i < notas.length; i++) {
        media += notas[i];
    }
    return media / notas.length;
}

let lista = document.getElementById("lista");
lista.append(pintarAlumno())