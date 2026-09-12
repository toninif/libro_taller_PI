# Registro de preparación de la base

Guardá esta planilla en `documentos/` y completala mientras preparás la base en jamovi (@sec-preparar). Sirve para dejar por escrito cada decisión, de modo que otra persona (o vos mismo, más adelante) pueda reconstruir cómo se pasó de la base original a la base de trabajo. La regla de fondo: se agregan columnas y decisiones, nunca se borra ni se sobrescribe lo que llegó del instrumento.

## Archivos

| Material | Ruta |
|---|---|
| Base original (sin tocar) | `datos-originales/` |
| Base de trabajo vigente | `trabajo/` |
| Diccionario de datos | `documentos/` |

## Recodificaciones (Transform)

Cada variable nueva creada a partir de categorizar otra.

| Variable nueva | Variable de origen | Criterio (condiciones) | Nivel de medida |
|---|---|---|---|
| | | | |

## Variables calculadas (Compute)

Cada variable derivada de una fórmula.

| Variable nueva | Fórmula | Ítems o variables que usa | Tratamiento de faltantes |
|---|---|---|---|
| | | | |

## Datos faltantes (Missing Values)

| Variable | Código declarado como faltante | Cantidad de casos afectados |
|---|---|---|
| | | |

## Filtros (Filters)

| Condición del filtro | Qué casos deja fuera | ¿Activo al analizar? |
|---|---|---|
| | | |

## Comprobaciones finales

- [ ] La columna original sigue en la base, sin editar.
- [ ] Cada variable nueva figura en el diccionario con su fórmula o criterio.
- [ ] Los faltantes están declarados como faltantes, no borrados ni tratados como números.
- [ ] Sé qué filtros quedaron activos y por qué.
