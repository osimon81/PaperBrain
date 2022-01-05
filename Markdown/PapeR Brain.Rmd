---
title: "PapeR Brain"
author: "Simon Ogundare"
date: "1/2/2022"
output:
  pdf_document:
    toc: yes
  html_document:
    toc: yes
    toc_float: yes
    number_sections: yes
    theme: darkly
editor_options:
  markdown:
    wrap: 72
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# Introduction

Hey there! This is an R Markdown document showcasing one particular use of the `networkd3` package. Here, we use the `simpleNetwork()` package to plot Micro-Networks, used to model biological neural networks in terms of computational functions.

## The Neuron

The graphs you'll see here are a digital iteration of a project I started in mid-2021, called "Paper Brain." I set up basic neuron models on paper which consist of only two actions: 

- A neuron will fire an excitatory pulse when triggered
- A neuron will fire an inhibitory pulse when triggered

Pulses (action potentials) are additive — so, if a neuron A receives 2 inhibitory pulses and 3 excitatory pulses from presynaptic neurons, neuron A will fire. If the same neuron receives 3 excitatory pulses and 3 inhibitory pulses, neuron A will not fire.

Furthermore, with this model, all neuronal connections are assumed to be unidirectional — between a presynaptic neuron and a postsynaptic neuron, a pulse will only ever propagate from presynaptic to postsynaptic neuron.

Evidently, this is an oversimplification for neuronal activity (no clear exploration of how networks change over time, variations in neurotransmitters, or neuromodulation). However, it can be a pretty nifty tool to learn how to explore the grey areas between what we call "neural networks" in a computational perspective, and a biological one.

## Decision-making

To begin, I started by exploring how we make decisions. In the context of code, we can rely on certain structures to give our programs functionality. In effect, the code we use, when we use `if`, `ifelse`, or `else` statements, gives our programs autonomous "decision-making" capacity (if only in any basic sense).

### Fight OR Flight

The stress response — the triggered release of stress hormones to respond to a potentially threatened environment — can be triggered by both external and internal changes in an environment or cognition, respectively. However, for simplicity, let's consider some environmental factors that might contribute to such a response:

- Sensory: Feeling a sense of pain in response to an environmental change
- Visual: Sighting a predator or dangerous object in one's immediate vision
- Auditory: Hearing a sound associated with a particular conditioned fear

These are all factors that could contribute to the release of stress hormones, in any combination. Either a sensory, visual, or auditory stimulus could result in this response (or even all three at the same time).

In code, we could use OR (| operator), AND (& operator), or even NOT (! operator) to assess these sensory inputs. My model does not account for what we'd refer to as "weights" in an artificial neural network sense (yet), which considers how important a sensory input is in determining the overall result following the circuit. However, using the previously-mentioned model for neurons, we can actually model what these functions may look like in a biological sense.

### Motive

When we put together the structures for decision-making operators, these may be the structural motifs we may want to search for when we consider the expanse of the neural circuits in the human brain.

While this depiction may not currently be completely generalizable to a brain in its complexity, analyzing the simplest model may present us with an easier model we can use to dissect the true circuits.



# Paper Brain

## On paper

The paper representations of the structures that will be generated below can be found in my [PaperBrain repository on GitHub](https://github.com/osimon81/PaperBrain), under the *Images* folder. Feel free to excuse the scribbles :)

## On the screen

### Loading `networkd3`

We'll start by loading `networkD3`, once this package is installed. We'll use the `simpleNetwork()` function to plot our functional motifs for conditional operators:

```{r}
library(networkD3)
library(readr)
```


### The And MicroNetwork

The structure of the `simpleNetwork()` function is designed to generate a [force-directed network](https://en.wikipedia.org/wiki/Force-directed_graph_drawing). The syntax is based on a vector of sources (the nodes or neurons which project out to other neurons), and targets (the nodes or neurons which the sources project to). In the `simpleNetwork()` function, the indices for a certain source and target are paired, such that in the generated diagram, a connection exists between the source neuron and the target neuron.

In the code below, two character vectors are added to the global environment in order to generate a force-directed diagram. The nomenclature for each neuron in the vectors is as follows:

- Neurons with a + or - at the end of their name will either generate an excitatory or inhibitory impulse once they are triggered. For instance, (1a)+ is excitatory, and (6a)- is inhibitory.
- Neurons with a capital letter (A, B, or C) outside of parentheses are either input neurons or output neurons. Neuron Aa (In) is an input neuron, and neuron Da (Out) is an output neuron. Assume all input and output neurons are excitatory.
- The lowercase letter in front of the capital letter (for In/Out neurons) or numbers (for +/- interneurons) are unique letter identifiers corresponding to which motif these neurons are a part of. In this case, all of these neurons are labeled with an "a," which indicate that these are all part of the AND MicroNetwork.

In the context of this syntax, we can understand that input neuron Aa (In), located in the srcAND vector, is connected to excitatory interneuron (1a)+, located in the targetAND vector.

The nomenclature system may appear overly complicated at a glance, but this system ensures that every neuron in a MicroNetwork (or combination of MicroNetworks) can be isolated and identified. I'm also open to suggestions as to how the nomenclature for these neuron models can be improved, so feel free to reach out!

While visualization of this network solely based on these two vectors can be relatively complex, we can use this information to plot our visualization using `simpleNetwork()`.

```{r, echo = TRUE}
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

head(andNetwork)

```

Using `head(andNetwork)` shows the first 6 rows of the data frame we constructed, where we pair the source and target vectors. This is a better way to inspect connectivity, and this is the data we will feed into the `simpleNetwork()` function.


The function below plots our And MicroNetwork. The graph is interactive, and nodes can be dragged around to better visualize the network. You can mouse-hover over neurons to reveal the neurons they're connected to. I recommend dragging the input neurons to one side and outputs to the other side, in order to see the connections between neurons better.

```{r}
micronetAND <- function() {
  simpleNetwork(andNetwork, fontSize = 14,
                linkDistance = 100, zoom = FALSE)
}


micronetAND()
```

### The Loop MicroNetwork

We can achieve the same goals with the Loop MicroNetwork. Here, we initialize our (much smaller) network of neurons involved in the loop. Assess how each neuron connects with one another using these two vectors, or using the paired data frame:

```{r}
srcLOOP <- c("Al (In)",
             "(1l)+", "(2l)+", "(3l)+", "(4l)+",
             "(3l)+")

targetLOOP <- c("(1l)+",
                "(2l)+", "(3l)+", "(4l)+", "(1l)+",
                "Bl (Out)")

loopNetwork <- data.frame(srcLOOP, targetLOOP)

head(loopNetwork)
```

Here, we plot the loop MicroNetwork. Inspecting the network, the network appears to be a positive feedback loop, where an incoming excitatory sensory neuron triggers this loop. Every time neurons fire from 1 -> 2 -> 3 -> 4 -> 1, an output neuron Bl (Out) is fired.

```{r}
micronetLoop <- function() {
  simpleNetwork(loopNetwork, fontSize = 14, nodeColour = "green",
                linkDistance = 100, zoom = FALSE)
}

micronetLoop() # generate our network!
```


### A Loop Variation

The code below constructs a data frame with two extra connections added to both srcLOOPv1 and targetLOOPv1. These extra connections can be seen at the bottom 2 rows of the outputted data frame.

Try to use the nomenclature system to figure out how this modifies the Loop MicroNetwork

```{r}
srcLOOPv1 <- c("Al (In)",
             "(1l)+", "(2l)+", "(3l)+", "(4l)+",
             "(3l)+", "(2l)+", "(5l)-")

targetLOOPv1 <- c("(1l)+",
                "(2l)+", "(3l)+", "(4l)+", "(1l)+",
                "Bl (Out)", "(5l)-", "(4l)+")

# construct data frame with source and target vectors

loopNetworkv1 <- data.frame(srcLOOPv1, targetLOOPv1)

loopNetworkv1 # display our data frame!
```

Notice the two extra rows of connections added in this variation of the Loop MicroNetwork, and how this changes the structure (and therefore functionality) of the overall Loop:

```{r}
micronetLoopv1 <- function() {
  simpleNetwork(loopNetworkv1, fontSize = 14, nodeColour = "violet",
                linkDistance = 100, zoom = FALSE)
}

micronetLoopv1() # generate our network!
```

Inhibitory interneuron 5 was formed to bridge excitatory neurons 2 and 4 in the loop, which allows the loop to run for exactly one time before terminating the loop. This variation takes synchronization of latency into account (i.e. the excitatory signal from 2 -> 3 -> 4 will reach interneuron 4 at the same time 2 -> 5 -> 4 reaches this interneuron because the same number of neurons are fired and the same number of synapses are crossed).

This MicroNetwork could be seen in a setup with sensory neuron which fires only once, and requires the signal to be terminated once this signal is directed to the output of the loop. Without the inhibitory element of interneuron 5, the loop would operate indefinitely. Signifying this structure in code, it could be represented as:

`for (i in 1:1) {`
  `triggerOutput()`
`}`

Clearly, many variations can be made using this underlying structure, and exploring factors such as signal latency (which was utilized to generate loop v1) gives this model a degree of flexibility and adaptability for predicting and modeling various neural systems in the brain using basic structures.

## Combining MicroNetworks

### Isolated MicroNetworks

As mentioned, every neuron which is part of a distinct MicroNetwork has a unique identifier. As a result, multiple networks can be stitched together and viewed as a singular, poly-network assembly. In the following code, we put the "And" and "Loop" networks in the same environment (not neurally connected, however). This is in order to allow you to manipulate both MicroNetworks and visualize the multiplicity of ways that they can be connected to one another.

```{r}
micronetAndLoop <- function() {
  srcBOTH <- c(srcAND, srcLOOP)
  targetBOTH <- c(targetAND, targetLOOP)
  
  dualComponentNetwork <- data.frame(srcBOTH, targetBOTH)
  
  simpleNetwork(dualComponentNetwork, fontSize = 14, nodeColour = rainbow(6),
                linkDistance = 100, zoom = TRUE)
}

micronetAndLoop()
```

### Combined MicroNetworks

Manipulating the two networks, they can easily be seen as discrete entities — however, we can also combine these two networks to form a larger, more complex network.

For instance, if we wanted to develop a network model where if A, B, and C were all true, a positive feedback loop would be the output, we can develop the micronetwork here:

```{r}

# The only change made here is adding "Da (Out)" to the end of our src list.

srcAND <- c("Aa (In)", "Ba (In)", "Ca (In)",
            "(1a)+", "(2a)+", "(3a)+",
            "(1a)+", "(2a)+", "(3a)+",
            "(4a)+", "(4a)+", "(6a)-",
            "(7a)-", "(5a)+", "Da (Out)")

# The only change made is adding "Al (In)" to the end of our target list.

targetAND <- c("(1a)+", "(2a)+", "(3a)+",
               "(4a)+", "(4a)+", "(4a)+",
               "(5a)+", "(5a)+", "(5a)+",
               "(6a)-", "(7a)-", "(5a)+",
               "(5a)+", "Da (Out)", "Al (In)")

# The following vectors of neurons were not modified at all.

srcLOOP <- c("Al (In)",
             "(1l)+", "(2l)+", "(3l)+", "(4l)+",
             "(3l)+")

targetLOOP <- c("(1l)+",
                "(2l)+", "(3l)+", "(4l)+", "(1l)+",
                "Bl (Out)")

micronetAndLoop()
```

In a case like this, it's as easy as linking the output neuron Da (Out) to the input neuron Al (In), and assembling the rest of the network using the `micronetAndLoop()` function we wrote earlier.

While this neural network appears more complicated, the function reflects exactly what structure we designed for it. In other words, if input neurons Aa (In), Ba (In), and Ca (In) all experience a stimulus, they will result in output neuron Bl (Out) releasing regular pulses due to the positive feedback loop.

We can link up MicroNetworks in many different configurations to model any variety of neuronal pathway, provided that we have a basic understanding of the structural motifs which represent these computational operators in our target organisms.



# Pipelining

## Linear MicroNetwork Pipeline

The code below is an adaptation of the function `constructLinearMicroNetwork()` which will construct a MicroNetwork formed from multiple MicroNetworks. The function will essentially link a pair of input and output neurons for two adjacent MicroNetworks by building a connection between the two. To test out the function, run `constructLinearMicroNetwork()` in the console. The code to run this function can also be found under this line in the .Rmd file.

```{r constructLinearMicroNetwork() function, eval=FALSE, include=FALSE}
constructLinearMicroNetwork <- function() {
  print("Hello! Welcome to version 1 of the concerted MicroNetwork construction interface.")
  print("This project is essentially a pipeline which allows for fluid force-directed network construction.")
  print("To create MicroNetworks, use the following lines as syntax examples:")
  print("AND(n,n): create an AND MicroNetwork with any number of input neurons n and any output neurons n.")
  print("NOT(3, 1): create a NOT MicroNetwork with 3 input neurons and 1 output neuron")
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

constructLinearMicroNetwork()
```

The nomenclature system can appear complex, but the system exists to give every neuron a unique identification which reveals how they operate and where they are located in a much larger network. The following function, `interpretNeuron(id)` exists to automatically decipher these notation systems for ease of understanding the properties of each neuron.

For instance, the function can decipher the IDs "1(2n)-" and "52(Out3)" as the outputs show below:

```{r interpretNeuron() function, echo=FALSE}
interpretNeuron <- function(id) {
  if (grepl("Out", id) == TRUE) {
    neuronAttributes <- list(
      "Neuron Type" = "Output Neuron (sensory)",
      "Activity" = "Excitatory",
      "MicroNetwork Identifier" = substr(id, 1, regexpr("(", id, fixed = TRUE) -
                                           1),
      "Subpathway Identifier" = sub(".*Out", "", substr(id, 1, nchar(id) -
                                                          1))
    )
  }
  else if (grepl("In", id) == TRUE) {
    neuronAttributes <- list(
      "Neuron Type" = "Input Neuron (sensory)",
      "Activity" = "Excitatory",
      "MicroNetwork Identifier" = substr(id, 1, regexpr("(", id, fixed = TRUE) -
                                           1),
      "Subpathway Identifier" = sub(".*In", "", substr(id, 1, nchar(id) -
                                                         1))
    )
  }
  else if (grepl("a)", id) == TRUE) {
    neuronAttributes <-
      list("Neuron Type" = "Interneuron (AND MicroNetwork)")
    if (grepl("-|[\U{2013}]", id) == TRUE) {
      neuronAttributes <- c(
        neuronAttributes,
        "Activity" = "Inhibitory",
        "MicroNetwork Identifier" = substr(id, 1, regexpr("(", id, fixed = TRUE) -
                                             1),
        "Subpathway Identifier" = as.character(parse_number(substr(
          id, 2, nchar(id)
        )))
      )
    }
    else if (grepl(as.character("+"), id) == TRUE) {
      neuronAttributes <- c(
        neuronAttributes,
        "Activity" = "Excitatory",
        "MicroNetwork Identifier" = substr(id, 1, regexpr("(", id, fixed = TRUE) -
                                             1),
        "Subpathway Identifier" = as.character(parse_number(substr(id, 2, nchar(id))))
      )
    }
  }
  else if (grepl("l)", id) == TRUE) {
    neuronAttributes <-
      list("Neuron Type" = "Interneuron (LOOP MicroNetwork)")
    if (grepl("-|[\U{2013}]", id) == TRUE) {
      neuronAttributes <- c(
        neuronAttributes,
        "Activity" = "Inhibitory",
        "MicroNetwork Identifier" = substr(id, 1, regexpr("(", id, fixed = TRUE) -
                                             1),
        "Subpathway Identifier" = as.character(parse_number(substr(
          id, 2, nchar(id)
        )))
      )
    }
    else if (grepl(as.character("+"), id) == TRUE) {
      neuronAttributes <- c(
        neuronAttributes,
        "Activity" = "Excitatory",
        "MicroNetwork Identifier" = substr(id, 1, regexpr("(", id, fixed = TRUE) -
                                             1),
        "Subpathway Identifier" = as.character(parse_number(substr(id, 2, nchar(id))))
      )
    }
  }
  else if (grepl("n)", id) == TRUE) {
    neuronAttributes <-
      list("Neuron Type" = "Interneuron (NOT MicroNetwork)")
    if (grepl("-|[\U{2013}]", id) == TRUE) {
      neuronAttributes <- c(
        neuronAttributes,
        "Activity" = "Inhibitory",
        "MicroNetwork Identifier" = substr(id, 1, regexpr("(", id, fixed = TRUE) -
                                             1),
        "Subpathway Identifier" = as.character(parse_number(substr(
          id, 2, nchar(id)
        )))
      )
    }
    else if (grepl(as.character("+"), id) == TRUE) {
      neuronAttributes <- c(
        neuronAttributes,
        "Activity" = "Excitatory",
        "MicroNetwork Identifier" = substr(id, 1, regexpr("(", id, fixed = TRUE) -
                                             1),
        "Subpathway Identifier" = as.character(parse_number(substr(id, 2, nchar(id))))
      )
    }
  }
  
  str(neuronAttributes)
}

interpretNeuron(id = "1(2n)-")
interpretNeuron(id = "52(Out3)")
```

This utility function can help to easily identify the properties of particular neurons based on a relatively compact identification system.

The lists displayed here determine the following properties:

- Neuron Type (Input / Output / Interneuron)
- Neuronal Activity (Excitatory / Inhibitory)
- MicroNetwork Identifier (Which net this neuron is a part of in the sequence of MicroNetworks)
- Subpathway Identifier (Where this neuron is in the particular MicroNetwork)

Saving all the properties of neurons created (as well as their linkages from the source-target data frame) for future processing may serve a useful feature for further analysis in modeling.



# Limitations

## Modular Simplicity

(may not account for brain complexity)

## Coloring Limitations

Use of the `simpleNetwork()` function allows for flexible creation of force-directed representations of biological neural networks. However, some limitations in the function narrow the scope of how these models can be made easier to understand. While `interpretNeuron()` can be run on every neuron to determine the activity of each neuron, setting up a color scheme for labeling distinct colors for excitatory, inhibitory, input or output neurons.

Counteracting this limitation may be achieved by using the `forceNetwork()` function, which grants more customization options for force-directed networks, including colors, and is a future direction encouraged for this project.

## Transmission Directionality

Examining the network as simply a force-directed network in isolation, without reference to the list of source and associated target neurons, can make it unintuitive to establish the directionality of the signal (from input neurons to interneurons to output neurons).

Since connections between a source (presynaptic) neuron and a target (postsynaptic) neuron are assumed to be unidirectional, potentially changing the ambiguous lines represented in typical force-directed networks to unidirectional arrows may clarify the ambiguity.

## Modular Generalizability

Recent advances in the field of [_in vivo_ calcium imaging](https://www.inscopix.com/miniature-microscope-technology) have allowed for the opportunity to inspect synapses at the microscale, and by extension, neural circuits. Inspection of circuits and firing patterns for an array of model organisms can inform how to update the structures of previously-established MicroNetworks to anatomically-correct representations.

Cross-matching the connectivity of these modules across various regions in an organism, accessed through minimicroscopes may allow updated pathways to be generalizable across an entire brain for that organism.



# Future Directions

One of the primary aims of the PaperBrain / MicroNetwork project is to allow for a simple interface where researchers in Systems or Computational Neuroscience and various other fields can construct these models using language one might ordinarily see while programming. For instance, a programmer could write:

`if (A & B & C) {`
  `while (I == FALSE) {`
    `triggerOutput()`
  `}`
`}`

PapeRBrain could interpret this code as a combination of an And MicroNetwork (recognizing the `&` operator) and a Loop MicroNetwork (recognizing the `while` loop), and construct the neurobiological representation of this code using `networkd3`.

(Looking carefully at this code, the Loop MicroNetwork may be constructed as a Loop unit with some input neuron I acting as an inhibitory element on the positive feedback loop)

Constructing these complex assemblies can be modular, and MicroNetwork units such as "And," "Loop," "Not," and "Or" (among others) can be modularly assembled using the syntax of computer programming (which may be a useful construction interface for programmers).

Another goal of the PBMN project is to inspect the basic modular circuits which form the nervous systems of simpler organisms, and design a directory for MicroNetworks where the relevant units for certain species can be easily retrieved. As a sub-goal, I would like to standardize the nomenclature for neurons in MicroNetworks, to minimize confusion.

Finally, I hope to make the visualizations more functional by designing an interface where the circuit can be interacted with: various neurons can be triggered in order to assess the circuit's redundancies, areas for improvement, or simply effectiveness.
