
# APL Quest Episode 2: Making the Grade

Welcome to the second episode of the APL Quest! Check out the APL Wiki for details. Today's quest is called **Making the Grade**, which is the second problem from the [2013 APL Problem Solving Competition Phase 1](https://problems.tryapl.org/psets/2013.html?goto=P2_Making_The_Grade).

## Problem Overview

In this episode, we are tasked with writing a function that takes a list of numbers representing the points that people scored on some type of test. If they scored 65 or higher, then they have passed the test, and we need to compute the percentage of people who passed.

Let's start off by generating some test data. Here are 10 scores between 1 and 100

```apl
t ← ?10⍴100  ⍝ Generate 10 random scores between 1 and 100
```

## Computing the Percentage of Passes

We know how many scores there are in total, and we can compare all these scores with 65. If the test scores are greater than or equal to 65, then those individuals have succeeded. This gives us a boolean vector indicating the ones (success) and zeros (failure).

Next, we can sum the boolean vector to find out how many have succeeded and then divide that by the total number of scores. This gives us a fraction that we can multiply by 100 to get a percentage.

Putting this all together, we have a function `F`:

```apl
F ← {100 × (+/ (⍵ ≥ 65)) ÷ ≢ ⍵}  ⍝ Explicit
```

Running this function on the scores gives us the expected result.

### Alternative Function Implementations

We also implemented several alternative functions for the same purpose, including both explicit and tacit definitions:

```apl
F ← {100×(+/⍵≥65)÷≢⍵}      ⍝ Explicit
G ← {100×+/(⍵≥65)÷≢⍵}      ⍝ Variation
H ← {+/100×(⍵≥65)÷≢⍵}      ⍝ Variation
J ← 100×+.≥∘65÷≢ ⍝ Tacit
```

These functions `F`, `G`, `H`, and `J` compute the percentage using slightly different approaches.

## Performance Considerations

It is important to note that while the operations we are performing are mathematically equivalent, the order in which we perform them can significantly impact performance.

Here are some variations we could explore:

1. Starting with the comparison, then dividing by the total count, followed by summing, and finally multiplying by 100.
2. Computing the boolean vector first and then dividing and multiplying.

Let's generate a large dataset for performance testing:

```apl
s ← ?1e6⍴100  ⍝ Generate one million random scores between 1 and 100
```

We’ll compare the execution time of different variations of the function, specifically `F`, `G`, and `H`, to observe the differences in performance.

### Analysis of Function Performance

We can compare the execution output of each function using the `CMPX` utility:

```apl
'cmpx'⎕cy'dfns'  ⍝ Load custom comparison functions
cmpx 'F s' 'G s' 'H s'  ⍝ Compare the functions on the dataset
```

The outputs will help us evaluate the performance:

```apl
⍝ F s → 6.6E¯5 |     0%
⍝ G s → 2.4E¯3 | +3451%
⍝ H s → 2.8E¯3 | +4126%
```

- In function `F`, we perform `n` comparisons, `n-1` additions, and then one division and one multiplication.
- In function `G`, we again perform `n` comparisons, but we also do `n` divisions resulting in a higher workload.
- In function `H`, we see similar high computational overhead because of `n` divisions and `n` multiplications.

Thus, function `F` is the most efficient due to the least amount of work being done.

## Alternative Approaches

In the live chat event from last Friday, we discussed various methods to address this problem:

1. **Using a Set Difference**: Assume all scores are integers between 0 and 100. Generate scores that wouldn’t pass and remove them, then compute the ratio of passing scores to the original total.

2. **Using Interval Indexing**: Define cutoffs, compute the intervals for each score, and sum the boolean results.

For each of these approaches, a similar percentage calculation can be conducted:

```apl
S ← {100×(+/.≥⍵)÷≢⍵}    
W ← {100×(⍸(,65)⍸⍵)÷≢⍵}   
```

## Conclusion

We have explored different variations to compute the passing percentage, highlighting the performance differences across various implementations. Remember to check how performance varies on the type of data you are working with!

Thank you for joining today’s episode of the APL Quest!
