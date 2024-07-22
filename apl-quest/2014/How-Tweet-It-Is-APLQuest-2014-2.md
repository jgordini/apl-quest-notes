
# APL Quest: Problem Solving and Performance of Text Processing Techniques

Welcome to the APL Quest! Today, we'll delve into the second problem from the 2014 round of the APL Problem Solver Competition. The challenge is to process a given text and find words, removing any vowels from those words, except when the vowel is at the beginning or end of the word.

## Understanding the Problem

Let's break down our approach to tackling this problem:

1. **Identifying Spaces and Non-Spaces**  
   We can begin by identifying spaces and non-space characters in our text. This identification allows us to partition the text effectively.

2. **Partitioning the Text**  
   Using a mask that corresponds to runs of ones (letters) and zeros (non-letters), we can use a partitioning function that combines runs of letters into single elements while discarding anything represented by a zero.

3. **Processing Each Word**  
   Since we need to handle words in a case-insensitive manner, we can convert our text to uppercase. We then ascertain which characters are vowels, accounting for their positions within words.

   Here's a simple APL function that accepts a character vector and removes the interior vowels from each word:
   ```apl
   C←{1↓∊{' ',⍵/⍨1@1(≢⍵)~'AEIOU'∊⍨1⎕C⍵}¨⍵⊆⍨' '≠⍵}   ⍝ Cut
   ```

4. **Creating the Vowel Mask**  
   Each word has its own mask to identify vowels. However, we must ensure that any vowel at the end of a word is not mistakenly removed.

   The following APL function demonstrates the 'drop' method, which processes the entire array in one go:
   ```apl
   D←{⍵/⍨(∊∘'AEIOU'⍲0,¯1↓' '(∧⌿≠)0 1 2↓⍤0 1⊢)1⎕C⍵}  ⍝ Drop
   ```

5. **Finalizing the Compression**  
   After creating a mask, we can determine which characters to keep and which to remove. By applying a compression technique, we join the words back together, ensuring to eliminate leading spaces.

   Here’s how the 'reduce' function is defined in APL:
   ```apl
   R←{⍵/⍨(∊∘'AEIOU'⍲0,0,⍨' '(3∧/≠)⊢)1⎕C⍵}           ⍝ Reduce
   ```

### Implementing the Solution

This solution is effectively illustrated through the following APL functions:

- **Cut (C)**: Processes each word individually, removing unwanted vowels.
- **Drop (D)**: Processes the entire array in one go without splitting into words.
- **Reduce (R)**: Uses reduction techniques to streamline processing.
- **Stencil (S)**: Applies a stencil approach, using neighborhoods of characters to determine vowel removals.
  
  The stencil implementation can be defined as:
  ```apl
  S←{⍵/⍨(∊∘'AEIOU'⍲(' '(∧/≠)⊢)⌺3)1⎕C⍵}             ⍝ Stencil
  ```

### Comparing Performance

In our tests, we've measured the performance of various implementations with differing techniques. The naive "cut" method performs the weakest, likely due to its word-by-word processing, while "drop" and "reduce" yield much better performance since they handle the entire structure at once.

Stencils also show competitive results, but they can be slower than other methods due to complex operand handling.

```apl
'cmpx' 'dxb'⎕CY'dfns'
≢t3←dxb{⍵[?1e3⍴≢⍵]}60↑⎕A,⎕C⎕A
cmpx'CDRS',¨⊂' t3'
```

## Addressing Edge Cases

After the initial implementations, we faced challenges with punctuation, specifically letters adjacent to non-space characters, which were erroneously marked for removal. Adjusting our membership checks to ensure only alphabetical characters were considered as neighbors resolved this issue. Here’s how the improved functions look:

```apl
D←{⍵/⍨(∊∘'AEIOU'⍲0,¯1↓⎕A(∧⌿∊)⍨0 1 2↓⍤0 1⊢)1⎕C⍵}
R←{⍵/⍨(∊∘'AEIOU'⍲0,0,⍨⎕A(3∧/∊)⍨⊢)1⎕C⍵}
S←{⍵/⍨(∊∘'AEIOU'⍲⎕A(∧/∊)⍨{⍵}⌺3)1⎕C⍵}
```

### Exploring Regular Expressions

In addition to array-oriented methods, we also investigated using regular expressions. By crafting expressions to match characters while applying look-behind and look-ahead assertions, we can effectively remove internal vowels while preserving those on word boundaries.

```apl
# Define regex patterns
patternA = '(*?)' (?<=\w)[aeiou](?=\w)'⎕R''⍠1     ⍝ look-Arounds
patternB = '\b\w|\w\b' '[aeiou]'⎕R'&' ''⍠1       ⍝ word-Boundaries
```

### Performance Insights

Though regex can elegantly handle complex string manipulations, it often comes with performance trade-offs, particularly when compared to the optimizations achievable through array-centric operations. In many cases, utilizing APL's array capabilities can provide significant performance gains.

## Conclusion

In this exploration of text processing techniques in APL, we highlighted the effectiveness of various methods, comparing their performance while also addressing edge cases, ultimately demonstrating the suitability of array-oriented approaches over regex in most scenarios.

Thank you for joining me in this analysis. Let's continue refining our problem-solving skills in APL and explore new challenges together!
