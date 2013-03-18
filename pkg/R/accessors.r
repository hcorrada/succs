#' @section Accessors: In the following code \code{object} is a \code{AntiProfileStats} object. \describe{
#'   \item{\code{getProbeStats}:}{Gets probeset statistics. A \code{data.frame} with columns
#'     \describe{
#'        \item{\code{affyid}:}{Affymetrix probeset id}
#'        \item{\code{SD0}:}{Normal expression standard deviation (aggregated over tissue types)}
#'        \item{\code{SD1}:}{Cancer expression standard deviation (aggregated over tumor types)}
#'        \item{\code{stat}:}{The log2-variance ratio statistic}
#'        \item{\code{meds0}:}{Median normal expression (aggregated over tissue types)}
#'        \item{\code{mads0}:}{Median absolute deviation of normal expression (aggregate over tissue types)}        
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
