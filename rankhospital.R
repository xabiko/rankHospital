##rankhospital_function: retrieving the name of the nth best hospital in the 'state' for a
## certain 'outcome'/type of death (heart attack, heart failure or pneumonia).

rankhospital <- function(state,outcome,num='best'){
        
        ## Reading data
        temp    <- read.csv("outcome-of-care-measures.csv")
        
        ## Setting up valid arguments
        validStates     <- unique(temp[,7])
        validOutcomes   <- c('heart attack','heart failure','pneumonia')
        
        ## Modifying arguments:
        ## Fitting case insensibility & capacity to check with valid arguments
        state <- toupper(state)
        outcome <- tolower(outcome)
        
        ## Checking validity of passed arguments
        if(!(state%in%validStates))     {stop("invalid state")}
        if(!(outcome%in%validOutcomes)) {stop("invalid outcome")}
        
        ## Building a 2-col dataframe with colnames='hospital name' & 'outcome'
        temp            <- temp[temp$State==state,c(2,11,17,23)]
        colnames(temp)  <- c('hospital name','heart attack','heart failure','pneumonia')
        colnames(temp)[which(names(temp) == outcome)] <- "outcome"
        temp            <- temp[,c('hospital name','outcome')]
        temp[,1]        <- as.vector(temp[,1])
        temp[,2]        <- as.numeric(as.vector(temp[,2]))
        temp            <- temp[!is.na(temp$outcome),]
        temp            <- temp[order(temp$outcome,temp[,1]),]
        
        ## Returning nth element of the table. "best"=1st , "worst"=last
        if(is.numeric(num))   {Hospital.Name   <- as.character(temp[num,1])}
        else if(num=='best')  {Hospital.Name   <- as.character(head(temp[,1],1))}
        else if(num=='worst') {Hospital.Name   <- as.character(tail(temp[,1],1))}
        else                  {return("invalid num")}
        
        return(Hospital.Name)
}