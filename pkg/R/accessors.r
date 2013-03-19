# Accessors for the AntiProfileStats class
#
#' @section Accessors: In the following code \code{object} is a \code{AntiProfileStats} object. \describe{
#'   \item{\code{getProbeStats}:}{Gets probeset statistics. A \code{data.frame} with columns
#'     \describe{
#'        \item{\code{affyid}:}{Affymetrix probeset id (character)}
#'        \item{\code{SD0}:}{Normal expression standard deviation aggregated over tissue types (numeric)}
#'        \item{\code{SD1}:}{Cancer expression standard deviation aggregated over tumor types (numeric)}
#'        \item{\code{stat}:}{The log2-variance ratio statistic (numeric)}
#'        \item{\code{meds0}:}{Median normal expression aggregated over tissue types (numeric)}
#'        \item{\code{mads0}:}{Median absolute deviation of normal expression aggregate over tissue types (numeric)}        
#'    }
#'  }   
#' }
#' 
#' @param object Object of class \code{\link{AntiProfileStats}}
#' @aliases getProbeStats,AntiProfileStats-method
#' @rdname antiprofilestats-class
#' @export
setMethod(getProbeStats,signature=c(object="AntiProfileStats"),
          function(object) {
            object@probes
          })

# Accessors for the AntiProfile class
#
#' @section Accessors: In the following code \code{object} is a \code{AntiProfile} object. \describe{
#'  \item{\code{getProbesetIds}:}{vector of Affymetrix ids for probesets included in the anti-profile (character)}
#'  \item{\code{getNormalRegions}:}{median and upper boundary of normal expression regions (numeric matrix of dimension s-by-2, where s is the size of the anti-profile)}
#' }
#' 
#' @param object Object of class (or inheriting from) \code{\link{AntiProfile}}
#' @aliases getProbesetIds,AntiProfile-method getNormalRegions,AntiProfile-method
#' @rdname antiprofile-class
#' @export
setMethod(getProbesetIds, signature=c(object="AntiProfile"),
          function(object) {
            object@probes
          })

#' @export
setMethod(getNormalRegions, signature=c(object="AntiProfile"),
          function(object) {
            out=cbind(object@meds0, object@cutoff * object@mads0)
            dimnames(out)=list(object@probes, c("median","upperBound"))
            out
          })


# Accesors for the TissueSpecAntiProfile class (some inherited from AntiProfile)
#
#' @section Accessors: In the following code \code{object} is a \code{TissueSpecAntiProfile} object. \describe{
#'  \item{\code{getProbesetIds}:}{vector of Affymetrix ids for probesets included in the anti-profile (character)}
#'  \item{\code{getNormalRegions}:}{median and upper boundary of normal expression regions (numeric matrix of dimension s-by-2, where s is the size of the anti-profile)}
#'  \item{\code{getNormalTissueRegions}:}{median and upper boundary of normal expression regions (numeric array of dimension s-by-2-by-t, 
#'  where s is the size of the anti-profile, and t the number of normal tissues used in the anti-profile)}
#' }
#' 
#' @param object Object of class \code{\link{TissueSpecAntiProfile}}
#' @aliases getProbesetIds,TissueSpecAntiProfile-method getNormalRegions,TissueSpecAntiProfile-method getNormalTissueRegions,TissueSpecAntiProfile-method
#' @rdname tissuespecantiprofile-class
#' @export
setMethod(getNormalTissueRegions, signature=c(object="TissueSpecAntiProfile"),
          function(object) {
            out=array(NA, dims=c(length(object@probes, 2, ncol(object@tMeds0))))
            for (j in seq(len=ncol(object@tMeds0))) {
              out[,,j]=cbind(object@tMeds0[,j], object@cutoff*object@tMads0[,j])
            }
            dimnames(out)=list(object@probes,c("median","upperBound"),names(object@theTiss))
            out
          })
