console.log("Ejercicio extra con Switch/Case");

let num = prompt("Di un número del 1 al 10: ");

if(typeof num == "string") {
    console.log("WTF")

} else {
    switch (true) {
        case (num > 10 || num < 1):
            document.write("Te he dicho uno del 1 al 10... <br> ¿No te enteras o qué?");
            break;
        case (num === 5):
            document.write("Por el cu** te la hinco<br>JAJAJAJAJA");
            break;
        default:
            document.write("Te has librado...");
    }
}

