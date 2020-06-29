# The Monty Hall Problem, in R

# The Monty Hall Problem is a notoriously counterintuitive probability game that frustrates people because of a subtle framing effect I examine in Part 2. The game is simple -- pick a door, win a prize -- with a twist -- once the door is picked, the host gives  players a chance to change their decision. A typical response is, what if a player picked the correct door on the first go? This leads to misunderstanding the actual probability at work. Using R, I show that the "typical response" is untenable, and a byproduct of how the problem frames the actual decision problem.

#Marilyn vos Savant's "Ask Marilyn" column in Parade magazine (1990) states the Monty Hall problem as follows:

#"Suppose you're on a game show, and you're given the choice of three doors: Behind one door is a car; behind the others, goats. You pick a door, say No. 1, and the host, who knows what's behind the doors, opens another door, say No. 3, which has a goat. He then says to you, "Do you want to pick door No. 2?" Is it to your advantage to switch your choice?"

# Yes! But why?

# Part 1: The Traditional Case

# Firstly, let's find the probability of any given door containing the car, and the goat.  
# The probabilities can be expressed as P(A=car), P(A=goat), etc.

numchoices.orig <- 3
numchoices.update <- 2
num.goats <- 2
num.cars <- 1
num.reveal <- 1

#P(A=car) = 
chanceof.car <- num.cars/numchoices.orig
chanceof.car

#P(A=goat) = 
chanceof.goat <- num.goats/numchoices.orig
chanceof.goat



# b) Without loss of generality, assume you chose door A. What is the probability that the host reveals door B if the car is behind door A? If the car is behind door B? Door C? Assume that the host chooses randomly if there are two possible doors to reveal. Show the expression of your answers as conditional probabilities.


#P(revealB|A=car) = (P(revealB) * P(A=car)) / P(A=car), or rather:

((num.reveal/numchoices.update) * (num.cars/numchoices.orig)) / (num.cars/numchoices.orig)

#P(revealB|B=car) = 0 #apriori; if the car is behind door B the host will never reveal it

#P(revealB|C=car)

choosefrom.remaining <- ((num.reveal/numchoices.update) * (num.cars/numchoices.orig)) / (num.cars/numchoices.orig)
choosefrom.remaining


# c) What is the probability that the host reveals door B? 
#(This is the sum of the probabilities of revealing a goat behind door B for all possibilities of where the car is.)

#I understood this question as the host reveals B instead of A or C. Since the host only reveals a door after the contestant does we have something like this:

#Assume the contestant chooses at random.

#Possible locations of the goat consist of  AB, AC, BC (which are just car in C, B, A, respectively)

#P(revealB|carA) = 1/2 * 1/3  = 1/6

chooseB.carA <- choosefrom.remaining * chanceof.car

#P(revealB|carB) = 0

chooseB.carB <- 0

#P(revealB|carC) = 

chooseB.carC <- choosefrom.remaining * chanceof.car

chooseB.carA + chooseB.carB + chooseB.carC


# d) If the host reveals door B, what is the probability that the car is behind door A?

num.cars/numchoices.update


# e) Generally speaking, should you switch if  the host reveals door B?

# Yes, the chance of winning becomes 2/3 if one switches (2x as high chance of winning as sticking to the first door).

# This can be proved by way of Bayes' Theorem as follows:

# The prior probability was: 
bayesianprior <- num.cars/numchoices.orig
bayesianprior

# Which corresponds to the subjective probability that P(B=car) = 1/3

# Now it is updated by 1/2 as the host eliminated one of the goats: 

num.cars/numchoices.update


#which is the same as 

bayesianupdate <- num.cars/(numchoices.orig - 1)


# Now apply Bayes:

bayesianprior / bayesianupdate


# Part 2: Extending and Driving it Home
# I was interested in how the question is framed:

# The rule of the Monty Hall game is that the host opens one door that had a goat. But the host is actually removing all but one of the unchosen doors as long as those doors did not have the car. This seems trivial for a three-door game. In classical probability, removing 1 door means more or less the same as reducing the choice space to 2. 

# What happens when there are 5 doors, or 100 doors? The host ought to remove, again, all but one door so the player has to choose between two doors: their original choice, and a door that may or may not have a goat. 


# Consider the same game rules (pick one door, the host removes ALL doors except one and the one you chose), but now the number of choices becomes larger:


numchoices.new <- 100

bayesianprior.new <- num.cars/numchoices.new
bayesianprior.new # now there is a 1% chance of choosing the car on the first guess

bayesianupdate.new <- num.cars/(numchoices.new - 1)

bayesianprior.new / bayesianupdate.new 


#So we see, if the host opens ALL the doors except one, you definitely should switch. Which is the basic premise of the 3-door Monty Hall problem.