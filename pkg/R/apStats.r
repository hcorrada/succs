#' Compute statistics used to construct antiProfile
#' 
#' This function calculates normal ranges of expressions and variance ratios for all probesets. To create an anti-profile,
#' call buildAntiProfile on the output of this function 
#' 
#' @param e matrix of gene expression, with one column per sample 
#' @param cl vector of normal/cancer indicators as 0/1 
#' @param tiss vector of tissue types for each sample
#' @param minL minimum number of samples of a given tissue/class to compute stats
#' @param cutoff median absolute deviation multiplier used to determine proportion of samples within normal range of expression
#' @param OnCutoff gene expression barcode z-score to determine if a gene is expressed
#' @return An object of class SuccsStats
#' 
#' 
#' @examples
#'  if (require(antiProfilesData)) { 
#'    data(apColonData)
#'    colonStats = apStats(exprs(apColonData), pData(apColonData)$Status)
#'  }
#' 
#' @author Hector Corrada Bravo \email{hcorrada@@gmail.com}
#' @seealso \code{\linkS4class{AntiProfileStats}} for the type of object returned. \code{\link{buildAntiProfile}} to construct anti-profiles
#' with objects returned by this function.
#' 
#' @export
apStats <- function(e, cl, tiss=NULL, minL=10, cutoff=5, OnCutoff=2.54)
  {
    message("Getting sample indices")
    cIndex0=which(cl==0)
    cIndex1=which(cl==1)

    if (!is.null(tiss)) {
      tIndexes0=split(cIndex0,tiss[cIndex0])
      tIndexes1=split(cIndex1,tiss[cIndex1])
    } else {
      tIndexes0=list(nullTiss=cIndex0)
      tIndexes1=list(nullTiss=cIndex1)
    }

    L0=sapply(tIndexes0,length)
    L1=sapply(tIndexes1,length)

    if (all(L0<minL) || all(L1<minL))
      stop("Not enough samples")

    message("Computing sds")
    sd0=sapply(tIndexes0[L0>=minL],function(ind) return(matrixStats::rowSds(e[,ind])))
    sd1=sapply(tIndexes1[L1>=minL],function(ind) return(matrixStats::rowSds(e[,ind])))

    SD0=rowMeans(sd0) ##im using mean but we could try median
    SD1=rowMeans(sd1) 
    stat=log2(SD1/SD0) ##the statistic 

    message("Computing ranges")
    tMeds=sapply(tIndexes0[L0>=minL], function(ind) matrixStats::rowMedians(e[,ind]))
    tMads=sapply(seq_along(tIndexes0[L0>=minL]), function(i) matrixStats::rowMads(e[,tIndexes0[L0>=minL][[i]]], centers=tMeds[,i]))
    colnames(tMads)=colnames(tMeds)

    meds0=matrixStats::rowMedians(tMeds)
    mads0=matrixStats::rowMedians(tMads)

    message("Computing tissue specificity")
    p0=sapply(tIndexes0[L0>=minL], function(ind) rowMeans(e[,ind]>OnCutoff))
    p1=sapply(tIndexes1[L1>=minL], function(ind) rowMeans(e[,ind]>OnCutoff))

    message("Computing normal tissue outside ranges")
    xx <- .succify(e,meds0,mads0,cutoff)
    tProps0 <- sapply(tIndexes0[L0>=minL], function(ind) rowMeans(xx[,ind]))
    tProps1 <- sapply(tIndexes1[L1>=minL], function(ind) rowMeans(xx[,ind]))
    
    message("Making probe data frame")
    probes=data.frame(affyid=rownames(e),
      SD0=SD0,SD1=SD1,stat=stat,
      meds0=meds0,mads0=mads0,
      stringsAsFactors=FALSE)

    o=order(-probes$stat)
    new("AntiProfileStats",
        probes=probes[o,],
        normalTissues=names(tIndexes0),
        cancerTissues=names(tIndexes1),
        call=match.call(),
        sd0=sd0[o,,drop=FALSE],
        sd1=sd1[o,,drop=FALSE],
        p0=p0[o,,drop=FALSE],
        p1=p1[o,,drop=FALSE],
        tMeds=tMeds[o,,drop=FALSE],
        tMads=tMads[o,,drop=FALSE],
        tProps0=tProps0[o,,drop=FALSE],
        tProps1=tProps1[o,,drop=FALSE])
  }
