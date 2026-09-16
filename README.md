# Pensar el análisis antes de los datos

**Análisis de datos con jamovi para iniciantes**

[Leer el libro en línea](https://toninif.github.io/libro_taller_PI/)

Este libro propone una manera de trabajar centrada pensar el análisis antes de tener los datos o abrir el programa. 
Está dirigido principalmente a estudiantes que empiezan a analizar datos y necesitan conectar las decisiones de su proyecto con lo que luego harán en jamovi.

El objetivo no es enseñar una colección de pruebas aisladas ni mucho menos estadística. Eso ya lo deberían saber......

<p align="center">
  <img src="meme_readme.png" alt="Perro con anteojos frente a fórmulas matemáticas" width="280">
</p>

El recorrido planteado intenta acompañar al estudiante de el momento en que formula una pregunta, define qué se quiere comparar o relacionar, organiza y documenta la base, 
selecciona un análisis, revisa sus supuestos, interpreta la salida y comunica el resultado.

## Qué incluye

- Un recorrido desde la pregunta y el plan de análisis hasta el informe.
- Orientaciones para preparar, documentar y describir una base de datos.
- Ejemplos guiados en jamovi con pruebas *t*, ANOVA de un factor, correlación y chi-cuadrado.
- Criterios para leer tablas y gráficos sin perder de vista la pregunta original.
- Modelos para informar resultados siguiendo las convenciones de APA.
- Plantillas, listas de control, bases sintéticas y archivos de práctica.

Los datos de los ejemplos son sintéticos y sirven para practicar el procedimiento. Bajo ningún término representan una población real.

## Cómo está organizado

La **Apertura** parte de la pregunta de investigación y del plan de análisis. La **Parte I** se concentra en ordenar, preparar y describir los datos. 
La **Parte II** ayuda a elegir y ejecutar el análisis adecuado. La **Parte III** se ocupa de comunicar los resultados y pensar los gráficos. 
Los apéndices reúnen guías rápidas, paletas accesibles, un glosario y materiales complementarios.

La propuesta es trabajar con un proyecto propio abierto mientras se avanza. En mi experiencia eso genera mucha más motivación que un proyecto genérico.
Cada capítulo deja una tarea concreta para incorporar a ese proyecto y ofrece un autochequeo para revisar lo realizado.

## Materiales del repositorio

- `plantillas/`: plan de análisis, diccionario de datos, listas de control, modelos de reporte y archivos `.omv`.
- `datos/`: bases sintéticas en CSV y scripts para generarlas y validarlas.
- `figuras/`: gráficos utilizados en los capítulos.
- Archivos `.qmd`: fuentes de la portada, los capítulos y los apéndices.

## Reproducir el libro en local

El sitio está construido con [Quarto](https://quarto.org/). Con Quarto instalado, desde la raíz del repositorio se puede ejecutar:

```powershell
quarto preview
```

Para generar la versión completa del sitio:

```powershell
quarto render
```

El resultado se escribe en `_book/`.


