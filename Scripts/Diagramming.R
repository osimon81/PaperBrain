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

andNetwork <- data.frame(srcAND, targetAND)



srcLOOP <- c("Al (In)",
             "(1l)+", "(2l)+", "(3l)+", "(4l)+",
             "(3l)+")

targetLOOP <- c("(1l)+",
                "(2l)+", "(3l)+", "(4l)+", "(1l)+",
                "Bl (Out)")

loopNetwork <- data.frame(srcLOOP, targetLOOP)



srcLOOPv1 <- c("Al (In)",
               "(1l)+", "(2l)+", "(3l)+", "(4l)+",
               "(3l)+", "(2l)+", "(5l)-")

targetLOOPv1 <- c("(1l)+",
                  "(2l)+", "(3l)+", "(4l)+", "(1l)+",
                  "Bl (Out)", "(5l)-", "(4l)+")

loopNetworkv1 <- data.frame(srcLOOPv1, targetLOOPv1)


# Plot "AND" Network

micronetAND <- function() {
  simpleNetwork(andNetwork, fontSize = 14,
                linkDistance = 100, zoom = TRUE)
}

# Plot "LOOP" Network

micronetLoop <- function() {
  simpleNetwork(loopNetwork, fontSize = 14,
                linkDistance = 100, zoom = TRUE)
}

micronetAndLoop <- function() {
  srcBOTH <- c(srcAND, srcLOOP)
  targetBOTH <- c(targetAND, targetLOOP)
  
  dualComponentNetwork <- data.frame(srcBOTH, targetBOTH)
  
  simpleNetwork(dualComponentNetwork, fontSize = 14,
                linkDistance = 100, zoom = TRUE)
}

micronetLoopv1 <- function() {
  simpleNetwork(loopNetworkv1, fontSize = 14,
                linkDistance = 100, zoom = TRUE)
}

micronetLoopv1()




