# Emulating APL Array Printing Behavior

In this article, we'll explore how to emulate the behavior of an APL (A Programming Language) interpreter, specifically focusing on printing arrays. Our objective is to combine multiple arrays into a single array for display, allowing them to appear formatted correctly without printing each one individually. This approach helps us avoid clutter and maintain organization.

## Sample Data

To illustrate our goal, let’s start with some sample data. When printed, these arrays appear side by side. However, if we print them one by one, they stack on top of each other. The idea is to generate an array that looks uniform when outputted.

```apl
d ← (3 3 ⍴ ⍳ 9)(↑ 'Adam' 'Michael')(⍳ 10) '*' (5 5 ⍴ ⍳ 25)
d
```

```
⍝ ┌─────┬───────┬────────────────────┬─┬──────────────┐
⍝ │1 2 3│Adam   │1 2 3 4 5 6 7 8 9 10│*│ 1  2  3  4  5│
⍝ │4 5 6│Michael│                    │ │ 6  7  8  9 10│
⍝ │7 8 9│       │                    │ │11 12 13 14 15│
⍝ │     │       │                    │ │16 17 18 19 20│
⍝ │     │       │                    │ │21 22 23 24 25│
⍝ └─────┴───────┴────────────────────┴─┴──────────────┘
```

## Initial Approach

The simplest way to achieve this is to split the display of each item into separate rows. We can then combine all those rows into a single list and subsequently into a matrix.

### Formatting Each Element

1. **Character Arrays Creation**: We begin by formatting each element of the right argument. This doesn't change the appearance initially but converts them into character arrays, allowing for scalars, vectors, or matrices to be processed uniformly.

   ```apl
   {⍕¨ ⍵} d
   ```

   ```
   ⍝ ┌─────┬───────┬────────────────────┬─┬──────────────┐
   ⍝ │1 2 3│Adam   │1 2 3 4 5 6 7 8 9 10│*│ 1  2  3  4  5│
   ⍝ │4 5 6│Michael│                    │ │ 6  7  8  9 10│
   ⍝ │7 8 9│       │                    │ │11 12 13 14 15│
   ⍝ │     │       │                    │ │16 17 18 19 20│
   ⍝ │     │       │                    │ │21 22 23 24 25│
   ⍝ └─────┴───────┴────────────────────┴─┴──────────────┘
   ```

2. **Splitting into Rows**: Next, we can split each formatted array into its constituent rows. For vectors and scalars, this will not produce significant changes; it merely encloses the scalar or vector representation.

   ```apl
   {↓¨ ⍕¨ ⍵} d
   ```

   ```
   ⍝ ┌───────────────────┬─────────────────┬──────────────────────┬─┬────────────────────────────────────────────────────────────────────────────┐
   ⍝ │┌─────┬─────┬─────┐│┌───────┬───────┐│┌────────────────────┐│*│┌──────────────┬──────────────┬──────────────┬──────────────┬──────────────┐│
   ⍝ ││1 2 3│4 5 6│7 8 9│││Adam   │Michael│││1 2 3 4 5 6 7 8 9 10││ ││ 1  2  3  4  5│ 6  7  8  9 10│11 12 13 14 15│16 17 18 19 20│21 22 23 24 25││
   ⍝ │└─────┴─────┴─────┘│└───────┴───────┘│└────────────────────┘│ │└──────────────┴──────────────┴──────────────┴──────────────┴──────────────┘│
   ⍝ └───────────────────┴─────────────────┴──────────────────────┴─┴────────────────────────────────────────────────────────────────────────────┘
   ```

3. **Combining Rows**: Combining all the individual arrays at this stage gives us the basis for our final result. We'll use a concatenation reduction approach, which combines them while reducing their rank.

   ```apl
   {,/↓¨⍕¨⍵} d
   ```

   ```
   ⍝ ┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
   ⍝ │┌─────┬─────┬─────┬───────┬───────┬────────────────────┬─┬──────────────┬──────────────┬──────────────┬──────────────┬──────────────┐│
   ⍝ ││1 2 3│4 5 6│7 8 9│Adam   │Michael│1 2 3 4 5 6 7 8 9 10│*│ 1  2  3  4  5│ 6  7  8  9 10│11 12 13 14 15│16 17 18 19 20│21 22 23 24 25││
   ⍝ │└─────┴─────┴─────┴───────┴───────┴────────────────────┴─┴──────────────┴──────────────┴──────────────┴──────────────┴──────────────┘│
   ⍝ └─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
   ```

### Example Code

The following APL code snippet illustrates the described approach:

```apl
formattedData ← {⍉⍵} d
result ← {⍉⍵} allRows
```

#### Handling Scalars

An important point to note is that if we simply work with character scalars, we risk obtaining an incorrect output. Scalars do not provide the required format changes, thus failing our need for separation.

```apl
{↑⊃,/↓⍤⍵} 'abcd'  ⍝ simple scalar characters are problematic
```

```
⍝ abcd
```

### Using Replication

To counter this issue, we can convert each scalar into a vector using the `replicate` function. This function takes an array and an axis as arguments, ensuring that we achieve the required vector formation without affecting other arrays.

```apl
replicatedScalar ← {1 ⍴ ⍵}
```

By applying this `replicate` function to each element, we can ensure that even scalars are now formatted as vectors.

## Alternative Approaches

Besides the initial method, there are various different techniques to achieve similar results.

### Using APL's Default Display

Instead of formatting arrays individually, we could stack them on top of each other to create a vector of vectors. By utilizing APL’s default display capabilities and functions such as `,` (the comma operator), we can transform the data effectively.

### Dropping Extra Spaces

While this method gets us close to the desired outcome, we might encounter issues with unwanted spaces on either end. A straightforward solution involves transposing the array, dropping the first and last rows, and then transposing it back.

### Rank Operator

Alternatively, we can apply the rank operator to achieve desired transformations. This method allows us to drop excess rows systematically without manual transposition.

## Final Touches

At this point, once we've formatted the data appropriately, we can concatenate each entry with a newline character. Using Unicode character sets helps in formatting while maintaining the final output's cleanliness.

### Example Unicode Implementation

```apl
newLine ← {⎕UCS 10}   ⍝ Unicode for Line Feed
```

We then concatenate our formatted data with newLine, ensuring we have the right spacing between outputs.

### Clean Up

After achieving the desired output, we can simplify further by flattening the structure into a list using the `⍴` operator, while ensuring to drop any unnecessary trailing newlines.

```apl
(¯1↓∘∊⍕¨,¨∘⎕UCS 10⍨) d
```

```
⍝ 1 2 3
⍝ 4 5 6
⍝ 7 8 9
⍝ Adam   
⍝ Michael
⍝ 1 2 3 4 5 6 7 8 9 10
⍝ *
⍝  1  2  3  4  5
⍝  6  7  8  9 10
⍝ 11 12 13 14 15
⍝ 16 17 18 19 20
⍝ 21 22 23 24 25
```

## Conclusion

Through various methods, we've demonstrated how to effectively combine and display arrays in an APL interpreter while overcoming common formatting issues. Each of these techniques presents unique advantages, and you may choose the one that fits your specific requirements best.

Thank you for reading!
