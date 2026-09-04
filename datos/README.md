# Datasets sintéticos del libro

Estos archivos contienen datos ficticios para practicar el recorrido del libro. No representan personas reales ni se deben usar para sacar conclusiones sobre una población.

## Archivos

- `encuesta-estudiantes-bruta.csv`: fuente para importar en el capítulo 05. Incluye `-99` como código de dos faltantes en `horas_trabajo`.
- `encuesta-estudiantes-limpia.csv`: versión de control en CSV; declara los faltantes como vacíos e incluye `trabaja` calculada con el criterio de 10 o más horas semanales.
- `taller-organizacion-prepost.csv`: 32 casos con puntajes antes y después de un taller, para la t pareada.
- `generar_datasets.R`: script con semilla fija que regenera los tres CSV y los `.omv` de `plantillas/`.

## Patrones pedagógicos previstos

- Organización frente al punto medio 24: diferencia no concluyente.
- Procrastinación por situación laboral: diferencia interpretable entre grupos.
- Organización antes/después del taller: cambio interpretable en medidas pareadas.
- Procrastinación por turno: diferencias para practicar ANOVA y comparaciones posteriores.
- Horas de estudio y procrastinación: relación negativa interpretable.
- Situación laboral y aprobación: asociación no concluyente.

Los valores exactos se deben obtener siempre de los archivos generados, no de esta descripción.
