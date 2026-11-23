# music-renamer-metadata

Skill propia de la biblioteca musical. Fijó el contrato que la suite de audio tenía que respetar al descargar.

## Qué decide

- Una colección suelta se nombra `Artista - Título`, sin número de pista.
- Un álbum o una discografía se nombra `01 - Artista - Título`, con el número a dos dígitos.
- Los tags se escriben sin recodificar el audio.
- El artista del tag es el intérprete, no el nombre del canal de donde salió el archivo.
- Un archivo sin tags igual recibe artista y título.

## Qué no entra en esta entrega

La ruta de la biblioteca y el script que la recorre. No hacen falta para ver la regla.

## Dónde se ve en el código

`yt-audio-playlist` guarda `01 - Artista - Título.opus` y escribe las etiquetas `album` y `tracknumber`. El refactor no cambia ese módulo: lo despacha desde `yt`.
