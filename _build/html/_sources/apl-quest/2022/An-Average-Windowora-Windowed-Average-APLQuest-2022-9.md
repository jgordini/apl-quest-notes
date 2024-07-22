
# Calculating the Window Average of a List of Numbers in APL

In this article, we will compute the window average of a list of numbers using APL. While calculating window averages is typically straightforward in APL, let’s break down the steps to understand the process clearly.

## Example Data

Let’s consider a simple list of numbers:

```
1, 2, 3, 4, 5, 6
```

We want to compute the window average for these numbers. The specification requires us to consider a specific number of neighboring elements on each side of a target element. For instance, if we choose two neighbors on each side, when calculating the average for the number `3`, we will include the two neighbors on both sides:

- **Neighbors to include**: `1, 2, 3, 4, 5`

This gives us a total of five numbers for the window average calculation.

## Window Size Calculation

To define the window size, we can derive it from the number of neighbors specified:

- If the left argument (the number of neighbors) is `2`, the full window size can be calculated as:

```
2 (left neighbors) * 2 (right neighbors) + 1 (the middle element) = 5
```

Now we have our window size determined as `5`. 

## Reduction Over Windows

Next, we utilize a reduction operation over this window size. The left argument to our plus reduction will be `5`, and the actual data that we will reduce will be taken as the right argument to our outer function.

- **Summing Over a Window**: The left argument represents the size of the sliding window, while the right argument is our list of numbers.

For example, we can compute the sum for the first range of numbers:

```apl
2 ((1+2×⊣)) 1 2 3 4 5 6
```
This APL expression will produce:

```
⍝ 5
```
Continuing this for each possible window, we find:

- The window sums would be:
  - For `1, 2, 3`: `1 + 2 + 3 = 6`
  - For `2, 3, 4`: `2 + 3 + 4 = 9`
  - For `3, 4, 5`: `3 + 4 + 5 = 12`
  - For `4, 5, 6`: `4 + 5 + 6 = 15`

To compute all sums, we can represent this in a single APL expression as:

```apl
2 ((1+2×⊣)+/⊢) 1 2 3 4 5 6
```

This will produce the complete window sums:

```
⍝ 15 20
```

## Average Calculation

Now that we have the sums of the windows, we need to divide by the number of elements to calculate the average. Conveniently, the number of elements is already present as the left argument in the plus reduction.

We wrap the sum operation into a function and divide it by the left argument to determine the average:

```
Average = Sum / Length
```

Thus, the average for the various windows can be computed as follows using this APL expression:

```apl
2 ((1+2×⊣)(+/÷⊣)⊢) 1 2 3 4 5 6
```

This results in:

```
⍝ 3 4
```

- For window `1, 2, 3`: Average = `6 / 3 = 2`
- For window `2, 3, 4`: Average = `9 / 3 = 3`
- And similarly for other windows.

## Edge Cases and Extending the Data

A catch with this method is that we might not compute window averages for all elements if the necessary neighbors are not present. For instance, if we only use the original data, we won’t be able to compute averages for elements at the edges of our list.

To handle this, we extend the data by duplicating the first and last elements. The steps involved are:

1. **Extend on the left**: Duplicate the first element as necessary.
2. **Extend on the right**: Duplicate the last element.

In APL, we can pre-process the right argument using a cyclic reshape that includes these extended elements. 

For example, to extend the input, we can use:

```apl
2 (⍴) 1 2 3 4 5 6
```

This gives the extended vector:

```
⍝ 1 2
```
Simulating how we would extend the list:

```apl
2 (⍴∘⊃) 1 2 3 4 5 6
```

This results in:

```
⍝ 1 1
```

By applying reshaping and concatenation, we subsequently create a new array that includes the copies of the first and last elements.

## Final Implementation

Now, with the original formula for the window average applied to the extended data, we can finalize our running window average function:

```apl
F←(1+2×⊣)(+/÷⊣)⍴∘⊃,⊢,⍴∘⊃∘⌽
```

Now we can apply the function to our original numbers:

```apl
2 F 1 2 3 4 5 6
```

This evaluates to:

```
⍝ 1.6 2.2 3 4 4.8 5.4
```

As an example, using a window of `1`:

```apl
1 F 1 2 3 4 5 6
```
This produces:

```
⍝ 1.333333333 2 3 4 5 5.666666667
```

## Conclusion

Through these steps, we've calculated the window averages for a list of numbers while accounting for necessary edge cases by extending the data. This gives us both an accurate and robust method to handle window calculations efficiently in APL.

Thank you for reading!
