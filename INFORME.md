<h3 align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset=".github/Assets/kodigo_logo_dark.png">
    <source media="(prefers-color-scheme: light)" srcset=".github/Assets/kodigo_logo.png">
    <img src=".github/Assets/kodigo_logo.png" width="220" alt="Kodigo"/>
  </picture><br/>
  <img src=".github/Assets/transparent.png" height="30" width="0px"/>
  AI For Devs Jr. 5
  <img src=".github/Assets/transparent.png" height="30" width="0px"/>
</h3>

<p align="center">
  <img src=".github/Assets/macchiato.png" width="400" alt="Divider"/>
</p>

<p align="center">
  <strong>ACTIVIDAD</strong><br/>
  Refactorización y personalización de un sistema agéntico mediante skills propias
</p>

<p align="center">
  <strong>INSTRUCTOR</strong><br/>
  Ing. Ronald Mejía
</p>

<p align="center">
  <strong>ESTUDIANTE</strong><br/>
  Roberto Carlos Flores Quintanilla
</p>

<p align="center">
  <strong>REPOSITORIO</strong><br/>
  <a href="https://github.com/robert-flo/kodigo-yt">github.com/robert-flo/kodigo-yt</a>
</p>

<p align="center">
  <strong>FECHA DEL INFORME</strong><br/>
  22 de noviembre de 2026
</p>

<p align="center">
  <em>Formamos talento tech en El Salvador y Latinoamérica</em>
</p>

&nbsp;

## 1. Resumen, enlaces y decisiones

El presente informe documenta la refactorización de una suite real de descarga (`yt-audio`, `yt-video`, `yt-audio-playlist`, `yt-video-playlist` y `yt-x`) hacia una sola puerta de entrada, el ejecutable `yt`. El comportamiento de cada descarga se conserva. Lo que cambia es la estructura: un launcher, un catálogo y un menú, con el mismo molde que `ravn-wt`. El método de trabajo queda registrado en skills y en tres agentes (PM, WK y RV).

La prueba de la puerta no necesita red ni una descarga real. Quien clona el repositorio puede ejecutar el menú, la ayuda y un comando inválido en menos de un minuto.

| Recurso | Qué contiene | Enlace |
| --- | --- | --- |
| Repositorio | Código original, código refactorizado, skills, spec, tickets y este informe | https://github.com/robert-flo/kodigo-yt |
| Informe | Este documento | [INFORME.md](INFORME.md) |
| Código original | Los seis archivos de la suite, sin modificar | [antes/](antes/) |
| Código refactorizado | Launcher `yt`, catálogo, módulos y wrappers | [despues/](despues/) |
| Skills usadas | `ro-restate-goals`, `grill-me`, `grilling`, `to-spec`, `to-tickets` | [.agents/skills/](.agents/skills/) |
| Spec y tickets | Decisiones cerradas y cortes de la refactorización | [docs/spec.md](docs/spec.md), [docs/tickets/](docs/tickets/) |

### Decisiones tomadas por el estudiante

- **Qué se refactoriza.** No se reescribe la descarga. Se separa la puerta (menú, catálogo y despacho) del cuerpo de cada comando. Los archivos de `despues/runtime/scripts/` son byte a byte los de `antes/`.
- **Qué menú.** El menú no es un diseño nuevo. Es el de `ravn-wt` (banner, números, `h`, `q` y `Selection`) con las opciones de esta suite.
- **Qué skills se documentan.** No se inventan skills de audio o de video. Se documentan las que sí se usaron: `ro-restate-goals`, `grill-me`, `to-spec` y `to-tickets`, más la skill de dominio `music-renamer-metadata`, que fijó el nombre `01 - Artista - Título` de la playlist de audio.
- **Qué queda fuera.** El paquete Arch, el reemplazo de los dotfiles de la máquina, la ruta de la biblioteca personal y cualquier archivo de cookies.

### Apoyo de la IA y control del estudiante

| Decisión | Lo que propuso la IA | Lo que quedó bajo control del estudiante |
| --- | --- | --- |
| Skills del informe | Documentar skills nuevas, una por comando de descarga. | Esas skills no existen. El informe documenta `ro-restate-goals`, `grill-me`, `to-spec`, `to-tickets` y los agentes PM, WK y RV. |
| Menú | Un menú distinto, sin el banner de `ravn-wt`. | El menú de la captura de `ravn-wt`, adaptado. Sin ese menú la entrega no muestra nada nuevo. |
| Nombre del repositorio | `robert-flo/yt`, como si ya fuera el paquete definitivo. | `robert-flo/kodigo-yt`, el repo de esta entrega. |
| Alcance del cambio | Preguntar de nuevo un flujo que ya estaba en el código. | Replicar `ravn-wt` y mover los scripts. No inventar otra arquitectura. |

## 2. Cómo descargar y probar

Requisitos para la prueba de la puerta: `git` y `bash`. No hace falta Python, red ni `yt-dlp`.

Una descarga real, además, necesita `yt-dlp` y `ffmpeg`. El archivo queda en `/zt/yt-downloads/` si ese directorio existe, y si no en `~/yt-downloads/`. Esta prueba es opcional.

### 2.1. Clonar

```bash
git clone https://github.com/robert-flo/kodigo-yt.git
cd kodigo-yt
```

### 2.2. Probar la puerta, sin descargar nada

```bash
./despues/yt help
./despues/yt no-existe
./despues/yt audio
./despues/bin/yt-audio
cmp antes/yt-audio despues/runtime/scripts/audio && echo "audio identico"
```

Resultado esperado:

- `yt help` lista `audio`, `video`, `audio-playlist`, `video-playlist`, `x` y `help`.
- `yt no-existe` termina con error (`exit 1`) y el texto `Unknown command: no-existe`.
- `yt audio` y `bin/yt-audio` muestran la misma ayuda del módulo original y no descargan.
- `cmp` confirma que el cuerpo del comando no cambió. Lo mismo vale para `video`, `audio-playlist`, `video-playlist` y `x`.

### 2.3. Probar el menú

En una terminal:

```bash
./despues/yt
```

Aparece el banner `YT`, la línea `Choose an action` y estas opciones. `q` cierra. `h` muestra la ayuda.

| Tecla | Opción | Qué hace al confirmar una URL |
| --- | --- | --- |
| `1` | Download audio | Corre el módulo de audio. |
| `2` | Download video | Corre el módulo de video. |
| `3` | Download audio playlist | Corre el módulo de playlist de audio. |
| `4` | Download video playlist | Corre el módulo de playlist de video. |
| `5` | Download X video | Corre el módulo de X. |
| `h` | Help and usage | Muestra el catálogo. No pide URL. |
| `q` | Exit | Sale con `Goodbye!`. |

Si la salida no es una terminal (por ejemplo `./despues/yt | cat`), no abre el menú: muestra el help.

### 2.4. Usar un comando sin pasar por el menú

```bash
./despues/yt audio "https://youtu.be/HWsOivtPz-o"
./despues/yt video "https://youtu.be/Shqtk_2Jd3c"
```

Esas dos direcciones son las de los ejemplos de `antes/yt-audio` y `antes/yt-video`. Hoy resuelven: el audio es «superstar» de Sharou (`HWsOivtPz-o`) y el video es «How to set up Herdr for multi-agent coding» (`Shqtk_2Jd3c`). Una playlist sigue pidiendo una URL de playlist real; los scripts originales no traen un `list=` concreto.

Los nombres anteriores siguen funcionando:

```bash
./despues/bin/yt-audio
./despues/bin/yt-video
./despues/bin/yt-audio-playlist
./despues/bin/yt-video-playlist
./despues/bin/yt-x
```

## 3. La refactorización

### 3.1. Qué estaba acoplado

Cada formato era un ejecutable aparte (`yt-audio`, `yt-video`, `yt-audio-playlist`, `yt-video-playlist`, `yt-x`). Cada uno repetía su propia interfaz. No había catálogo, ni menú, ni un solo comando para elegir el modo. `yt-video` y `yt-video-playlist` compartían helpers en `yt-common.sh`, pero la puerta de entrada seguía partida en cinco programas.

### 3.2. Qué quedó separado

| Pieza | Dónde está | Responsabilidad |
| --- | --- | --- |
| Launcher | `despues/yt` | Banner, menú, ayuda sin terminal y despacho del comando |
| Catálogo | `despues/runtime/commands.tsv` | Nombre, alias, etiqueta, descripción e icono de cada opción |
| Despacho | `despues/runtime/lib/dispatch.sh` | Resuelve el nombre y ejecuta el módulo |
| Presentación | `despues/runtime/lib/presentation.sh` | Colores, sección y errores del menú |
| Módulos | `despues/runtime/scripts/` | La descarga, igual que en `antes/` |
| Nombres viejos | `despues/bin/` | Llaman a `yt <comando>` |

El menú lee el catálogo. No tiene las cinco opciones escritas a mano en el launcher.

### 3.3. Qué no se movió, a propósito

Destino, tope de 1080p, idioma de subtítulos y cookies del navegador siguen dentro de cada módulo. Sacarlos habría cambiado el comportamiento. La regla de la playlist de audio también se conserva: `01 - Artista - Título.opus`, con etiquetas `album` y `tracknumber`. Esa regla viene de la skill `music-renamer-metadata`, documentada en [docs/skills/music-renamer-metadata.md](docs/skills/music-renamer-metadata.md).

### 3.4. Opciones de cada módulo

| Comando | Menú | Qué descarga | Opciones propias | Destino por defecto |
| --- | --- | --- | --- | --- |
| `audio` | `1` | Un audio en Opus, sin playlist | Las de `yt-dlp` | `/zt/yt-downloads/audio/<uploader>/` o `~/yt-downloads/audio/` |
| `video` | `2` | Un video de hasta 1080p, con subtítulos | `-f` explícito salta el menú de calidades | `/zt/yt-downloads/video/` o `~/yt-downloads/video/` |
| `audio-playlist` | `3` | Playlist en Opus, `01 - Artista - Título` | `--list`, `--no-archive` | `/zt/yt-downloads/audio-playlist/<Playlist>/` o `~/yt-downloads/audio-playlist/` |
| `video-playlist` | `4` | Playlist en MP4, `001 - Título [id]` | `--list`, `--no-archive`, `--standard`, `--premium`, `--720p`, `--no-subs` | `/zt/yt-downloads/video-playlist/<Playlist>/` o `~/yt-downloads/video-playlist/` |
| `x` | `5` | Videos de un post de X | `--no-cookies` | `/zt/yt-downloads/x/` o `~/yt-downloads/x/` |

`x` lee cookies de Chrome solo en el momento de la descarga. El repositorio no guarda cookies.

## 4. Corrección del criterio frente a la IA

La IA propuso tres atajos que habrían dejado una entrega distinta a la suite real.

1. **Skills que no existían.** La primera propuesta fue escribir skills nuevas (`audio`, `video`, `playlist`, `x`) para que el informe tuviera «skills propias». Esas skills no forman parte del flujo que se usó. El flujo real fue `ro-restate-goals`, después `grill-me`, después `to-spec` y después `to-tickets`. La skill de dominio que sí explicó el nombre de la playlist es `music-renamer-metadata`.
2. **Un menú inventado.** La IA ofreció un menú sin el banner de `ravn-wt`, con el argumento de que el help alcanzaba. La corrección fue explícita: el menú interactivo es la parte nueva de la entrega, y ya estaba resuelto en el código de `ravn-wt`. Había que adaptarlo, no diseñar otro.
3. **Un repositorio con nombre de producto.** La IA nombró el repo `robert-flo/yt`. El nombre de la entrega es `kodigo-yt`. El ejecutable, dentro, sí se llama `yt`.

Esas tres correcciones están cerradas en [docs/spec.md](docs/spec.md).

## 5. Evidencia

Corrido el 22 de noviembre de 2026 en la copia local del repositorio, sin red.

```text
$ ./despues/yt help
  audio            Download one audio track as Opus.
  video            Download one video up to 1080p.
  audio-playlist   Download a playlist as numbered Opus tracks.
  video-playlist   Download a playlist as numbered MP4 files.
  x                Download a video from X using browser cookies.
  help             Show this guide.

$ ./despues/yt no-existe
  [ERROR] Unknown command: no-existe
  exit: 1

$ cmp antes/yt-audio despues/runtime/scripts/audio && echo audio identico
  audio identico
$ cmp antes/yt-video despues/runtime/scripts/video && echo video identico
  video identico
$ cmp antes/yt-audio-playlist despues/runtime/scripts/audio-playlist && echo playlist identica
  playlist identica
$ cmp antes/yt-video-playlist despues/runtime/scripts/video-playlist && echo video-playlist identica
  video-playlist identica
$ cmp antes/yt-x despues/runtime/scripts/x && echo x identico
  x identico
```

Menú en una terminal, cerrado con `q`:

```text
  │     Audio, video and playlists via yt-dlp          │
  │     by Roberto Flores @robert-flo                  │

  Choose an action
  1  Download audio
  2  Download video
  3  Download audio playlist
  4  Download video playlist
  5  Download X video
  h  Help and usage
  q  Exit

  Selection: q
  [INFO] Goodbye!
```

`./despues/yt audio` sin URL muestra la ayuda original (`yt-audio — Descarga audio individual en Opus`) y termina sin descargar. `./despues/bin/yt-audio` produce el mismo texto.
