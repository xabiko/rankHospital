##rankall_function: retrieving a list of names for the nth best hospital in each state,
## for a certain 'outcome'/type of death (heart attack, heart failure or pneumonia).

rankall <- function(outcome, num='best'){
        
        ## Reading data
        temp            <- read.csv("outcome-of-care-measures.csv")
        
        ## Setting up valid arguments
        states          <- as.vector(unique(temp[,7]))
        numStates       <- length(states)
        validOutcomes   <- c('heart attack','heart failure','pneumonia')
        
        ## Modifying arguments:
        ## Fitting case insensibility & capacity to check with valid arguments
        outcome         <- tolower(outcome)
        
        ## Checking validity of passed arguments
        if(!(outcome%in%validOutcomes)) {stop("invalid outcome")}
        
        ##Building a 3-col dataframe with colnames = "hospital name","state" & "outcome"
        temp            <- temp[,c(2,7,11,17,23)]
        colnames(temp)  <- c('hospital name','state','heart attack','heart failure','pneumonia')
        colnames(temp)[which(names(temp) == outcome)]   <- "outcome"
        temp            <- temp[,c('hospital name','state','outcome')]
        temp[,1]        <- as.vector(temp[,1])
        temp[,2]        <- as.vector(temp[,2])
        temp[,3]        <- as.numeric(as.vector(temp[,3]))
        temp            <- temp[!is.na(temp$outcome),]
        
        ##Initializing result
        result          <- as.data.frame(matrix(ncol=2,nrow=0))
        names(result)   <- c('hospital','state')

        ##Iterating through 'temp' subsets for every different state, then picking the nth
        ## best hospital for the passed outcome.
        for(i in 1:numStates){
                temp2   <- temp[temp[,2]==states[i],]
                temp2   <- temp2[order(temp2$outcome,temp2[,1]),]
                
                if(is.numeric(num))   {Hospital.Name   <- as.character(temp2[num,1])}
                else if(num=='best')  {Hospital.Name   <- as.character(head(temp2[,1],1))}
                else if(num=='worst') {Hospital.Name   <- as.character(tail(temp2[,1],1))}
                else                  {Hospital.Name   <- NA}
                
                
                result[i,]  <- c(Hospital.Name,temp2[1,2])
        }
        
        return(result)
}
