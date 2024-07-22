# Splitting Numbers into Integer and Fractional Parts

In this article, we will explore how to take a number and split it into its integer part and its fractional part. Let's start with a number example, and we'll understand the process step by step.

## Getting the Integer Part

To retrieve the integer part of a number, we can use the floor function. The floor function essentially rounds down the number to the nearest integer. You can think of the floor as a "stylish wall" beside the number. 

For instance, if our number is 1.2345, using the floor function will give us:

```apl
⌊1.2345
```
```
1
```

On the other hand, there is also a ceiling function, which rounds the number up. However, in our case, we are focusing on flooring, which gives us the integer part. 

We can also use a direct application of the floor function in a more functional form:

```apl
(⌊)1.2345
```
```
1
```

## Subtracting to Find the Fractional Part

Once we have the integer part, we can subtract it from the original number to obtain the fractional part. This can be conceptualized as creating a "train" or a special construct that refers to the function in terms of its application. 

If we denote this operation as:

```apl
fractional_part = original_number - floor(original_number)
```

In APL, this would look like:

```apl
(⊢-⌊)1.2345
```
```
0.2345
```

By using this operation, we can effectively separate the integer and fractional parts of the original number. We can combine both operations to get both parts together:

```apl
(⌊,⊢-⌊)1.2345
```
```
1 0.2345
```

## Alternative Methods: Division Remainder

Another method to derive the integer and fractional parts involves using division and the remainder. 

When you divide using integer math, you might end up with a remainder. For example, if we divide 10 by 3, we get an integer result of:

```apl
10 ÷ 3
```
```
3.333333333
```

The expression "3 divides 10" would give us a remainder of:

```apl
3|10
```
```
1
```

If we proceed to divide by numbers like 11, we would get:

```apl
3|11
```
```
2
```

But what if we have a number that is not a whole number? If we divide it by 1, the integer part remains the same, but the remainder reflects the fractional part. 

To obtain the fractional part via a division remainder, we can express it as follows:

```apl
1|1.2345
```
```
0.2345
```

We can synthesize it with our earlier floor operation. If we bind zero as the argument and utilize the remainder function, we can create a streamlined function that efficiently returns both the integer and fractional parts:

```apl
(⌊,1∘|)1.2345
```
```
1 0.2345
```

## A Neat Trick Using Encode

Let's also look at a more direct method using the encode function. For example, consider a movie that lasts 96 minutes. We might want to convert this to hours and minutes. 

With the encode function, represented metaphorically as a "T", we can easily convert 96 minutes into a more digestible format, like so:

```apl
0 60⊤96
```
```
1 36
```

Now, if we wanted to convert 96.5 minutes (or 96 minutes and 30 seconds), the encode function can show us how the fractional part would work out as overflow to the next unit. We can see:

```apl
0 60⊤96.5
```
```
1 36.5
```

And if we adjust the encoding to encapsulate hours and minutes for a non-integer value:

```apl
0 1⊤96.5
```
```
96 0.5
```

If we want to get the integer and fractional parts from a simple number like 1.2345:

```apl
0 1⊤1.2345
```
```
1 0.2345
```

We can generalize this with a compact approach:

```apl
0 1∘⊤ 1.2345
```
```
1 0.2345
```

In conclusion, to convert between these forms seamlessly, we can bind together the use of functions with syntax like this:

```plaintext
result = encode([0, 1], original_number)
```

This captures our entire solution as a compact function, facilitating easy application and understanding. 

Thank you for watching!