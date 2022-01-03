#library(readr)
#library(networkD3)

instructions <- function() {
  print("Hello! Welcome to version 1 of the concerted MicroNetwork construction interface.")
  print("This project is essentially a pipeline which allows for fluid force-directed network construction.")
  print("To create MicroNetworks, use the following lines as syntax examples:")
  print("AND(n,n): create an AND MicroNetwork with any number of input neurons n and any output neurons n.")
  print("NOT(3, 1): create a NOT MicroNetwork with 3 input neurons and 1 output neuron")
}

constructLinearInterface <- function() {
  instructions()
  circuitList <- c()
  
  src <- c()
  target <- c()
  
  id <- 1
  editMode <- TRUE
  while (editMode == TRUE) {
    
    selectedNet <- readline(prompt = "Name the MicroNetwork you would like to add: ")
    if (grepl("AND", selectedNet) == TRUE) {
      circuitList <- c(circuitList, selectedNet)
      identifier <- as.character(id)
      
      in_out_count <- strsplit(selectedNet, ",")
      inputs <- as.numeric(parse_number(in_out_count[[1]][1]))
      outputs <- as.numeric(parse_number(in_out_count[[1]][2]))
      print("MicroNetwork Type: And") # Unique feedback for AND MicroNetworks
      print(paste("MicroNetwork Identifier:", identifier))
      print(paste("MicroNetwork", identifier, "Inputs:", as.character(inputs)))
      print(paste("MicroNetwork", identifier, "Outputs:", as.character(outputs)))
      
      # Assemble AND MicroNetwork neurons here (for the time being, this network only makes computational sense when input number is set to 3)
      
        src <- c(src,
                 
                 paste0(identifier, "(1a)+"),
                 paste0(identifier, "(2a)+"),
                 paste0(identifier, "(3a)+"),
                 paste0(identifier, "(1a)+"),
                 paste0(identifier, "(2a)+"),
                 paste0(identifier, "(3a)+"),
                 paste0(identifier, "(4a)+"),
                 paste0(identifier, "(4a)+"),
                 paste0(identifier, "(6a)-"),
                 paste0(identifier, "(7a)-"))
        
        
        target <- c(target,
                    paste0(identifier, "(4a)+"),
                    paste0(identifier, "(4a)+"),
                    paste0(identifier, "(4a)+"),
                    paste0(identifier, "(5a)+"),
                    paste0(identifier, "(5a)+"),
                    paste0(identifier, "(5a)+"),
                    paste0(identifier, "(6a)-"),
                    paste0(identifier, "(7a)-"),
                    paste0(identifier, "(5a)+"),
                    paste0(identifier, "(5a)+"))
        
        if (as.numeric(identifier) > 1) {
          src <- c(src,
                   paste0(as.character((as.numeric(identifier)-1)), "(Out1)"))
          
          target <- c(target,
                      paste0(identifier, "(In1)"))
        }
        
        
        for (i in 1:inputs) {
          src <- c(src,
                    paste0(identifier, "(In", as.character(i), ")"))
          
          target <- c(target,
                      paste0(identifier, "(", i, "a)+"))
         }
        
        for (i in 1:outputs) {
          src <- c(src,
                   paste0(identifier, "(5a)+"))
          
          target <- c(target,
                      paste0(identifier, "(Out", as.character(i), ")"))
        }
      }
    else if (grepl("LOOP", selectedNet) == TRUE) {
      circuitList <- c(circuitList, selectedNet)
      identifier <- as.character(id)
      
      in_out_count <- strsplit(selectedNet, ",")
      inputs <- parse_number(in_out_count[[1]][1])
      outputs <- parse_number(in_out_count[[1]][2])
      print("MicroNetwork Type: Loop") # Unique feedback for LOOP MicroNetworks
      print(paste("MicroNetwork Identifier:", identifier))
      print(paste("MicroNetwork", identifier, "Inputs:", inputs))
      print(paste("MicroNetwork", identifier, "Outputs:", outputs))
      
      # Assemble LOOP MicroNetwork neurons here:
      
        src <- c(src,
                 paste0(identifier, "(1l)+"),
                 paste0(identifier, "(2l)+"),
                 paste0(identifier, "(3l)+"),
                 paste0(identifier, "(4l)+"))
        
        target <- c(target,
                    paste0(identifier, "(2l)+"),
                    paste0(identifier, "(3l)+"),
                    paste0(identifier, "(4l)+"),
                    paste0(identifier, "(1l)+"))
        
        if(as.numeric(identifier) > 1) {
          src <- c(src,
                   paste0(as.character((as.numeric(identifier)-1)), "(Out", as.character(i), ")"))
          
          target <- c(target,
                      paste0(identifier, "(In1)"))
        }

        for (i in 1:inputs) {
          src <- c(src,
                   paste0(identifier, "(In", as.character(i), ")"))
          
          target <- c(target,
                      paste0(identifier, "(1l)+"))
        }
        
        for (i in 1:outputs) {
          src <- c(src,
                   paste0(identifier, "(3l)+"))
          
          target <- c(target,
                      paste0(identifier, "(Out", as.character(i), ")"))
        }
      }
    else if (grepl("NOT", selectedNet) == TRUE) {
      circuitList <- c(circuitList, selectedNet)
      identifier <- as.character(id)
      
      in_out_count <- strsplit(selectedNet, ",")
      inputs <- parse_number(in_out_count[[1]][1])
      outputs <- parse_number(in_out_count[[1]][2])
      print("MicroNetwork Type: NOT") # Unique feedback for NOT MicroNetworks
      print(paste("MicroNetwork Identifier:", identifier))
      print(paste("MicroNetwork", identifier, "Inputs:", inputs))
      print(paste("MicroNetwork", identifier, "Outputs:", outputs))
      
      # Assemble NOT MicroNetwork neurons here:
      
        src <- c(src,
                 paste0(identifier, "(1n)-"))
        
        target <- c(target,
                    paste0(identifier, "(2n)+"))
      
      if (as.numeric(identifier) > 1) {
        src <- c(src,
                 paste0(as.character((as.numeric(identifier)-1)), "(Out", as.character(i), ")"))
        
        target <- c(target,
                    paste0(identifier, "(In1)"))
      }
      
      for (i in 1:inputs) {
        src <- c(src,
                 paste0(identifier, "(In", as.character(i), ")"))
        
        target <- c(target,
                    paste0(identifier, "(1n)-"))
      }
      
      for (i in 1:outputs) {
        src <- c(src,
                 paste0(identifier, "(2n)+"))
        
        target <- c(target,
                    paste0(identifier, "(Out", as.character(i), ")"))
      }
    }
    else {
      print("You have entered an invalid MicroNetwork type.")
      id <- id - 1
    }
  
    continue <- readline(prompt = "Would you like to add a new MicroNetwork? (Y/N) ")
    
    if (toupper(continue) == "Y") {
      editMode <- TRUE
      id <- id + 1
    }
    else if (toupper(continue) == "N") {
      editMode <- FALSE
    }
    else {
      editMode <- FALSE
    }
  }
  
  networkDF <- data.frame(src, target)
  simpleNetwork(networkDF, fontSize = 14,
                linkDistance = 100, zoom = TRUE)
}




interpretNeuron <- function(id) {
  neuronAttributes <- list()
}