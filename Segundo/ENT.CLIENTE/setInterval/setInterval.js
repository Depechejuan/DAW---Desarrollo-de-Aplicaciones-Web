let contador = 0;
let intervalo = null;

function comenzar() {
    if (intervalo !== null) {
        return;
    }

    intervalo = setInterval(() => {
        const p = document.getElementById("contador");
        p.textContent = contador;
        console.log(contador);
        contador++;
    }, 1000);
}

function stop() {
    clearInterval(intervalo);
    intervalo = null;
}

function reset() {
    stop();
    contador = 0;
    document.getElementById("contador").textContent = contador;
}

let inicio = document.getElementById("iniciar");
let parar = document.getElementById("parar");
let reiniciar = document.getElementById("reset");

inicio.addEventListener("click", comenzar);
parar.addEventListener("click", stop);
reiniciar.addEventListener("click", reset);
