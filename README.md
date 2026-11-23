<h3 align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset=".github/Assets/kodigo_logo_dark.png">
    <source media="(prefers-color-scheme: light)" srcset=".github/Assets/kodigo_logo.png">
    <img src=".github/Assets/kodigo_logo.png" width="220" alt="Kodigo"/>
  </picture><br/>
  <img src=".github/Assets/transparent.png" height="30" width="0px"/>
  AI For Devs Jr. 5 — Grupo 12
  <img src=".github/Assets/transparent.png" height="30" width="0px"/>
</h3>

<h6 align="center">
  <a href="https://github.com/kodigo-grupo-12/monorepo">Monorepo</a>
  ·
  <a href="https://github.com/kodigo-grupo-12/documentacion">Documentación</a>
</h6>

<p align="center">
  <img src=".github/Assets/macchiato.png" width="400" alt="Divider"/>
</p>

&nbsp;

<p align="center">
  Refactorización y personalización de un sistema agéntico mediante skills propias.<br/>
  Entregable del <strong>Grupo 12</strong> para el programa <strong>AI For Devs Jr. 5</strong> de <strong>Kodigo</strong>.<br/>
  <em>Formamos talento tech en El Salvador y Latinoamérica</em>
</p>

<p align="center">
  <strong>INSTRUCTOR</strong><br/>
  Ing. Ronald Mejía
</p>

<p align="center">
  <strong>INTEGRANTES</strong><br/>
  Roberto Carlos Flores Quintanilla
</p>

<p align="center">
  <strong>FECHA DE ENTREGA</strong><br/>
  Domingo, 22 de noviembre de 2026
</p>

&nbsp;

## Descripción

El presente repositorio documenta la refactorización de la suite de descarga `yt-*` hacia una única puerta de entrada, el ejecutable `yt`, y el flujo de skills y agentes con el que se realizó el trabajo.

El informe completo, con el mismo orden que la Tarea 03 (decisiones, corrección frente a la IA y evidencia de consola), está en [INFORME.md](INFORME.md).

El código original se conserva en [`antes/`](antes/). El código refactorizado se encuentra en [`despues/`](despues/). El comportamiento de cada descarga se mantiene. El cambio es de estructura y sigue el molde de `ravn-wt`: launcher, catálogo de comandos, módulos y menú.

## Cómo descargarlo y probarlo

Hace falta `git` y `bash`. Esta prueba no descarga nada y no necesita red ni `yt-dlp`.

```bash
git clone https://github.com/robert-flo/kodigo-yt.git
cd kodigo-yt
./despues/yt help
./despues/yt no-existe
./despues/yt audio
cmp antes/yt-audio despues/runtime/scripts/audio && echo "audio identico"
```

Resultado esperado: el help lista los seis comandos, `no-existe` termina con error, `yt audio` muestra la ayuda del módulo y no baja ningún archivo, y `cmp` imprime `audio identico`.

El menú, en una terminal:

```bash
./despues/yt
```

`q` sale. `h` muestra la ayuda. Sin terminal, `yt` muestra el help en lugar del menú.

Una descarga real es opcional. Requiere `yt-dlp` y `ffmpeg`, y escribe en `/zt/yt-downloads/` o, si esa ruta no existe, en `~/yt-downloads/`.

```bash
./despues/yt audio "https://youtu.be/VIDEO"
./despues/yt audio-playlist --list "https://www.youtube.com/playlist?list=LIST"
```

`--list` solo inspecciona la playlist.

## Opciones

| Tecla | Comando | Qué hace | Opciones propias |
| --- | --- | --- | --- |
| `1` | `yt audio` | Un audio en Opus | Las de `yt-dlp` |
| `2` | `yt video` | Un video de hasta 1080p | `-f` salta el menú de calidades |
| `3` | `yt audio-playlist` | Playlist en Opus, `01 - Artista - Título` | `--list`, `--no-archive` |
| `4` | `yt video-playlist` | Playlist en MP4, `001 - Título [id]` | `--list`, `--no-archive`, `--standard`, `--premium`, `--720p`, `--no-subs` |
| `5` | `yt x` | Videos de un post de X | `--no-cookies` |
| `h` | `yt help` | Catálogo | — |
| `q` | — | Sale del menú | — |

Los nombres anteriores siguen en `despues/bin/`: `yt-audio`, `yt-video`, `yt-audio-playlist`, `yt-video-playlist` y `yt-x`. Cada uno llama a `yt` con el mismo comando.

## Refactorización

Antes, cada formato era un ejecutable con su propia interfaz. Ahora la puerta está separada del cuerpo:

| Pieza | Ruta | Responsabilidad |
| --- | --- | --- |
| Launcher y menú | `despues/yt` | Banner, opciones, despacho |
| Catálogo | `despues/runtime/commands.tsv` | Nombre, alias, etiqueta e icono |
| Módulos | `despues/runtime/scripts/` | La descarga, igual que en `antes/` |
| Nombres viejos | `despues/bin/` | Delegan en `yt` |

Los cuerpos son los mismos archivos. `cmp` entre `antes/yt-audio` y `despues/runtime/scripts/audio` (y el equivalente de los otros cuatro) no muestra diferencia. Destino, tope de 1080p y subtítulos se quedaron dentro de cada módulo para no cambiar el comportamiento. El detalle y la evidencia de consola están en [INFORME.md](INFORME.md).

## Flujo de skills

El trabajo se desarrolló en el orden siguiente. Cada skill está copiada en [`.agents/skills/`](.agents/skills/) para que pueda leerse el método, además del resultado.

1. **`ro-restate-goals`** (skill propia). Antes de modificar el código se reformuló el pedido: la entrega debía ser una prueba real, con el antes y el después comparables, y no un ejemplo inventado. El trabajo se detuvo hasta confirmar que el problema era la suite `yt-*` y el flujo de agentes.
2. **`grill-me`**. Esta skill delega en `grilling`. En esa entrevista se cerraron las decisiones: el repositorio es este, el ejecutable se llama `yt`, el menú es el de `ravn-wt` con las opciones de la suite, las fichas van en español, y no se publica la biblioteca personal ni el script que la recorre.
3. **`to-spec`**. La conversación cerrada se sintetizó en [`docs/spec.md`](docs/spec.md).
4. **`to-tickets`**. El spec se dividió en cortes verticales en [`docs/tickets/`](docs/tickets/). Cada ticket indica qué puede demostrarse y qué lo bloquea.

## Agentes

El flujo de trabajo autónomo utiliza tres agentes. Las fichas se encuentran en [`docs/agentes/`](docs/agentes/).

| Agente | Papel en este problema |
| --- | --- |
| PM | Única puerta de entrada. Ejecuta `ro-restate-goals` y `grill-me`, publica el spec y los tickets. |
| WK | Implementa un ticket sobre el código, conserva el comportamiento y deja el módulo ejecutable. |
| RV | Revisa que el comportamiento de `antes/` se conserve en `despues/` y que el menú corresponda al de `ravn-wt` adaptado. |

En esta entrega el PM documentó el flujo y dejó el árbol adaptado para su ejecución. No se simula una sesión distinta del WK ni del RV.

## Skill de dominio

[`docs/skills/music-renamer-metadata.md`](docs/skills/music-renamer-metadata.md) es la skill propia que fijó la regla de nombres y de etiquetas. `yt-audio-playlist` ya la cumple: `01 - Artista - Título.opus`, con las etiquetas `album` y `tracknumber`. Esa regla se conserva en el refactor.

## Comparación

| Antes | Después |
| --- | --- |
| Cinco ejecutables sueltos, cada uno con su interfaz | Un ejecutable, `despues/yt`, que despacha |
| Sin catálogo | `despues/runtime/commands.tsv` |
| Sin menú | El menú de `ravn-wt`, con las opciones de esta suite |
| `yt-audio`, `yt-video`, `yt-audio-playlist`, `yt-video-playlist`, `yt-x` | Los mismos cuerpos en `despues/runtime/scripts/`, más wrappers en `despues/bin/` |

Los cuerpos de `audio`, `video`, `audio-playlist`, `video-playlist` y `x` son los scripts de `antes/`. La descarga no se reescribió. `yt-common.sh` permanece junto a los módulos que lo cargan.

## Fuera de alcance

- El paquete de Arch.
- El reemplazo de los dotfiles instalados en la máquina.
- La ruta de la biblioteca personal y el script que la recorre.
- Cookies almacenadas en el repositorio. El comando `x` puede leer las del navegador, como el script original.
