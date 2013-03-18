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
#' Objects of this class are used to calculate anti-profile scores for samples.
#' 
#' @section Slots: \describe{
#'     \item{\code{probes}:}{Affymetrix ids of probesets used in anti-profile}
#'     \item{\code{meds0}:}{Median normal expression}
#'     \item{\code{mads0}:}{Median absolute deviation of normal expression}
#'     \item{\code{cutoff}:}{Multiplier in mad used to determine region of normal expression}
#'   }
#'
#' @author Hector Corrada Bravo \email{hcorrada@@gmail.com}
#' @examples
#'   if (require(antiProfilesData)) {
#'     data(apColonData)
#'     colonStats=apStats(exprs(apColonData), pData(apColonData)$Status)
#'     colonAP = buildAntiProfile(colonStats, tissueSpec=FALSE, sigsize=10)
#'     show(colonAP)
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
#' Objects of this class are used to calculate anti-profile scores for samples.
#' 
#' @section Slots: \describe{
#'    \item{\code{tMeds}:}{Median expression for each tissue type}
#'    \item{\code{tMads}:}{Median absolute deviation for each tissue type}
#'    \item{\code{theTiss}:}{List of tissue type names}
#'   }
#' 
#' @author Hector Corrada Bravo \email{hcorrada@@gmail.com}
#' @examples 
#'   if (require(antiProfilesData)) {
#'     data(apColonData)
#'     # fake tissues
#'     tissue=rep(c("colon","lung"), len=length(sampleNames(apColonData)))
#'     tissStats=apStats(exprs(apColonData), pData(apColonData)$Status, tiss=tissue)
#'     tissAP=buildAntiProfile(tissStats, sigsize=10)
#'     show(tissAP)
#'   }   
#' @name TissueSpecAntiProfile-class
#' @rdname tissueSpecAntiprofile-class
#' @export
setClass("TissueSpecAntiProfile",
         contains="AntiProfile",
         representation=representation(tMeds="matrix",
           tMads="matrix",
           theTiss="list"))
