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
  Domingo, 29 de noviembre de 2026 — 23:59
</p>

&nbsp;

## Descripción

El presente repositorio documenta la refactorización de la suite de descarga `yt-*` hacia una única puerta de entrada, el ejecutable `yt`, y el flujo de skills y agentes con el que se realizó el trabajo.

El código original se conserva en [`antes/`](antes/). El código refactorizado se encuentra en [`despues/`](despues/). El comportamiento de cada descarga se mantiene. El cambio es de estructura y sigue el molde de `ravn-wt`: launcher, catálogo de comandos, módulos y menú.

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

## Ejecución

```bash
./despues/yt              # menú, si hay terminal
./despues/yt help         # catálogo
./despues/yt audio --help # ayuda del módulo original, si no recibe URL
./despues/bin/yt-audio    # nombre anterior, misma puerta
```

Sin terminal, `yt` muestra la ayuda. Una opción del menú solicita la URL y ejecuta el módulo real. `q` cierra el menú.

## Fuera de alcance

- El paquete de Arch.
- El reemplazo de los dotfiles instalados en la máquina.
- La ruta de la biblioteca personal y el script que la recorre.
- Cookies almacenadas en el repositorio. El comando `x` puede leer las del navegador, como el script original.
