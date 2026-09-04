# Genera los datos sintéticos usados en el libro.
# Ejecutar con el R incluido en jamovi y definir JAMOVI_R_LIBRARY si fuera necesario.

jamovi_library <- Sys.getenv("JAMOVI_R_LIBRARY")
if (nzchar(jamovi_library)) {
  .libPaths(c(jamovi_library, .libPaths()))
}

# D02: en una corrida anterior, los caracteres acentuados (á é í ó ñ) quedaron
# corruptos en los CSV y en los .omv generados (ver PROJECT_LOG.md). Forzamos
# la codificación de entrada/salida a UTF-8 explícitamente para evitar que
# quede librada al locale nativo de la máquina que ejecuta el script.
tryCatch(Sys.setlocale("LC_CTYPE", "en_US.UTF-8"), error = function(e) invisible(NULL))
tryCatch(Sys.setlocale("LC_CTYPE", ".UTF-8"), error = function(e) invisible(NULL))

# Marca explícitamente como UTF-8 cualquier literal con tilde o ñ, para que
# no dependa de cómo el intérprete de R haya leído el código fuente de este
# archivo. Usar siempre u("...") en vez de "..." para texto acentuado.
u <- function(x) {
  Encoding(x) <- "UTF-8"
  x
}

if (!requireNamespace("jmvReadWrite", quietly = TRUE)) {
  stop("No se encontró jmvReadWrite. Ejecutá este script con el R incluido en jamovi.")
}

set.seed(20260904)

root <- normalizePath(file.path(getwd()), winslash = "/", mustWork = TRUE)
templates <- file.path(root, "plantillas")

n_by_shift <- 24L
n <- n_by_shift * 3L
id <- sprintf("%03d", seq_len(n))
turno <- factor(rep(c("manana", "tarde", "noche"), each = n_by_shift),
                levels = c("manana", "tarde", "noche"))

# Hay la misma cantidad de estudiantes que trabajan en cada turno.
works_true <- rep(rep(c(FALSE, TRUE), each = n_by_shift / 2L), 3L)
horas_trabajo <- ifelse(
  works_true,
  pmin(35, pmax(10, round(rnorm(n, mean = 20, sd = 5)))),
  sample(0:8, n, replace = TRUE)
)

shift_effect <- c(manana = 0, tarde = 2.5, noche = 5)[as.character(turno)]
horas_estudio <- round(pmax(1, rnorm(n, mean = 7 - 1.5 * works_true, sd = 1.9)), 1)
procrastinacion <- round(pmin(50, pmax(
  10,
  29 + shift_effect + 3 * works_true - 0.7 * (horas_estudio - 6) + rnorm(n, sd = 3.3)
)), 1)

# El promedio queda cerca del punto medio 24 para el ejemplo de t de una muestra.
organizacion <- round(rnorm(n, mean = 24.3, sd = 4.2), 1)
edad <- sample(18:35, n, replace = TRUE)

# La aprobación difiere un poco entre grupos, pero no lo suficiente para una
# asociación concluyente. Los dos faltantes de horas de trabajo quedan fuera
# de esta tabla porque `trabaja` no se puede calcular para esos casos.
aprobo_parcial <- character(n)
missing_rows <- c(7L, 58L)
no_trabaja_valid <- setdiff(which(!works_true), missing_rows)
trabaja_valid <- which(works_true)
aprobo_parcial[no_trabaja_valid] <- sample(c(rep(u("sí"), 22L), rep("no", 12L)))
aprobo_parcial[trabaja_valid] <- sample(c(rep(u("sí"), 18L), rep("no", 18L)))
aprobo_parcial[missing_rows] <- c(u("sí"), "no")
aprobo_parcial <- u(aprobo_parcial)
aprobo_parcial <- factor(aprobo_parcial, levels = c("no", u("sí")))

# Dos faltantes intencionales para practicar su declaración y tratamiento.
horas_trabajo_raw <- horas_trabajo
horas_trabajo_raw[missing_rows] <- -99L

bruta <- data.frame(
  id = id,
  edad = edad,
  turno = turno,
  horas_trabajo = horas_trabajo_raw,
  horas_estudio = horas_estudio,
  procrastinacion = procrastinacion,
  organizacion = organizacion,
  aprobo_parcial = aprobo_parcial,
  check.names = FALSE
)

limpia <- bruta
limpia$horas_trabajo[limpia$horas_trabajo == -99] <- NA
limpia$trabaja <- factor(
  ifelse(is.na(limpia$horas_trabajo), NA, ifelse(limpia$horas_trabajo >= 10, u("sí"), "no")),
  levels = c("no", u("sí"))
)

labels <- c(
  id = "Identificador del caso",
  edad = u("Edad en años"),
  turno = "Turno de cursada",
  horas_trabajo = "Horas de trabajo remunerado por semana",
  horas_estudio = "Horas de estudio semanales fuera de clase",
  procrastinacion = u("Puntaje total de procrastinación académica"),
  organizacion = u("Puntaje de organización académica"),
  aprobo_parcial = u("Aprobación del parcial"),
  trabaja = u("Situación laboral: 10 o más horas semanales")
)
for (variable in intersect(names(labels), names(limpia))) {
  attr(limpia[[variable]], "description") <- labels[[variable]]
}
attr(limpia$id, "jmv-id") <- TRUE

# Dataset independiente para la comparación pre/post del capítulo 11.
n_prepost <- 32L
id_prepost <- sprintf("T%02d", seq_len(n_prepost))
organizacion_pre <- round(rnorm(n_prepost, mean = 22.5, sd = 4.0), 1)
organizacion_post <- round(pmin(40, pmax(
  8,
  organizacion_pre + rnorm(n_prepost, mean = 2.6, sd = 1.8)
)), 1)
prepost <- data.frame(id = id_prepost, organizacion_pre, organizacion_post)
attr(prepost$id, "jmv-id") <- TRUE
attr(prepost$organizacion_pre, "description") <- u("Puntaje de organización antes del taller")
attr(prepost$organizacion_post, "description") <- u("Puntaje de organización después del taller")

write.csv(bruta, file.path(root, "datos", "encuesta-estudiantes-bruta.csv"),
          row.names = FALSE, na = "", fileEncoding = "UTF-8")
write.csv(limpia, file.path(root, "datos", "encuesta-estudiantes-limpia.csv"),
          row.names = FALSE, na = "", fileEncoding = "UTF-8")
write.csv(prepost, file.path(root, "datos", "taller-organizacion-prepost.csv"),
          row.names = FALSE, na = "", fileEncoding = "UTF-8")

jmvReadWrite::write_omv(limpia,
                         file.path(templates, "encuesta-estudiantes-limpia.omv"),
                         frcWrt = TRUE)
jmvReadWrite::write_omv(prepost,
                         file.path(templates, "taller-organizacion-prepost.omv"),
                         frcWrt = TRUE)

cat("Datasets generated successfully.\n")
