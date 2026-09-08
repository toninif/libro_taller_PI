# Verifica que los datasets sintéticos conserven los patrones pedagógicos previstos.

jamovi_library <- Sys.getenv("JAMOVI_R_LIBRARY")
if (nzchar(jamovi_library)) {
  .libPaths(c(jamovi_library, .libPaths()))
}

if (!requireNamespace("jmvReadWrite", quietly = TRUE)) {
  stop("No se encontró jmvReadWrite. Ejecutá este script con el R incluido en jamovi.")
}

main <- read.csv("datos/encuesta-estudiantes-limpia.csv", na.strings = "", fileEncoding = "UTF-8")
main$turno <- factor(main$turno)
main$trabaja <- factor(main$trabaja, levels = c("s\u00ed", "no"))
main$aprobo_parcial <- factor(main$aprobo_parcial)
paired <- read.csv("datos/taller-organizacion-prepost.csv")

one_sample <- t.test(main$organizacion, mu = 24)
independent <- t.test(procrastinacion ~ trabaja, data = main, var.equal = TRUE)
paired_result <- t.test(paired$organizacion_post, paired$organizacion_pre, paired = TRUE)
anova_result <- summary(aov(procrastinacion ~ turno, data = main))[[1]][["Pr(>F)"]][1]
correlation <- cor.test(main$horas_estudio, main$procrastinacion)
contingency <- chisq.test(table(main$trabaja, main$aprobo_parcial), correct = FALSE)

reopened_main <- jmvReadWrite::read_omv("plantillas/encuesta-estudiantes-limpia.omv")
reopened_paired <- jmvReadWrite::read_omv("plantillas/taller-organizacion-prepost.omv")

cat("MAIN_ROWS=", nrow(main), "\n", sep = "")
cat("PAIRED_ROWS=", nrow(paired), "\n", sep = "")
cat("MISSING_WORK_HOURS=", sum(is.na(main$horas_trabajo)), "\n", sep = "")
cat(sprintf("ONE_SAMPLE_MEAN=%.2f P=%.4f\n", mean(main$organizacion), one_sample$p.value))
cat(sprintf("INDEPENDENT_DIFF=%.2f P=%.4f\n",
            -diff(tapply(main$procrastinacion, main$trabaja, mean)), independent$p.value))
cat(sprintf("PAIRED_DIFF=%.2f P=%.4f\n",
            mean(paired$organizacion_post - paired$organizacion_pre), paired_result$p.value))
cat(sprintf("ANOVA_P=%.6f\n", anova_result))
cat(sprintf("CORRELATION_R=%.3f P=%.6f\n", correlation$estimate, correlation$p.value))
cat(sprintf("CHI_P=%.4f MIN_EXPECTED=%.2f\n",
            contingency$p.value, min(contingency$expected)))
cat("OMV_MAIN_ROWS=", nrow(reopened_main), " COLS=", ncol(reopened_main),
    " MISSING_WORK_HOURS=", sum(is.na(reopened_main$horas_trabajo)), "\n", sep = "")
cat("OMV_PAIRED_ROWS=", nrow(reopened_paired), " COLS=", ncol(reopened_paired), "\n", sep = "")
cat("OMV_MAIN_MEASURE_TYPES=",
    paste(vapply(reopened_main, function(x) attr(x, "measureType"), character(1)), collapse = ","),
    "\n", sep = "")

# D02: verifica que las etiquetas de categoría no hayan quedado corruptas
# (ver PROJECT_LOG.md: "sí" apareció como "sC-" por un problema de codificación
# que no afectaba los conteos ni la significancia, por eso no se detectaba acá).
stopifnot(
  identical(sort(levels(main$trabaja)), sort(c("no", "sí"))),
  identical(sort(levels(main$aprobo_parcial)), sort(c("no", "sí"))),
  identical(sort(levels(factor(reopened_main$trabaja))), sort(c("no", "sí"))),
  identical(sort(levels(factor(reopened_main$aprobo_parcial))), sort(c("no", "sí")))
)

stopifnot(
  nrow(main) == 72L,
  nrow(paired) == 32L,
  sum(is.na(main$horas_trabajo)) == 2L,
  one_sample$p.value > .05,
  independent$p.value < .05,
  paired_result$p.value < .05,
  anova_result < .05,
  correlation$estimate < 0,
  correlation$p.value < .05,
  contingency$p.value > .05,
  min(contingency$expected) >= 5,
  nrow(reopened_main) == 72L,
  ncol(reopened_main) == 9L,
  nrow(reopened_paired) == 32L,
  ncol(reopened_paired) == 3L
)

cat("VALIDATION=PASS\n")
