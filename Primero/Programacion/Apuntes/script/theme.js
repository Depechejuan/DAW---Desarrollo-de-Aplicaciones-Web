"use strict";

//--------------------------------------------------------------------------------------//
//                              OBTENER ELEMENTOS DEL DOM                               //
//--------------------------------------------------------------------------------------//

// Obtener el elemento con id="theme"
const themeButton = document.querySelector("#theme");

// Obtener el elemento con la etiqueta body
const body = document.body;

// Obtener todas las details con el atributo open
const detailsOpen = document.querySelectorAll("details[open]");

// Obtener todas las etiquetas summary
const summaries = document.querySelectorAll("summary");

// Obtener todos los elementos con la clase icon
const icons = document.querySelectorAll(".icon");

// Obtener todos los h1, h2, h3, h4, h5 y h6
const headings = document.querySelectorAll("h2, h3, h4, h5, h6");

// Obtener todos los strong
const strongs = document.querySelectorAll("strong");

// Recuperar el estado inicial del tema de localStorage y transfromarlo a booleano
const themeStorage = JSON.parse(localStorage.getItem("theme"));

// Definir si el estado inicial del tema es dark o no
let isDarkTheme = themeStorage ? themeStorage : false;

themeButton.textContent = isDarkTheme ? "🌙" : "🌞";

// Guardar el estado del tema en localStorage
localStorage.setItem("theme", isDarkTheme);

// Si isDarkTheme es true, agregar la clase dark al body
if (isDarkTheme) {
    body.classList.toggle("dark");

    // Si isDarkTheme es true, agregar la clase dark a todos los details[open]
    detailsOpen.forEach((detail) => {
        detail.classList.add("dark");
    });

    // Si isDarkTheme es true, agregar la clase dark a todos los elementos con la clase icon
    icons.forEach((icon) => {
        icon.classList.toggle("dark");
    });

    // Si isDarkTheme es true, agregar la clase dark a todos los h1, h2, h3, h4, h5 y h6
    headings.forEach((heading) => {
        heading.classList.toggle("dark");
    });

    // Si isDarkTheme es true, agregar la clase dark a todos los strong
    strongs.forEach((strong) => {
        strong.classList.toggle("dark");
    });
}

// Agregar el evento click a todos los elementos summary
summaries.forEach((summary) => {
    summary.addEventListener("click", () => {
        const detail = summary.parentElement;
        if (isDarkTheme) {
            detail.classList.add("dark");
        } else {
            detail.classList.toggle("dark");
        }
    });
});

// Al hacer click en el botón
themeButton.addEventListener("click", () => {
    // Agregar o quitar la clase dark del body, los details[open], los icon, los h2, h3, h4, h5 y h6 y los strong
    body.classList.toggle("dark");
    detailsOpen.forEach((detail) => {
        detail.classList.toggle("dark");
    });
    icons.forEach((icon) => {
        icon.classList.toggle("dark");
    });

    headings.forEach((heading) => {
        heading.classList.toggle("dark");
    });

    strongs.forEach((strong) => {
        strong.classList.toggle("dark");
    });

    // Cambiar el valor de isDarkTheme
    isDarkTheme = !isDarkTheme;

    // Cambiar el texto del botón
    themeButton.textContent = isDarkTheme ? "🌙" : "🌞";

    // Guardar el estado del tema en localStorage
    localStorage.setItem("theme", isDarkTheme);

    //
});
