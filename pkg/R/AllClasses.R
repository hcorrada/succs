#' Statistics used to build anti-profiles
#' 
#' This class stores statistics required to build anti-profiles. Objects of this class should be created
#' using the apStats function.
#' 
#' @section Slots: \describe{
#'    \item{\code{probes}:}{A data.frame with probe statistics: Columns are the following
#'      \describe{
#'        \item{\code{affyid}:}{Affymetrix probeset id}
#'        \item{\code{SD0}:}{Normal expression standard deviation (aggregated over tissue types)}
#'        \item{\code{SD1}:}{Cancer expression standard deviation (aggregated over tumor types)}
#'        \item{\code{stat}:}{The log2-variance ratio statistic}
#'        \item{\code{meds0}:}{Median normal expression (aggregated over tissue types)}
#'        \item{\code{mads0}:}{Median absolute deviation of normal expression (aggregate over tissue types)}        
#'      }
#'    }
#'    \item{\code{normalTissues}:}{Names of normal tissue types included in the dataset}
#'    \item{\code{cancerTissues}:}{Names of cancer tumor types included in the dataset}
#'    \item{\code{call}:}{The call to the succStats function}
#'    \item{\code{sd0}:}{Normal standard deviations for each tissue type}
#'    \item{\code{sd1}:}{Cancer standard deviations for each tumor type}
#'    \item{\code{p0}:}{Proportion of samples expressed for each normal tissue type}
#'    \item{\code{p1}:}{Proportion of samples expressed for each tumor type}
#'    \item{\code{tMeds}:}{Median normal expression for each tissue type}
#'    \item{\code{tMads}:}{Median absolute deviation of normal expression for each tissue type}
#'    \item{\code{tProps0}:}{Proportion of normal samples outside normal region of expression for each tissue type}
#'    \item{\code{tProps1}:}{Proportion of cancer samples outside normal region of expression for each tumor type}
#'  }
#'
#' @author Hector Corrada Bravo \email{hcorrada@@gmail.com}
#' @examples
#'   if (require(antiProfilesData)) {
#'     data(apColonData)
#'     colonStats = apStats(exprs(apColonData), pData(apColonData)$Status)
#'     show(colonStats)
#'     show(probes(colonStats))
#'   }
#' @name AntiProfileStats-class
#' @rdname antiprofilestats-class
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
