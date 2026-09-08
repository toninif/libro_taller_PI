# Validación estadística — Codex — 2026-09-08

## Entrega para Claude

T1 completada: los tres CSV se regeneraron sin cambios de contenido respecto de los archivos corregidos por Claude. Los dos OMV se regeneraron y sus valores coinciden, columna por columna, con los CSV. Las etiquetas `sí/no` y las descripciones acentuadas se conservan.

Los seis resultados principales están confirmados con el módulo instalado de jamovi. Claude puede conservar los números de las frases APA. La corrección numérica detectada está en Levene del capítulo 11: **F(1, 68) = 2.83, p = .097**. Codex la integra junto con las correcciones operativas de 05–15.

La versión 2.7.31 está confirmada tanto por la instalación local como por las [notas oficiales de publicación](https://www.jamovi.org/release-notes.html), que la fechan el 1 de junio de 2026. Se corrigió el año de la referencia del capítulo 05 a 2026. Esto resuelve la alerta de versión de T2; no estamos afirmando que sea la versión más reciente.

Correcciones T3 aplicadas: opciones de diferencia/IC/descriptivos en las t; orden sí − no; Levene; explicación del IC frecuentista y la simetría de Wilcoxon; distinción entre One-Way ANOVA y ANOVA para obtener η²; se retiraron del ejemplo los IC de Tukey que ese panel no muestra (quedan arriba documentados como cálculo de R); χ² sin Yates explícito; faltantes antes de transformar y desactivación del filtro; Spearman limitado a relaciones monótonas; alcance de la correlación punto-biserial; número de tabla APA en negrita y título en cursiva. Los resultados de las frases APA siguen vigentes.

Al excluir de a un caso, Pearson varía entre −.4033 y −.3374: no depende del signo aportado por un único caso. La revisión visual del diagrama aún forma parte de la comprobación interactiva pendiente.

| Análisis | Resultado validado | IC 95 % | Tamaño de efecto |
|---|---|---|---|
| t de una muestra, n = 72 | t(71) = 0.82, p = .415 | Media [23.44, 25.34]; diferencia respecto de 24 [−0.56, 1.34] | d = 0.10 |
| t independiente, sí − no, n = 70 | t(68) = 2.70, p = .009 | Diferencia [0.72, 4.79] | d = 0.65 |
| t pareada, post − pre, n = 32 | t(31) = 7.83, p < .001 | Diferencia [1.90, 3.25] | d = 1.38 |
| ANOVA clásico, n = 72 | F(2, 69) = 18.63, p < .001 | Tukey: ver debajo | η² = .35 |
| Pearson, n = 72 | r(70) = −.38, p = .001 | [−.56, −.16] | r = −.38 |
| Chi-cuadrado sin Yates, n = 70 | χ²(1) = 1.54, p = .214 | No informado en el ejemplo | V = .15 |

Tukey: tarde − mañana = 4.57, IC [2.03, 7.10], p = .0001545; noche − mañana = 6.25, IC [3.71, 8.78], p = .0000004; noche − tarde = 1.68, IC [−0.86, 4.22], p = .2586749. Los IC se calcularon con `stats::TukeyHSD`; One-Way ANOVA de jamovi muestra diferencias y p, pero no esos IC.

Levene para ANOVA: F(2, 69) = 2.10, p = .130, confirmado. Levene de la t independiente: el módulo devuelve 2.834460 y .0968476. El resultado previo calculado fuera de jamovi no coincide con su implementación.

## Entorno y reproducción

- jamovi instalado: `C:/Program Files/jamovi 2.7.31.0`.
- R ejecutado: 4.5.3 UCRT; jmv 2.7.7; jmvReadWrite 0.4.12, de las bibliotecas incluidas en jamovi.
- El intento inicial con R incluido en jamovi falló al iniciar el locale y recodificar el script, antes de generar archivos. Con R 4.5.3 y locale UTF-8 explícito se completaron generación, validación y auditoría.

Desde PowerShell, en la raíz del proyecto:

```powershell
$env:LANG = 'en_US.UTF-8'
$env:LC_ALL = 'en_US.UTF-8'
$env:JAMOVI_R_LIBRARY = 'C:/Program Files/jamovi 2.7.31.0/Resources/modules/base/R'
$env:JAMOVI_ANALYSIS_LIBRARY = 'C:/Program Files/jamovi 2.7.31.0/Resources/modules/jmv/R'
& 'C:/Program Files/R/R-4.5.3/bin/Rscript.exe' --vanilla --encoding=UTF-8 datos/generar_datasets.R
& 'C:/Program Files/R/R-4.5.3/bin/Rscript.exe' --vanilla --encoding=UTF-8 datos/validar_datasets.R
& 'C:/Program Files/R/R-4.5.3/bin/Rscript.exe' --vanilla --encoding=UTF-8 datos/auditar_analisis.R
```

## Alcance y límites de la verificación

Ejecutados los análisis con `jmv` y cotejados con R base. Leídas las definiciones de opciones y paneles en `Resources/modules/jmv/ui/` de la instalación 2.7.31. No se ha realizado todavía una comprobación interactiva de los menús en la aplicación; esa parte de Q01 permanece pendiente. No confundir esta verificación del motor y las definiciones con una sesión visual.

Fuentes de contraste: [One-Way ANOVA de jamovi](https://docs.jamovi.org/jmv/jmv_anovaOneW.html), [Wilcoxon en R](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/wilcox.test.html). La primera confirma las opciones disponibles del panel simplificado; la segunda explicita la simetría que requiere la prueba de rangos con signo.

## Entrega de integración y controles del sitio

- `quarto render`: exitoso, 18 páginas, Quarto 1.9.37.
- 751 enlaces locales del HTML comprobados, incluidos destinos y anclas.
- Descargas CSV/OMV/Markdown: hashes iguales entre fuente y copia publicada, y respuestas HTTP 200.
- `quarto preview`: el primer intento dentro del sandbox dio errores de acceso a la caché de estilos. Se repitió fuera con aprobación: las 18 páginas respondieron correctamente y se comprobó el contenido nuevo de Levene y del título de tabla APA. Servidor detenido al terminar.
- `git diff --check`: sin errores de espacios; solo avisos de conversión LF/CRLF.
- Corregidos los hallazgos de Claude sobre README raíz y URL del repositorio. El identificador del capítulo 04 agregado por Claude ya se usa en el 08.

### Comprobaciones que faltan para cerrar Q01 y Q03

1. Abrir los dos OMV en jamovi 2.7.31 y comprobar tipos, etiquetas y los dos faltantes. Repetir el recorrido de importar/transformar/filtrar del capítulo 06, comprobando que los casos 007 y 058 no queden clasificados como `no`.
2. Recorrer las opciones de las tres t: media/diferencia/IC, nivel `sí` primero en independientes, post primero en pareadas; contrastar el output con la tabla de esta entrega.
3. Recorrer ANOVA (Fisher/Tukey y η² en el otro panel), correlación y contingencia sin Yates; inspeccionar los gráficos de supuestos y dispersión.
4. Claude: revisar el libro en escritorio y móvil, especialmente las tablas de 08/15 y las instrucciones de 10–12. Puede empezar sobre esta entrega; si aparecen nuevas correcciones, volver a validar las páginas afectadas.

Esta lista requiere interacción visual real. La sesión de Codex dispone de terminal y consultas web, pero no de una herramienta de control visual del escritorio o navegador. AP1 y aprobación de publicación siguen pendientes; no se realizó push ni publicación.
