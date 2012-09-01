#' Obtain the anti-profile score for a set of samples
#' 
#' This function applies the given anti-profile to a new set of samples. Rownames in the expression matrix
#' are used to match probenames in the SuccsSig object.
#' 
#' @param fit an object of class SuccsSig as produced by the succs method
#' @param expr a matrix of gene expression, rownames are used as identifiers
#' @return a vector of anti-profile scores
#' @export
setMethod("succsCount",
          signature(fit="SuccsSig",
                    expr="matrix"),
          function(fit, expr, ...)
          {
            expr <- expr[fit@probes,]
            colSums(.succify(expr,fit@meds0,fit@mads0,fit@cutoff))
          })

.countTissSpec <- function(fit, expr, ...)
  {
    expr <- expr[fit@probes,]
    xx1 <- .succify(expr,fit@meds0,fit@mads0,fit@cutoff)
    
    nTiss <- sapply(fit@theTiss, length)
    tissIndexes <- split(seq_along(nTiss), nTiss)

    for (ii in 2:length(tissIndexes)) {
      curIndexes <- unlist(tissIndexes[ii:length(tissIndexes)])
      curtIndexes <- cbind(curIndexes, sapply(fit@theTiss[curIndexes], "[", ii-1))
      xx2 <- .succify(expr[curIndexes,], fit@tMeds[curtIndexes], fit@tMads[curtIndexes], fit@cutoff)
      xx1[curIndexes,] <- xx1[curIndexes,] & xx2
    }
    
    colSums(xx1)
  }

#' Obtain the anti-profile score for a set of samples
#' 
#' This function applies the given anti-profile to a new set of samples. Rownames in the expression matrix
#' are used to match probenames in the SuccsTissueSig object.
#' 
#' @param fit an object of class SuccsTissueSig as produced by the succs method
#' @param expr a matrix of gene expression, rownames are used as identifiers
#' @return a vector of anti-profile scores
#' @export
setMethod("succsCount",
          signature(fit="SuccsTissueSig",
                    expr="matrix"), .countTissSpec)


.succify <- function(e, meds, mads, cutoff) abs(e-meds)/mads>cutoff
