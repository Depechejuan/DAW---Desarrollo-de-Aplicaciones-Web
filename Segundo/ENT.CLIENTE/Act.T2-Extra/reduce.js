let coches = [
    { matricula: "ABC1", color: "rojo"},
    { matricula: "ABC2", color: "verde"},
    { matricula: "ABC3", color: "azul"},
    { matricula: "ABC4", color: "Rojo"},
    { matricula: "ZBC1", color: "rojo"},
    { matricula: "SBC2", color: "verde"},
    { matricula: "FBC3", color: "azul"},
    { matricula: "RBC4", color: "Rojo"},
]

function clasificarPorColor(coches) {
    let total = coches.length;
    let answer = coches.reduce((acum, coche) => {
        let color = coche.color;
        color = color.toLowerCase();
        if (!acum[color]) {
            acum[color] = {
                cuenta: 0,
                listado: []
            };
        }
        if (acum[color]) {
            acum[color].cuenta += 1;
            acum[color].listado.push(coche);
            acum[color].listado.sort(function(a, b) {
                if (a.matricula > b.matricula)
                    return 1;
                else
                    return -1;
            });
        }
        return acum;
    }, {})
    answer = {total, ...answer}
    answer = JSON.stringify(answer, null, 4)
    return answer;
}


console.log(clasificarPorColor(coches));