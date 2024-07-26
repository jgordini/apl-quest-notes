**Transcript:**

Welcome to this second episode of the APL Quest! Check out the APL Wiki for details. Today's quest is called "Making the Grade" and it's the second problem from the 2013 APL Problem Solving Competition's Phase 1. Here we are to write a function which takes a list of numbers representing the points that people scored on some type of test. If they scored 65 or higher, then they've passed in the test, and we are to compute the percentage of people who passed. 

Let's start off by generating some test data. So here are 10 scores between 1 and 100, and those that have succeeded in the test had scores 69 and 72. So we know how many scores there are in total and we can compare all these scores with 65, so if the test scores are greater than or equal to 65, then they have succeeded and this gives us a boolean vector indicating the ones and zeros, the ones that have succeeded. Then we can sum the boolean vector to find out how many have succeeded and then we can divide that by the total number so this gives us a fraction and we can multiply that by 100 to get a percentage. 

Putting all this together, we have the function f, and we take 100 multiplied by the sum of the scores that are larger than 65, divided by the total tally of scores. That's the argument here, not the variable t, and we can try this on t and that gives us the correct thing. 

Now there's something here that's worth noting: we are doing a bunch of different operations on our data and while mathematically equivalent, it is important which order we do this in in order to have the maximal performance. So here are some variations of things that we could do in f. We started off by the comparison and then we summed. However, we could also start off a bit differently. So let's say that we start off by doing the comparison and then we divide by the total count, then we sum and then we multiply by the 100. So this is mathematically equivalent, but we'll see in a moment and it makes a big difference. 

What we could also do is we could start off in the same way by computing the numbers greater than or equal to 65, we could divide by the total number of numbers, then we could multiply by 100 and then sum again. Mathematically equivalent, but this makes a difference in performance. 

Let's generate a bunch of test data. So, here's some test data, we're going to do random numbers between 1 and 100 but this time we're going to do a million of them. I'm not going to print these out. Let's get in the comPare Execution Time utility from the Dfns workspace and then we're going to run f on these test scores and g on the test scores and h on the test scores and we'll see in a moment that there is a quite significant difference in the performance here. 

So what is it that's actually going on in f? We are doing, if we call the number of scores n, we're doing n comparisons first and then we are doing n minus one additions, we're doing one division and one multiplication. So we can write this, we're doing n comparisons like this and then we are doing an n minus 1 summations and then we're doing one division and one multiplication. 

In g, we again start off the same way, we're doing n comparisons and then but then we're dividing every comparison with the tally so that means we're doing n divisions and we're doing the summation after that, so that's n minus 1 summations and finally, we're doing one multiplication. 

And in h, here we are doing starting off the same way with an n comparisons then we're doing the n divisions and then we're doing n multiplications as well and finally we're doing n minus 1 at additions. So while these are mathematically equivalent, we can see that there's going to be a big difference in the performance and indeed, f is the one where we're doing the least amount of work. 

So now we could sum this up and divide by the total number of scores, but let's do it a little bit differently. Instead, we can use iota algebra again, but this time magnetically. This computes the indices of those that fulfill the requirement of being above 65.

Now we can use the same method as we did above, where we take this result and divide it by the tallies of the original. Then we add the last thing. This is using "where" and the interval index, so we can say it's 100 times this. Of course, for both S and T, we could modify them to take an optional or required left argument.

Here are all the definitions that we did today. Compare them, and don't forget to check out what the performance looks like on the kind of data that you're running with.

Thank you so much for watching.

