let notas = [6.532, 9.477, 7.677, 
            6.607, 9.247, 9.794,
            9.47, 8.355, 0.416,
            5.646, 8.208, 4.265,
            6.999, 8.795, 1.807,
            3.36, 6.874, 8.813,
            3.165, 5.001];


for (let i = 0; i < notas.length; i++) {
    if (notas[i] < 5.00) {
        document.write(`${notas[i]} [Insuficiente] <br>`)
    }
    if (notas[i] >= 5.00 && notas[i] < 6.00) {
        document.write(`${notas[i]} [Suficiente] <br>`)
    }
    if (notas[i] >= 6.00 && notas[i] < 7.00) {
        document.write(`${notas[i]} [Bien] <br>`)
    }
    if (notas[i] >= 7.00 && notas[i] < 9.00) {
        document.write(`${notas[i]} [Notable] <br>`)
    }
    if (notas[i] >= 9.00) {
        document.write(`${notas[i]} [Sobresaliente] <br>`)
    }
}