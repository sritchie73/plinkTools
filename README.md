plinkTools
==========

An R package that provides miscellaneous functions to supplement the command line tool [plink](http://pngu.mgh.harvard.edu/~purcell/plink/).

## Installation
These tools are scripted in the statistical programming language [R](http://cran.r-project.org/). To install this package you will also need the `devtools` package installed:

```
library(devtools)
install_github(repo="plinkTools", username="sritchie73")
```

## Combining the output from multiple association studies
When running an association test in plink with multiple phenotypes, e.g.:

    plink --bfile mydata --assoc --pheno bigpheno.raw --all-pheno

plink will create an output file for each phenotype.

The function `combineAssocFiles` will combine all of these results files into one, prepending an additional column denoting the phenotype.
