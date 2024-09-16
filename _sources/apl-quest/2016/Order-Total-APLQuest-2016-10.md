
# Welcome to the APL Quest

Welcome to the APL Quest! For more details, please refer to the APL Wiki. Today’s Quest is the 10th and last of the 2016 round in the EPL problem-solving competition.

## The Problem

We are given a bunch of prices along with the quantities of each item that were purchased, and we are tasked with calculating the total amount that this purchase sums up to. 

Here, we have the number of items bought and their corresponding prices. Mathematically, this is quite simple. We can multiply the quantities by the prices, and APL will automatically vectorize the operation. 

For example:
- 5 gets multiplied by 2.99
- 0 gets multiplied by 4.99
- 2 gets multiplied by 1.99

These calculations give us the total prices per item type.

## Calculating the Total

To find the overall total amount, we can use the summation function. In APL, we achieve this by using the `+` reduction operator, denoted by `+/`. 

For instance, the total can be computed as follows:

```apl
total = +/ 5 0 2 × 2.99 4.99 1.99
```
This gives us the total amount. It's a straightforward solution, but we can also create a single function to solve the problem.

## Creating an Anonymous Function

Using braces `{}`, we can create an anonymous lambda function. The left argument is represented by `α` (alpha) and the right argument by `ω` (omega). In our function, we multiply the quantities by the prices and then sum the results:

```apl
total = 5 0 2 {+/⍺×⍵} 2.99 4.99 1.99
```

This serves as a covering function for multiplication. We can chain this with the summation to produce the final solution.

### Point-Free Programming

A neat technique called "point-free programming" allows us to write the function without explicitly mentioning the arguments. By changing the braces to parentheses, we can create a single function known as a "train":

```apl
total = 5 0 2 (+/×) 2.99 4.99 1.99
```

In this scenario, the right function receives the arguments of the overall function, and its result is then fed into the left function.

## Higher-Order Functions

APL provides a powerful operator called `⊃` ("atop"), which is a higher-order function that combines the summation on the left with multiplication on the right. It effectively applies the right-hand function first and feeds the result into the left-hand function.

```apl
total = 5 0 2 +/ ⊃ × 2.99 4.99 1.99
```

Another useful operator is the dot product operator `.` , which computes the inner product of two vectors. This is equivalent to performing a dot product, so this approach will also work:

```apl
total = 5 0 2 +.× 2.99 4.99 1.99
```

## Why Use Dot Product?

You might ask, what’s the advantage of using these techniques rather than simply performing a sum over the multiplication? There are both technical and practical reasons for this.

### Technical Reasons

1. The interpreter recognizes this combination instantly and optimizes the underlying code for performance. 
2. Instead of executing two nested loops (for multiplication followed by summation), it fuses the operations, resulting in faster execution.

### Practical Reasons

Suppose we have two customers with different quantities of items. For instance:
- Customer 1 purchases: 5 of item A and 2 of item B.
- Customer 2 purchases: 50 of item A and 20 of item B.

We can represent these purchases in a matrix format. This helps us visualize it as records per customer, able to compute sums individually.

By reshaping the data into two rows and three columns, we create a matrix that looks like this:

```apl
matrix = 2 3⍴5 0 2 50 0 20
```

When we perform the operations, it’s critical to ensure correct dimensional alignment. We need parentheses during multiplication to avoid dimension errors. Using the dot operator allows us to correctly compute our results:

```apl
result = (matrix) +.× 2.99 4.99 1.99
```

If we attempted to multiply the matrix directly with a single vector, we would encounter a length error. Hence, using the dot operator or inner product is essential whenever possible.

## Conclusion

Thank you for watching! This concludes our introduction to the APL Quest and the effective problem-solving techniques in APL.
