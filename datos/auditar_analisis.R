# Auditoria reproducible de los seis analisis y de los archivos distribuidos.
# Ejecutar desde la raiz con Rscript --vanilla --encoding=UTF-8.
base_lib <- Sys.getenv("JAMOVI_R_LIBRARY")
jmv_lib <- Sys.getenv("JAMOVI_ANALYSIS_LIBRARY")
.libPaths(c(base_lib[nzchar(base_lib)], jmv_lib[nzchar(jmv_lib)], .libPaths()))
cat(R.version.string, "\n")
cat("jmvReadWrite:", as.character(packageVersion("jmvReadWrite")), "\n")
main <- read.csv("datos/encuesta-estudiantes-limpia.csv", fileEncoding = "UTF-8",
                 colClasses = c(id = "character"), na.strings = "")
paired <- read.csv("datos/taller-organizacion-prepost.csv", fileEncoding = "UTF-8")
omv <- jmvReadWrite::read_omv("plantillas/encuesta-estudiantes-limpia.omv")
omv_paired <- jmvReadWrite::read_omv("plantillas/taller-organizacion-prepost.omv")
for (pair in list(list(main, omv), list(paired, omv_paired))) {
  stopifnot(identical(names(pair[[1]]), names(pair[[2]])))
  for (nm in names(pair[[1]])) {
    stopifnot(identical(as.character(pair[[1]][[nm]]), as.character(pair[[2]][[nm]])))
  }
}
for (path in c("plantillas/encuesta-estudiantes-limpia.omv",
               "plantillas/taller-organizacion-prepost.omv")) {
  for (member in c("metadata.json", "xdata.json")) {
    con <- unz(path, member, encoding = "UTF-8")
    raw_json <- paste(readLines(con, warn = FALSE), collapse = "\n")
    close(con)
    stopifnot(!any(vapply(c("sC-", "aC1os", "C3n", "C!s", "C)mica"),
                         function(bad) grepl(bad, raw_json, fixed = TRUE), logical(1))))
    if (member == "metadata.json") {
      fields <- jsonlite::fromJSON(raw_json)$dataSet$fields
      expected <- if (grepl("encuesta", path)) c(
        edad = "Edad en a\u00f1os",
        procrastinacion = "Puntaje total de procrastinaci\u00f3n acad\u00e9mica",
        organizacion = "Puntaje de organizaci\u00f3n acad\u00e9mica",
        aprobo_parcial = "Aprobaci\u00f3n del parcial",
        trabaja = "Situaci\u00f3n laboral: 10 o m\u00e1s horas semanales"
      ) else c(
        organizacion_pre = "Puntaje de organizaci\u00f3n antes del taller",
        organizacion_post = "Puntaje de organizaci\u00f3n despu\u00e9s del taller"
      )
      stopifnot(identical(unname(expected), fields$description[match(names(expected), fields$name)]))
    }
    cat(path, member, "ENCODING=PASS\n")
  }
}
main$trabaja <- factor(main$trabaja, levels = c("s\u00ed", "no"))
main$turno <- factor(main$turno, levels = c("manana", "tarde", "noche"))
main$aprobo_parcial <- factor(main$aprobo_parcial, levels = c("no", "s\u00ed"))
cat("CSV_OMV_VALUES=PASS\n")
raw_data <- read.csv("datos/encuesta-estudiantes-bruta.csv", fileEncoding = "UTF-8",
                     colClasses = c(id = "character"))
stopifnot(identical(which(raw_data$horas_trabajo == -99), c(7L, 58L)),
          identical(which(is.na(main$trabaja)), c(7L, 58L)),
          identical(raw_data$aprobo_parcial, as.character(main$aprobo_parcial)))
leave_one_out <- vapply(seq_len(nrow(main)), function(i)
  cor(main$horas_estudio[-i], main$procrastinacion[-i]), numeric(1))
cat("CORRELATION_LEAVE_ONE_OUT_RANGE=", range(leave_one_out), "\n")
stopifnot(all(leave_one_out < 0))
for (nm in c("organizacion", "horas_estudio", "procrastinacion")) {
  cat(nm, "mean", mean(main[[nm]]), "sd", sd(main[[nm]]), "range", range(main[[nm]]), "\n")
}
print(t.test(main$organizacion, mu = 24))
print(t.test(procrastinacion ~ trabaja, main, var.equal = TRUE))
print(t.test(paired$organizacion_post, paired$organizacion_pre, paired = TRUE))
print(TukeyHSD(aov(procrastinacion ~ turno, main)))
print(cor.test(main$horas_estudio, main$procrastinacion))
print(chisq.test(table(main$trabaja, main$aprobo_parcial), correct = FALSE))
cat("jmv:", as.character(packageVersion("jmv")), "\n")
print(jmv::ttestOneS(main, vars = "organizacion", testValue = 24,
                   meanDiff = TRUE, ci = TRUE, effectSize = TRUE, norm = TRUE, desc = TRUE))
print(jmv::ttestIS(main, vars = "procrastinacion", group = "trabaja",
                 meanDiff = TRUE, ci = TRUE, effectSize = TRUE, eqv = TRUE, desc = TRUE))
print(jmv::ttestPS(paired, pairs = list(list(i1 = "organizacion_post", i2 = "organizacion_pre")),
                 meanDiff = TRUE, ci = TRUE, effectSize = TRUE, norm = TRUE, desc = TRUE))
print(jmv::anovaOneW(main, deps = "procrastinacion", group = "turno", fishers = TRUE,
                   welchs = FALSE, eqv = TRUE, desc = TRUE, phMethod = "tukey"))
print(jmv::ANOVA(main, dep = "procrastinacion", factors = "turno", effectSize = "eta"))
print(jmv::corrMatrix(main, vars = c("horas_estudio", "procrastinacion"), ci = TRUE, n = TRUE))
print(jmv::contTables(main, rows = "trabaja", cols = "aprobo_parcial", phiCra = TRUE,
                    exp = TRUE, pcRow = TRUE))
cat("AUDIT=PASS\n")
