#' Obtain the anti-profile score for a set of samples
#' 
#' This function applies the given anti-profile to a new set of samples. Rownames in the expression matrix
#' are used to match probenames in the AntiProfile object.
#' 
#' @param fit an object of class AntiProfile as produced by the buildAntiProfile method
#' @param expr a matrix of gene expression, rownames are used as identifiers
#' @return a vector of anti-profile scores
#' 
#' @examples 
#'   if (require(antiProfilesData)) {
#'     data(apColonData)
#'   
#'     # compute statistics
#'     colonStats = apStats(exprs(apColonData), pData(apColonData)$Status)
#'   
#'     # create an anti-profile, ignoring tissue-specificity of probesets, with 10 probesets
#'     ap = buildAntiProfile(colonStats, tissueSpec=FALSE, sigsize=10)
#'   
#'     # get counts for the original dataset
#'     counts =apCount(ap, exprs(apColonData$expr))
#'  }
#' @export  
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

#' Obtain the anti-profile score for a set of samples
#' 
#' This function applies the given anti-profile to a new set of samples. Rownames in the expression matrix
#' are used to match probenames in the TissueSpecAntiProfile object.
#' 
#' @param fit an object of class TissueSpecAntiProfile as produced by the buildAntiProfile method
#' @param expr a matrix of gene expression, rownames are used as identifiers
#' @return a vector of anti-profile scores
#' @export
setMethod("apCount",
          signature(fit="TissueSpecAntiProfile",
                    expr="matrix"), .countTissSpec)


.succify <- function(e, meds, mads, cutoff) abs(e-meds)/mads>cutoff
