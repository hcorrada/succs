setClass("SuccsStats",
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


setClass("SuccsSig",
         representation=representation(probes="character",
           meds0="numeric",
           mads0="numeric",
           cutoff="numeric",
           filterFunc="character"))

setClass("SuccsTissueSig",
         contains="SuccsSig",
         representation=representation(tMeds="matrix",
           tMads="matrix",
           theTiss="list"))



