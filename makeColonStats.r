expDir="~/barcode/exps/succs/rafaSuccs"
load(file.path(expDir,"rdas/gpl570.rda"))


ii=tab$ExperimentID %in% c("GSE8671","GSE4183") & goodIndex & !(is.na(tab$Status))
colonTab=tab[ii,]
colonExpr=zscores[,ii]

load(file.path(expDir,"rdas/anno.rda"))

# look at probesets in blocks
blockIds=subset(anno,inBlock)$affyid
blockExpr=colonExpr[blockIds,]

rownames(colonTab)=colonTab$DB_ID
colnames(blockExpr)=colonTab$DB_ID

require(Biobase)
colonData=ExpressionSet(assayData=blockExpr,phenoData=AnnotatedDataFrame(colonTab))

save(colonData, file="pkg/data/colonData.rda")



