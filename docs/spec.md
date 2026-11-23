# Spec: una puerta `yt` para la suite existente

Sintetizado con la skill `to-spec` a partir del diseño ya cerrado. No agrega decisiones nuevas.

## Problem Statement

La suite de descarga ya funciona, pero cada formato es un ejecutable aparte, con su propia interfaz. No hay una puerta única ni un menú para elegir el modo. Quien revisa la entrega no puede ver, en un solo lugar, el código original, el código modularizado y el flujo de skills y agentes que llevó a esa modularización.

## Solution

Un ejecutable `yt` abre el mismo tipo de menú que `ravn-wt` y despacha a los scripts que ya existen. El catálogo declara los comandos. Los nombres viejos siguen funcionando como wrappers. El repositorio guarda el original, el refactor, las skills usadas y las fichas de los agentes.

## User Stories

1. Como estudiante, quiero un repositorio único, para que el catedrático compare sin salir de un solo proyecto.
2. Como catedrático, quiero el código original separado del refactorizado, para ver qué cambió de estructura y qué se conservó.
3. Como usuario de la suite, quiero escribir `yt` y ver un menú, para elegir audio, video, playlist o X sin recordar cinco comandos.
4. Como usuario, quiero que el menú se parezca al de `ravn-wt`, para reconocer la misma arquitectura.
5. Como usuario, quiero un banner con el nombre de la herramienta y el autor, para saber qué programa estoy usando.
6. Como usuario, quiero elegir un número, pegar una URL y que corra el módulo real, para no tener un menú de demostración.
7. Como usuario, quiero `q` para salir y `h` para la ayuda, para moverme como en `ravn-wt`.
8. Como usuario, quiero `yt audio <url>` sin abrir el menú, para usar la suite desde otro script.
9. Como usuario, quiero que `yt` sin terminal muestre el help, para poder redirigir la salida.
10. Como usuario, quiero que un comando desconocido falle, para no disparar una descarga por error.
11. Como usuario, quiero seguir llamando `yt-audio`, `yt-video`, `yt-audio-playlist`, `yt-video-playlist` y `yt-x`, para no romper el hábito.
12. Como usuario de playlists de audio, quiero archivos `01 - Artista - Título` con tags de álbum y pista, para que la regla de la skill de música siga vigente.
13. Como usuario de video, quiero el mismo tope de 1080p, los mismos subtítulos y el mismo destino que el script original.
14. Como usuario de X, quiero el mismo uso de cookies del navegador, sin que el repositorio guarde cookies.
15. Como catedrático, quiero leer las skills en `.agents/skills`, para ver el método y no solo el código.
16. Como catedrático, quiero ver el orden restate, grill, spec y tickets, para evaluar el uso consciente de la IA.
17. Como catedrático, quiero fichas cortas del PM, el WK y el RV, para entender el flujo autónomo sin leer un framework entero.
18. Como autor, quiero que el README esté en español, para entregar en el idioma del curso.

## Implementation Decisions

- El molde es el de `ravn-wt`: launcher, catálogo tabular, despacho a un módulo por comando, menú numerado, ayuda y salida.
- El menú lista audio, video, audio playlist, video playlist, X, ayuda y salida. Al elegir un número pide la URL y ejecuta ese módulo.
- Los cuerpos de los comandos son los scripts actuales. La descarga no se reescribe.
- El catálogo es la lista de comandos, alias, etiqueta, descripción e icono.
- Los wrappers conservan los nombres históricos y delegan en el launcher.
- La skill de música se documenta como ficha: regla de nombres y de tags. No se copia el script que recorre la biblioteca ni su ruta.
- `ro-restate-goals`, `grill-me`, `grilling`, `to-spec` y `to-tickets` se copian al repo para que el método sea legible.
- El banner sustituye el wordmark de `ravn-wt` por `YT` y mantiene la firma del autor, leída igual que en esa herramienta.
- Idioma de README, spec, tickets y fichas: español. El menú conserva el inglés de la interfaz que se adapta.

## Testing Decisions

Una buena prueba mira el comportamiento externo: ayuda, comando desconocido, nombre viejo y menú. No inspecciona funciones internas. No hace falta red para la puerta de entrada. La descarga real queda cubierta por el hecho de que el módulo ejecutado es el script original.

La prueba de esta entrega es correr el help, un comando inválido, un wrapper sin URL y el menú hasta salir.

## Out of Scope

- Empaquetar para Arch.
- Reemplazar los scripts instalados en la máquina.
- Publicar la biblioteca personal o el script que la organiza.
- Agregar formatos, calidades o destinos que los scripts no tengan hoy.
- Inventar una sesión de revisión que no haya ocurrido.

## Further Notes

La costura de prueba acordada es la puerta `yt`: menú en terminal, help sin terminal, comando directo y wrappers. El comportamiento detrás de esa puerta es el de los scripts originales.
