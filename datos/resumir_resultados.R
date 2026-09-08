# Resume los resultados exactos que se informan en los capítulos 10–14.

main <- read.csv("datos/encuesta-estudiantes-limpia.csv", na.strings = "")
main$turno <- factor(main$turno)
main$trabaja <- factor(main$trabaja)
main$aprobo_parcial <- factor(main$aprobo_parcial)

cat("== ANOVA: procrastinación por turno ==\n")
anova_fit <- aov(procrastinacion ~ turno, data = main)
print(aggregate(procrastinacion ~ turno, data = main,
                FUN = function(x) c(n = length(x), media = mean(x), de = sd(x))))
print(summary(anova_fit))

# Levene clásico: ANOVA sobre las desviaciones absolutas respecto de la media del grupo.
mean_by_group <- ave(main$procrastinacion, main$turno, FUN = mean)
levene_fit <- aov(abs(main$procrastinacion - mean_by_group) ~ main$turno)
print(summary(levene_fit))
print(TukeyHSD(anova_fit))
eta_squared <- summary(anova_fit)[[1]][["Sum Sq"]][1] / sum(summary(anova_fit)[[1]][["Sum Sq"]])
cat(sprintf("ETA_SQUARED=%.4f\n", eta_squared))

cat("\n== Correlación: horas de estudio y procrastinación ==\n")
print(summary(main[c("horas_estudio", "procrastinacion")]))
print(cor.test(main$horas_estudio, main$procrastinacion, method = "pearson"))

cat("\n== Chi-cuadrado: trabajo y aprobación ==\n")
contingency <- table(main$trabaja, main$aprobo_parcial)
print(contingency)
chi <- chisq.test(contingency, correct = FALSE)
print(chi)
print(chi$expected)
cramers_v <- sqrt(unname(chi$statistic) / (sum(contingency) * min(nrow(contingency) - 1, ncol(contingency) - 1)))
cat(sprintf("CRAMERS_V=%.4f\n", cramers_v))
