## Compare Means Tool
## For use with two sample mean comparisons

## (C) Daniel Van Veghel, 2021
#' Determine the statistical significance of the difference in two different sample means.
#' @param mean1 The first sample mean
#' @param mean2 The second sample mean
#' @param var1 The first sample variance
#' @param var2 the second sample variance
#' @param n1 The first sample size
#' @param n2 The second sample size
#'
#' @usage compare_means(mean1, mean2, var1, var2, n1, n2)
#' @return The t value of the associated small two-sample t-test, and the associated p-value for this t-value.
#' @export
#' @examples compare_means(12, 15, 20, 30, 40, 45)
#'

compare_means <- function(mean1, mean2, var1, var2, n1, n2){
  t <- (mean1 - mean2)/sqrt((var1/n1)+(var2/n2))
  p <- 2*pt(-abs(t), df=(n1+n2-2))
  newlist <- list(t,p)
  return(newlist)
}
