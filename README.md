# kodigo-yt

Refactorización de la suite `yt-*` a una sola puerta de entrada, `yt`, y registro del flujo de trabajo con skills y agentes que produjo esta entrega.

El problema real es la suite que ya uso para bajar audio, video, playlists y posts de X. El código original está en [`antes/`](antes/). El código refactorizado está en [`despues/`](despues/). El comportamiento de cada descarga no cambió: cambió la estructura, siguiendo el molde de `ravn-wt` (launcher, catálogo, módulos y menú).

## Flujo de skills

El trabajo se hizo en este orden. Cada skill está copiada en [`.agents/skills/`](.agents/skills/) para que se pueda leer el método, no solo el resultado.

1. **`ro-restate-goals`** (skill propia). Antes de tocar código se reformuló el pedido: la entrega tenía que ser una prueba real, con el antes y el después comparables, y no un ejemplo inventado. Se frenó hasta confirmar que el problema era la suite `yt-*` y el flujo de agentes, no un programa nuevo.
2. **`grill-me`**. Esta skill delega en `grilling`. Ahí se cerraron las decisiones: el repo es este, el ejecutable se llama `yt`, el menú es el de `ravn-wt` con otras opciones, las fichas van en español, y no se publica la biblioteca personal ni el script que la recorre.
3. **`to-spec`**. La conversación cerrada se sintetizó en [`docs/spec.md`](docs/spec.md). No hubo una segunda entrevista: el spec recoge lo ya decidido.
4. **`to-tickets`**. El spec se partió en cortes verticales en [`docs/tickets/`](docs/tickets/). Cada ticket dice qué se puede demostrar y qué lo bloquea.

## Agentes

El flujo de trabajo autónomo usa tres agentes. Las fichas cortas están en [`docs/agentes/`](docs/agentes/).

| Agente | Papel en este problema |
| --- | --- |
| PM | Única puerta de entrada. Corre `ro-restate-goals` y `grill-me`, publica el spec y los tickets, y no inventa una sesión que no ocurrió. |
| WK | Implementa un ticket sobre el código, conserva el comportamiento y deja el módulo ejecutable. |
| RV | Revisa que el comportamiento de `antes/` siga igual en `despues/` y que el menú sea el de `ravn-wt` adaptado. |

En esta entrega el PM documentó el flujo conmigo y dejó el árbol adaptado para que se pueda ejecutar. No se simula una sesión aparte del WK ni del RV.

## Skill de dominio

[`docs/skills/music-renamer-metadata.md`](docs/skills/music-renamer-metadata.md) es la skill propia que fijó la regla de nombres y de tags. `yt-audio-playlist` ya la cumple: `01 - Artista - Título.opus`, con etiquetas `album` y `tracknumber`. Esa regla se conserva en el refactor.

## Cómo comparar

| Antes | Después |
| --- | --- |
| Cinco ejecutables sueltos, cada uno con su interfaz | Un ejecutable, `despues/yt`, que despacha |
| Sin catálogo | `despues/runtime/commands.tsv` |
| Sin menú | El menú de `ravn-wt`, con las opciones de esta suite |
| `yt-audio`, `yt-video`, `yt-audio-playlist`, `yt-video-playlist`, `yt-x` | Los mismos cuerpos en `despues/runtime/scripts/`, más wrappers en `despues/bin/` |

Los cuerpos de `audio`, `video`, `audio-playlist`, `video-playlist` y `x` son los scripts de `antes/`. No se reescribió la descarga. `yt-common.sh` sigue al lado de los módulos que lo cargan.

## Cómo correrlo

```bash
./despues/yt              # menú, si hay terminal
./despues/yt help         # catálogo
./despues/yt audio --help # la ayuda del módulo original, si no recibe URL
./despues/bin/yt-audio    # el nombre viejo, misma puerta
```

Sin terminal, `yt` muestra el help. Una opción del menú pide la URL y corre el módulo real. `q` sale.

## Fuera de esta entrega

- El paquete de Arch.
- Mover los dotfiles instalados.
- La ruta de la biblioteca personal y el script que la recorre.
- Cookies guardadas en el repo. `x` sigue pudiendo leer las del navegador, como el script original.
