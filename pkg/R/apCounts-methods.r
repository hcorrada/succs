#' @rdname apCount-methods
#' @aliases apCount,AntiProfile,matrix-method
setMethod("apCount",
          signature(fit="AntiProfile",
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

#' @rdname apCount-methods
#' @aliases apCount,TissueSpecAntiProfile,matrix-method
setMethod("apCount",
          signature(fit="TissueSpecAntiProfile",
                    expr="matrix"), .countTissSpec)


.succify <- function(e, meds, mads, cutoff) abs(e-meds)/mads>cutoff
