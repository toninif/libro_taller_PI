# Cambios pendientes — Libro de análisis de datos con jamovi

Contexto: libro en Quarto, enfoque íntegro con jamovi, pensado para la cátedra de
Prácticas de Investigación. No enseña estadística (los estudiantes ya la traen):
enseña a **razonar** los análisis. Alcance: de la gestión de datos hasta una ANOVA
de un factor. Tesis central: el análisis empieza en el diseño, antes de tener los
datos.

## Cambios de diseño y presentación

1. Poner una imagen más linda del proyecto.
2. Incluir emojis (o algo similar) en el diseño/presentación.
3. Darle enfoque bilingüe a todos los contenidos del libro.

## Cambios de contenido por capítulo

4. **Capítulo 8**: aclarar que todos los análisis del libro son del mismo modelo.
   Mostrar que hacer una prueba t y una correlación es, en el fondo, lo mismo.
5. **Capítulo 13**: integrar un juego / versión lúdica para interpretar
   correlaciones.

## Visualización de datos (dos niveles)

6. **Secciones transversales**: agregar en cada capítulo una sección corta de
   visualización, siempre con la misma estructura:
   - qué gráfico corresponde al análisis de ese capítulo,
   - cómo sacarlo en jamovi,
   - sobre todo, cómo leerlo (no un tutorial: "cuando corrés esto, mirá esto").
   - Incluir esta sección también en el capítulo de supuestos, donde hoy se
     menciona "ggplots" sin explicar qué son ni cómo se ven (ahí el gráfico
     abstracto se vuelve un Q-Q plot / gráfico de residuos concreto).

7. **Capítulo final independiente ("pensar gráficos")**: cierre que unifica y da el
   marco conceptual que las secciones transversales aplican. Va al final, cuando ya
   vieron todos los gráficos. Debe cubrir:
   - La gramática básica: un gráfico mapea variables a propiedades visuales
     (posición, largo, color, forma). Entender eso es lo que permite elegir bien.
   - Qué percibe bien el ojo humano, y de ahí, con fundamento, **por qué no
     conviene el gráfico de torta**: obliga a comparar ángulos/áreas (lo que peor
     estimamos), mientras que las barras usan longitud/posición sobre un eje común
     (lo que mejor leemos). Con 3+ categorías la torta se vuelve casi ilegible.
     Usarlo como ejemplo del principio general, no como prohibición suelta.
   - Otros "no hagas esto" con su porqué: ejes truncados que exageran diferencias,
     3D que distorsiona, demasiadas categorías, color decorativo que no codifica
     nada.
   - Decisiones honestas: cuándo el color informa vs. distrae, paletas accesibles
     (daltonismo), lo mínimo necesario para que el gráfico se explique solo.
   - El gráfico como parte del razonamiento, no como decoración final.
   - Sección corta sobre plugins de jamovi para visualizar: qué viene de fábrica
     (Exploration → Descriptives: barras, histogramas, densidades, boxplots,
     dispersión), y qué instalar si se quiere más:
     - **jmvplots** (oficial, wrapper de ggplot2 para gráficos personalizados),
     - **jjstatsplot** (gráficos estadísticos "listos para publicar", basado en
       ggstatsplot; integra gráfico + test + tamaño de efecto).
     - Aclarar que se instalan desde Modules → jamovi library, en un par de clics y
       sin reiniciar.

## Apéndices

8. Sumar una serie de apéndices. Candidatos:
   - **Glosario de términos** (bilingüe): tabla de tres columnas — término (ES) ·
     término (EN) · definición **solo en español**. Sirve doble: como glosario y
     como mapa de equivalencias ES/EN para el enfoque bilingüe de todo el libro.
     Los términos en inglés son los que van a encontrar en papers y en la interfaz
     de jamovi (que está en inglés).
   - Guía rápida "qué análisis / qué gráfico según tipo y nivel de variable" (tabla
     de una carilla, resumen del razonamiento central del libro).
   - Plantillas: diccionario de datos, preparación de la base, reporte de
     resultados.
   - Instalación de jamovi y módulos (jmvplots, jjstatsplot).
   - Paletas de colores accesibles (acompaña al capítulo de visualización).
