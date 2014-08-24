rankhospital <- function(state, outcome, num = "best") {
  # Read the care measures file
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  # Filter by state
  data <- data[data[, "State"] == state, ]
  if (nrow(data) == 0) {
    stop("invalid state")
  }
  
  # Get the column of interest
  vec <- c("Hospital.30.Day.Death..Mortality..Rates.from", unlist(strsplit(outcome, " ")))
  col <- paste(toupper(substring(vec, 1, 1)), substring(vec, 2), sep = "", collapse = ".")
  if (!col %in% colnames(data)) {
    stop("invalid outcome")
  }
  
  # Filter by valid outcome values
  data <- data[order(as.numeric(data[, col]), data[, "Hospital.Name"], decreasing = FALSE), ]
  if (num == "best") {
    data[1, "Hospital.Name"]
  }
  else if (num == "worst") {
    data <- data[!is.na(as.numeric(data[, col])), ]
    data[nrow(data), "Hospital.Name"]
  }
  else if (num <= nrow(data)) {
    data[num, "Hospital.Name"]
  }
  else {
    "NA"
  }
}