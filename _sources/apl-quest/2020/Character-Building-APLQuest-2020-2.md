
# Understanding Byte Sequences and UTF-8 Encoding

In this article, we'll explore how to handle sequences of bytes and convert them into individual code points or characters, specifically focusing on UTF-8 encoding.

## Introduction to Byte Sequences

We start by taking a sequence of bytes and cutting it into pieces, where each piece represents a single code point or character. For our purposes, we will consider this sequence to be a UTF-8 stream.

### Sample Text

Let's look at some sample text consisting of:

- A normal 'd'
- A Yen symbol (¥)
- An alpha (α)
- A down style circle (Ⓡ)
- A normal '9'

Looking at the Unicode character set, we notice that some code points have relatively low values, some have medium-high values, and others possess very large values.

Using APL to see the bytes of a sample string:
```apl
⍝ Let's take the sample text and get its UTF-8 byte representation
bytes ← 'UTF-8' ⎕UCS 'D¥⍺⌊○9'
bytes
```
The output will give us:
```apl
⍝ 68 194 165 226 141 186 226 140 138 226 151 139 57
```
These integer values represent the byte values for the characters.

## Understanding UTF-8

UTF-8 is a variable-width encoding, meaning that the number of bytes representing each character can vary. For example, while the ASCII characters ('d' and '9') may be represented with one byte each, more complex characters like the Yen symbol (¥) or the alpha (α) might require more bytes.

### Byte Representation

When we ask APL (A Programming Language) to give us the bytes associated with these characters, we find that not all characters translate to a fixed number of bytes. 

For instance:
```apl
⍝ Here’s how APL represents the bytes of 'D¥⍺⌊○9'
'UTF-8' ⎕UCS 'D¥⍺⌊○9'
```
Output:
```apl
⍝ D¥⍺⌊○9
```

Here's the process to convert these characters into bytes and back:

1. **UTF-8 to Bytes**: We can convert characters to their byte representation using `quad UCS`.
2. **Bytes to UTF-8**: We convert back using binding the `quad GCS` function.

## Continuation Bytes

In UTF-8, when we have byte values larger than or equal to 128 and less than or equal to 191, they act as continuation bytes for the previous character. 

For instance:
```apl
(≤∘191) bytes 
```
Output:
```apl
⍝ 1 0 1 0 1 1 0 1 1 0 1 1 1
```
- `68` (`d`) starts a new character.
- `194` starts another character.
- `165` is between `128` and `191`, so it continues the previous byte to form a single character.

It's important to remember that characters can consist of up to four bytes, particularly for complex characters like emojis and traditional Chinese characters.

## Checking Byte Ranges

To process the byte data correctly, we start by checking for defined ranges. For instance, we can create a function for checking if a byte is less than or equal to 191:
```apl
⍝ Function to check if bytes are within specified ranges
result ← bytes ((≤∘191) bytes)
```
This would produce a matrix aligning the original byte values with their evaluation results.

## Applying Logical Functions

Next, we need to check if the byte values are also greater than or equal to 128. 

Here, we can construct a logical "fork" where we identify new character beginnings using the results from both comparisons. 

Using a binary negation (not function), we flip our indicators for initiating new characters and use these masks for cutting the byte sequences into usable segments.

### Implementing Masking

To implement this, we use the `partition enclosed function`, which allows us to divide the byte sequences based on our earlier evaluations. For example:
```apl
F ← ⊢⊂⍨ 128 ∘≤⍲ ≤∘191
F bytes
```

By applying the necessary transformations and combining results from logical operations, we can efficiently split the byte sequence into recognizable characters:
```apl
⍝ Output the segmented characters
```

## Alternative Methods

An alternative approach involves using the `interval index` function to identify the intervals that our byte values fall into. Here, we can check if the indices indicate the start of a new character or if they continue a previous one.

Utilizing the `underscore` utility helps visualize these values, leading to efficient character segmentation:
```apl
(⊢⊂⍨ 1≠128 192∘⍸) bytes
```
Produces the segmented format:
```apl
⍝ ┌──┬───────┬───────────┬───────────┬───────────┬──┐
⍝ │68│194 165│226 141 186│226 140 138│226 151 139│57│
⍝ └──┴───────┴───────────┴───────────┴───────────┴──┘
```

## Conclusion

We've explored how to handle a sequence of bytes in UTF-8 encoding, methods for identifying character beginnings, and how to apply various logical and mathematical functions to efficiently process these byte streams.

Thank you for reading!
