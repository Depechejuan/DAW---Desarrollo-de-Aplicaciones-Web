let num = prompt("¿En qué año naciste?")
const edad = 2025 - num;

document.write(`<p>Naciste en el año ${num}. <br>
    Por lo tanto, tienes ${edad} años. <br>
    El año que viene tendrás ${edad + 1} años.</p>`)