complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  out <- data.frame (numeric(), numeric())
  for (i in id) {
    fileNumber <- formatC(i, width = 3, format = "d", flag = "0")
    fileName <- paste(directory, "/", fileNumber, ".csv", sep="")
    df <- read.csv (fileName)
    out <- rbind (out, data.frame(i, nrow(na.omit(df))))
  }
  
  names(out) <- c("id", "nobs")
  out
}