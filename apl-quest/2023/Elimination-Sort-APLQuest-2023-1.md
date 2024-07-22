# Removing Non-Decreasing Elements from a List

In this article, we'll explore how to remove any elements from a given list that are not part of a non-decreasing sequence starting from the list's beginning. The goal is to end up with a sorted yet potentially shorter list than the original input.

## Problem Explanation

We need to analyze a list of elements to discard those that break the non-decreasing order. For example, in a list where elements are compared pairwise:

- **Example List**: `[1, 3, 7, 3, 5, 8]`

In this list:
- `1` is less than `3`
- `3` is less than `7`
- However, `7` is **not** less than `3` (which follows it)

From this, we find that the first element is always kept to mark the start of our sequence. The elements that follow are evaluated, and we will keep elements as long as they do not decrease.

## Initial Approach

A naive implementation might look like this using an anonymous lambda function to compare adjacent elements.

### Step-by-Step Process

1. **Keep the first element**: It marks the beginning of the non-decreasing sequence.
2. **Iterate through the list**:
   - For adjacent elements, check if they are in non-decreasing order.
   - Remove elements that do not meet the criteria.

For instance:
- We might keep `1`, `3`, `7`, but remove `3` after `7`, and so on.

### APL Implementation

We define a numeric vector `t` that contains our elements:

```apl
t←1 3 7 3 5 8 5 8 1 6 1 8 1 10 8 4 3 4 1 4
```

Using an anonymous function, we can find which elements to keep based on whether they are at least as large as the previous kept element:

```apl
{2≤/⍵} t
```

This returns a binary vector indicating the elements that should be kept:

```
⍝ 1 1 0 1 1 0 1 0 1 0 1 0 1 0 0 0 1 0 1
```

From this, we can filter the list with:

```apl
{⍵/⍨1,2≤/⍵} t
```

This produces the non-decreasing subsequence:

```
⍝ 1 3 7 5 8 8 6 8 10 4 4
```

### Multiple Passes

If we apply this comparison multiple times, we can eliminate elements until no more discrepancies are found. By using a match condition instead of a number, we can efficiently continue the process until two consecutive iterations yield the same result.

Using the following APL expression invokes the filter repeatedly until stability:

```apl
({⍵/⍨1,2≤/⍵}⍣≡) t
```

Finally, we arrive at the result:

```apl
⍝ 1 3 7 8 8 8 10
```

## Efficient Approach: Single Pass

To improve efficiency, we can utilize a single-pass approach by maintaining a maximum value seen so far. This leads us to the following steps:

### Steps to Implement the Single-Pass Solution

1. **Track maximum**: Keep a running maximum of the elements seen so far.
2. **Filter the list**: Retain elements that match this current maximum, as any smaller element must be filtered out.

This logic allows us to maintain the non-decreasing properties without repeated evaluations.

### APL Implementation for Single Pass

We can also use the ceiling function `⌈\` in APL to capture the maximum value throughout the list as follows:

```apl
{⌈\⍵} t
```

This would yield:

```
⍝ 1 3 7 7 7 8 8 8 8 8 8 8 8 10 10 10 10 10 10 10
```

Next, we can identify the positions of the maximum values with:

```apl
{⍵=⌈\⍵} t
```

Which returns a binary vector where `1` indicates retained values:

```
⍝ 1 1 1 0 0 1 0 1 0 0 0 1 0 1 0 0 0 0 0 0
```

Finally, we filter the list to retain the non-decreasing elements:

```apl
{⍵/⍨⍵=⌈\⍵} t
```

Resulting in:

```
⍝ 1 3 7 8 8 8 10
```

### Conclusion

By applying these techniques, we can efficiently remove non-decreasing elements from a list using both a literal interpretation and an optimized single-pass solution. This approach ensures we keep our implementation both effective and computationally efficient.

Thank you for reading!