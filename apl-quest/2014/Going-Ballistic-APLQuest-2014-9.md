# APL Quest

Welcome to the APL Quest

## Quest Overview

Today’s quest is the 9th from the 2014 round of the APL Problem Solving Competition. We are tasked with computing how far an object reaches based on the angle and velocity at which it is thrown. 

Although the angle and velocity are given, we have a formula ready to use. All we need to do is translate it into APL code.

## The Formula

The distance \( d \) can be computed using the following formula:

$[ d = \frac{v^2 \cdot \sin(2\theta)}{g} ]$

where:
- \( g = 9.8 \) (gravitational constant)
- \( v \) is the velocity
- \( \theta \) is the angle in radians

Since the angle is provided in degrees, we need to convert it by multiplying by \( \frac{\pi}{180} \).

### Simplification

We can simplify the expression by doing the following transformations:

1. Instead of using $( \sin(2\theta) )$, we can multiply and divide by \( 2 \) and use $( \sin(90) )$.
2. This allows us to divide by 90 instead of 180, which keeps the expression neat.

In APL, the distance can be calculated using the following function:

```apl
D ← {9.8 ÷ ⍨ (⍺ * 2) × 1 ○ 2 × ○ ⍵ ÷ 180}
```

This allows us to compute the distance given initial velocity and angle using the provided formula.

### Testing Values

We can test various velocities and angles. For example, if we set:

```apl
v ← 100 0 100 
a ← 45 45 90
v D a
```

We might observe that when using an angle of 90 degrees, the distance won’t quite be zero due to floating-point inaccuracies. An object thrown straight up will return to the origin, resulting in no horizontal displacement.

### Challenge

To make this more interesting, a challenge was proposed: implement the calculation without using the `circle` function, which we currently require for the sine function and for multiplying by \( $\pi$ \).

## Implementing Sine Function

We can use a Taylor series expansion for the sine function:

\[ $\sin(x) = \sum_{n=0}^{\infty} \frac{(-1)^n \cdot x^{2n+1}}{(2n+1)!}$ \]

We can calculate the alternating sum with only a few terms for a sufficiently accurate result. In APL, this can be implemented as follows:

```apl
Sin ← {-/(⍵ ∘ * ÷ !) ¯1 + 2 × ⍳ 9}  ⍝ Taylor series
```

Let’s test this against the native sine function to confirm its accuracy.

## Implementing Pi

To compute \( \pi \), one option is to use **Euler's identity**:

\[ $e^{i \cdot \pi} + 1 = 0$ \]

First, we can isolate \( $e^{i \cdot \pi}$ \) by rearranging the equation and applying the logarithm. In APL, we compute this as follows:

```apl
0 = 1 + * ○ 0 J 1  ⍝ Euler's identity
¯1 = * ○ 0 J 1
(⍟ ¯1) = ○ 0j1
(0J1 × ⍟ ¯1) = ○ ¯1
(0J ¯1 × ⍟ ¯1) = ○ 1
0J ¯1 × ⍟ ¯1
```

While this method may seem like “cheating,” as it leverages the properties of logarithms and complex numbers, we can also use a series approach.

### Series Approach for Pi

The simplest series approximates \( $\frac{\pi}{4}$ \):

\[ $\sum_{n=0}^{\infty} \frac{(-1)^n}{2n + 1}$ \]

However, even with many terms, it converges slowly. A more effective series for \( $\pi$ \) can be implemented in APL as follows:

```apl
pi ← 4 × -/ ÷ ¯1 + 2 × ⍳ 999
pi = ○ 1
pi - ○ 1
```
or a faster convergence version:

```apl
pi ← (12 * ÷ 2) × -/ ÷ (3 ∘ * × 1 + +⍨) 0, ⍳ 99
pi = ○ 1
pi - ○ 1
```

### Calculation

By simplifying the series and performing calculations, we can compute values exceedingly close to the official value of \( \pi \). By utilizing this, we can now substitute our sine and pi calculations back into the initial formula.

## Final Computation

The final distance \( d \) can now be computed as:

\[ $d = \frac{9.8}{\alpha} \cdot \alpha \cdot \sin\left(\frac{\pi \cdot \text{angle}}{90}\right)$ \]

Using the following APL expression:

```apl
{9.8 ÷ ⍨ ⍺ × ⍺ × Sin pi × ⍵ ÷ 90}
```

Using `each` effectively allows us to compute the results for various inputs, leading us to satisfactory values even for extreme angles. 

Thank you for watching!