# Revisión de Claude

Este documento registra los hallazgos de Claude durante el plan de cierre vigente (`PROJECT_LOG.md`, 2026-09-08). Es de solo lectura para Codex: Claude lo actualiza al terminar cada tarea propia.

## T2 — Auditoría de citas, referencias, enlaces y descargables (2026-09-08)

**Método:** lectura completa de los 16 capítulos, `index.qmd`, el apéndice, `_quarto.yml`, `README.md` (raíz), `plantillas/README.md`, `datos/README.md` y las siete plantillas de `plantillas/*.md`; `grep` dirigido para citas (`(AAAA)`, `et al.`), cross-references (`@sec-`/`{#sec-}`), enlaces relativos (`](...)`) y números de capítulo fijos; `git remote -v` para validar `_quarto.yml`; `WebFetch` sobre los cinco enlaces externos del libro. No modifiqué ningún archivo en esta tarea.

### Resumen

Sin hallazgos bloqueantes. Todas las citas tienen referencia, todas las referencias tienen cita, todos los `@sec-` resuelven y todos los enlaces a descargables apuntan a archivos que existen con el nombre exacto. Hay una inconsistencia de configuración (`_quarto.yml`) y un archivo desactualizado (`README.md` raíz) que quedan fuera de lo que puedo editar en T4; los anoto para quien corresponda. También encontré una laguna menor de consistencia editorial (falta un id de sección en el capítulo 04) que sí voy a corregir en T4 por estar dentro de mi alcance.

### Hallazgos

1. **`_quarto.yml` líneas 17-18 — `repo-url`/`site-url` no coinciden con el remoto real.**
   `repo-url: "https://github.com/toninif/libro_practicas"` y `site-url: "https://toninif.github.io/libro_practicas/"`, pero `git remote -v` muestra `https://github.com/toninif/libro_taller_PI.git`. Ambos campos ya tienen comentario `# ajustar` (pendiente conocido desde la auditoría inicial), pero lo confirmo con evidencia concreta: si se publica sin corregir, el ícono de "código fuente" del sitio y las URL canónicas apuntarán a un repositorio inexistente. No lo edito porque `_quarto.yml` es de T6 (Codex + aprobación de Fernando). **Corrección sugerida:** cambiar `libro_practicas` por `libro_taller_PI` en ambos campos, o renombrar el repo si `libro_practicas` es el nombre final deseado.

2. **`README.md` (raíz) desactualizado — fuera del alcance de T4.**
   Línea 33 dice "`01–16 .qmd` — capítulos (stubs con TODO por ahora)"; los 16 capítulos ya están completos, no son *stubs*. Tampoco menciona `plan-de-analisis.md`, `arbol-de-decision.md` ni `frases-de-reporte-apa.md` en la lista de `plantillas/`. Este archivo es la raíz del repo, no `plantillas/README.md`, así que no entra en mi lista de T4 (`index.qmd`, capítulos 01–04 y 16, `plantillas/*.md`, `plantillas/diccionario-de-datos.csv`). Nadie lo tiene asignado en el plan de cierre vigente. Lo dejo anotado para que Codex o Fernando decidan quién lo actualiza antes de PUB.

3. **Citas y referencias — sin problemas de fondo, dos verificaciones externas limitadas por bloqueos de bot.**
   - Cap. 01: cita a Gelman & Loken (2013) y Nosek et al. (2018), ambas con entrada completa en "Referencias". Verifiqué los dos enlaces con `WebFetch`: el PDF de Gelman (tras redirección `stat.columbia.edu` → `sites.stat.columbia.edu`) devuelve 200 OK y un PDF válido de ~215 KB (no pude extraer el texto porque el stream viene comprimido, pero el archivo carga). El DOI de Nosek et al. resuelve y redirige a `pnas.org/doi/full/...`, pero `pnas.org` devuelve 403 Forbidden a `WebFetch` — es un bloqueo de bot (Cloudflare u similar), no evidencia de enlace roto para un lector real.
   - Cap. 05: cita a "The jamovi project (2025), *jamovi* (Version 2.7.31)" con enlace a `jamovi.org`, que sigue devolviendo 403 Forbidden a `WebFetch` (mismo bloqueo que ya reportó la sesión del 2026-09-04; no cambió). Como verificación alternativa, consulté hoy `github.com/jamovi/jamovi/releases`: el último release listado ahí es **2.7.30**, un patch por debajo del 2.7.31 citado en el capítulo. Esto no confirma que 2.7.31 esté mal —GitHub puede no reflejar el build más reciente publicado en jamovi.org—, pero **reitero la alerta abierta desde el 2026-09-04**: Codex o Fernando deberían confirmar el número de patch exacto antes de publicar, ahora con este dato adicional. Cap. 05 es de Codex en el plan vigente (capítulos 05–15), así que no lo edito.
   - Cap. 15: cita a APA (2020); el DOI resuelve y redirige correctamente a `psycnet.apa.org` (vía `content.apa.org`), sin 403; no pude leer el contenido porque la página carga por JavaScript, pero la cadena de redirección es válida — no es un enlace roto.

4. **Cross-references (`@sec-...`) — todas resuelven.**
   Confirmé las 12 etiquetas `{#sec-*}` definidas (`pregunta`, `plan`, `anatomia`, `jamovi`, `preparar`, `describir`, `arbol`, `supuestos`, `t-una-muestra`, `dos-grupos`, `anova`, `correlacion`, `chi`, `apa` — son 13, no 12) y los ~35 usos de `@sec-...` en todo el libro: cada uno apunta a una etiqueta que existe. No hay ningún `@sec-` huérfano. `{#sec-preparar}` (cap. 06) no se usa desde ningún otro capítulo, pero no hace falta: nadie necesita remitir puntualmente a "preparar la base" además de mencionarla en el recorrido general.

5. **Números de capítulo fijos — ya resueltos en Q02, sin novedad.**
   Sólo quedan las menciones de rango en `index.qmd` (líneas 24 y 26: "capítulos 1 y 2", "capítulos 3 a 7", "capítulos 3 a 9") y en `a1-para-ir-mas-lejos.qmd` (línea 3: "capítulos 1 a 16"). Son rangos sin cross-ref equivalente, ya revisados y aceptados como estilo deliberado el 2026-09-04. No es un hallazgo nuevo.

6. **Enlaces a descargables — sin promesas sin recurso.**
   Los 29 enlaces relativos a `plantillas/*` y `datos/*` distribuidos en 9 capítulos apuntan todos a archivos que existen con el nombre exacto (comparé contra el listado real de ambos directorios). `plantillas/README.md` y `datos/README.md` tienen su inventario al día y coinciden con el capítulo 16; `plantillas/README.md` ya no promete formatos inexistentes (a diferencia de lo que señalaba la auditoría inicial del 2026-09-04, ya corregido).

7. **Falta un id de sección en el capítulo 04 (`04-diccionario-de-datos.qmd`).**
   Es el único capítulo de la Parte I sin `{#sec-*}` en su encabezado (03 tiene `sec-anatomia`, 05 `sec-jamovi`, 06 `sec-preparar`, 07 `sec-describir`). Nadie lo referencia todavía vía `@sec-`, así que hoy no rompe nada, pero es inconsistente con el resto del libro y le impide a cualquier capítulo futuro (o a una corrección de Codex en 08–15) enlazarlo con cross-ref en vez de texto plano. Como el capítulo 04 está en mi alcance de T4, agrego `{#sec-diccionario}` ahí; no toco ningún otro archivo para usarlo, porque los lugares donde podría aprovecharse (p. ej. `08-arbol-de-decision.qmd`, línea 18: "o al diccionario de datos") pertenecen a Codex.

### Comprobaciones no realizadas o limitadas

- No pude renderizar visualmente `jamovi.org`, `pnas.org` ni `orcid.org` con `WebFetch` (bloqueos de bot o carga por JavaScript). No es evidencia de enlace roto, es una limitación de la herramienta en esta sesión.
- No verifiqué exactitud estadística de los capítulos 08–15 (corresponde a T3/Q01, Codex).
- No corrí `quarto render` en esta tarea: T2 es de solo lectura y no modifiqué ningún archivo. El render de esta entrega queda registrado en la sección de T4 más abajo.

### Estado

T2 completa. Sin bloqueos para Q03/T5. Paso a T4.

---

## T4 — Integración de hallazgos editoriales (2026-09-08)

Se completa después de T2. Ver entradas en `PROJECT_LOG.md` → Registro de actividad para el detalle de los cambios aplicados.

### Cambios aplicados

- **`04-diccionario-de-datos.qmd`**: agregado el identificador `{#sec-diccionario}` al encabezado, por ser el único capítulo de la Parte I sin id de sección (hallazgo T2 n.º 7). No lo usé todavía desde ningún otro archivo porque los lugares que podrían aprovecharlo (p. ej. `08-arbol-de-decision.qmd`) son de Codex; queda disponible para que él lo use si quiere reemplazar la mención en texto plano por un cross-ref.
- `index.qmd`, capítulos 01–03, 16, `plantillas/*.md` y `plantillas/diccionario-de-datos.csv`: revisados de nuevo con la lupa de T2 (citas, enlaces, promesas de recursos); no encontré nada adicional para corregir más allá del punto anterior. No los edité.
- `quarto render` ejecutado una vez, antes de ver la reserva de turno de Codex en la bitácora: 18 páginas generadas sin errores ni advertencias de cross-reference, confirmé en `_book/04-diccionario-de-datos.html` que `sec-diccionario` quedó bien resuelto. No vuelvo a renderizar hasta que Codex libere el turno que reservó para las correcciones de T3.

### Propuesta AP1 (para decisión de Fernando)

**Recomendación: mantener el apéndice diferido formalmente, sin redactar contenido nuevo en esta primera edición.**

Estado actual de `a1-para-ir-mas-lejos.qmd`: ya tiene una línea introductoria que dice explícitamente "Este apéndice queda como trabajo futuro, fuera del núcleo de la materia y de esta primera edición", y cada uno de los tres temas (regresión lineal, ANOVA factorial, ANOVA de medidas repetidas) tiene la leyenda "*Pendiente para una próxima edición.*" en vez de quedar vacío. Esto ya cumple, en los hechos, con la condición del backlog: *"El apéndice avanzado puede quedar fuera de la primera edición si se lo etiqueta explícitamente como trabajo futuro."*

Lo que falta no es texto, es una decisión registrada: AP1 sigue `PENDIENTE` en el backlog porque nadie confirmó formalmente si (a) esto alcanza como cierre para la primera edición, o (b) Fernando prefiere que se redacte al menos una introducción breve a los tres temas antes de publicar (sin desarrollarlos por completo). No tomo esta decisión por mi cuenta porque el backlog la marca explícitamente como "decisión abierta" que le corresponde a Fernando, y el plan de cierre dice que el apéndice se modifica recién después de resolver AP1.

**Pido a Fernando que confirme una de estas dos opciones antes de T6:**
1. Cerrar AP1 tal como está (diferido, con las tres leyendas), sin más cambios de contenido.
2. Pedir que se agregue una introducción breve por tema (2–3 líneas cada uno, sin ejemplos ni procedimientos) antes de publicar.

Si Fernando elige la opción 2, lo puedo redactar yo en una entrega separada, ya que `a1-para-ir-mas-lejos.qmd` pasa a mi alcance recién cuando se resuelva AP1.

---

## T5 — Revisión visual de escritorio y móvil (2026-09-08)

Arranqué después de que Codex confirmó en la bitácora que las correcciones de T3 estaban estables y liberó el turno de render. Mi parte de T5 es la revisión visual; Codex controla enlaces/descargas/render (ver su entrega del 2026-09-08 en el registro de actividad).

**Método:** serví `_book/` (ya renderizado por Codex, sin volver a renderizar hasta que hizo falta corregir algo mío) con un servidor estático local (`python -m http.server`) y recorrí las 18 páginas con Chromium headless (Playwright) en dos tamaños: escritorio 1440×900 y móvil 390×844 (iPhone 12, `deviceScaleFactor: 3`). Para cada página y tamaño medí: ancho de scroll del documento contra el ancho del viewport (para detectar overflow horizontal), errores de consola, imágenes rotas, y si la barra lateral de navegación (`#quarto-sidebar`, botón `.quarto-btn-toggle`) se comporta como corresponde (expandida en escritorio, colapsada con botón para abrirla en móvil). Guardé capturas de pantalla completas de cada página/tamaño y capturas de viewport real (sin `fullPage`) para los casos con problemas, para ver exactamente qué queda cortado sin hacer scroll. Las capturas quedaron en mi scratchpad de sesión, no en el repo.

### Resultado general

- **Navegación:** correcta en los dos tamaños. En escritorio la barra lateral de capítulos está expandida por defecto; en móvil arranca colapsada y el botón para abrirla (`.quarto-btn-toggle`) está presente y visible en las 18 páginas. Sin errores de consola ni imágenes rotas en ninguna combinación página/tamaño.
- **Escritorio (1440 px):** las 18 páginas renderizan sin overflow horizontal ni problemas visuales. Confirmé especialmente, a pedido de Codex, las tablas de los capítulos 08 y 15, y las instrucciones ampliadas de 10–12 (con los números ya corregidos en T3: Levene *F*(1, 68) = 2.83, *p* = .097; *t*(68) = 2.70, *p* = .009 en el cap. 11; tabla APA del cap. 15 con número/título en cursiva y bordes solo horizontales) — todo se ve bien, sin cortes ni desbordes.
- **Móvil (390 px):** encontré overflow horizontal de página completa en **5 de 18 páginas**: `01-de-la-pregunta-al-analisis` (577 px de ancho de contenido contra 390 px de viewport), `03-anatomia-de-una-base` (533 px), `04-diccionario-de-datos` (679 px), `08-arbol-de-decision` (470 px) y `09-supuestos` (419 px, apenas 29 px de sobra). Las 13 páginas restantes (incluidas 02, 05–07, 10–16 y el apéndice) no tienen overflow en móvil.

### Causa y corrección

La causa es la misma en los cinco casos: Quarto/Pandoc genera las tablas Markdown como `<table class="table">` sin envolverlas en un contenedor con scroll propio, así que una tabla más ancha que la pantalla empuja **toda la página** a scrollear horizontalmente en vez de scrollear solo la tabla — en un teléfono real, eso significa que columnas enteras quedan fuera de la pantalla sin ningún indicio visual de que hay más contenido al costado. Confirmé esto capturando el viewport real (sin `fullPage`) de la tabla del capítulo 08 ("la tabla maestra", la referencia más usada del libro): en 390 px el lector ve las columnas "…es…", "…son…" y "…central es…" pero la columna **"Capítulo"** completa —con los enlaces a cada análisis— queda cortada fuera de la pantalla.

El framework ya trae la solución sin agregar CSS nuevo: la hoja de Bootstrap que usa el tema (`_book/site_libs/bootstrap/*.min.css`) ya define `.table-responsive` (contenedor con `overflow-x: auto`) y `.text-break` (permite cortar palabras/URLs largas), así que alcanza con envolver el contenido en un div de Pandoc (`::: {.table-responsive}` / `::: {.text-break}`), sin tocar `_quarto.yml` ni sumar dependencias.

- **`01-de-la-pregunta-al-analisis.qmd`** (mío): la causa no es una tabla sino la URL larga sin cortes de la referencia de Gelman & Loken en "## Referencias". Envolví las dos referencias en `::: {.text-break}`. Verificado: ahora la URL corta con guion dentro de la columna y `scrollWidth` de la página baja a 390 px.
- **`03-anatomia-de-una-base.qmd`** (mío): dos tablas anchas (la de ejemplo `id/turno/horas_estudio/procrastinacion/aprobo_parcial`, 507 px, y la de "Nivel de medida", 467 px). Envolví ambas en `::: {.table-responsive}`.
- **`04-diccionario-de-datos.qmd`** (mío): la tabla de la sección "4.3 Ejemplo" (`horas_trabajo`/`trabaja`/`procrastinacion`) medía 654 px; la primera tabla del capítulo (339 px) ya entraba bien y no la toqué. Envolví solo la de 4.3 en `::: {.table-responsive}`.
- Volví a renderizar (`quarto render`, 18 páginas, sin errores) después de estos tres cambios y repetí la revisión Playwright completa: las tres páginas pasaron a `overflowsViewport: false` (scrollWidth = 390 px), y comprobé en escritorio (capturas completas de 01 y 03) que no hay ningún cambio visual — las tablas y la lista de referencias se ven exactamente igual que antes, porque `.table-responsive`/`.text-break` solo actúan cuando el contenido no entra.
- **`08-arbol-de-decision.qmd`** y **`09-supuestos.qmd`** son de Codex (capítulos 05–15): **no los edité**. Dejo la corrección sugerida acá para que la aplique con el mismo patrón:
  - 08: envolver la tabla de "## La tabla maestra" (línea con el encabezado `| Si tu pregunta es… | Y tus variables son… | El análisis central es… | Capítulo |`) en `::: {.table-responsive} … :::`. Es el hallazgo más importante de los dos: es la tabla de referencia más usada del libro y en móvil pierde la columna "Capítulo" (con los enlaces a los análisis) sin ningún indicio de que hay que hacer scroll.
  - 09: overflow marginal (29 px) en la tabla de "## Las comprobaciones más comunes" (`| Pregunta | Qué mirar | Por qué importa |`). Mismo arreglo si Codex quiere prolijidad total, pero es de prioridad baja frente a 08.

### Comprobaciones no realizadas o limitadas

- No probé en un dispositivo físico ni en un navegador real con touch; usé Chromium headless vía Playwright, que reproduce el motor de renderizado real (Chrome) pero no gestos táctiles. El comportamiento de `overflow-x: auto` con scroll táctil es estándar de Bootstrap y no debería variar, pero queda como una verificación manual pendiente si Fernando quiere confirmarlo en un teléfono real antes de publicar.
- No revisé tablets/orientación horizontal (el plan pedía "escritorio y móvil" específicamente); si hace falta un tercer tamaño, lo puedo agregar.
- Q01 sigue abierto según la nota de Codex (falta el recorrido interactivo real en jamovi); mi revisión fue solo visual/HTML, no reemplaza eso.

### Estado

T5 (parte de Claude): revisión visual completa, con dos correcciones propias aplicadas y verificadas (01, 03, 04) y dos hallazgos entregados a Codex (08, 09) sin editar sus archivos. Falta que Codex aplique o descarte la corrección de 08/09 y, si corresponde, un último `quarto render` de cierre antes de dar Q03 por terminado.
