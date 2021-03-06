#' Pareto distribution maximum likelihood estimation
#'
#' The maximum likelihood estimate of `b` is the minimum of `x` and the
#'     maximum likelihood estimate of `a` is
#'     `1/(mean(log(x)) - log(b))`.
#'
#' For the density function of the Pareto distribution see
#'    [Pareto][extraDistr::Pareto].
#'
#' @param x a (non-empty) numeric vector of data values.
#' @param na.rm logical. Should missing values be removed?
#' @param ... currently affects nothing.
#' @return `mlpareto` returns an object of [class][base::class] `univariateML`.
#'    This is a named numeric vector with maximum likelihood estimates for
#'    `a` and `b` and the following attributes:
#'     \item{`model`}{The name of the model.}
#'     \item{`density`}{The density associated with the estimates.}
#'     \item{`logLik`}{The loglikelihood at the maximum.}
#'     \item{`support`}{The support of the density.}
#'     \item{`n`}{The number of observations.}
#'     \item{`call`}{The call as captured my `match.call`}
#' @examples
#' mlpareto(precip)
#' @seealso [Pareto][extraDistr::Pareto] for the Pareto density.
#' @references Johnson, N. L., Kotz, S. and Balakrishnan, N. (1995) Continuous
#' Univariate Distributions, Volume 1, Chapter 20. Wiley, New York.
#' @export

mlpareto <- function(x, na.rm = FALSE, ...) {
  if (na.rm) x <- x[!is.na(x)] else assertthat::assert_that(!anyNA(x))
  ml_input_checker(x)
  assertthat::assert_that(min(x) > 0)

  M <- mean(log(x))
  b <- min(x)
  a <- 1 / (M - log(b))

  object <- c(a = a, b = b)

  class(object) <- "univariateML"
  attr(object, "model") <- "Pareto"
  attr(object, "density") <- "extraDistr::dpareto"
  attr(object, "logLik") <- length(x) * (log(a) + a * log(b) - (a + 1) * M)
  attr(object, "support") <- c(b, Inf)
  attr(object, "n") <- length(x)
  attr(object, "call") <- match.call()
  object
}
