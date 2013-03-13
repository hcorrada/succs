#' @rdname buildAntiProfile-methods
#' @aliases buildAntiProfile,AntiProfileStats-method
setMethod("buildAntiProfile", signature(stats="AntiProfileStats"),
          function(stats, tissueSpec=TRUE, tissueFilter=FALSE, sigsize=NULL, cutoff=5, statCutoff=1, ...)
          {
            isHyperVar <- stats@probes$stat>statCutoff

            if (tissueSpec)
              return(.tissueSpecAP(stats, isHyperVar, cutoff, sigsize, ...))
            
            ii=isHyperVar
            if (tissueFilter) {
              ii <- ii & .apTissueSpec(stats, ...)
            }

            stopifnot(sum(ii)>0)
            if (!is.null(sigsize) && sum(ii)>sigsize) {
              ii <- which(ii)[1:sigsize]
            }

            new("AntiProfile",
                probes=stats@probes$affyid[ii],
                meds0=stats@probes$meds0[ii],
                mads0=stats@probes$mads0[ii],
                cutoff=cutoff)
          })

.apTissueSpec <- function(stats, propCutoff=.95, nTiss=3)
  {
    N10 <- rowSums(stats@p0>=propCutoff)
    N10<=nTiss
  }

.tissueSpecAP <- function(stats, isHyperVar, cutoff, sigsize, propCutoff=.95, nTiss=3)
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

    new("TissueSpecAntiProfile",
        probes=stats@probes$affyid[ii],
        meds0=stats@probes$meds0[ii],
        mads0=stats@probes$mads0[ii],
        cutoff=5,
        tMeds=stats@tMeds[ii,],
        tMads=stats@tMads[ii,],
        theTiss=theTiss[ii])
  }
