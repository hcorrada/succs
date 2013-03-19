#' Statistics used to build anti-profiles
#' 
#' This class stores statistics required to build anti-profiles. 
#' Objects of this class should be built using the \code{\link{apStats}} function. 
#' To build anti-profiles from objects of this class, use the \code{\link{buildAntiProfile}} function.
#' 
#' @section FIXME:
#' ## usage
#' ## Accessors
#' getProbeStats(object)
#' 
#' @seealso \code{\link{apStats}} to construct objects of this class, \code{\link{buildAntiProfile}} to build anti-profiles from objects of this class.
#' 
#' @name AntiProfileStats-class
#' @rdname antiprofilestats-class
#' @author Hector Corrada Bravo \email{hcorrada@@gmail.com}
#' @examples
#' if (require(antiProfilesData)) { 
#'    data(apColonData)
#'    colonStats = apStats(exprs(apColonData), pData(apColonData)$Status)
#'    show(getProbeStats(colonStats))
#'  }
#' 
#' @export
setClass("AntiProfileStats",
         representation=representation(probes="data.frame",
           normalTissues="character",
           cancerTissues="character",
           call="call",
           sd0="matrix",
           sd1="matrix",
           p0="matrix",
           p1="matrix",
           tMeds="matrix",
           tMads="matrix",
           tProps0="matrix",
           tProps1="matrix"))

#' A gene expression anti-profile
#' 
#' This class encapsulates anti-profiles. 
#' Objects of this class should be built from \code{\linkS4class{AntiProfileStats}} objects using the \code{\link{buildAntiProfile}} method.
#' Anti-profile scores can be computed for new samples using the \code{\link{apCount}} method.
#' 
#' @section FIXME:
#' ## usage
#' ## Accessors
#' 
#' getProbesetIds(object)
#' getNormalRegions(object)
#' 
#' @seealso \code{\linkS4class{AntiProfileStats}} for the class of objects from which anti-profiles are built. \cite{\link{buildAntiProfile}}
#' for the method used to construct objects of this class. \code{\link{apCount}} for the function used to calculate anti-profile scores from
#' objects of this class.
#' 
#' @author Hector Corrada Bravo \email{hcorrada@@gmail.com}
#' @examples
#'   if (require(antiProfilesData)) {
#'     data(apColonData)
#'     colonStats=apStats(exprs(apColonData), pData(apColonData)$Status)
#'     colonAP = buildAntiProfile(colonStats, tissueSpec=FALSE, sigsize=10)
#'     show(colonAP)
#'     
#'     head(getProbesetIds(colonAP))
#'     head(getNormalRegions(colonAP))
#'   }
#' @name AntiProfile-class
#' @rdname antiprofile-class
#' 
#' @export
setClass("AntiProfile",
         representation=representation(probes="character",
           meds0="numeric",
           mads0="numeric",
           cutoff="numeric",
           filterFunc="character"))

#' A gene expression anti-profile using tissue-specific regions
#'
#' This class encapsulates anti-profiles with tissue-specific normal expression regions. 
#' Objects of this class should be built from \code{\linkS4class{AntiProfileStats}} objects using the \code{\link{buildAntiProfile}} method.
#' Anti-profile scores can be computed for new samples using the \code{\link{apCount}} method.
#' 
#' @section FIXME:
#' ## usage
#' ## Accessors
#' 
#' getProbesetIds(object)
#' getNormalRegions(object)
#' getNormalTissueRegions(object)
#' 
#'   @seealso \code{\linkS4class{AntiProfileStats}} for the class of objects from which anti-profiles are built. \cite{\link{buildAntiProfile}}
#'   for the method used to construct objects of this class. \code{\link{apCount}} for the function used to calculate anti-profile scores from
#'   objects of this class.
#'                                                                                                                                                                                                                                                                                                                                                                                                                                                                              #' @author Hector Corrada Bravo \email{hcorrada@@gmail.com}
#' @examples 
#'   if (require(antiProfilesData)) {
#'     data(apColonData)
#'     # fake tissues
#'     tissue=rep(c("colon","lung"), len=length(sampleNames(apColonData)))
#'     tissStats=apStats(exprs(apColonData), pData(apColonData)$Status, tiss=tissue, minL=3)
#'     tissAP=buildAntiProfile(tissStats, sigsize=10)
#'     show(tissAP)
#'     
#'     head(getProbesetIds(tissAP))
#'     head(getNormalRegions(tissAP))
#'     head(getNormalTissueRegions(tissAP))
#'   }   
#' @name TissueSpecAntiProfile-class
#' @rdname tissuespecantiprofile-class
#' @export
setClass("TissueSpecAntiProfile",
         contains="AntiProfile",
         representation=representation(tMeds="matrix",
           tMads="matrix",
           theTiss="list"))
