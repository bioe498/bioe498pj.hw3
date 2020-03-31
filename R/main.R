
fitquad <- function(y, x=c(-1,0,1)) {
  model <- lm(y ~ poly(x,2))
  function(x) predict(model, data.frame(x=x))
}

model_pH <- fitquad(c(2.3, 1.5, -0.3))
model_stir <- fitquad(c(-0.5, 1, -0.1))
model_lactose <- fitquad(c(0, 1.2, 1.5))
model_aa <- fitquad(c(0, 0.05, 0.07))
model_nisin <- fitquad(c(0, 0.1, 0.15))

model_lactose_nisin <- fitquad(c(-0.1, 0, -0.1))
model_pH_stir <- fitquad(c(1,0,-0.1))

response <- function(pH, stir, lactose, aa, nisin, block) {
  model_pH(pH) +
    model_stir(stir) +
    model_lactose(lactose) +
    model_aa(aa) +
    model_nisin(nisin) +

    model_lactose_nisin(lactose * nisin) +
    model_pH_stir(pH * stir) +

    1.3*(block-1) +
    rnorm(pH,0.1)

}

#' @export
run_experiments <- function(design, block=1) {
  inblock <- design$Block == block
  pH <- design$x1[inblock]
  stir <- design$x2[inblock]
  lactose <- design$x3[inblock]
  aa <- design$x4[inblock]
  nisin <- design$x5[inblock]
  set.seed(block)
  design$titer[inblock] <- response(pH, stir, lactose, aa, nisin, block)
  return(design)
}
