
# APL Quest: 8th Quest Overview

Welcome to the APL Quest. Today, we're diving into the details of the 8th Quest for the 2016 round of the APL Problem Solving Competition.

## Quest Description

In this Quest, we are provided with a list of numbers, and our goal is to return a two-element list. The first element must contain all the negative values, while the second element must contain all the non-negative values.

## Approach

We can achieve this by filtering the values. Let's get started by creating some values.

### Implicit Mapping in APL

APL has implicit mapping over arrays, meaning that any comparison, such as checking if a number is less than or equal to zero, automatically applies to all the values in the array. 

In APL, `1` and `0` represent `true` and `false`, respectively. We can use this property to filter our array `V` with the following expressions:

```apl
positiveValues ← V / 0 ≤ V
negativeValues ← V / V < 0
```

This can also be expressed using a single function that returns both negative and non-negative values:

```apl
filterValues ← {((0 > ⍵)/⍵)((0 ≤ ⍵)/⍵)}
```

Now, we're equipped with two formulas that we can place next to each other.

### Creating a Function

To turn this into a function, we encapsulate it in braces, forming an anonymous lambda function. We designate the argument as `Ω`, the rightmost letter of the Greek alphabet, since our argument will be placed on the right:

```apl
filterValues ← { (V / 0 ≤ V), (V / V < 0) }
```

This expression forms one solution, but it has a lot of parentheses, which can reduce readability. Alternatively, we can define the function using the explicit filtering approach with a mask:

```apl
filterValues ← { (⍵/⍨0>⍵)(⍵/⍨0≤⍵) }
```

### Simplifying the Expression

To simplify, we can create a function that takes the mask on the right and the data on the left. Although APL does not have a built-in function for this, we can utilize a modifier called **commute** (or **swap**), which rearranges the function arguments. We redefine our expression as follows:

```apl
filterValues ← { (M ← ⍵/0≤⍵), (⍵/M) }
```

However, since we want to filter values and keep track of them efficiently, we can store the mask as `M` directly. Notably, the result of the assignment in APL is always the value being assigned.

### Avoiding Redundant Calculations

To optimize further, we can use a positive mask instead and negate it when needed. Our expression reads:

```apl
positiveMask ← ⍵ / 0 ≤ ⍵
negativeValues ← ⍵ / ~positiveMask
```

Alternatively, we could declare masks separately, enhancing code clarity:

```apl
negativeMask ← ⍵ / ⍵ < 0
positiveMask ← ⍵ / 0 ≤ ⍵
```

In this way, we have neatly organized our logic.

### Set Computations Variation

For a slightly different approach, we can switch our focus to directly computing the positive values first:

```apl
positiveValues ← ⍵ / 0 ≤ ⍵
negativeValues ← ⍵ \ positiveValues
```

In this case, we employ the **tilde (~)** operator to denote "without," distinguishing between *not* in logical contexts and *except* in set difference contexts.

## Conclusion

This strategy leads us to a final solution that efficiently separates our values into negative and non-negative categories. We thank you for watching, and we hope this guide has clarified the process of tackling this Quest in APL!