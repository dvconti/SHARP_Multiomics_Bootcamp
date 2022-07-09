# R script to install all packages needed for workshop

# R packages
if (!requireNamespace("knitr", quietly = TRUE)) install.packages("knitr")
if (!requireNamespace("reshape2", quietly = TRUE)) install.packages("reshape2")
if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")
if (!requireNamespace("epiR", quietly = TRUE)) install.packages("epiR")
if (!requireNamespace("summarytools", quietly = TRUE)) install.packages("summarytools")
if (!requireNamespace("tidyverse", quietly = TRUE)) install.packages("tidyverse")
if (!requireNamespace("glmnet", quietly = TRUE)) install.packages("glmnet")
if (!requireNamespace("gap", quietly = TRUE)) install.packages("gap")
if (!requireNamespace("factoextra", quietly = TRUE)) install.packages("factoextra")
if (!requireNamespace("gplots", quietly = TRUE)) install.packages("gplots")
if (!requireNamespace("UpSetR", quietly = TRUE)) install.packages("UpSetR")
if (!requireNamespace("pls", quietly = TRUE)) install.packages("pls")
if (!requireNamespace("corrplot", quietly = TRUE)) install.packages("corrplot")
if (!requireNamespace("RColorBrewer", quietly = TRUE)) install.packages("RColorBrewer")
if (!requireNamespace("BAS", quietly = TRUE)) install.packages("BAS")
if (!requireNamespace("mvtnorm", quietly = TRUE)) install.packages("mvtnorm")
if (!requireNamespace("MASS", quietly = TRUE)) install.packages("MASS")
if (!requireNamespace("here", quietly = TRUE)) install.packages("here")

# Bioconductor packages
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("MultiAssayExperiment")
BiocManager::install("Biobase")

