pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  
  # Loop through the ids to compute mean  
  total <- 0
  count <- 0
  for (i in id) {
    fileNumber <- formatC(i, width = 3, format = "d", flag = "0")
    fileName <- paste(directory, "/", fileNumber, ".csv", sep="")
    df <- read.csv (fileName)
    total <- total + sum (df[, pollutant], na.rm = TRUE)
    count <- count + sum (!is.na(df[, pollutant]))
  }
  
  round (total/count, 3)
}

