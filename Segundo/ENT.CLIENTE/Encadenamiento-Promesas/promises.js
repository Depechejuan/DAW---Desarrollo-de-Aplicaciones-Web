function promise(tiempo) {
    return new Promise((resolver, rechazar) => {
        if (typeof tiempo !== "number" || !Number.isFinite(tiempo) || tiempo < 0) {
            rechazar(new Error("Tiempo inválido"));
            return;
        }
        setTimeout(() => {
        resolver(console.log(`Temporizador de ${tiempo} ms terminado`));
        }, tiempo);
    });
}



promise(10000).then(() => {
    console.log(":)");
}).catch(err => console.error(err)).finally(console.log("All Done"))

promise(5000).then(promise(3000)).catch(err => console.error(err)).finally(console.log("All Done"))
