# Outer Product in APL: A Comprehensive Overview

## Introduction

The outer product is a fundamental concept in APL (A Programming Language) that allows for powerful array operations. Introduced by Kenneth E. Iverson, the creator of APL, outer product has been a key feature of array programming languages since the early days of APL, predating its adoption in other programming paradigms.

### 1. Function Application

In APL, function application can be either prefix (monadic) or infix (dyadic). Let's see some examples:
```apl
7 + 4  ⍝ Infix function: addition
- 2    ⍝ Prefix function: negation
2 ! 5  ⍝ Ways to choose a set of 2 items out of 5
times ← ×
9 times 1
```
### 2. Order of Operations

APL has no precedence ordering among functions. It evaluates from right to left.
```apl
4 + 3 ÷ - 2 × 2
```
This evaluates as:
1. `2 × 2` gives `4`
2. `- 4` gives `-4`
3. `3 ÷ -4` gives `-0.75`
4. `4 + -0.75` gives `3.25`

### 3. Kinds of Arguments

In Dyalog APL, the two main types of data are:
- Numbers (complex using 64-bit IEEE binary floats for components)
- Characters (unicode code points)

### 4. Lists

Two or more arguments with no functions in between form a list.
```apl
3 2 1 × 2 4 6  ⍝ Element-wise multiplication
'λ' (4.5 2.2) 'string' = 'r'  ⍝ Element-wise equality
```
### 5. Functions as Arguments

Besides arguments and functions, APL has operators which take functions as operands, forming new functions.
```apl
2 -⍨ 5  ⍝ Commute operator exchanges arguments
-⍨ 4    ⍝ Duplicates argument, places it on left and right
```

### 6. Operator Valence

Unlike functions, which take one or two arguments depending on context, each APL operator always takes only one operand or always takes two.
```apl
⌊/ 2 0 3 5 4  ⍝ Reduction (fold)
2 ⌊/ 2 0 3 5 4  ⍝ Windowed reduction
-∘÷ 0.5  ⍝ Composition
3 -∘÷ 0.5
```
### 7. Parsing Precedence

Order of evaluation in APL:
1. Stranding (associative)
2. Operators (left-to-right)
3. Functions (right-to-left)

### 8. Multiplication Table with Outer Product

The outer product is an essential concept in APL. It generalizes the idea of matrix multiplication.
```apl
∘.×⍨ 1+⍳12
```
This creates a 12x12 multiplication table.

### 9. Character Equality

APL allows operations on character arrays.
```apl
'abcd' ∘.= 'cabbage'
+/ 'abcd' ∘.= 'cabbage'
```
### 10. Pascal's Triangle

Using outer products, you can generate Pascal's triangle.
```apl
∘.!⍨ ⍳12
```
This uses the combination function to generate the values.

### 11. Exchanging Arguments

The commute operator `⍨` is useful for reversing arguments.
```apl
10 20 30 ∘.- 1 2 4 8
1 2 4 8 ∘.- 10 20 30
```
### 12. Commutativity

You can check if a function is commutative using outer product and transposition.
```apl
{(⍵)(⍉⍵)} ∘.<⍨ ⍳4
{(⍵)(⍉⍵)} ∘.=⍨ ⍳4
{⍵≡⍉⍵} ∘.=⍨ ⍳4
```
### 13. Multiple Outer Products

You can chain outer products to compute higher-dimensional results.
```apl
1 2 4 ∘.× 1 3 ∘.× 1 5
```
### 14. Associativity of Outer Product

The outer product is associative.
```apl
'I.' 'II.' ∘., '1.' '2.' '3.' ∘., 'abcde'
```
### 15. Array Programming and Shape

Arrays are central to APL. The shape of an array is crucial in understanding its structure and operations.
```apl
(⍳2) ∘., (⍳3) ∘., (⍳4)
⍴ (⍳2) ∘., (⍳3) ∘., (⍳4)
```
### 16. Nested Lists and Leading Axis Theory

In modern APL, arrays are often treated as lists of major cells.
```apl
⊢d ← 2 3 4 ∘.∨ 2 3 6 7
≢d
∪d
```
### 17. Empty Arrays

Empty arrays in APL still retain their shape.
```apl
(⍳2) ∘.× ⍬ ∘.× (⍳4)
⍴ (⍳2) ∘.× ⍬ ∘.× (⍳4)
```
### 18. Identity Elements for Outer Product

The identity element for an outer product needs to be an array whose shape is the empty list.
```apl
⍴⍬
20 30 ∘.+ 0 ∘.+ 3 4 5 6
⊂⍬
((⍳2 3) ∘., (⊂⍬) ∘., (⍳4 5))  ≡  (⍳2 3) ∘., (⍳4 5)
```
### 19. Array Attributes and Everything is an Array

Arrays have various attributes like shape, bound, tally, and rank.
```apl
array  ⍝ Rank 2 array
shape  ⍝ Shape of the array
bound  ⍝ Total number of elements
tally  ⍝ Number of major cells
rank   ⍝ Number of dimensions
```
### 20. Rank Operator

The rank operator `⍤` allows you to specify the rank of arrays that a function operates on.
```apl
⊂⍤2
```
### 21. Reverse with Rank

The rank operator can be used to apply functions to subarrays.
```apl
⊢a←2 3 6⍴⍳36
⌽⍤2⊢a
⊖⍤2⊢a
```
### 22. More Functions with Rank

The rank operator can also work on multi-axis functions.
```apl
+⌿⍤2⊢A
+⌿⍤1⊢A
2↓⍤2⊢A
2↓⍤1⊢A
```
### 23. Dyadic Functions with Rank

Dyadic functions can also be applied with rank.
```apl
'rank' ∊ 'array'
'rank' ∊ ↑'array' 'shape' 'bound'
```
### 24. Scalar Extension

Scalar extension allows functions to work on arrays by extending scalar arguments.
```apl
2 * ⍳6
(⍳6) * 2
(⍳6) * ⍳6
```
### 25. Functional Programming and Functors

Functors can be used in functional programming to map functions over arrays.
```apl
map f x
```
### 26. Typed Functions

Haskell's type system allows you to define functions that work on lists of different types.
```haskell
map f x
```
### 27. Outer Product with Functors

You can define the outer product using functors in Haskell.
```haskell
map compose f
```
### 28. Split Compose

The outer product on functions can be derived from functional programming concepts.
```haskell
outer f g h
```
### 29. Using the Rank Operator

The rank operator in APL allows you to perform complex operations on multi-dimensional arrays.
```apl
'abc' ∘., 'def'
'abc' ∘.× 'def'
```
### 30. Combining Functional Programming with APL

Combining concepts from functional programming with APL can lead to powerful abstractions and concise code.
```haskell
outer f g h
map compose f
```

In APL, the outer product is denoted by the symbols `∘.` (pronounced "jot dot") followed by a function. The syntax is somewhat unusual compared to other APL operators, as it appears to the left of its operand function. This is due to its historical development as a special case of the inner product.

Example:

```apl
      1 2 3 ∘.× 4 5 6
4  5  6
8 10 12
12 15 18
```

This creates a multiplication table between the two input vectors. The outer product applies the given function (in this case multiplication) to every pair of elements from the two input arrays.

### Key Properties

1. Shape: The shape of the result is the concatenation of the shapes of the input arrays.
2. Rank: The rank of the result is the sum of the ranks of the input arrays.
3. Associativity: If the function used in the outer product is associative, the outer product itself is associative.

### Commutativity

If we exchange the arguments of an outer product, two things happen:

1. Every single application of the function is reversed.
2. The axes are reversed (as the first argument is always laid out vertically and the second horizontally).

This can be expressed mathematically as:

```apl
      X ∘.F Y ≡ ⍉ Y ∘.(F⍨) X
```

Where `⍉` is the transpose function and `F⍨` is the commute operator applied to F.

### Associativity

If the function F is associative, then the outer product preserves this associativity. This property is particularly useful when working with nested outer products.

## Applications

### Multiplication Tables

One of the simplest applications is creating multiplication tables:

```apl
      ∘.×⍨ 1+⍳12
```

This generates a 12x12 multiplication table. The `⍨` operator is used here to apply the function to a single argument, effectively squaring the list.

### Character Equality

Outer product can be used for string operations:

```apl
      'abcd' ∘.= 'cabbage'
0 1 0 0 1 0 0
0 0 1 1 0 0 0
1 0 0 0 0 0 0
0 0 0 0 0 0 0

      +/ 'abcd' ∘.= 'cabbage'
2 2 1 0
```

The first operation checks each character in 'abcd' against each character in 'cabbage'. The second operation counts the occurrences of each character from 'abcd' in 'cabbage'.

### Combination Generation

Outer product is useful for generating combinations:

```apl
      meat ← 'Chicken' 'Pork' 'Beef'
      style ← 'fried rice' 'lo mein' 'and broccoli' 'with black bean sauce'
      meat ∘.{⍺,' ',⍵} style
┌──────────────────┬───────────────┬────────────────────┬─────────────────────────────┐
│Chicken fried rice│Chicken lo mein│Chicken and broccoli│Chicken with black bean sauce│
├──────────────────┼───────────────┼────────────────────┼─────────────────────────────┤
│Pork fried rice   │Pork lo mein   │Pork and broccoli   │Pork with black bean sauce   │
├──────────────────┼───────────────┼────────────────────┼─────────────────────────────┤
│Beef fried rice   │Beef lo mein   │Beef and broccoli   │Beef with black bean sauce   │
└──────────────────┴───────────────┴────────────────────┴─────────────────────────────┘
```

This generates all combinations of meat and cooking styles.

### Pascal's Triangle and Sierpinski's Triangle

Outer product can be used to generate mathematical structures:

```apl
      ∘.!⍨ ⍳12  ⍝ Pascal's Triangle

      2 | ∘.!⍨ ⍳16  ⍝ Sierpinski's Triangle

```

### Multiple Outer Products

Outer products can be chained to create multi-dimensional results. For example, to find all divisors of 60:

```apl
      1 2 4 ∘.× 1 3 ∘.× 1 5
 1  5
 3 15

 2 10
 6 30

 4 20
12 60
```

## Relationship to Functional Programming

The outer product in APL has interesting parallels in functional programming:

1. It can be expressed as a composition of maps:

   ```haskell
   outer f xs ys = map (\x -> map (f x) ys) xs
   ```

2. It preserves the associativity of its operand function.

3. In terms of functors, outer product can be seen as a nested application of fmap:

   ```haskell
   outer f x y = fmap (fmap f x) y
   ```

4. The outer product can be decomposed into two applications of `map`:

   ```haskell
   rmap = map .
   lmap = flip . rmap . flip
   outer = lmap . rmap
   ```

5. In point-free style, outer product can be expressed as:

   ```haskell
   outer = flip . map . flip . map
   ```

## Identity Element

The identity element for outer product depends on the function being used. For example:

- For addition (`+`), the identity element is a scalar 0.
- For multiplication (`×`), the identity element is a scalar 1.
- For catenation (`,`), the identity element is an enclosed empty list (`⊂⍬`).

Understanding the identity element is crucial for certain array operations and for maintaining the monoid properties of outer product.

