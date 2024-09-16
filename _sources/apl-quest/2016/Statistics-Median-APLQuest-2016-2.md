
# Welcome to the APL Quest

Welcome to the APL Quest! For details, see the APL Wiki. Today’s quest is the second problem from the 2016 round of the APL Problem Solving Competition.

## Problem Statement

We are given some numbers, which can be either a list or a single number, and we are to compute the median. The median is defined as the middle element of a sorted list. If there is no distinct middle element, we take the average of the two middle elements.

## Test Data

To understand how to compute the median, we will explore some test data. There is a key difference between lists with even and odd lengths concerning the median calculation.

### Example 1: Odd Number of Elements

Let’s start with an odd number of elements:

1. Given the list `[1, 1, 3, 4, 5]`, when ordered, the middle element is `3`.

### Example 2: Even Number of Elements

Now, consider the case of an even number of elements:

2. Given the list `[1, 1, 3, 4]`, the middle elements are `1` (one of the two) and `3`. The average of these two values is `(1 + 3) / 2 = 2`.

### Example 3: Single Element

In the case of a single element, the median is simply that element itself.

### Example 4: Empty List

If we have an empty list, as per the problem specification, the median should be considered `0`, even though there are no elements.

### APL Syntax

In APL, you denote an empty vector with a numeric `1`. To handle a one-element list, we use the revel operator (`,`) to flatten it. Note that APL denotes negative numbers with a high minus (e.g., `⍷-1`).

## Approaching the Computation of the Median

We will eventually use the `each` operator, which applies a function to each element of the list.

### Sorting and Dropping Elements

To compute the median, one straightforward method is to sort the elements first, then remove the elements that are before and after the middle element(s):

1. We define a function encapsulated in braces `{}`.
2. Using the `each` operator, we apply the function to each element of our input list.
3. To sort in APL, we typically use the `grade` function as there is no direct sort function.

```apl
MedianR ← {2 ≥ ≢ ⍵: 2 ÷ ⍨ +/ 2 ⍴ ⍵ ⋄ ∇ 1↓ ¯1↓ ⍵[⍋ ⍵]}
```

This function, `MedianR`, computes the median recursively by dropping elements one at a time until one or two remain.

### Handling Scalars

A challenge arises if one of our inputs is a scalar since it lacks an order. To resolve this, we can use the revel operator to treat it as a list.

### Utilizing the Grade Function

Using `grade`, we can obtain the indices required to sort the data. A stable sort preserves the relative ordering of equal elements.

### Indexing to Create a Sorted List

APL allows us to perform multiple indexing in one step. This way, we can retrieve the sorted list elements efficiently.

```apl
MedianI ← {⍬≡⍵: 0 ⋄ 2 ÷ ⍨ +/ ⍵[⍋ ⍵][⌈ 2 ÷ ⍨ 0 1 + ≢ ⍵]}
```

`MedianI` computes the indices in the sorted array that allows for retrieving the median values.

## Recursive Function for Median Calculation

We will now write a recursive function to drop elements until we are left with one or two elements. The stopping condition will ensure that we do not loop infinitely. The function processes as follows:

1. Count the elements in the argument.
2. If the count is `0`, `1`, or `2`, we can return the argument without further modification.
3. Use `drop` to remove elements from both ends of the list.

### Using Delta for Recursion

The upside-down triangle symbol (Δ) represents recursion in APL, allowing us to define an anonymous function easily.

```apl
MedianD ← {d ← ⌊ 2 ÷ ⍨ ¯1 + ≢ ⍵ ⋄ 2 ÷ ⍨ +/ 2 ⍴ d↓(-d)↓ ⍵[⍋ ⍵]}
```

In `MedianD`, we compute how many elements should be dropped based on the total count of elements in the array.

### Averaging the Result

For the final step, if we are left with two elements, we can compute their average. The cyclic `reshape` function helps ensure that we always operate with two-element lists to facilitate averaging.

```apl
median ← { ... }
```

You would ultimately implement this function to return the correct median based on the input list.

## Alternative Method: Dropping Indices

We can also approach the median computation by calculating how many elements should be dropped based on the length of the list:

1. Identify the number of elements.
2. Compute how many to drop, which depends on whether the count is even or odd.
3. Use the calculated indices to directly access the required elements.

### Conclusion

In conclusion, there are multiple ways to compute the median in APL, whether by dropping elements, averaging, or directly indexing sorted lists. 

Thank you for joining today's quest. Feel free to explore other methods and applications in APL!
