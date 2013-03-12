setMethod("show",
          signature(object="AntiProfileStats"),
          function(object) {
            cat("AntiProfileStats object on",nrow(object@probes),"probes\n")
            cat("built from",length(object@normalTissues),"normal tissues\n")
            .printHead(object@normalTissues)
            cat("and", length(object@cancerTissues), "cancers types\n")
            .printHead(object@cancerTissues)
            cat("Hypervariability stat:\n")
            show(summary(object@probes$stat))
          })

setMethod("show",
          signature(object="AntiProfile"),
          function(object) {
            cat("AntiProfile object with", length(object@probes),"probes\n")
            cat("Normal medians\n")
            print(summary(object@meds0))
            cat("Using cutoff",object@cutoff,"\n")
          })

setMethod("show",
          signature(object="TissueSpecAntiProfile"),
          function(object) {
            cat("TissueSpecAntiProfile object with", length(object@probes), "probes\n")
            cat("Normal medians\n")
            print(summary(object@meds0))
            cat("Number of tissues\n")
            print(table(sapply(object@theTiss,length)))
            cat("Using cutoff",object@cutoff,"\n")
          })

.printHead <- function(x)
  {
    n <- length(x)
    if (n>20) {
      print(x[1:5])
      cat(n-5, "more elements ...\n")
    } else {
      print(x)
    }
  }
