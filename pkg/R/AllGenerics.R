#' @export
setGeneric("getProbeStats",
           function(object) standardGeneric("getProbeStats"),
           signature=c("object"))

#' @export
setGeneric("getProbesetIds",
           function(object) standardGeneric("getProbesetIds"),
           signature=c("object"))

#' @export
setGeneric("getNormalRegions",
           function(object) standardGeneric("getNormalRegions"),
           signature=c("object"))

#' @export
setGeneric("getNormalTissueRegions",
           function(object) standardGeneric("getNormalTissueRegions"),
           signature=c("object"))

#' Create an anti-profile from a AntiProfileStats object
#' 
#' This function creates anti-profile using statistics stored in a AntiProfileStats object
#' 
#' @param stats an object of class AntiProfileStats as produced by the apStats function
#' @param tissueSpec use tissue-specific regions of normal expression 
#' @param tissueFilter use only tissue-specific genes in the anti-profile
#' @param sigsize desired size of signature, if NULL, computed from statCutoff
#' @param cutoff median absolute deviation multiplier used to define normal regions of expression
#' @param statCutoff cutoff used to include probesets in anti-profile
#' @return an object of class AntiProfilesSig or AntiProfilesTissueSig depending on the tissueSpec argument
#' 
#' @examples 
#' if (require(antiProfilesData)) {
#'   # create an anti-profile, ignoring tissue-specificity of probesets, with 10 probesets
#'   data(apColonData)
#'   colonStats = apStats(exprs(apColonData), pData(apColonData)$Status)
#'   ap = buildAntiProfile(colonStats, tissueSpec=FALSE, sigsize=10)
#' } 
#' 
#' @author Hector Corrada Bravo \email{hcorrada@@gmail.com}
#'   
#' @export
#' @docType methods
#' @rdname buildAntiProfile-methods
setGeneric("buildAntiProfile",
           function(stats, tissueSpec=TRUE, ...) standardGeneric("buildAntiProfile"),
           signature=c("stats"))

#' Obtain the anti-profile score for a set of samples
#' 
#' This function applies the given anti-profile to a new set of samples. Rownames in the expression matrix
#' are used to match probenames in the AntiProfile object.
#' 
#' @param fit an object of class AntiProfile as produced by the buildAntiProfile method
#' @param expr a matrix of gene expression, rownames are used as identifiers
#' @return a numeric vector of anti-profile scores
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
#'     counts =apCount(ap, exprs(apColonData))
#'  }
#'  
#' @author Hector Corrada Bravo \email{hcorrada@@gmail.com}
#' 
#' @export  
#' @docType methods
#' @rdname apCount-methods
setGeneric("apCount",
           function(fit, expr, ...) standardGeneric("apCount"),
           signature=c("fit", "expr"))

#' Reorder an AntiProfileStats object
#' 
#' Reorders given AntiProfileStats object using provided ordering o
#' 
#'
#' @param stats An object of class AntiProfileStats
#' @param o A numeric vector giving new probe ordering
#' @return A reordered AntiProfileStats object
#' 
#' @examples 
#' if (require(antiProfilesData)) {
#'   data(apColonData)
#'   colonStats = apStats(exprs(apColonData), pData(apColonData)$Status)
#'   o = sample(seq(len=nrow(slot(colonStats,"probes"))))
#'   newStats = apReorder(colonStats, o)
#' } 
#' 
#' @author Hector Corrada Bravo \email{hcorrada@@gmail.com}
#' 
#' @export
#' @docType methods
#' @rdname apReorder-methods
setGeneric("apReorder",
           function(stats, o) standardGeneric("apReorder"),
           signature=c("stats","o"))
