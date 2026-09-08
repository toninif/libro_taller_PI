# Pensar el análisis antes de los datos

Libro de análisis de datos con jamovi para la cátedra de Prácticas de Investigación.
Dr. Fernando Tonini · [toninif.github.io](https://toninif.github.io)

## Trabajar en local

1. Instalar [Quarto](https://quarto.org/docs/get-started/).
2. En esta carpeta: `quarto preview` (vista previa con recarga automática) o `quarto render` (genera `_book/`).

## Estado y coordinación

Los capítulos 01–16 y los recursos están redactados. El cierre estadístico, la revisión de interfaz y el control final del sitio se coordinan en [PROJECT_LOG.md](PROJECT_LOG.md). Consultá allí el estado vigente antes de editar o publicar. El apéndice avanzado está señalado como trabajo futuro.

## Publicar (después de aprobar la versión)

1. El repositorio ya existe en [toninif/libro_taller_PI](https://github.com/toninif/libro_taller_PI); las URL de `_quarto.yml` apuntan a ese nombre.
2. Completar Q01/Q03 y registrar la aprobación de Fernando en `PROJECT_LOG.md`.
3. Para la publicación inicial, ejecutar `quarto publish gh-pages` y comprobar el resultado.
4. En GitHub: Settings → Pages → Source: rama `gh-pages`.
5. Desde ahí, cada push a `main` republica solo (workflow en `.github/workflows/publish.yml`).

La URL prevista es `https://toninif.github.io/libro_taller_PI/`. Esta configuración no implica que el sitio ya esté publicado.

## Integrar al menú Herramientas del sitio

En el `_quarto.yml` del sitio principal, dentro del menú Herramientas, agregar:

```yaml
- text: "Libro: análisis de datos con jamovi"
  href: https://toninif.github.io/libro_taller_PI/
```

## Estructura

- `_quarto.yml` — configuración y orden de capítulos
- `01–16 .qmd` — capítulos del recorrido principal
- `a1-para-ir-mas-lejos.qmd` — apéndice opcional
- `plantillas/` — plan de análisis, diccionario de datos, árbol de decisión, checklists, frases APA y archivos `.omv`
- `datos/` — bases sintéticas CSV y scripts de generación, validación y auditoría; instrucciones en [datos/README.md](datos/README.md)
- `VALIDACION_ESTADISTICA.md` — resultados reproducidos y límites de la comprobación estadística
- `REVISION_CLAUDE.md` — hallazgos de revisión editorial y visual
