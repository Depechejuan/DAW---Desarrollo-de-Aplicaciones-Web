
document.write("Bucle hecho con el <b>WHILE</b> <br>")

let i = 0;
while(i <= 10) {
    document.write(`Que llegue ya <u>verano</u>, ¡por favor! <br>`);
    i++;
    if (i == 11) {
        document.write("¿Ha quedao claro?")
    }
}

document.write("<br>")
document.write("<br>")
document.write("Con bucle <b>FOR</b> <br>")

for (let i = 1; i <= 11; i++) {
    document.write(`Que llegue ya <u>verano</u>, ¡por favor! <br>`);
    if (i == 11) {
        document.write("¿Ha quedao claro?")
    }
}

