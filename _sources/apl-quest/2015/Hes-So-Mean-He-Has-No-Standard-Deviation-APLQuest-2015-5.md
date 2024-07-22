
# APL Quest: Standard Deviation Calculation

Welcome to the APL Quest, where we explore problems in APL with a focus on problem-solving compositions. Today's quest is the fifth in the 2015 round of the APL Problem Solver composition. 

## Problem Overview

The task at hand is a straightforward computation of the standard deviation. The unique aspect of this problem is that it needs to work on an array of any rank, not just a simple vector.

While I didn't have the pleasure of working directly with Ken Iverson, I did have the opportunity to work with his close student, Roger Huey. Roger used to say, "What would Ken do?" In this spirit, I often think about how Roger would approach a problem. I’ve seen him write fantastic code, and I believe this is how he would tackle this task.

## Defining the Mean and Deviation

To begin, we define the mean as follows:

```apl
mean ← { +/⍵ ÷ ⍴⍵ }
```

Next, we define the deviation from the mean:

```apl
deviation ← { ⍵ - mean ⍵ }
```

This gives us the distance of each element from the mean. 

## Helper Functions

We can also create some small utility functions such as `square` and `square root`:

```apl
square ← { ⍵*2 }
squareRoot ← { ⍵*0.5 }
```

With these utilities, we can now write the formula for standard deviation. The standard deviation is defined as the square root of the mean of the squares of the deviations:

```apl
stdDev ← { squareRoot mean square (deviation ⍵) }
```

To test our implementation, we can use an example:

```apl
stdDev 3 1 4 1 5
⍝ 1.6
```

## Handling Arrays of Any Rank

Since we need our function to work on an array of any rank, we can define our function as follows:

```apl
stdDev ← { squareRoot mean square (deviation ⍵) }
```

To ensure it works uniformly, we concatenate the array with its own flattened version:

```apl
F ← stdDev,
F ,∘⍪⍨ 3 1 4 1 5
⍝ 1.6
```

## Compact Style

We can improve our implementation with a more compact style, integrating various parts. We will define a new function called `bracketDevs`:

```apl
bracketDevs ← { ⍵ }
```

Using early binding, we integrate our earlier definitions into a single formula that calculates the standard deviation directly.

To achieve a more organized solution, we can also make some arguments dyadic and rearrange elements for symmetry:

```apl
stdDev ← { squareRoot mean (power 2 (deviation ⍵)) }
```

## Implementing Recursion

Interestingly, when we ask an APL interpreter for the standard deviation, we find something almost identical to our implementation, with the added feature that it flattens the array before applying the function, making it compatible with high-rank arrays.

To define a simple under operator (which isn't provided out-of-the-box in APL), we can preprocess the argument using a right operand:

```apl
under ← { ⍵⍵⍣¯1⊢ ⍺⍺ ⍵⍵ ⍵ }
```

Using this, we can create another function for standard deviation:

```apl
stddevU ← mean under square∘deviation
```

For verification, we can run:

```apl
I ← ((+⌿÷≢){⍵⍵⍣¯1⊢⍺⍺ ⍵⍵ ⍵}(×⍨)⊢-+⌿÷≢) 3 1 4 1 5
⍝ 1.6
```

## Conclusion

To summarize, we’ve explored how to calculate standard deviation on arrays of any rank using various APL techniques. Our final implementation allows us to effectively compute the standard deviation while incorporating Roger Huey's influence.

Thank you for joining us on this APL quest!