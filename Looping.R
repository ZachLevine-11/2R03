#The following is a short tutorial on using loops.
#Lines that begin with a # are comments, and I encourage you to read them as explanation for the code beneath them.

#Let's start from the begining. Suppose I wanted to print out the numbers 1 and 2.
#I could do it like so:
print(1)
print(2)
#And while this strategy, known as brute-force works, there's a caveat- it gets very time consuming for large inputs. If I asked you to print out the numbers between one and five, we could still do it the same way:
print(1)
print(2)
print(3)
print(4)
print(5)
#But now, it's a cumbersome process. What about if we wanted to print the numbers between one and 1000? 10,000? This strategy becomes virtually unusable, and that's literally just printing numbers.
#What if I wanted to do something more complex, like store the numbers in an atomic vector?
#Surely, there has to be another way.

#And there is! Let me introduce you to my good friend, looping. In time, it will become your good friend too!
#Loops are crucial in any programming language as they help you to execute a block of code repeatedly. As a general rule of thumb, if you ever find yourself writing the same method on multiple lines in a row, there's probably a more concise (and therefore better) way to implement your solution using a loop.
#And while loops (pun intended) and brute-force iteration  aren't necessarily the fastest way to do something from an algorithmic-time/space perspective, they're still a powerful tool that programmers use all the time.
#There are multiple ways to implement a loop in R (and many programming languages, for that matter). While the syntax to implement them changes between different languages, the basic ideas are the same. The two we're going to explore here though are the 'for' and 'while' loops.

#The while loop.
#The while loop is probably the more intuitive of the two, so let's start with it. The basic idea is that when you'd like the computer to repeat a task until a certain condition is no longer satisfied, it's good to use a while loop.
#The basic syntax is as follows:

"while (condition){
  do something
}"

#So, for example, printing the numbers between one and 10,000 as we might have wanted to do above could be achieved in four lines as so:
"counter <-  1
 while (counter <= 10,000){
  print(counter)
  counter <- counter + 1
 }"
#Okay, but what's that first line doing? Try and figure it out on your own first.

#Try executing the block without that first line and you'll run into an error. Why is that? What I'm doing there is that I'm instantiating the counting variable. Without it, the compiler has no idea what "counter" is.
#The while loop is then composed of a couple crucial parts. First, there's the condition, a statement that you want to evaluate to false when your repeated task is done. Make sure to update your counter variable at some point in the loop (to test yourself, ask yourself if the location of that incrementation matters? If so, why? When would it not matter?), or you'll enter an infinite loop.
#Next, you need a block of code that accomplishes some task, and finally, you need the 'while' statement itself.

#Try these to test your understanding of the while loop.
# 1) Add the first 50 even numbers and print the result
# 2) Build an atomic vector with the first 300 prime numbers (trickier)
# 3) Simulate flipping a coin 1000 times and save the result ('H' or 'T') in a data.frame formatted as so:
 # 1    result of first coin flip
 # 2    result of second coin flip
 # i    result of ith coin flip
#  .    .    .    .    .
#  .    .    .    .    .
#  .    .    .    .    .
# 1000   result of 100th, coin fip
   

#We'll be back for "for" loops later on!.
