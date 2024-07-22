
# Welcome to the APL Quest

Welcome to the APL Quest! For more details, please refer to the [APL Wiki](https://aplwiki.com). This is the first problem of the 2014 set from the APL Problem Solving Competition.

## Problem Statement

We are given the left argument, which consists of the two supposed shorter sides of a triangle, and the right argument, representing the longer side. Our task is to check if these three numbers can indeed form the lengths of a right-angled triangle.

### Approach

It is natural to use the Pythagorean theorem to solve this problem. Let's examine some test cases:

1. Shorter sides: `2` and `4`. Longer side: `4.5` → Result: **False**
2. Shorter sides: `3` and `4`. Longer side: `5` → Result: **True**

According to the Pythagorean theorem, the sum of the squares of the two shorter sides must equal the square of the longer side. We can express this as an APL function:

```apl
{(+/⍺*2)=⍵*2}
```

### Mathematical Representation

We can express this mathematically using the concept of self-multiplication or squaring:

1. The square of a number is the same as multiplying the number by itself.
2. The sum of the squares can be represented as an inner product of the shorter sides.

Given this, we can rewrite our check as:

```apl
(sum of squares of shorter sides) = (square of longer side)
```

### Simplification

We can preprocess both arguments with self-multiplication (squaring) and then sum the left argument:

```apl
sum(left_arguments) = right_argument
```

This can be effectively represented in APL as:

```apl
=∘(+/)⍨⍥(×⍨)
```

Alternatively, we could break out the multiplication:

1. **Commuting Arguments**: We may preprocess one argument and then check for equality.
2. **Reduction Over a Single Element**: Notably, a reduction of a single element doesn't change its value, allowing us to fold these operations effectively.

For a reduction, we can use:

```apl
(+/⍤⊣=⊢)⍥(×⍨)  ⍝ break out the squaring
```

### Complex Number Approach

Another approach is to represent the two shorter sides as components in the complex plane. We can represent the sides as:

```
z = a + bi
```

Where `a` and `b` are the two shorter sides. The magnitude of the vector is given by the absolute value, which we can derive as follows:

1. Multiply the last element of the left argument by the imaginary unit.
2. Take the absolute value and compare it with the right argument.

In APL, we can calculate the magnitude of a complex number using:

```apl
{⍵=|(⊃⍺)+0J1×⊢/⍺}
```

### Final Solution Using Domain Concepts

We can solve this using the **Domino** function, which represents a ratio between the inversions of both arguments:

1. Apply the function to both arguments.
2. Check if it matches the original ratio.

This method of inversion can be represented in APL as:

```apl
÷⍥⌹≡÷
```

This is derived from:

```apl
⍝ Derivation:
{((⌹⍺                ) ×⍵) ≡ ⍺÷⍵}  ⍝ unpacked
{((⍺ ÷ ((+/⍺*2)*÷2)*2) ×⍵) ≡ ⍺÷⍵}  ⍝ ⌹⍺ is equivalent to scaling ⍺ down by the square of its diagonal
{((⍺ ÷   +/⍺*2       ) ×⍵) ≡ ⍺÷⍵}  ⍝ *÷2 and *2 cancel out each other
{((  ÷   +/⍺*2       ) ×⍵) ≡  ÷⍵}  ⍝ divide both sides by ⍺
{( ⍵ ÷   +/⍺*2       )     ≡  ÷⍵}  ⍝ move ⍵
{(      (+/⍺*2)÷⍵    )     ≡   ⍵}  ⍝ reciprocal on both sides
{       (+/⍺*2)            ≡ ⍵*2}  ⍝ multiply by ⍵ on both sides
{(+/⍺*2)=⍵*2}
```

## Conclusion

In summary, we explored multiple approaches to determine if three lengths can form a right-angled triangle. We verified our solutions with test cases, ensuring the correctness of our methods. Notably, all methods converge on the fundamental principles of geometry and algebra, leading to the same outcome defined by the Pythagorean theorem.

Thank you for participating in this APL Quest!
