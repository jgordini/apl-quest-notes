
# Ensure Odd Numbers Become Even Using APL

In this article, we'll explore how to use APL (A Programming Language) to transform all odd numbers in an array to even numbers. We will achieve this by incrementing the odd numbers by 1.

## Step 1: Define an Array

Let's begin by defining an array `A` that contains the numbers from 1 to 16.

```apl
A ← 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
```

After executing this assignment, we will have the following array. 

Next, we can modify this array by subtracting 5:

```apl
A ← A - 5
```

Now, we will have some negative numbers as well as positive numbers. To make this data more suitable for testing, we'll shape the array into a four by four configuration:

```apl
A ← 4 4⍴(⍳16) - 5
```
The resulting array will be:

```
¯4 ¯3 ¯2 ¯1
 0  1  2  3
 4  5  6  7
 8  9 10 11
```

## Step 2: Write the Function

Next, we will write a function that converts odd numbers into even numbers. Let's develop it piece by piece. This function is enclosed in braces to mark its limits.

```apl
F ← {⍵}
```

This identity function doesn't alter the input. Now we can modify this function to achieve our goal. To start, we can divide our input by 2, which will allow for scaling down:

```apl
F ← {⍵ ÷ 2}
```

APL's arithmetic automatically maps the operation to all elements of the array—even a multi-dimensional array like this one.

If we now apply this to our array:

```apl
F A
```
We would receive:

```
¯2 ¯1.5 ¯1 ¯0.5
 0  0.5  1  1.5
 2  2.5  3  3.5
 4  4.5  5  5.5
```

Next, if we round up, we will effectively add 0.5 to the odd numbers, which means we have halved their magnitude and can scale back up to add 1 instead of 0.5. 

Here's how we can implement rounding up (ceiling function):

```apl
F ← {⌈⍵ ÷ 2}
```

Thus, applying this to our original array:

```apl
F A
```

Results in:

```
¯2 ¯1 ¯1 0
 0  1  1 2
 2  3  3 4
 4  5  5 6
```

Now, we continue by multiplying by 2:

```apl
F ← {2 × ⌈⍵ ÷ 2}
```

This function will convert each odd number to one greater than itself while leaving the even numbers unchanged. Now we can apply our function `F` to array `A` without any extra parentheses or brackets:

```apl
F A
```
We obtain:

```
¯4 ¯2 ¯2  0
 0  2  2  4
 4  6  6  8
 8 10 10 12
```

## Step 3: Alternative Solution

Let's explore a different approach to achieve the same result. We previously noted that odd numbers yield a remainder of 1 when divided by 2. We can exploit this by incorporating the modulo operation. 

In APL, the remainder when dividing by 2 can be calculated with:

```apl
R ← {2 | ⍵}
```

In our context, we want to add either 1 (for odd numbers) or 0 (for even numbers). Thus, we can define our new function `G`:

```apl
G ← {⍵ + 2 | ⍵}
```

Applying `G` to our array `A` will yield:

```apl
G A
```

The output will be:

```
¯4 ¯2 ¯2  0
 0  2  2  4
 4  6  6  8
 8 10 10 12
```

## Conclusion

We have explored two elegant solutions to ensure that all odd numbers in an array become even numbers while keeping the even numbers unchanged. In summary, APL provides powerful tools for mathematical operations that can simplify complex transformations in your data.

Thank you for reading!