
# APL Quest Cap Wiki: Progressive Dyadic Iota

Welcome to the APL Quest Cap Wiki! Today, we will delve into the fourth task from the 2015 round of the APL Problem-Solving Competition. Our goal will be to implement what is traditionally known as *progressive dyadic iota* or *progressive index of*.

## Overview

The task is similar to the normal `index of` function. However, in progressive dyadic iota, instead of finding the first occurrence of every element from the right array in the left array, it consumes the elements from the left. This means it's akin to *index of without replacement*.

This is a classic problem in APL that has been extensively discussed and documented for decades. The most commonly used formulation for this has been well explained in various APL cultivations. You can also find a video link in those discussions where I explain the approach. For this article, I will primarily focus on demonstrating how to update the traditional formulation for modern use.

## Sample Data

Let’s start with some sample data: we have the arrays `Landon` and `Finnegan`, and our task is to find the indices without replacement.

1. **Sample Elements**:
   - `Finnegan`: f i n n e g a n
   - `Landon`: l a n d o n

2. **Expected Indexing**:
   - The character `f` is not found, so it receives an index of 7.
   - For `i`, it finds a match at index 3 (indexing starting from 0), so `i` is consumed.
   - The first `n` is found at index 2, so it is consumed. The second `n` must then look for the next occurrence in `Landon`, which is at index 5.
   - `e` and `g` are not found, so they receive an index of 7.
   - `a` is found at index 1, and the final `n` will not find a match as both previous `n`s were consumed, so it also receives an index of 7.

From this logic, we establish the following mapping for `Finnegan`:

- f → 7
- i → 3
- n → 2
- n → 5
- e → 7
- g → 7
- a → 1
- n → 7

After executing the traditional formulation, we arrive at these results: 
- `f` gives 7, `i` gives 3, the two `n`s give 2 and 5 respectively, both `e` and `g` give 7, `a` gives 1, and the final `n` gives 7.

### Implementing the Function

We can implement the progressive dyadic iota using the following APL function:

```apl
⍝ Define progressive dyadic iota function F
F ← { ⍺(R⍨⍳R←≢⍤⊢⍴⍋⍤⍋⍤⍪⍨)⍵ }
```

## Error with Matrix Arguments

However, if we change our arguments into matrices by applying `table` to both, we run into an error. This is because the traditional formulation uses trailing axes and other inappropriate functions. We can easily update the method to accommodate matrix inputs:

1. We need to rearrange the order for major cells.
2. Properly handle shapes and ranks of the right argument without misalignments.

Understanding the symmetry between the left and right arguments can help express this using a single function.

## Modernized Solution

Let's present a modernized solution, referred to as `f`, which is somewhat shorter than the traditional approach. This includes an alternative formulation noted in the APL idiom list—refer to this for additional explanations.

Here’s how the updated function works:
- The right argument is processed separately and then commuted when needed.
- Instead of directly matching elements, we can group them more efficiently using the `key` operator.

### Key-Based Approach

To enhance clarity, we often create a comparison table where:
- Rows represent letters from `Landon`.
- Columns represent letters from `Finnegan`.

This allows us to visualize which indices have been matched and which have not. Using `key`, we can establish unique pairings based on the current indices and make necessary adjustments.

### Performance Comparison

Next, we can generate some test data to compare the performance of the traditional vs modern approaches. In practice, functions like `f` yield significantly faster results than others.

```apl
⍝ Generate sample data and compare performance
x ← ⎕A[?1000⍴26]
y ← ⎕A[?1000⍴26]
cmpx 'x F y' 'x G y'
⍝  x F y → 2.8E¯5 |    0% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕                       
⍝  x G y → 6.6E¯5 | +133% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕
```

### Additional Considerations

Alternative methods may introduce complications, especially when handling high-rank arrays. For efficiency:
- Use macros to avoid excessive nesting and parenthesis.
- Implement solutions leveraging `namespace` for clean state management.

## Conclusion

By adopting modern implementations of the progressive index methods, we can effectively solve the original ranked problem without replacement. This can be crucial for applications like order fulfillment or resource allocation.

For further learning and an in-depth explanation, check out the linked resources in the description.

Thank you for reading!
