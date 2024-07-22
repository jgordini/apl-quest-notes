
# APL Quest: Float your Boat

Hello and welcome to the APL Quest! For details, please refer to the [APL Wiki](https://aplwiki.com).

## Today's Quest: Float your Boat

In today's quest, we are tasked with selecting the numbers from a vector that are floating point or non-integers. This is Problem Seven from the [2013 APL Problem Solving Competition](https://problems.tryapl.org/psets/2013.html?goto=P7_Float_Your_Boat).

Interestingly, the distinction of what constitutes a floating point number or a non-integer is not well-defined in APL, as a number is simply a number in this language. Regardless, we will do our best, and any of the solutions we propose will be considered correct.

### Getting Started

First, let’s create some data for ourselves. What defines a number that isn’t an integer? There are various ways to approach this, but a very simple and effective method is to compare the number to what happens if we round it. Any integer remains unchanged when rounded, while a non-integer will change.

We can find the integer values in our vector by using the floor function. This allows us to filter the non-integers. Here’s how we can implement this as a function called `f`:

```apl
v ← ¯3.1 4 1.5 92.6 ¯5 ⍝ Test Data
f ← {⍵/⍨⍵≠⌊⍵} ⍝ Function to select non-integer values
```

It was noted during a live chat event that this function can be expressed as a fully derived function composed entirely of operators and functions together. Here’s how we can transform `f` into this form:

1. Compare the argument with its own floor.
2. Use the self-commute operator to facilitate this equality check.
3. Pre-process the right argument using the floor function.

Here’s the derived function:

```apl
A ← {⍵/⍨⍵≠⌊⍵} ⍝ Compare the number against its floored version
B ← (/⍨)∘(≠∘⌊⍨)⍨ ⍝ Derived function 
```

This results in a fully tested version of `f`. Although the implementation is correct, it could be considered less readable. 

### Floating Point Numbers

Now, let’s examine what we mean by a floating point number. If we create some interesting data, say by adding a very small value (1 × 10^-13) to the integers 1 through 15, it may visually appear as though they are still integers due to APL's default rounding to approximately 10 digits of precision.

```apl
w ← 1e¯13 + ⍳15 ⍝ Test Data
14⍕ w ⍝ Format using 14 decimals
```

If we delve deeper and display the numbers using 14 decimals, we start to notice the discrepancies due to floating-point inaccuracies. This raises the question: should these numbers be considered floating point or not? 

When applying the function `f` on this array, we find that some numbers (1 through 9) are considered non-integers, while others (10 through 15) are considered integers based on APL’s default comparison tolerance.

### Adjusting Comparison Tolerance

To address this issue, we can create a version of `f` that includes the comparison tolerance. By temporarily setting the comparison tolerance to zero, we ensure that all 15 numbers are classified as floating point values.

```apl
C ← {⎕CT←0 ⋄ ⍵/⍨⍵≠⌊⍵} ⍝ Comparison tolerance set to 0
```

Here are some additional considerations. APL allows us to see the internal representation of numbers, and understanding this can give further insight. By checking the representation of these values, we can see their actual types (e.g., 64-bit binary float or other types). 

### Non-integer Definitions

It's also interesting to explore definitions. A simple method to determine non-integers is to format each number as a character array and check for the presence of a decimal point. This method of identification is not foolproof when dealing with scientific notation.

By combining approaches, we can filter numbers based on the presence of a dot in their formatted representation. This can be done succinctly by using a membership check on the formatted versions of our values:

```apl
H ← {⍵/⍨'.'∊∘⍕¨⍵} ⍝ Filtering by formatted representation
```

### Exotic Solutions

In addition to traditional methods, there are some more exotic solutions:

1. **Division Remainder Method**: By taking the division remainder with 1, we can identify non-integers since any integer will yield a remainder of 0.

```apl
I ← {⍵/⍨ ×1|⍵} ⍝ Division remainder with 1
```

2. **Encoding Method**: We can use the `encode` function to determine how numbers map to different bases, taking advantage of its precision.

3. **Error Handling with Replicate**: A humorous solution involves passing the argument as the left operand to the replicate function, which can throw errors for non-integers.

```apl
L ← ∊{0::⍵⋄⍵/⍬}¨ ⍝ Replicate and error guard 
```

### Conclusion

In conclusion, determining whether a number is a floating point or non-integer in APL can be approached in multiple ways, each with its advantages and peculiarities. From setting comparison tolerances to employing creative functions, we have successfully navigated the APL quest of Float your Boat!

Please remember that while some solutions may be functional, they might not be optimal or should be used cautiously in actual applications. Thank you for participating!
