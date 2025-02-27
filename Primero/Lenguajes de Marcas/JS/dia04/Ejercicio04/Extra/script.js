


document.write("<br>")
document.write("Ahora con DO - WHILE <br>")
let j = 1;
do {
    document.write(`Hola Mundo ${j} <br>`)
    j++;
}
while (j <= 5)


document.write("<br>")
document.write("Ahora con ForEach <br>")
let array = [1, 2, 3, 4, 5]
array.forEach(element => {
    document.write(`Hola Mundo ${element} <br>`)
});

