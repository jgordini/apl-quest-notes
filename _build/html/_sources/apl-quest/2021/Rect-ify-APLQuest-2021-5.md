
# Finding Rectangle Dimensions with Given Area

In this article, we will explore a problem that involves creating a rectangle (or square) with a specified area, under certain restrictions. The goal is to ensure that the dimensions of the rectangle are integers. If the rectangle is not a square, the smaller side will be listed first. 

## Example: An Area of 12

Let’s take 12 as an example. This area is interesting because it can be obtained through several different integer multipliers. For instance, we can multiply:

- $$( 1 \times 12 )$$
- $( 2 \times 6 )$
- $( 3 \times 4 )$

Among these combinations, the only factorization that results in a rectangle closest to being a square is \( 3 \times 4 \). However, since 3 and 4 do not equal each other, this means we cannot form a square from this area. The aim here is to create a rectangle that is as square as possible.

## Finding Candidates

To solve this, we need to look at all integers that can potentially compose the dimensions of our rectangle, ensuring these values do not exceed our area (12). Excluding zero, we consider integers from 1 to 12. 

Next, we want to determine which of these integers can evenly divide 12. We can use modulus operation to find out the divisors. 

### Divisors of 12

The integers that divide 12 evenly are found as follows in APL:

```apl
⍳ 12
⍝ 1 2 3 4 5 6 7 8 9 10 11 12
```

These are the integers from 1 to 12. To find the divisors, we check for non-zero remainders:

```apl
(⍳|⊢) 12
⍝ 0 0 0 0 2 0 5 4 3 2 1 0
```

From this, the integers that divide 12 evenly (i.e., yield a remainder of zero) are:

- 1 **(0 remainder)**
- 2 **(0 remainder)**
- 3 **(0 remainder)**
- 4 **(0 remainder)**
- 5 **(non-divisor)**
- 6 **(0 remainder)**
- 12 **(0 remainder)**

So, the valid divisors are **1, 2, 3, 4, 6, 12**.

## Identifying the Middle Values

Out of these divisors, we want to find the two middle values. The valid divisors can be arranged as:

- 1, 2, 3, 4, 6, 12

Using APL, we can find the indices of zero remainders:

```apl
((⍸)0=⍳|⊢) 12
⍝ 1 2 3 4 6 12
```

Here, the middle values are **3** and **4**. 

### Efficiently Finding Dimensions

Instead of manually looking for middle values, we can streamline the process a bit. We can replicate our divisors list to ensure we have pairs of each value, and then we can remove the first half of the list (which contains our smallest values) and look at the next two elements. 

When we apply the APL code to get the pairs and find the middle values:

```apl
((0,2/⍸)0=⍳|⊢) 12
⍝ 0 1 1 2 2 3 3 4 4 6 6 12 12
((+/↓0,2/⍸)0=⍳|⊢) 12
⍝ 3 4 4 6 6 12 12
((2↑+/↓0,2/⍸)0=⍳|⊢) 12
⍝ 3 4
```

The dimensions of our rectangle are **3** and **4**.

## Solution Summary

To summarize, for an area of 12:

- The rectangle dimensions that fulfill the criteria are **3** and **4**.
- If the area were **0**, the output would be consistent, and we handled that in our method.

```apl
((2↑+/↓0,2/⍸)0=⍳|⊢) 0
⍝ 0 0
```

Thank you for engaging with this exploration of rectangle dimensions based on integer areas!
