#' Loads in genotype data from a PED and MAP file.
#' 
#' @param fileprefix prefix of the PED and MAP file to load.
#' @return A matrix of genotypes in 0,1,2 coding
#' @export
loadPed <- function(fileprefix) {
  pedFile <- paste0(fileprefix, ".ped")
  mapFile <- paste0(fileprefix, ".map")
  
  ped <- read.table(pedFile, header=FALSE, sep=" ")
  map <- read.table(mapFile, header=FALSE)
  
  genotypes <- matrix(NA, nrow(ped), nrow(map), 
                      dimnames=list(ped[,2], map[,2]))
  
  for (i in 1:ncol(genotypes)) {
    genotypes[,i] <- recodeAlleles(ped[,i*2-1+6], ped[,i*2+6])
  }
  
  genotypes
}

recodeAlleles <- Vectorize(function(a, b) {
  switch(paste(a, b),
    "0 0" = NA,
    "1 1" = 0,
    "2 1" = 1,
    "1 2" = 1,
    "2 2" = 2,
    stop("Invalid coding of PED file.")
  )
},  c('a', 'b'))