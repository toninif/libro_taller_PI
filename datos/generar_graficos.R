# Genera las figuras del libro a partir de las bases de practica.
# Ejecutar desde la raiz del repositorio con R 4.5.3 o posterior.

options(stringsAsFactors = FALSE)

main <- read.csv("datos/encuesta-estudiantes-limpia.csv", na.strings = "")
paired <- read.csv("datos/taller-organizacion-prepost.csv", na.strings = "")

dir.create("figuras", showWarnings = FALSE)

ink <- "#24324B"
blue <- "#3B5CCC"
sky <- "#56B4E9"
orange <- "#D55E00"
green <- "#009E73"
yellow <- "#E69F00"
lavender <- "#E8EBFA"
grid_col <- "#DCE1ED"
muted <- "#667085"

work <- ifelse(is.na(main$trabaja), NA,
               ifelse(main$trabaja == "no", "No trabaja", "Trabaja"))
passed <- ifelse(is.na(main$aprobo_parcial), NA,
                 ifelse(main$aprobo_parcial == "no", "No aprob\u00f3", "Aprob\u00f3"))
turn_order <- c("manana", "tarde", "noche")
turn_labels <- c("Ma\u00f1ana", "Tarde", "Noche")

open_svg <- function(name, width = 9, height = 5.2) {
  svg(file.path("figuras", name), width = width, height = height,
      bg = "white", pointsize = 11, family = "sans")
}

panel_style <- function() {
  par(col.axis = ink, col.lab = ink, col.main = ink, fg = ink,
      mgp = c(2.2, 0.65, 0), tcl = -0.25)
}

soft_grid_y <- function() {
  abline(h = axTicks(2), col = grid_col, lwd = 0.8)
}

draw_hist <- function(x, main_title, x_label, reference = NULL) {
  h <- hist(x, breaks = "FD", plot = FALSE)
  plot(h, col = lavender, border = "white", main = main_title,
       xlab = x_label, ylab = "Frecuencia", col.axis = ink,
       col.lab = ink, col.main = ink)
  if (!is.null(reference)) {
    abline(v = reference, col = orange, lwd = 2.2, lty = 2)
    legend("topright", legend = paste("Referencia:", reference),
           col = orange, lty = 2, lwd = 2.2, bty = "n", text.col = ink,
           cex = 0.82)
  }
}

draw_qq <- function(x, main_title = "Gr\u00e1fico Q-Q") {
  qq <- qqnorm(x, plot.it = FALSE)
  plot(qq$x, qq$y, pch = 19, cex = 0.72, col = adjustcolor(blue, 0.78),
       main = main_title, xlab = "Cuantiles normales esperados",
       ylab = "Valores observados")
  qqline(x, col = orange, lwd = 2)
}

draw_scatter <- function(main_title = "Relaci\u00f3n entre dos variables") {
  plot(main$horas_estudio, main$procrastinacion, pch = 19, cex = 0.78,
       col = adjustcolor(blue, 0.62), main = main_title,
       xlab = "Horas de estudio por semana",
       ylab = "Procrastinaci\u00f3n")
  abline(lm(procrastinacion ~ horas_estudio, data = main),
         col = orange, lwd = 2.2)
}

draw_group_box <- function(main_title = "Distribuci\u00f3n por grupo") {
  keep <- !is.na(work)
  boxplot(main$procrastinacion[keep] ~ factor(work[keep],
           levels = c("No trabaja", "Trabaja")),
          col = c(sky, yellow), border = ink, main = main_title,
          xlab = "Situaci\u00f3n laboral", ylab = "Procrastinaci\u00f3n",
          names = c("No trabaja", "Trabaja"))
  stripchart(main$procrastinacion[keep] ~ factor(work[keep],
             levels = c("No trabaja", "Trabaja")),
             vertical = TRUE, method = "jitter", pch = 19,
             col = adjustcolor(ink, 0.35), cex = 0.5, add = TRUE)
}

draw_expected <- function(main_title = "Frecuencias esperadas") {
  tab <- table(factor(work, levels = c("No trabaja", "Trabaja")),
               factor(passed, levels = c("No aprob\u00f3", "Aprob\u00f3")))
  expected <- chisq.test(tab, correct = FALSE)$expected
  vals <- as.vector(t(expected))
  labs <- c("No trabaja\nNo aprob\u00f3", "No trabaja\nAprob\u00f3",
            "Trabaja\nNo aprob\u00f3", "Trabaja\nAprob\u00f3")
  mids <- barplot(vals, names.arg = labs, col = c(sky, blue, yellow, orange),
                  border = NA, ylim = c(0, max(vals) * 1.22),
                  main = main_title, ylab = "Conteo esperado", las = 1,
                  cex.names = 0.72)
  abline(h = 5, col = muted, lty = 2, lwd = 1.5)
  text(mids, vals, labels = sprintf("%.2f", vals), pos = 3, col = ink, cex = 0.8)
  legend("topright", legend = "Referencia: 5", col = muted, lty = 2,
         lwd = 1.5, bty = "n", text.col = ink, cex = 0.75)
}

# Capitulo 07: cuatro preguntas, cuatro elecciones graficas.
open_svg("07-mapa-graficos.svg", 9.4, 7.2)
par(mfrow = c(2, 2), mar = c(4, 4, 2.6, 1), oma = c(0, 0, 1.2, 0))
panel_style()
draw_hist(main$organizacion, "Una variable continua", "Organizaci\u00f3n")
draw_group_box("Una continua por grupo")
draw_scatter("Dos variables continuas")
counts <- table(factor(main$turno, levels = turn_order))
barplot(counts, names.arg = turn_labels, col = c(sky, blue, orange),
        border = NA, main = "Una variable categ\u00f3rica",
        xlab = "Turno", ylab = "Frecuencia", ylim = c(0, max(counts) * 1.18))
mtext("La pregunta y el tipo de variables determinan el gr\u00e1fico", side = 3,
      outer = TRUE, line = 0.1, col = ink, font = 2, cex = 1.05)
dev.off()

# Capitulo 09: diagnosticos que se leen junto con las pruebas.
open_svg("09-comprobacion-supuestos.svg", 9.4, 7.2)
par(mfrow = c(2, 2), mar = c(4.2, 4.2, 2.7, 1), oma = c(0, 0, 1.2, 0))
panel_style()
draw_qq(main$organizacion, "Normalidad: Q-Q")
draw_group_box("Homogeneidad: dispersi\u00f3n")
draw_scatter("Linealidad: dispersi\u00f3n")
draw_expected("Chi-cuadrado: esperadas")
mtext("Cada supuesto necesita una comprobaci\u00f3n pertinente", side = 3,
      outer = TRUE, line = 0.1, col = ink, font = 2, cex = 1.05)
dev.off()

# Capitulo 10: forma de la variable y ajuste a la normal.
open_svg("10-normalidad-una-muestra.svg", 9.2, 4.5)
par(mfrow = c(1, 2), mar = c(4.2, 4.2, 2.7, 1))
panel_style()
draw_hist(main$organizacion, "Histograma", "Organizaci\u00f3n", reference = 24)
draw_qq(main$organizacion)
dev.off()

# Capitulo 11: grupos independientes y diferencias pareadas.
open_svg("11-dos-grupos.svg", 9.2, 4.6)
par(mfrow = c(1, 2), mar = c(4.2, 4.2, 2.7, 1))
panel_style()
draw_group_box("Muestras independientes")
diffs <- paired$organizacion_post - paired$organizacion_pre
stripchart(diffs, method = "jitter", vertical = FALSE, pch = 19,
           col = adjustcolor(blue, 0.62), cex = 0.8,
           main = "Muestras pareadas",
           xlab = "Diferencia: despu\u00e9s menos antes", ylab = "Casos",
           xlim = range(c(0, diffs)) + c(-0.35, 0.35))
abline(v = 0, col = muted, lty = 2, lwd = 1.5)
abline(v = mean(diffs), col = orange, lwd = 2.2)
legend("topleft", legend = c("Sin cambio", "Diferencia media"),
       col = c(muted, orange), lty = c(2, 1), lwd = c(1.5, 2.2),
       bty = "n", text.col = ink, cex = 0.78)
dev.off()

# Capitulo 12: medias e intervalos, mas distribuciones por turno.
open_svg("12-anova.svg", 9.2, 4.7)
par(mfrow = c(1, 2), mar = c(4.2, 4.2, 2.7, 1))
panel_style()
groups <- lapply(turn_order, function(g) main$procrastinacion[main$turno == g])
means <- vapply(groups, mean, numeric(1))
ses <- vapply(groups, function(x) sd(x) / sqrt(length(x)), numeric(1))
cis <- qt(0.975, df = vapply(groups, length, integer(1)) - 1) * ses
plot(seq_along(means), means, pch = 19, cex = 1.25, col = blue,
     xaxt = "n", xlim = c(0.6, 3.4), ylim = range(means - cis, means + cis),
     main = "Medias e IC del 95 %", xlab = "Turno",
     ylab = "Procrastinaci\u00f3n")
axis(1, at = 1:3, labels = turn_labels)
arrows(1:3, means - cis, 1:3, means + cis, angle = 90, code = 3,
       length = 0.07, col = blue, lwd = 2)
lines(1:3, means, col = adjustcolor(blue, 0.45), lwd = 1.2)
boxplot(groups, names = turn_labels, col = c(sky, blue, orange), border = ink,
        main = "Distribuciones por turno", xlab = "Turno",
        ylab = "Procrastinaci\u00f3n")
dev.off()

# Capitulo 13: relacion observada y tendencia lineal.
open_svg("13-correlacion.svg", 7.5, 5.2)
par(mar = c(4.5, 4.5, 2.8, 1))
panel_style()
draw_scatter("M\u00e1s estudio, menor procrastinaci\u00f3n")
legend("topright", legend = "Tendencia lineal", col = orange, lwd = 2.2,
       bty = "n", text.col = ink, cex = 0.82)
dev.off()

# Capitulo 14: porcentajes observados y chequeo de esperadas.
open_svg("14-barras-agrupadas.svg", 7.5, 5.2)
par(mar = c(4.5, 4.5, 2.8, 1))
panel_style()
tab <- table(factor(work, levels = c("No trabaja", "Trabaja")),
             factor(passed, levels = c("No aprob\u00f3", "Aprob\u00f3")))
percent <- prop.table(tab, 1) * 100
mids <- barplot(t(percent), beside = TRUE, names.arg = c("No trabaja", "Trabaja"),
                col = c(sky, orange), border = NA, ylim = c(0, 80),
                main = "Aprobaci\u00f3n seg\u00fan situaci\u00f3n laboral",
                xlab = "Situaci\u00f3n laboral", ylab = "Porcentaje dentro del grupo")
text(mids, t(percent), labels = sprintf("%.1f %%", t(percent)), pos = 3,
     col = ink, cex = 0.8)
legend("topright", legend = colnames(percent), fill = c(sky, orange),
       border = NA, bty = "n", text.col = ink, cex = 0.82)
dev.off()

open_svg("14-frecuencias-esperadas.svg", 7.5, 5.2)
par(mar = c(5.4, 4.5, 2.8, 1))
panel_style()
draw_expected("Todas las frecuencias esperadas superan 5")
dev.off()

# Capitulo 17: ejemplos de mapeo, comparacion perceptiva y ejes honestos.
open_svg("17-gramatica-grafica.svg", 9.4, 3.8)
par(mfrow = c(1, 3), mar = c(4.1, 3.8, 2.7, 0.8))
panel_style()
draw_scatter("Posici\u00f3n + posici\u00f3n")
small_counts <- c(42, 31, 18, 9)
barplot(small_counts, names.arg = LETTERS[1:4], col = blue, border = NA,
        main = "Categor\u00eda + largo", xlab = "Categor\u00eda", ylab = "Cantidad")
boxplot(groups, names = turn_labels, col = c(sky, blue, orange), border = ink,
        main = "Grupo + distribuci\u00f3n", xlab = "Turno",
        ylab = "Procrastinaci\u00f3n")
dev.off()

open_svg("17-barras-vs-torta.svg", 9.2, 4.4)
par(mfrow = c(1, 2), mar = c(4.1, 4, 2.8, 1))
panel_style()
pie(small_counts, labels = paste0(LETTERS[1:4], "  ", small_counts, "%"),
    col = c(sky, blue, yellow, orange), border = "white",
    main = "\u00c1ngulos y \u00e1reas")
barplot(small_counts, names.arg = LETTERS[1:4], col = c(sky, blue, yellow, orange),
        border = NA, ylim = c(0, 50), main = "Longitudes sobre un eje com\u00fan",
        xlab = "Categor\u00eda", ylab = "Porcentaje")
dev.off()

open_svg("17-ejes-honestos.svg", 9.2, 4.4)
par(mfrow = c(1, 2), mar = c(4.1, 4.2, 2.8, 1))
panel_style()
comparison <- c(64.7, 50.0)
barplot(comparison, names.arg = c("No trabaja", "Trabaja"),
        col = c(sky, orange), border = NA, ylim = c(0, 70),
        main = "Eje desde cero", ylab = "Porcentaje que aprob\u00f3")
barplot(comparison, names.arg = c("No trabaja", "Trabaja"),
        col = c(sky, orange), border = NA, ylim = c(45, 70),
        main = "Eje truncado", ylab = "Porcentaje que aprob\u00f3")
mtext("Los mismos valores parecen mucho m\u00e1s distintos cuando el eje se corta",
      side = 1, outer = TRUE, line = -0.2, col = muted, cex = 0.86)
dev.off()

cat("Graficos generados en figuras/\n")
