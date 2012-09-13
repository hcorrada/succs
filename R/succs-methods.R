#' Create an anti-profile from a SuccsStats object
#' 
#' This function creates anti-profiles using statistics stored in a SuccsStats object
#' 
#' @param stats an object of class SuccsStats as produced by the succStats function
#' @param tissueSpec use tissue-specific regions of normal expression 
#' @param tissueFilter use only tissue-specific genes in the anti-profile
#' @param sigsize desired size of signature, if NULL, computed from statCutoff
#' @param cutoff median absolute deviation multiplier used to define normal regions of expression
#' @param statCutoff cutoff used to include probesets in anti-profile
#' @return an object of class SuccsSig or SuccsTissueSig depending on the tissueSpec argument
#' 
#' @examples 
#' show(colonStats)
#' # create an anti-profile, ignoring tissue-specificity of probesets, with 10 probesets
#' ap = succs(colonStats, tissueSpec=FALSE, sigsize=10)
#'   
#' @export
setMethod("succs", signature(stats="SuccsStats"),
          function(stats, tissueSpec=TRUE, tissueFilter=FALSE, sigsize=NULL, cutoff=5, statCutoff=1, ...)
          {
            isHyperVar <- stats@probes$stat>statCutoff

            if (tissueSpec)
              return(.succsTissueSig(stats, isHyperVar, cutoff, sigsize, ...))
            
            ii=isHyperVar
            if (tissueFilter) {
              ii <- ii & .succsTissueSpec(stats, ...)
            }

            stopifnot(sum(ii)>0)
            if (!is.null(sigsize) && sum(ii)>sigsize) {
              ii <- which(ii)[1:sigsize]
            }

            new("SuccsSig",
                probes=stats@probes$affyid[ii],
                meds0=stats@probes$meds0[ii],
                mads0=stats@probes$mads0[ii],
                cutoff=cutoff)
          })

.succsTissueSpec <- function(stats, propCutoff=.95, nTiss=3)
  {
    N10 <- rowSums(stats@p0>=propCutoff)
    N10<=nTiss
  }

.succsTissueSig <- function(stats, isHyperVar, cutoff, sigsize, propCutoff=.95, nTiss=3)
  {
    xx <- stats@p0>=propCutoff
    theTiss <- apply(xx,1,which)
    N10 <- sapply(theTiss,length)
    isTissueSpec <- N10<=nTiss

    ii <- isHyperVar & isTissueSpec
    stopifnot(sum(ii)>0)

    if (!is.null(sigsize) && sum(ii)>sigsize) {
      ii <- which(ii)[1:sigsize]
    }

    new("SuccsTissueSig",
        probes=stats@probes$affyid[ii],
        meds0=stats@probes$meds0[ii],
        mads0=stats@probes$mads0[ii],
        cutoff=5,
        tMeds=stats@tMeds[ii,],
        tMads=stats@tMads[ii,],
        theTiss=theTiss[ii])
  }
