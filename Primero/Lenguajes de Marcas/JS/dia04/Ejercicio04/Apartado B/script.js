for (let i = 1; i < 101; i++) {
    // Te he añadido un pequeño if inline en el que pregunta si es la primera iteración
    // para solo esceribir "obeja", y si es otra iteración, añade la "s"
    document.write(`${i} Oveja${i == 1 ? "" : "s"} <br>`)
}