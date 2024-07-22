
# Calculating Percentage of Characters in a DNA String

In this article, we will explore how to calculate the percentage of characters in a given character vector that are either the uppercase letter **C** or the uppercase letter **G**. Let’s dive into the process to determine this percentage using an example with a DNA string.

## Step 1: Identify Characters

First, we need to identify which letters in our DNA string are **C** and **G**. We can achieve this by using a membership function, where one argument is pre-filled. We bind an argument to it, specifying our lookup array containing **C** and **G**. This will give us a Boolean vector, where each character is represented by a bit indicating whether it is a **C** or a **G**.

For example, if we take the DNA string `GATTACCA`, we can represent which characters are **C** or **G** with the following APL expression:

```apl
(∊∘'CG') 'GATTACCA'
```
This would yield a Boolean vector:
```
1 0 0 0 0 1 1 0
```
Here, `1` indicates the presence of **C** or **G**, and `0` indicates otherwise.

## Step 2: Calculate the Fraction

To find the percentage of **C** and **G** in the string, we sum these Boolean values and divide the result by the length of the character vector. We then multiply by 100 to express it as a percentage.

Here's the process in clearer mathematical terms:

1. Let `total_cg` be the sum of the Boolean values indicating **C** and **G**. We can calculate this like so:

```apl
(+/∊∘'CG') 'GATTACCA'
```
This gives us:
```
3
```

2. Let `length` be the total length of the character vector, which can also be calculated using APL:

```apl
≢ 'GATTACCA'
```
This yields:
```
8
```

3. The percentage can be calculated as follows:

   \[
   $\text{percentage} = \left( \frac{\text{total\_cg}}{\text{length}} \right) \times 100$
   \]

Using these values in APL, the calculation would be:

```apl
(100×(+/∊∘'CG')÷≢)'GATTACCA'
```
This results in:
```
37.5
```

For example, if the calculation yields **37.5%**, it indicates that **C** and **G** make up 37.5% of the total characters.

## Step 3: Optimize the Calculation

However, notice that we may not be using the most efficient method because we are performing both summation and division. To enhance efficiency, we can combine these operations.

Instead of dividing each Boolean before summing, it is better to sum them first and then divide, which can be expressed as:

\[
\text{percentage} = \left( \text{sum}(\text{Boolean values}) \times 100 \right) / \text{length}
\]

This approach reduces the number of operations involving division. In APL, we can express this as:

```apl
((100+.×∊∘'CG')÷≢)'GATTACCA'
```
This returns:
```
37.5
```

Alternatively, we can factor the operations differently:

- Multiply the total length by 100 before summing the Boolean values, as shown here:

```apl
(≢ ÷ ⍨ 100 +.× ∊ ∘ 'CG') 'GATTACCA'
```
This also results in:
```
37.5
```

## Conclusion

In summary, calculating the percentage of **C** and **G** in a DNA string can be approached in various ways. We demonstrated a straightforward method followed by opportunities for optimization and manipulation of the calculations to enhance efficiency.

Thank you for reading!
