#' @rdname apReorder-methods
#' @aliases apReorder,AntiProfileStats,numeric-method
setMethod("apReorder", signature(stats="AntiProfileStats",o="numeric"),
          function(stats, o) {
            new("AntiProfileStats",
                probes=stats@probes[o,],
                normalTissues=stats@normalTissues,
                cancerTissues=stats@cancerTissues,
                call=stats@call,
                sd0=stats@sd0[o,,drop=FALSE],
                sd1=stats@sd1[o,,drop=FALSE],
                p0=stats@p0[o,,drop=FALSE],
                p1=stats@p1[o,,drop=FALSE],
                tMeds=stats@tMeds[o,,drop=FALSE],
                tMads=stats@tMads[o,,drop=FALSE],
                tProps0=stats@tProps0[o,,drop=FALSE],
                tProps1=stats@tProps1[o,,drop=FALSE])
          })
