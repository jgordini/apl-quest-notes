
# Welcome to This Episode of the APL Quest

Welcome to this episode of the APL Quest! For more details, be sure to check out [the APL Wiki](https://aplwiki.com). In today's quest, we will be exploring how to generate an [identity matrix](https://en.wikipedia.org/wiki/Identity_matrix) of order \( n \).

This is a very simple task, but there are plenty of interesting ways we can accomplish this. Let's dive into some serious solutions first, and then we'll look at some more fun and innovative methods afterward.

## Generating an Identity Matrix

Let's say we want to create a \( 5 \times 5 \) identity matrix. We define our number \( n \) as 5, and therefore, we want to create a matrix of dimensions \( n \times n \).

### Method 1: Using Indices

1. **Calculate Indices**: Generate all the indices of an array of shape \( 5 \times 5 \).
2. **Compare Indices**: By comparing each horizontal and vertical index, we can see where they are the same, which gives us the identity matrix.

This can be achieved using the following APL code that defines a function with dyadic transpose:

```apl
identityMatrix ← {
  s ← ⍵ ⍵⍴0 ⋄ (1 1⍉s)←1 ⋄ s 
}
```

### Method 2: Inequality Table

Instead of generating indices for the entire matrix, we can:

1. **Generate Indices Until \( n \)**: Only generate the indices up to \( n \).
2. **Use Outer Product**: Create an inequality table using the outer product and the self-commute operator to generate the identity matrix directly.

Here’s a simple approach:

```apl
B←(∘.=⍨⍳) ⍝ Equality table for one-dimensional indices
```

### Method 3: Creating an Empty Matrix

An effective approach:

1. **Initialize Matrix of Zeros**: Start by creating a matrix filled with zeros of shape \( n \times n \).
2. **Use Dyadic Transpose**: Apply dyadic transpose to select the diagonal.
3. **Selective Assignment**: Set the diagonal elements to 1.

We can express this in APL as follows:

```apl
identityMatrix ← {s←⍵ ⍵⍴0 ⋄ (1 1⍉s)←1 ⋄ s} 
```

This method may be verbose, but it works effectively.

### Method 4: Using the Add Operator

We can generate indices that we need to set to 1 by initializing a vector and using selective assignments. Here’s another approach:

```apl
{1@(,⍨¨⍳⍵)⊢⍵ ⍵⍴0} ⍝ Amend at (i,i)
```

### More Innovative Solutions

We can create identity matrices using different strategies such as vectors or even base conversions.

#### Encoding

We can encode the positions in a special radix. Starting with our indices, we can rearrange them to obtain the diagonals:

```apl
A ← (⍴∘2⊤2*⊢-⍳) ⍝ Powers of two are 1 0 0 …
B ← {(⍵⍴2)⊤(2*(⍵-(⍳⍵)))} ⍝ Tacit help
```

### Fun Techniques with Randomness

For a twist, we can generate a matrix of random numbers and explore the properties of [matrix multiplication](https://en.wikipedia.org/wiki/Matrix_multiplication) to derive our identity matrix indirectly.

Using the following function, you can perform matrix multiplication to see how it behaves with the identity matrix:

```apl
A ←{⌹⍨?⍵ ⍵⍴0}  ⍝ M × I = M
```

### Complex Numbers

We can also utilize [complex numbers](https://aplwiki.com/wiki/Complex_number) in generating an identity matrix, leveraging their unique properties to find the identity matrix through argument calculation and magnitude assessments.

```apl
A ← {4=○÷12○⍵∘.+0j1×⍵}⍳     ⍝ π÷4 = arg(a+ai)
B ← {0=(2*÷2)||⍵∘.+0j1×⍵}⍳ ⍝ |a+ai| = 0 mod √2
```

## Summary

Throughout this exploration, we've uncovered various methods to create an identity matrix in APL, from straightforward to more complex and innovative solutions. Whether it's the classic method utilizing indices or adopting clever tricks such as random numbers or complex calculations, each method provides a unique perspective on the task.

Feel free to choose whichever method works best for you, whether for practical purposes or just for fun programming exercises.

[Thank you for watching!](https://youtu.be/vVaZ3wEdmpQ)
