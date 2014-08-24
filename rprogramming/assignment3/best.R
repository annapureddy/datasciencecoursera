best <- function(state, outcomeName) {
  # Read the outcome and hospitals data
  outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  # Get outcomes for a given state; throw error if no such state
  outcome <- outcome[outcome[, "State"] == state, ]
  if (nrow(outcome) == 0) {
    stop("invalid state")
  }

  # Determine if the outcome is valid; else throw error
  vec <- c("Hospital.30.Day.Death..Mortality..Rates.from", unlist(strsplit(outcomeName, " ")))
  col <- paste(toupper(substring(vec, 1, 1)), substring(vec, 2), sep = "", collapse = ".")
  if (!col %in% colnames(outcome)) {
    stop("invalid outcome")
  }

  # Get the providers with minimum value for the outcome
  outcomeNumeric <- as.numeric(outcome[, col])
  minValue <- min(outcomeNumeric, na.rm = TRUE)
  providers <- outcome[!is.na(outcomeNumeric) & outcomeNumeric == minValue, ]
  
  # Get the first hospital name in alphabetic order
  providers <- providers[order(providers[,"Hospital.Name"], decreasing = FALSE), ]
  providers[1, "Hospital.Name"]
}
