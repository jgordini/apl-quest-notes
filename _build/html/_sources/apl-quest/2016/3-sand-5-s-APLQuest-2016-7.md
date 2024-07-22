
# Welcome to the APL Quest

## Overview

This article discusses the seventh problem from the 2016 round of the APL Problem Solving Competition. The task is to take a list of numbers and filter it so that only the numbers that can be cleanly divided by either 3, 5, or both remain.

Let's get started!

## Creating Test Data

First, we need to create some data to test our approach. Here are some integers, along with some numbers that are not whole numbers for variety.

```apl
d ← 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 0.5 3.5
```

## Understanding APL's Outer Product

Before diving into which numbers are divisible by 3 or 5, let's explore a very special feature of APL: the outer product. Conceptually, it is quite simple, especially in its basic form, where we provide two lists.

For example, consider the left list containing numbers and the right list containing another set of numbers. The outer product generates a combination of every element on the left with every element on the right, effectively creating a table of combinations.

### Example: Multiplication Table

A common example of such a table would be a multiplication table. The syntax in APL for creating a table (outer product) is as follows:

```apl
10 20 30 ∘.× 1 2 3 4
```

This will yield:

```
┌→───────────┐
↓10 20 30  40│
│20 40 60  80│
│30 60 90 120│
└~───────────┘
```

### Creating a Divisibility Table

Instead of multiplication, we want to explore divisibility. While APL doesn't have a direct "divisible by" function, it does have a "remainder" function that shows how many are left over after distributing evenly with whole numbers.

We can create a divisibility table that shows the remainder when dividing our numbers by 3 and 5. In this table, if we visualize it, we can expect the output as follows:

```apl
3 5 ∘.| d
```

This will produce:

```
┌→────────────────────────────────────────┐
↓0 1 2 0 1 2 0 1 2 0 1 2 0 1 2 0 1 0.5 0.5│
│0 1 2 3 4 0 1 2 3 4 0 1 2 3 4 0 1 0.5 3.5│
└~────────────────────────────────────────┘
```

A number is considered divisible if the remainder is 0. Thus, we can compare our calculated remainder to 0.

### Using APL's Long Right Scope

APL uses a concept called long right scope, which means that the equality function can take its right argument across the entire expression without needing parentheses.

With this, we derive a table indicating a `1` (true) whenever a number is divisible and a `0` when it’s not. However, we are only interested in filtering numbers divisible by either 3 or 5.

```apl
0 = 3 5 ∘.| d
```

This yields:

```
┌→────────────────────────────────────┐
↓1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 0│
│1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0│
└~────────────────────────────────────┘
```

### Applying Logical Operations

We can achieve filtering by using the `or` function combined with a vertical reduction. This will allow us to reduce a two-dimensional array, indicating which numbers are divisible.

```apl
∨⌿ 0 = 3 5 ∘.| d
```

This expression gives the indication of which elements to keep:

```
┌→────────────────────────────────────┐
│1 0 0 1 0 1 1 0 0 1 1 0 1 0 0 1 0 0 0│
└~────────────────────────────────────┘
```

Now we can filter the original vector based on this condition:

```apl
(∨⌿ 0 = 3 5 ∘.| d) / d
```

Output:

```
┌→─────────────────┐
│0 3 5 6 9 10 12 15│
└~─────────────────┘
```

## Creating a Higher Order Function

To simplify our approach further, if we want to eliminate parentheses while checking divisibility, we can create a higher order function called `commute`, which swaps the function arguments.

Finally, we can encapsulate our solution in a function using the Greek letter Omega, which represents the rightmost argument:

```apl
{⍵ /⍨ ∨⌿ 0 = 3 5 ∘.| ⍵} d
```

This succinctly solves our problem, yielding:

```
┌→─────────────────┐
│0 3 5 6 9 10 12 15│
└~─────────────────┘
```

## Conclusion

And there you have it! A concise approach to filtering numbers divisible by 3 or 5 using APL. Thank you for watching!
