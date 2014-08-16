corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  
  out <- numeric()
  files <- list.files(directory)
  for (file in files) {
    df <- read.csv (paste(directory, "/", file, sep = ""))
    if (nrow(na.omit(df)) > threshold) {
      dfc <- na.omit (df)
      sulfate <- dfc[, "sulfate"]
      nitrate <- dfc[, "nitrate"]
      out <- c(out, cor(sulfate, nitrate))
    }
  }
  
  out
}