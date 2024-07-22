
# Comparing Dates in APL: A Guide

In the realm of programming, comparing dates can often be a mundane task. However, the challenge becomes intriguing when you delve into how to efficiently determine the relationship between two dates expressed in vector format. In this article, we will explore the relationship between two dates: whether one precedes the other, is subsequent to it, or if they are identical. 

## The Problem Statement

Given two dates, we need to establish their temporal relationship:
- If the first date is before the second, return `-1`.
- If the first date is after the second, return `1`.
- If both dates are the same, return `0`.

## Approaching the Problem

There are multiple ways to tackle this challenge, but we'll employ a straightforward method using date manipulation. I will illustrate the tools available in **Dialog APL**, particularly leveraging the **.NET** framework.

Let’s consider the setup with the following test cases where the left date is constant, and the right date varies:

- Left date: Same for all comparisons.
- Right dates: Three different times.

We need to determine whether the left date is earlier, later, or the same time as each right date.

### Setting Up .NET Environment

To begin with, we must establish our using statement to access the functionality provided by **.NET**. This allows us to interact with the `System` namespace, particularly its `DateTime` class.

```apl
⎕USING ⎕NET`System
```

### Creating DateTime Objects

After the setup, we can create several `DateTime` objects that are derived from our input vectors. These are initially formatted for human readability but ultimately transformed into scalar entities representing time.

1. Define the left and right date arguments.
   
   ```apl
   X←⍪3⍴⊂2018 4 1 12 34 56 789
   Y←⍪(2018 4 1 16 45 12 800)(2018 4 1 12 34 56 789)(2017 4 1 12 34 56 789)
   ```

2. Create a lambda function to compare each left date with the entries on the right.

### Comparison Logic

Using the `DateTime` class, we can employ the built-in `Compare` method to evaluate our dates:

```apl
X{⎕USING←'System' ⋄ DateTime.Compare {⎕NEW DateTime ⍵}¨⍺⍵}¨Y
```

This snippet produces a direct relationship comparison:

```
¯1
 0
 1
```

## Utilizing APL’s Built-In Functionality

While .NET offers powerful date manipulation capabilities, APL also provides built-in functions such as `quad DT`, which can be used to convert date formats effectively, allowing subsequent comparisons.

### Conversion and Subtraction

To simplify the comparison process further, we can convert our date vectors into a serialized number format that represents the number of days since a specified epoch (e.g., 1899).

Utilizing these day numbers, we can subtract one from the other:

```apl
X{1⎕DT⍺⍵}¨Y
```

This results in:

```
┌───────────────────────┐
│43190.52427 43190.69806│
├───────────────────────┤
│43190.52427 43190.52427│
├───────────────────────┤
│43190.52427 42825.52427│
└───────────────────────┘
```

By computing the difference, we can then apply the `Signum` function to interpret the direction of the relationship:

```apl
X{-/1⎕DT⍺⍵}¨Y
```

This provides:

```
 ¯0.1737964236
  0
365
```

### Refined Function Expression

We can streamline our function to directly apply the subtraction across the entire vector prior to conversion, thus enhancing both clarity and performance. Our function can then be represented as:

```apl
F←×-⍥(1⎕DT⊂)
X F¨Y
```

This results in a concise output indicating the comparison results:

```
¯1
 0
 1
```

## Conclusion

By employing the rich functionalities of both .NET and APL, we can create elegant solutions for date comparisons. Whether you choose to utilize .NET capabilities or APL’s intrinsic functions, the principles of preprocessing, conversion, and comparison remain essential.

Thank you for reading, and I hope this guide has equipped you with the knowledge to tackle date comparisons in APL effectively!
