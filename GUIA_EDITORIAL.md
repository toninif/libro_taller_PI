# Guía editorial del libro

Usar esta guía al redactar o revisar cualquier capítulo. Su función es que el libro conserve una sola voz, avance de manera acumulativa y no se vuelva más largo de lo necesario.

## Propósito y lector

El libro acompaña a estudiantes de Prácticas de Investigación que ya vieron estadística y necesitan tomar decisiones, trabajar con una base e interpretar resultados en jamovi. No reemplaza una materia de estadística ni presenta el test como una receta: cada procedimiento debe volver a la pregunta, las variables y el resultado que se quiere comunicar.

## Voz y extensión

Escribir en español rioplatense, en segunda persona singular (`tenés`, `podés`, `elegís`), con tono directo, cuidadoso y no condescendiente. Explicar primero para qué sirve una decisión y luego cómo se implementa. Evitar definiciones enciclopédicas, tecnicismos sin traducción y listas de opciones que no ayudan a decidir.

Como guía, los capítulos conceptuales tendrán entre 800 y 1.400 palabras; los de análisis, entre 1.000 y 1.600. Una idea que requiere muchas excepciones se divide en una sección breve o se remite al apéndice.

## Estructura de los capítulos

Los capítulos conceptuales deben incluir: una idea central temprana, un ejemplo aplicado, las decisiones que el lector debe tomar y un cierre en forma de autochequeo o acción concreta.

Los capítulos de análisis 10–14 mantienen siempre este orden:

1. La idea en una línea.
2. Cuándo se usa.
3. Paso a paso en jamovi.
4. Ejemplo trabajado.
5. Cómo leer el output e informarlo en APA.
6. Ejercicios de autochequeo.
7. Plantilla para llevar.

Cada ruta de jamovi se escribe como texto, por ejemplo: `Analyses → T-Tests → Independent Samples T-Test`. No usar capturas salvo que una interfaz no pueda explicarse de forma clara con texto. Antes de publicar, verificar las rutas en la versión de jamovi declarada en el capítulo.

## Ejemplos, términos y recursos

Usar la matriz en `MATRIZ_DE_EJEMPLOS.md`. Los datos son sintéticos y sus números definitivos salen de los archivos fuente, nunca de valores inventados en el texto. Mantener estos términos: **base**, **caso**, **variable**, **variable de agrupamiento**, **variable de resultado**, **dato faltante**, **supuesto** y **plan B**.

Referirse a los archivos descargables con enlaces relativos y nombres idénticos a los archivos reales. Al sumar un recurso, actualizar también el capítulo 16 y `plantillas/README.md`.

## Citas, formato y revisión

Aplicar APA 7 para las citas dentro del texto y la bibliografía final. Citar fuentes para definiciones, métodos, normas, instrumentos o afirmaciones empíricas; no para cada instrucción operativa de jamovi. Todo capítulo debe usar Markdown simple, texto UTF-8, encabezados claros, tablas legibles y enlaces con texto descriptivo.

Antes de pasar un archivo a revisión: comprobar que responde la pregunta del capítulo, que no repite otro capítulo, que los ejemplos y enlaces existen, y que `quarto render` funciona.
