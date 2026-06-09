# =====================================================
# MCA + HCPC analysis
# EmotionalizTED Corpus
# =====================================================

# Install packages if needed
# install.packages("readxl")
# install.packages("FactoMineR")
# install.packages("explor")

library(readxl)
library(FactoMineR)
library(explor)

# =====================================================
# Load data
# =====================================================

df <- read_excel(
  "C:/Users/Khushi/Documents/GitHub/LREC2026-EmotionalizTED-Corpus/NEW analysis/combined_Bianca.xlsx"
)

# =====================================================
# Select variables for MCA
# =====================================================

mca_data <- df[, c(
  "Domain",
  "Gender",
  "EN_Attitude_type",
  "adjective"
)]

# Convert all variables to factors
mca_data[] <- lapply(mca_data, as.factor)

# Check structure
str(mca_data)

# =====================================================
# Run MCA
# =====================================================

MCAfac <- MCA(
  mca_data,
  graph = FALSE
)

# Eigenvalues
print(MCAfac$eig)

# =====================================================
# Interactive exploration (Explor)
# =====================================================

explor(MCAfac)

# =====================================================
# HCPC clustering on MCA dimensions
# =====================================================

HCPCres <- HCPC(
  MCAfac,
  nb.clust = -1,   # automatic choice
  graph = TRUE
)

# =====================================================
# Cluster membership
# =====================================================

head(HCPCres$data.clust)

table(HCPCres$data.clust$clust)

# =====================================================
# Variables characterising clusters
# =====================================================

HCPCres$desc.var

# =====================================================
# Individuals characterising clusters
# =====================================================

HCPCres$desc.ind
