\name{combineAssocFiles}
\alias{combineAssocFiles}
\title{Combine Multiple Association tests into one file}
\usage{
combineAssocFiles(out, dir = "./", prepend = "plink.",
  extension = ".assoc.linear", sep = "\\t", removeFiles = TRUE)
}
\arguments{
  \item{out}{The output file to store the combined results
  in.}

  \item{dir}{Directory the results of \code{plink} are
  stored in.}

  \item{prepend}{The part of the filename before the
  phenotype}

  \item{extension}{The file extension of the results to
  combine. Common extensions include ".assoc.linear",
  ".assoc.log", and ".qassoc".}

  \item{sep}{The separator to use between fields in the
  resulting output file.}

  \item{removeFiles}{logical; If \code{TRUE} removes all
  the individual association files once their results have
  been combined.}
}
\description{
When running association tests for multiple phenotypes,
\code{plink} creates one file for each phenotype. This
function combines them into one file, and puts the output
into a nicely separated file.
}

