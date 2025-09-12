DESARROLLO WEB EN ENTORNO CLIENTE


1. Estructura:
Cliente-Servidor

Lógica de servidor (back-end). Implementada la lógica de negocio de la aplicación, así como el almacenamiento de información de manera permanente en base de datos u otras tecnologías. Sus principales tareas son:
- Recibir datos de un usuario
- Realizar un procesamiento con dichos datos
- Guardar los datos en una BBDD
- Recuperar información del sistema de almacenamiento (Para devolver la info al cliente)

Lógicade Cliente: Interactua con el usuario para obtene ry mostrar información de la app.
Tareas:
- Comunicarse con la lógica de servidor para envío-recepción de datos
- Mostrar datos al usuario mediante la interfaz web
- Obtener datos de usuario a tra´ves de controles de la interfaz web.


1.2 Tipos de palicaciones web:
- Página web: Archivo con extensión .html con código HTML, CSS y/o JS
    - Estática: No generada por lógica de servidor 
    - Dinámicas: Generada a partir de la lógica del servidor

Terminología:
    - Distinción deweb estáticas y dinámicas - realizado desde el putno de vista de cómo se generan desde el servidor
    - Se habla también desde el punto de vista del fornt-end
        - Si se define como dinamica, incluye algún tipo de funcionalidad implementada con JavaSCript, mientras que una estática dependerá sólo de un HTML

Sitio Web:
    - Conjunto de webs alojadas en un server. Pueden ser estáticas o dinámicas. Nos proporcionan algún tipo de información.
    - No ofrece la funcionalidad de una app
App Web:
    - Ofrece características propias de un programa a diferencia de un sitio web.
    - Tiene funciones definidas (no sólo informativas) permitiendo acciones más complejas que un sitio web.


App Webs:
    - Múltiples páginas
        - Cada acceso a una sección necesita cargar una web completamente 
        - Cualquier actualización en tu web, provoca el envío completo de la página web actualizada
    - SPA (Single Page Application)
        - Se descarga una única vez, los datos nuevos se actualizan de lo descargado (Es decir, se "sustituye" el módulo viejo por el nuevo, sin afectar al resto)


