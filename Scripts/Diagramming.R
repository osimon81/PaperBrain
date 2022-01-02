library(networkD3)

srcAND <- c("Aa (In)", "Ba (In)", "Ca (In)",
            "(1a)+", "(2a)+", "(3a)+",
            "(1a)+", "(2a)+", "(3a)+",
            "(4a)+", "(4a)+", "(6a)-",
            "(7a)-", "(5a)+")
targetAND <- c("(1a)+", "(2a)+", "(3a)+",
               "(4a)+", "(4a)+", "(4a)+",
               "(5a)+", "(5a)+", "(5a)+",
               "(6a)-", "(7a)-", "(5a)+",
               "(5a)+", "Da (Out)")

srcLOOP <- c("Al (In)",
             "(1l)+", "(2l)+", "(3l)+", "(4l)+",
             "(3l)+")

targetLOOP <- c("(1l)+",
                "(2l)+", "(3l)+", "(4l)+", "(1l)+",
                "Bl (Out)")

# Plot "AND" Network

netAND <- function() {
  
  andNetwork <- data.frame(srcAND, targetAND)
  
  simpleNetwork(andNetwork, fontSize = 14,
                linkDistance = 100, zoom = TRUE)
}

# Plot "LOOP" Network

netLoop <- function() {
  
  loopNetwork <- data.frame(srcLOOP, targetLOOP)
  
  simpleNetwork(loopNetwork, fontSize = 14,
                linkDistance = 100, zoom = TRUE)
}

netAndLoop <- function() {
  srcBOTH <- c(srcAND, srcLOOP)
  targetBOTH <- c(targetAND, targetLOOP)
  
  dualComponentNetwork <- data.frame(srcBOTH, targetBOTH)
  
  simpleNetwork(dualComponentNetwork, fontSize = 14,
                linkDistance = 100, zoom = TRUE)
}


