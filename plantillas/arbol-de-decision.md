# Árbol de decisión para análisis básicos

Usalo después de escribir la pregunta y de identificar el tipo de cada variable. No elige por vos: confirma que el análisis responde la pregunta que ya definiste.

## 1. ¿Qué querés saber?

### ¿Un promedio difiere de un valor?

- Tenés una variable continua y un valor de referencia.
- Usá **t de una muestra**.

### ¿Un resultado continuo difiere entre grupos o momentos?

1. ¿Son las mismas personas medidas dos veces?
   - Sí → **t de muestras pareadas**.
2. Si son personas distintas, ¿cuántos grupos hay?
   - Dos → **t de muestras independientes**.
   - Tres o más → **ANOVA de un factor**.

### ¿Dos variables se relacionan?

- Dos variables continuas → **correlación**.
- Dos variables categóricas → **chi-cuadrado de independencia**.

## 2. Antes de abrir el análisis

- La pregunta nombra qué se compara o relaciona.
- Cada variable tiene una definición, tipo y rol claros.
- Los faltantes están declarados y la base original se conserva.
- Revisaste descriptivos y el supuesto que corresponde.
- Tenés un plan B si el supuesto relevante no se cumple.

## 3. Recordatorio

El análisis viene de la pregunta, no del menú disponible. Un resultado continuo no se vuelve categórico porque sea más fácil hacer una t, y un código numérico no convierte una categoría en una medida continua.
