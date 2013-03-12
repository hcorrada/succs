setGeneric("buildAntiProfile",
           function(stats, tissueSpec=TRUE, ...) standardGeneric("buildAntiProfile"),
           signature=c("stats"))

setGeneric("tissueProps",
           function(stats, e, isNormal, tiss, cutoff, ...) standardGeneric("tissueProps"),
           signature=c("stats","e","isNormal","tiss","cutoff"))

setGeneric("apCount",
           function(fit, expr, ...) standardGeneric("apCount"),
           signature=c("fit", "expr"))

setGeneric("apReorder",
           function(stats, o) standardGeneric("apReorder"),
           signature=c("stats","o"))
