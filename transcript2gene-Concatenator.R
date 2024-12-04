# Install and load dplyr if not already installed
# #Nota: seleccionar la instalación del binario, no del source (el source requiere compilar)
install.packages("dplyr") # only run if dplyr is not installed
#Correr DESDE AQUI
library(dplyr)

#transformar el archivo de excel en una matriz de datos r
list.files()

data <- read.delim("./counts-LINCs-GSE132177.txt", header = TRUE, sep = "\t")


# Assuming your data frame is named data

result <- data %>%
  group_by(Gene_id) %>%
  summarise(
    Transcript_id = paste(Transcript_id, collapse = " "),  # Concatenate transcript IDs
    Official_Symbol = first(Official_Symbol),  # Use first value for consistent metadata
    Gene_type = first(Gene_type),
    across(AD1_6m:WT3_9m, max)  # retrieves max value for sample columns
  )

# Guardar la tabla en un archivo


write.table(result, "GENcounts-LINCS-GSE132177.tsv", sep = "\t", row.names = FALSE, quote = FALSE)
print(head(result))