
# Finding a Reduced Fraction for a Given Number

In this article, we'll explore how to find a reduced fraction for a given number using an example. Let's take the number **1.2** and go through the solution together.

## Step-by-Step Solution

To begin, let's start with the actual full solution:

**1.2 can be expressed as 6/5.**

This approach utilizes a concept known as "the fork," which binds a left argument to a mathematical operation. In this case, we can think of it as finding the lowest common multiple for the numbers involved.

### Understanding the Fork Operation

The fork operation resembles the symbol for "n," but here it extends to represent the **lowest common multiple** (LCM). The LCM is calculated by dividing it by the concatenation of the arguments involved.

To expand this concept, we define two arguments:
- **Alpha**: the left argument (in our case, 1)
- **Omega**: the right argument (here we use 1.2)

The process we follow involves calculating the **lowest common multiple** of both arguments divided by their concatenation.

In APL, this can be represented using the following expression:
```apl
1∘(∧÷,) 1.2
```
This will yield the result:
```apl
⍝ 6 5
```

### What is the Lowest Common Multiple?

The LCM here is distinct from how we typically perceive it since it involves decimal numbers. To illustrate, we substitute our bound argument into the function literally.

When considering the LCM of **1.2** that is also divisible by 1, we multiply 1.2 by integers to find a whole number:

- **1.2 × 1 = 1.2**
- **1.2 × 2 = 2.4**
- **1.2 × 3 = 3.6**
- **1.2 × 4 = 4.8**
- **1.2 × 5 = 6**

Thus, the lowest common multiple (LCM) of **1** and **1.2** becomes **6**.

### Constructing the Fraction

Now that we established our LCM, we can represent the fraction as follows:

- The LCM, which is **6**, is used to form the numerator.
- The concatenation of 1.2 and 1 gives us the denominator:
  

So, the fraction formed is:

\[
$\text{Fraction} = \frac{6}{1.2}$
\]

In APL, we can express this fraction calculation using:
```apl
{(1∧⍵)÷(1,⍵)} 1.2
```

This produces the same result:
```apl
⍝ 6 5
```

To find the reduced form, we divide:
$$
[
\frac{6}{1} = 6
]
[
\frac{6}{1.2} = 5
]
$$
Thus, the final reduced fraction for **1.2** is:

$[\frac{6}{5}]$

### Conclusion

We have explored how to determine the reduced fraction for the number **1.2**, arriving at the result of **6/5**. This process highlights the use of the lowest common multiple and the concept of fractions.

We can also validate the consistency of our calculations with additional APL functions:

```apl
{(6÷1),(6÷⍵)} 1.2
```
```apl
⍝ 6 5
```

And another variant:
```apl
{6,6÷⍵} 1.2
```
```apl
⍝ 6 5
```

Thank you for reading!