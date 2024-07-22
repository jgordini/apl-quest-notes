
# Splitting Text in APL

In this article, we will explore how to split a text string based on a character found within a given left argument. The goal is to isolate the first character from the right text that matches a character from the left argument and split accordingly. Let's illustrate this with an example.

## Example Scenario

Suppose we have a left argument, `U`, which contains the characters we want to use as splitters, and a right argument, `DYA`, which is the text we want to split. Here’s how the characters match up:

- `D` does not exist in the left argument.
- `Y` does not exist in the left argument.
- `A` does exist in the left argument.

Thus, we want to split at `A`, isolating `DY` and `A`. Here's how we can express the splitting operation in APL:

```apl
F ← (¯1 + ⌊⌿⍤⍳⍨∘,)(↑,⍥⊂↓)⊢
F 'DYALOG'
```
This results in:
```
┌──┬────┐
│DY│ALOG│
└──┴────┘
```

## Approach

There are several ways to approach the problem. Let's start outlining one method.

### Finding Character Positions

First, we will find the positions of characters from the right argument (text to split) in the left argument (splitters). This is achieved using a lookup function that maps elements from the right (`DYA`) to the left (`U`). Since we need the smallest index, we can use the `minimum` reduction.

1. **Lookup Positions**:
   - A is found at position 3.
   - P (for Y) returns 7 since it does not exist.
   - L (for D) is also not found and returns an index indicating such.

In APL, we can use the following code to find the positions:

```apl
{⍵⍳⍺} 'DYALOG'
```
This results in:
```
3 7 4
```

Given we are looking for the position of `A`, we apply the `minimum` function to get the smallest index.

```apl
{⌊⌿⍵⍳⍺} 'DYALOG'
```
This results in:
```
3
```

### Splitting the Text

Once we find the index where `A` is located, we apply a simple transformation:

- Decrement the index by 1 (to split before `A`).
- Use this index to partition the right argument into two parts: take the elements before the split and drop the elements at and after the split.

The APL code for this transformation looks like this:

```apl
((¯1 + ⌊⌿⍤⍳⍨)↑⊢) 'DYALOG'
```
This results in:
```
DY
```

To get the remaining part:

```apl
((¯1 + ⌊⌿⍤⍳⍨)↓⊢) 'DYALOG'
```
This results in:
```
ALOG
```

### Handling Edge Cases

We must consider edge cases, such as when the right argument is scalar. In order to prevent errors, we preprocess the right argument using a function called `Ravel` to ensure it is transformed into a vector.

When the right argument is just a single character, for example, `'D'`, the following call would yield an RANK ERROR:

```apl
((¯1 + ⌊⌿⍤⍳⍨)(↑,⍥⊂↓)⊢) 'D'
```

However, we can handle this case using a different approach:

```apl
((¯1 + ⌊⌿⍤⍳⍨∘,)(↑,⍥⊂↓)⊢) 'D'
```
This results in:
```
┌─┬┐
│D││
└─┴┘
```
Thus, we effectively handle scalars without resulting in errors.

## Alternative Method

Another way to tackle this involves creating a Boolean mask. This approach starts similarly:

1. **Create a Mask**:
   - We generate a Boolean mask that has `1`s indicating where the sections begin (the positions we found), while all other positions are `0`.
   - By using the `where` function, we can create our desired indices.
   
   
   To illustrate using the lookup approach for masking:

```apl
{1,⌊⌿⍵⍳⍺} 'DYALOG'
```
This results in:
```
1 3
```

2. **Inverse Mask Application**:
   - The power operator in APL allows us to apply functions, including inverses, creating the needed mask for partitioning.

### Testing and Finalizing

After generating the two segments, we can test the function by flipping the arguments and ensuring they behave as expected.

1. We prepare a function for concatenation and apply it to check our splits.
2. Finally, we encapsulate required transformations within a wrapper function, which can handle scalars as well.

The final function to encapsulate split operations can be defined as follows:

```apl
G ← (⊢⊂⍨1⍸⍣¯1⍤,⌊⌿⍤⍳⍨)∘,
```

## Conclusion

Through APL functions, we can efficiently split text while accounting for complex scenarios. Whether using index lookups or Boolean masking, APL provides the flexibility for robust text manipulation. This flexibility allows us to accommodate diverse use cases, ensuring that our functions can adapt to the inputs provided.

Thank you for reading!
