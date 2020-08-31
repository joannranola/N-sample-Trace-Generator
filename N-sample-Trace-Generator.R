# Code name: N-sample-Trace-Generator
# Version: 0
# Date: August 31, 2020
# Developer: Jo Ann Ranola

# Clean the database.
rm(list = ls())

# Read the csv file.
T1 <- read.csv(file = "~/R/N-sample-Trace-Generator/Input/Trace.csv", stringsAsFactors = FALSE)

# Count the number of rows and columns. 
numrows <- nrow(T1)
numcols <- ncol(T1)

# Enter the minimum and maximum deviation from the original traces. 
minvalue <- -5
maxvalue <- 5

# Enter the selected months. 
month1 <- 6 # June
month2 <- 8 # August

# Enter the number of samples
samples <- 20

# Create the output folder.
dir.create("~/R/N-sample-Trace-Generator/Output")

# Main code
T2 <- T1[,1:4]
for (i in 1:samples){
  for (j in 5:numcols){
    T3 <- runif(numrows, minvalue, maxvalue)
    T4 <- ifelse(T1[,j] + T3 < 0, 0, T1[,j] + T3)
    T2[,j] <- ifelse((T1$Month == month1)|(T1$Month == month2), T4, T1[,j])
  }
  colnames(T2) <- colnames(T1)
  # Write the files.
  write.csv(T2, file = paste0("~/R/N-sample-Trace-Generator/Output/Trace_",i,".csv"), row.names = FALSE)
}