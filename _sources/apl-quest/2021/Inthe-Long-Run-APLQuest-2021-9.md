
# Finding the Longest Consecutive Sequence in a List of Numbers

In this article, we will discuss how to find the length of the longest consecutive subsequence of numbers, where the values can either be consistently increasing, decreasing, or constant. We will use a sample sequence to illustrate the method and provide a clear solution using APL (A Programming Language).

## Problem Statement

Given a list of numbers, our goal is to determine the length of the longest consecutive subsequence. This subsequence can be defined in three ways:

1. **Increasing**: where each subsequent number is greater than the previous.
2. **Decreasing**: where each subsequent number is less than the previous.
3. **Constant**: where each subsequent number is the same as the previous one.

For instance, consider the following sequence:

```apl
p ← 1 2 3 5 5 5 4 3 2
```

In this case, the longest subsequences are:

- The constant values (5, 5, 5) have a length of 3.
- The increasing sequence (1, 2, 3, 5) has a length of 4.
- The decreasing sequence (5, 4, 3, 2) has a length of 4.

## Approach

We begin by using a lambda function `F` with an argument `Omega`, representing our sequence. To determine the relative sizes, we subtract adjacent elements. This helps to identify whether we are going up, down, or staying constant.

```apl
{⍵} p
```

This yields the original sequence:

```apl
1 2 3 5 5 5 4 3 2
```

Then we compute the differences:

```apl
{2 -/ ⍵} p
```

This produces:

```apl
¯1 ¯1 ¯2 0 0 ¯1 1 1
```

Next, we focus on identifying the segments by checking whether adjacent elements are the same:

```apl
{1, 2 ≠/ ×2 -/ ⍵} p
```

The output shows:

```apl
1 0 0 1 0 1 1 0
```

This indicates where segments begin.

### Length of Segments

We can then count the length of these segments. First, we structure our data accordingly:

```apl
{⊂⍨ 1, 2 ≠/ ×2 -/ ⍵} p
```

This results in segments displayed in nested arrays:

```
┌─────┬───┬─┬───┐
│1 0 0│1 0│1│1 0│
└─────┴───┴─┴───┘
```

Now we calculate the lengths of each segment:

```apl
{≢¨ ⊂⍨ 1, 2 ≠/ ×2 -/ ⍵} p
```

The output shows:

```apl
3 2 1 2
```

From this, we can find the maximum length:

```apl
{⌈/ ≢¨ ⊂⍨ 1, 2 ≠/ ×2 -/ ⍵} p
```

This gives us:

```apl
3
```

We define our function `F` to encapsulate this logic:

```apl
F ← {⌈/ ≢¨ ⊂⍨ 1, 2 ≠/ ×2 -/ ⍵}
```

## Performance Consideration

APL emphasizes staying "flat" for performance reasons. Our initial solution produces a list of lists rather than a single list. To optimize, we can restructure the process to find the distance between the beginnings of segments. We locate the indices of our '1's, add a trailing '1' to the end, and then compute the segment lengths.

Here is the optimized function `G`:

```apl
G ← {⌈/ ¯2 -/ ⍸ 1, ⍨ 1, 2 ≠/ ×2 -/ ⍵}
```

### Implementation

Let’s test the efficiency of our optimized solution `G`. We will create a larger dataset, consisting of one million numbers from 1 to 10, and then measure performance:

```apl
10↑ q ← ?1e6 ⍴ 10
```

The result might look like this:

```apl
6 9 3 8 6 4 9 6 7 9
```

We will utilize a comparison utility to contrast the execution speeds of our functions `F` and `G` on this larger dataset.

```apl
'cmpx' ⎕CY 'dfns'
cmpx 'F q' 'G q'
```

After conducting this performance comparison with one million elements, we should see a significant speedup with our optimized approach. For example, the results may output something like:

```apl
F q → 3.1E-2 |   0%
G q → 2.6E-3 | -92%
```

## Conclusion

In conclusion, we explored a method to find the length of the longest consecutive subsequence while considering both increasing and decreasing sequences as well as constant values. Our approach leverages the powerful capabilities of APL for efficient computation. Thank you for reading!
