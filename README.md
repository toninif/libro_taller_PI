# Pensar el análisis antes de los datos

Libro de análisis de datos con jamovi para la cátedra de Prácticas de Investigación.
Dr. Fernando Tonini · [toninif.github.io](https://toninif.github.io)

## Trabajar en local

1. Instalar [Quarto](https://quarto.org/docs/get-started/).
2. En esta carpeta: `quarto preview` (vista previa con recarga automática) o `quarto render` (genera `_book/`).

## Publicar (una sola vez, al configurar)

1. Crear un repo en GitHub (p. ej. `libro_practicas`) y subir esta carpeta.
2. Ajustar `site-url` y `repo-url` en `_quarto.yml` al nombre real del repo.
3. Publicación inicial desde tu máquina: `quarto publish gh-pages` (crea la rama `gh-pages`).
4. En GitHub: Settings → Pages → Source: rama `gh-pages`.
5. Desde ahí, cada push a `main` republica solo (workflow en `.github/workflows/publish.yml`).

El libro queda en `https://toninif.github.io/<nombre-repo>/`.

## Integrar al menú Herramientas del sitio

En el `_quarto.yml` del sitio principal, dentro del menú Herramientas, agregar:

```yaml
- text: "Libro: análisis de datos con jamovi"
  href: https://toninif.github.io/<nombre-repo>/
```

## Estructura

- `_quarto.yml` — configuración y orden de capítulos
- `01–16 .qmd` — capítulos (stubs con TODO por ahora)
- `a1-para-ir-mas-lejos.qmd` — apéndice opcional
- `plantillas/` — descargables (diccionario de datos, checklists, .omv)
