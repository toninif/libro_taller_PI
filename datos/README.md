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

## Regeneración y validación

Ejecutá los scripts desde la raíz del proyecto con R 4.5.3 y codificación UTF-8. La instalación comprobada usa las bibliotecas `jmvReadWrite` 0.4.12 y `jmv` 2.7.7 incluidas en jamovi 2.7.31. El R integrado en jamovi falló al iniciar el locale en esta máquina; se verificó el procedimiento con la instalación independiente de R.

```powershell
$env:LANG = 'en_US.UTF-8'
$env:LC_ALL = 'en_US.UTF-8'
$env:JAMOVI_R_LIBRARY = 'C:/Program Files/jamovi 2.7.31.0/Resources/modules/base/R'
$env:JAMOVI_ANALYSIS_LIBRARY = 'C:/Program Files/jamovi 2.7.31.0/Resources/modules/jmv/R'
& 'C:/Program Files/R/R-4.5.3/bin/Rscript.exe' --vanilla --encoding=UTF-8 datos/generar_datasets.R
& 'C:/Program Files/R/R-4.5.3/bin/Rscript.exe' --vanilla --encoding=UTF-8 datos/validar_datasets.R
& 'C:/Program Files/R/R-4.5.3/bin/Rscript.exe' --vanilla --encoding=UTF-8 datos/auditar_analisis.R
```

Adaptá las rutas a tu instalación. El generador reemplaza los tres CSV de esta carpeta y los dos OMV de `plantillas/`; no lo uses sobre copias con análisis propios sin guardarlas antes.

`validar_datasets.R` comprueba tamaños, faltantes, etiquetas y patrones previstos. `auditar_analisis.R` compara todos los valores CSV/OMV, revisa la codificación de los metadatos y ejecuta los seis análisis con el motor de jamovi. Deben finalizar con `VALIDATION=PASS` y `AUDIT=PASS`, respectivamente.

La t independiente se informa en el orden `sí` menos `no`, con Student; chi-cuadrado se calcula sin corrección de Yates. Los OMV conservan el orden original `no`, `sí`: el capítulo 11 explica cómo cambiarlo para reproducir los signos positivos. Estos archivos contienen datos preparados, no análisis guardados.
