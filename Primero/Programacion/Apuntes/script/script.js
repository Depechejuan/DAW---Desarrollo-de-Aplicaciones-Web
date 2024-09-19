/* guardar en un array en localeStorage los details por su id y el estado de su atributo open
cada vez que el atributo open cambie actualizar el array en localeStorage
al recargar la página, si el estado es true, abrir el detail, si es false, cerrarlo */
const detailsDom = document.querySelectorAll("details");
const detailsArray = [];

// Comprobar si hay un array en localeStorage
if (localStorage.getItem("detailsDom") !== null) {
    // Recuperar el array del localeStorage
    const detailsArrayLocaleStorage = JSON.parse(
        localStorage.getItem("detailsDom")
    );
    // Actualizar el estado de open de cada detail
    detailsDom.forEach((detail) => {
        detailsArrayLocaleStorage.forEach((detailArray) => {
            if (detail.id === detailArray.id) {
                detail.open = detailArray.open;
            }
        });
    });
}

// Para cada detail, guardar en el array su id y su estado de open
detailsDom.forEach((detail) => {
    detailsArray.push({ id: detail.id, open: detail.open });
});

// Guardar el array en localeStorage
localStorage.setItem("detailsDom", JSON.stringify(detailsArray));

// Al cambiar el estado de open de un detail, actualizar el array en localeStorage
detailsDom.forEach((detail) => {
    detail.addEventListener("toggle", () => {
        detailsArray.forEach((detailArray) => {
            if (detail.id === detailArray.id) {
                detailArray.open = detail.open;
            }
        });
        localStorage.setItem("detailsDom", JSON.stringify(detailsArray));
    });
});
