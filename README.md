plinkTools
==========

An R package that provides miscellaneous functions to supplement the command line tool [plink](http://pngu.mgh.harvard.edu/~purcell/plink/).

# Combining the output from multiple association studies
When running an association test in plink with multiple phenotypes, e.g.:

    plink --bfile mydata --assoc --pheno bigpheno.raw --all-pheno

plink will create an output file for each phenotype.

The function `combineAssocFiles` will combine all of these results files into one, prepending an additional column denoting the phenotype.
