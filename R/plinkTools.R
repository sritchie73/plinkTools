#' @name plinkTools-package
#' @aliases plinkTools-package plinkTools
#' @docType package
#' 
#' @title Tools for processing plink data
#' @description
#' This R package provides supplementary tools for dealing with the output from
#' the bioinformatics program, \code{plink}. See: 
#' \link{http://pngu.mgh.harvard.edu/~purcell/plink}
#' 
#' @details
#' \tabular{ll}{
#'  Package: \tab plinkTools\cr
#'  Type: \tab Package\cr
#'  Version: \tab 1.0\cr
#'  Date: \tab 2014-02-19\cr
#'  License: \tab GPL (>= 2)\cr
#' }
#' See \code{\link{combineAssocFiles}}
#' 
#' @author 
#' Scott Ritchie \email{sritchie73@@gmail.com}
#' 
#' @rdname plinkTools-package
#' 
NULL

#' Combine Multiple Association tests into one file
#' 
#' When running association tests for multiple phenotypes, \code{plink} creates
#' one file for each phenotype. This function combines them into one file, and
#' puts the output into a nicely separated file.
#' 
#' @param out The output file to store the combined results in.
#' @param dir Directory the results of \code{plink} are stored in.
#' @param prepend The part of the filename before the phenotype
#' @param extension The file extension of the results to combine. Common 
#'  extensions include ".assoc.linear", ".assoc.log", and ".qassoc".
#' @param sep The separator to use between fields in the resulting output file.
#' @param removeFiles logical; If \code{TRUE} removes all the individual 
#'  association files once their results have been combined.
#' 
#' @export
combineAssocFiles <- function(out, dir  = "./", 
                              prepend   = "plink.",
                              extension = ".assoc.linear", 
                              sep       = "\t",
                              removeFiles = FALSE) {
  files <- list.files(path=dir, pattern=paste0(extension, "$"))
  fields <- strsplit(readLines(file.path(dir, files[1]), 1), "\\s+")[[1]]
  fields <- fields[fields != ""]
  
  cat("PHEN\t", paste(fields, collapse="\t"), "\n", sep="", file=out)
  
  for (ff in files) {
    phen <- gsub(paste(prepend, extension, sep="|"), "", ff)
    lines <- readLines(file.path(dir, ff))[-1] # ignore header
    if (length(lines) == 0 ) { next } # skip to next loop if there are no SNPs
    fields <- strsplit(lines, "\\s+")
    fields <- lapply(fields, function(x) { c(phen, x[x != ""]) })
    newLines <- lapply(fields, paste, collapse="\t")
    cat(paste(newLines, collapse="\n"), "\n", file=out, append=TRUE)
  }
  if (removeFiles) {
    sapply(paste("rm", file.path(dir, files)), system)
  }
}

#' Calculate Minor Allele Frequency from dosage levels
#' 
#' Useful for calculating the MAF for subsets of individuals
#' 
#' @param x vector of dosages as given by `loadPed`.
#' @return the frequency of a minor allele in your vector.
#' @export
maf_from_dosage <- function(x) {
  dosage_count <- table(x)
  (dosage_count["1"] + 2*dosage_count["2"]) / (2 * length(x))
}