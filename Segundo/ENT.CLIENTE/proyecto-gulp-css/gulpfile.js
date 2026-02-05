const gulp = require('gulp');
const cleanCSS = require('gulp-clean-css');

gulp.task('minify-css', () => {
    return gulp.src('./*.css') // Origen: todos los CSS del directorio raíz
    .pipe(cleanCSS()) // Minificación
    .pipe(gulp.dest('dist')); // Destino: carpeta dist
    }
);