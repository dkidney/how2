################################################################################
################################################################################
##
## depmixS4 package for hidden markov models
##
################################################################################
################################################################################

library(depmixS4) # for fit
library(e1071) # for confusionMatrix


################################################################################
## Make some data

# Example using a two state process
# state 1 draws realizations from N(-1, 1), state 2 from N(1, 1) 
# transition between states is determined by a stochastic transtion matrix

# transition matrix
# column = current state
# row = nex state
transition.matrix = matrix(c(0.9, 0.15, 0.1, 0.85), nrow = 2)
transition.matrix

# set of states
possible.states = c(1,2)
current.state = 1

n = 100 # number of iterations
set.seed(12345)
process.values = data.frame(rnorm(n, -1, 1), rnorm(n, 1, 1))
head(process.values)

# state transition record
true.states = rep(NA, n)
true.states[1] = current.state

# generate n-1 new states
for(i in 2:n){
    # transition probabilities
	transition.probs = transition.matrix[current.state, ]
    # generate a new state using previous state
	current.state = sample(possible.states, size = 1, prob = transition.probs)
	# add new state to transition record
	true.states[i] = current.state
}

# at each step, our sample trajectory takes realized values from process 1 or 2 depending on the current state
trajectory = process.values[cbind(1:n, true.states)]
# trajectory = sapply(1:n, function(i){
    # process.values[i, true.states[i]]
# })
head(trajectory) ; length(trajectory)


################################################################################
## Fit HMM with depmix 

# set up the model
model = depmix(trajectory ~ 1, data = data.frame(trajectory), nstates = 2)

# fit the model 
fitted.model = fit(model)

# check to see how the state transtion matricies and process mean/sd matches our sample data
summary(fitted.model)

# get the estimated state for each timestep 
estimated.states = posterior(fitted.model)
head(estimated.states)

# confusion matrix
confusionMatrix(data = estimated.states[,1], reference = true.states)

# plots
par(mfrow = c(3,1), mar = c(1,1,1,1))
plot(1:n, trajectory, pch = 19, col = true.states, main = 'Sample trajectory')
plot(1:n, estimated.states[,1], type = 'l', main = 'Estimated state')
plot(1:n, true.states, type = 'l', main = 'Actual state')

################################################################################
################################################################################
