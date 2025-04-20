document.addEventListener("DOMContentLoaded", () => {
    fetch('../discography.json')
        .then(response => response.json())
        .then(data => renderDiscography(data))
        .catch(error => console.error('Error cargando el JSON:', error));
});

function renderDiscography(albums) {
    const container = document.getElementById('discography-container');

    albums.forEach(album => {
        const section = document.createElement('section');
        section.id = album.Year; // Añadir ID basado en el año para el índice

        // Botón "Arriba" entre discos
        const topButton = document.createElement('a');
        topButton.href = '#index';
        topButton.className = 'nav-button btn-top';
        topButton.textContent = 'Volver Arriba';
        container.appendChild(topButton);

        // Año de lanzamiento
        const yearElement = document.createElement('h3');
        yearElement.textContent = album.Year;
        section.appendChild(yearElement);

        // Título del álbum
        const albumTitle = document.createElement('h2');
        albumTitle.textContent = album.Album;
        section.appendChild(albumTitle);

        // Imagen de portada del álbum
        if (album.AlbumCover) {
            const coverImg = document.createElement('img');
            coverImg.src = album.AlbumCover;
            coverImg.alt = `Cover of ${album.Album}`;
            coverImg.classList.add('album-cover');
            section.appendChild(coverImg);
        }

        // Modificamos la parte del tracklist en discography.js
        const tracklistTitle = document.createElement('h3');
        tracklistTitle.textContent = album.CD2 ? 'Tracklist CD1:' : 'Tracklist:';
        section.appendChild(tracklistTitle);

        const tracklist = document.createElement('ul');
        album.Tracklist.forEach((track, index) => {
            const li = document.createElement('li');
            const trackNumber = (index + 1).toString().padStart(2, '0');
            li.textContent = `${trackNumber}. ${track}`;
            tracklist.appendChild(li);
        });
        section.appendChild(tracklist);

        // CD2 si existe
        if (album.CD2) {
            const tracklistTitleCD2 = document.createElement('h3');
            tracklistTitleCD2.textContent = 'Tracklist CD2:';
            tracklistTitleCD2.style.marginTop = '15px'; // Espacio adicional
            section.appendChild(tracklistTitleCD2);

            const tracklistCD2 = document.createElement('ul');
            album.CD2.forEach((track, index) => {
                const li = document.createElement('li');
                const trackNumber = (index + 1).toString().padStart(2, '0');
                li.textContent = `${trackNumber}. ${track}`;
                tracklistCD2.appendChild(li);
            });
            section.appendChild(tracklistCD2);
        }


        // Singles
        const singlesTitle = document.createElement('h3');
        singlesTitle.textContent = 'Singles:';
        singlesTitle.style.marginTop = '20px';
        section.appendChild(singlesTitle);

        const singlesList = document.createElement('ul');
        singlesList.classList.add('singles-list');
        
        album.Singles.forEach(single => {
            const li = document.createElement('li');
            li.classList.add('single-item');

            // Título de la canción
            const songTitle = document.createElement('p');
            songTitle.textContent = single.Song;
            li.appendChild(songTitle);

            // Contenido del single (imagen o mensaje)
            if (single.Link && single.src) {
                const link = document.createElement('a');
                link.href = single.Link;
                link.target = '_blank';
                link.classList.add('single-link');

                const img = document.createElement('img');
                img.src = single.src;
                img.alt = `${single.Song} Video`;
                img.classList.add('single-img');

                link.appendChild(img);
                li.appendChild(link);
            } else {
                const noVideo = document.createElement('p');
                noVideo.textContent = 'Sin vídeo';
                noVideo.classList.add('no-video');
                li.appendChild(noVideo);
            }

            singlesList.appendChild(li);
        });

        section.appendChild(singlesList);
        container.appendChild(section);
    });
}