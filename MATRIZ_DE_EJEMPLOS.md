# Matriz de ejemplos y datasets

Esta matriz define los casos didácticos del libro antes de redactar los capítulos. Todos los datos serán **sintéticos**: representan situaciones plausibles de estudiantes universitarios, no personas reales ni resultados de investigación. Se usarán solo para enseñar decisiones y procedimientos en jamovi.

## Convenciones comunes

- Público: estudiantes que ya cursaron estadística y necesitan decidir, ejecutar e informar análisis básicos.
- Contexto narrativo: una encuesta ficticia sobre organización del estudio y cursada, aplicada a `n = 72` estudiantes.
- Archivo fuente común: `datos/encuesta-estudiantes-bruta.csv`.
- Archivo limpio para trabajar en jamovi: `plantillas/encuesta-estudiantes-limpia.omv`.
- Datos faltantes en el archivo fuente: `-99`; se declaran como faltantes durante la limpieza.
- Todas las rutas de jamovi se revisarán con la versión indicada en cada capítulo antes de publicar.

## Dataset principal: Encuesta de organización y cursada

| Variable | Tipo en jamovi | Uso didáctico |
|---|---|---|
| `id` | Identificador | Distinguir casos; no se analiza. |
| `edad` | Continua | Mostrar una variable numérica. |
| `turno` | Nominal: mañana, tarde, noche | Factor de tres grupos para ANOVA. |
| `horas_trabajo` | Continua | Insumo para crear `trabaja`. |
| `trabaja` | Nominal: sí, no | Variable derivada: sí = 10 o más horas remuneradas semanales. |
| `horas_estudio` | Continua | Relación con procrastinación. |
| `procrastinacion` | Continua, rango 10–50 | Resultado en t independiente, ANOVA y correlación. |
| `organizacion` | Continua, rango 8–40 | t de una muestra frente al punto medio teórico de 24. |
| `aprobo_parcial` | Nominal: sí, no | Asociación con `trabaja` en chi-cuadrado. |

La versión bruta conserva `horas_trabajo` y al menos algunos valores `-99`. La versión limpia declara los tipos, etiquetas y faltantes, y calcula `trabaja`. No se introducirán errores tipográficos artificiales: el foco está en decisiones de análisis, no en una limpieza caótica.

## Dataset complementario: taller pre/post

Para enseñar la t pareada del capítulo 11 se usará un segundo caso breve: `datos/taller-organizacion-prepost.csv`, con `n = 32` estudiantes que completan el puntaje `organizacion_pre` y `organizacion_post` antes y después de un taller de planificación. Tendrá un identificador y ambos puntajes continuos; los mismos casos aparecen dos veces en la comparación.

## Mapa de capítulos

| Capítulo | Pregunta de trabajo | Datos / variables | Producto que debe aprender a leer |
|---|---|---|---|
| 01 | ¿Qué cambia cuando la pregunta se define antes de recolectar? | Caso de Julia: `trabaja` y `procrastinacion` | Pregunta, hipótesis y resultado anticipado. |
| 02 | ¿Cómo se arma un plan de análisis? | Mismo caso de Julia | Plan en una página. |
| 03 | ¿Cómo se lee una base rectangular? | Dataset principal completo | Casos, variables, tipos y escalas. |
| 04 | ¿Cómo se documenta una base? | Dataset principal y su diccionario | Diccionario de datos completo. |
| 05 | ¿Cómo se importa y guarda una base? | Archivo CSV bruto | Proyecto `.omv` guardado. |
| 06 | ¿Cómo se prepara una base sin perder información? | `horas_trabajo`, `-99`, `trabaja` | Transformación, cómputo, faltantes y filtro. |
| 07 | ¿Qué mirar antes de testear? | `procrastinacion`, `turno`, `trabaja` | Descriptivos, tabla y gráfico pertinentes. |
| 08 | ¿Qué análisis responde cada pregunta? | Todas las variables de la matriz | Árbol de decisión textual. |
| 09 | ¿Cuándo confiar en un resultado y qué hacer si falla un supuesto? | Distribución de `procrastinacion` y grupos | Checks de supuestos y alternativa justificada. |
| 10 | ¿El promedio de organización difiere del punto medio 24? | `organizacion` | t de una muestra; ejemplo sin diferencia concluyente. |
| 11a | ¿Difiere la procrastinación entre quienes trabajan y quienes no? | `procrastinacion` por `trabaja` | t independiente; tamaño de efecto e IC. |
| 11b | ¿Cambia la organización después del taller? | `organizacion_pre`, `organizacion_post` | t pareada; dirección del cambio. |
| 12 | ¿Difiere la procrastinación entre turnos? | `procrastinacion` por `turno` | ANOVA, post-hoc y comparación de pares. |
| 13 | ¿Se relacionan las horas de estudio y la procrastinación? | `horas_estudio`, `procrastinacion` | Correlación, gráfico de dispersión y cautela causal. |
| 14 | ¿Se asocian situación laboral y aprobación del parcial? | `trabaja`, `aprobo_parcial` | Tabla de contingencia y chi-cuadrado; ejemplo sin asociación concluyente. |
| 15 | ¿Cómo se comunica un resultado? | Outputs de 10–14 | Párrafos y tablas APA 7. |
| 16 | ¿Qué recursos llevarse? | Todos los materiales | Índice de descargas y checklists. |

## Criterios para generar los datos

1. Los tamaños de grupo deben permitir mostrar los procedimientos sin celdas demasiado pequeñas.
2. La distribución debe ser razonable para explicar supuestos; si se muestra una excepción, se documenta y se usa para enseñar una alternativa, no como error oculto.
3. Los ejemplos deben incluir resultados significativos y no concluyentes. No se debe presentar `p > .05` como prueba de igualdad.
4. Cada dataset debe tener un CSV fuente, una versión `.omv` y un diccionario actualizado.
5. Los valores y resultados exactos se fijan una sola vez al crear los archivos; después, texto, tablas y ejercicios deben derivarse de esos archivos, no de números inventados en el capítulo.

## Próximo entregable

Crear los dos CSV sintéticos y verificar sus análisis en jamovi antes de redactar los capítulos 10–14. La matriz queda en revisión editorial antes de producir archivos `.omv` o tablas de resultados definitivas.
