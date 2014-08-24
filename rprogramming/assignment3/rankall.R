rankall <- function(outcome, num = "best") {
  # Read the care measures file 
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  # Construct the column required
  vec <- c("Hospital.30.Day.Death..Mortality..Rates.from", unlist(strsplit(outcome, " ")))
  col <- paste(toupper(substring(vec, 1, 1)), substring(vec, 2), sep = "", collapse = ".")
  if (!col %in% colnames(data)) {
    stop("invalid outcome")
  }
  
  # Sort data by col
  data <- data[order(as.numeric(data[, col]), data[, "Hospital.Name"], decreasing = FALSE), ]
  
  # Split the data per state
  states <- unique(data[, "State"])
  ldf <- list() # List of data frames per state
  lapply(states, function(state) {
    ldf[[state]] <<- data[data[, "State"] == state, ]
  })
  
  # Identify the num element for each state
  out <- data.frame()
  lapply(seq_along(ldf), function(index) {
    state <- names(ldf)[index]
    df <- ldf[[index]]
    rowNum <- nrow(out) + 1
    
    if (num == "best") {
      out <<- rbind(out, df[1, c("Hospital.Name", "State")])
    }
    else if (num == "worst") {
      df <- df[!is.na(as.numeric(df[, col])), ]
      out <<- rbind(out, df[nrow(df), c("Hospital.Name", "State")])
    }
    else if (num > nrow(df)) {
      out <<- rbind(out, c("NA", state))
    }
    else {
      out <<- rbind(out, df[num, c("Hospital.Name", "State")])
    }
    
    row.names(out)[rowNum] <<- state
  })
  
  # Sort output by state
  out <- out[order(out[, "State"], decreasing = FALSE), ]
  colnames(out) <- c("hospital", "state")
  out
}