setGeneric("succs",
           function(stats, tissueSpec=TRUE, ...) standardGeneric("succs"),
           signature=c("stats"))

setGeneric("tissueProps",
           function(stats, e, isNormal, tiss, cutoff, ...) standardGeneric("tissueProps"),
           signature=c("stats","e","isNormal","tiss","cutoff"))

setGeneric("succsCount",
           function(fit, expr, ...) standardGeneric("succsCount"),
           signature=c("fit", "expr"))

setGeneric("succsReorder",
           function(stats, o) standardGeneric("succsReorder"),
           signature=c("stats","o"))
