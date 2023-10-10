# Jeu de données QSAR biodegradation
# 
# description : https://archive-beta.ics.uci.edu/ml/datasets/qsar+biodegradation

# Configuration de l'environnement
SciViews::R(lang = "fr")


# Importation du jeu de données -------------------------------------------

cols <- c(
  "SpMax_L", "J_Dz(e)", "nHM", "F01[N-N]", "F04[C-N]",
  "NssssC", "nCb-", "C%", "nCp", "nO",
  "F03[C-N]", "SdssC", "HyWi_B(m)", "LOC", "SM6_L",
  "F03[C-O]", "Me", "Mi", "nN-N", "nArNO2",
  "nCRX3", "SpPosA_B(p)", "nCIR", "B01[C-Br]", "B03[C-Cl]",
  "N-073", "SpMax_A", "Psi_i_1d", "B04[C-Br]", "SdO",
  "TI2_L", "nCrt", "C-026", "F02[C-N]", "nHDon",
  "SpMax_B(m)", "Psi_i_A", "nN", "SM6_B(m)", "nArCOOR",
  "nX", "class"
)

biodeg <- readr::read_delim(
  "https://archive.ics.uci.edu/ml/machine-learning-databases/00254/biodeg.csv", 
  col_names = cols, delim = ";")


# Remaniement du tableau --------------------------------------------------

biodeg <- janitor::clean_names(biodeg)
biodeg$class <- as.factor(biodeg$class)


# Sauvegarde la version finale et nettoyage l'environnement ---------------

write$rds(biodeg, "data/biodegradation.rds", compress = "xz")
rm(cols, biodeg)
