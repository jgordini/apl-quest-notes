# [Making the Grade 2013-2](https://problems.tryapl.org/psets/2013.html?goto=P2_Making_The_Grade)

**Problem:** Write a dfn which returns the percent (from 0 to 100) of passing (65 or higher) grades in a vector of grades.

**Video:** [https://youtu.be/pxo2BtoMxP4](https://youtu.be/pxo2BtoMxP4)

**Code:** [https://github.com/abrudz/apl_quest/blob/main/2013/2.apl](https://github.com/abrudz/apl_quest/blob/main/2013/2.apl)

Welcome to this second episode of the APL Quest! Check out the APL Wiki for details. Today's quest is called "Making the Grade" and it's the second problem from the 2013 APL Problem Solving Competition's Phase 1. Here we are to create a function that accepts a list of test scores. It should calculate the percentage of scores that are 65 or above, representing the pass rate.

Let's start off by generating some test data. So here are 10 scores between 1 and 100, and those that have succeeded in the test had scores 69 and 72. 

```apl
t ← ?10⍴100
```

## Example Solutions

### Solution F

First we compare all scores to 65, creating a boolean vector (1 for pass, 0 for fail). Then we sum this vector to get the number of passing grades. Finally, we divide by the total number of scores and multiply by 100 for the success percentage. In APL this looks like F. 

```APL
F ← {100×(+/⍵≥65)÷≢⍵}
```

Let's break it down:

1. `(+/⍵≥65)` Use [greater than or equal to](https://aplwiki.com/wiki/Greater_than_or_Equal_to) as a [Comparison Function](https://aplwiki.com/wiki/Comparison_function) returning a boolean vector of 1 if true and 0 if false. 
2. Then [sum](https://aplwiki.com/wiki/Reduce) the result - `+/`. 
3. `÷≢⍵`  [Tally](https://aplwiki.com/wiki/Tally) the length of your argument and divde that into the result in step 1. 
4. Multiply this by 100 to get your percentage of passing grades. 

## Advanced Solutions

### Solution J

We are dealing with a scaler (65) and a vector (Scores). We should notice this pattern. We have a sum over a comparison of vectors. When we have that, we should think, [Inner Product](https://aplwiki.com/wiki/Inner_Product). 

```apl
J ← 100×+.≥∘65÷≢ ⍝ Tacit
```

J is a tacit version where 65 is bound to the right argument of `≥`.

1. `÷≢`  [Tally](https://aplwiki.com/wiki/Tally) the length of your array and divde it into the result of step 2.
2. `+.≥∘65` is an [Inner Product](https://aplwiki.com/wiki/Inner_Product) that combines summation and comparison.  The `∘65` part binds 65 as the right argument of `≥`. It's equivalent to `+/⍵≥65` in F.  
3. `100×` The result of  `+.≥∘65÷≢` is multiplied by 100.
4. Equivalent to `{100×(⍵+.≥65)÷≢⍵}`

### Solution K

**Generalization:** This solution generalizes the problem by allowing the passing grade threshold to be specified as a left argument.

```apl
K ← 100×+.≤÷≢⍤⊢
```

1. We are reversing the `≥` so that the Cuttoff Point (65) can be taken as the left argument. Represented by `⍺` in step 1. 
2. `≢⍤⊢` We use [Atop](https://aplwiki.com/wiki/Atop_(operator)) so that we can apply [Tally](https://aplwiki.com/wiki/Tally) monadically. (Dyadic Tally is [Not Match](https://aplwiki.com/wiki/Not_Match)) We could also use Jot `≢∘⊢` in this case and achieve the same result. 
3. K is parsed as `{100×((⍺(+.≤)⍵)÷(≢⍵))}` 

## Performance:

When dealing with large datasets, the order of operations can significantly impact performance. Consider the following variations:

```
F ← {100×(+/⍵≥65)÷≢⍵}    ⍝ Best performance
G ← {100×+/(⍵≥65)÷≢⍵}    ⍝ Lower performance
H ← {+/100×(⍵≥65)÷≢⍵}    ⍝ Lowest performance
```

The performance differences arise from the number and order of operations performed on the entire vector:

- F: n comparisons, n-1 additions, 1 division, 1 multiplication
- G: n comparisons, n divisions, n-1 additions, 1 multiplication
- H: n comparisons, n divisions, n multiplications, n-1 additions

For large datasets, minimizing operations on the entire vector (as in F) leads to better performance.

Let's generate a bunch of test data to compare their performance:

```APL
s←?1e6⍴100
'cmpx'⎕cy'dfns'
cmpx'F s' 'G s' 'H s'
⍝ F s → 6.6E¯5 | 0%
⍝ G s → 2.4E¯3 | +3451%
⍝ H s → 2.8E¯3 | +4126% 

```

We can evalute the performance of each function by importing the [CMPX](http://dfns.dyalog.com/n_cmpx.htm) function from the [DFNS](http://dfns.dyalog.com/n_contents.htm) library. 

1. We [Roll](https://aplwiki.com/wiki/Roll)1 million `1e6` random numbers between 1 and 100
2. We [copy](http://help.dyalog.com/latest/Content/Language/System%20Functions/cy.htm) `⎕cy` CMPX from the DFNS library into our workspace
3. We use cmpx to evalute the performance of each function. With the first function as our baseline. 

This demonstrates that F is significantly faster than G and H.

### Comment:

```apl
0,⍳64 ⍝ Raveld with zero becuase ⎕IO←1
```

## Glyphs Used

- [Roll](https://aplwiki.com/wiki/Roll)
- [Reshape](https://aplwiki.com/wiki/Reshape)
- [Tally](https://aplwiki.com/wiki/Tally)

- [Greater than or Equal to](https://aplwiki.com/wiki/Greater_than_or_Equal_to)

- [Scan](https://aplwiki.com/wiki/Scan) - Plus Scan

- [Quad](https://aplwiki.com/wiki/Quad_name)
- [Bind](https://aplwiki.com/wiki/Bind)

- [Atop](https://aplwiki.com/wiki/Atop_(operator))

- [Identity](https://aplwiki.com/wiki/Identity)

- [Diamond](https://aplwiki.com/wiki/Statement_Separator)

- [Ravel](https://aplwiki.com/wiki/Ravel)

- [Iota](https://aplwiki.com/wiki/Index_Generator)

- [Without](https://aplwiki.com/wiki/Without) aka not

- [Over](https://aplwiki.com/wiki/Over)

- [Indices](https://aplwiki.com/wiki/Indices) aka Where

## Concepts Used

- [Comparison Function](https://aplwiki.com/wiki/Comparison_function)
- [Dfn](https://aplwiki.com/wiki/Dfn)

- [Dfns Workspace](https://aplwiki.com/wiki/Dfns_workspace)

- [Scientific Notation](https://mastering.dyalog.com/Data-and-Variables.html#data-and-variables-representation-of-numbers)

- [CMPX](http://dfns.dyalog.com/n_cmpx.htm)
- [Scalar Function](https://aplwiki.com/wiki/Scalar_function)

- [Reduction](https://aplwiki.com/wiki/Reduce)

- [Inner Product](https://aplwiki.com/wiki/Inner_Product)
- [Dot Product](https://en.wikipedia.org/wiki/Dot_product)

- [Tacit Programming](https://aplwiki.com/wiki/Tacit_programming)

- [Function Atop Tack](https://mastering.dyalog.com/Tacit-Programming.html?highlight=atop#function-atop-tack)

- [Default Left Arguments](https://aplwiki.com/wiki/Dfn#Default_left_arguments)

- [Fork](https://aplwiki.com/wiki/Train#2-trains) - 2 Train

- [Boolean Mask](https://aplwiki.com/wiki/Boolean)

- [Code Reuse](https://en.wikipedia.org/wiki/Code_reuse)

- [Scalar Extension](https://aplwiki.com/wiki/Scalar_extension)

- [Conformability](https://aplwiki.com/wiki/Conformability)

## Transcript

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
