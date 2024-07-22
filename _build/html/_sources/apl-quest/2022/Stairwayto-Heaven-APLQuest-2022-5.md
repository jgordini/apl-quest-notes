
# Building a Staircase in APL

In this article, we will explore how to build a staircase using APL, a powerful array programming language. The goal is to generate a matrix that displays a staircase pattern based on a given input number. Let's dive into the problem and discover different approaches to solve it.

## Problem Definition

We need to create a matrix that has a specified width and height, where the bottom right corner and the diagonal is filled with the quad character (a boxy character) and all other positions are spaces. For example, if we get the input number `5`, the expected staircase matrix will look something like this:

```
     ⎕
    ⎕⎕
   ⎕⎕⎕
  ⎕⎕⎕⎕
 ⎕⎕⎕⎕⎕
```

## Setting Up the Environment

Let's start by defining a simple anonymous lambda function. We can later give it a name, but for now, we'll just use it as we go. We'll use `5` as our example input.

### Generating the Matrix

To visualize the staircase, we can think of it as a range extending from the top left to the bottom right. We will create a range using the `Iota` operator:

```apl
⍳5
```
This generates a range of indices from 1 to 5.

### Creating the Addition Table

By creating an outer addition table using the `+` operator and the `Iota` function, we can generate the needed indices:

```apl
table ← {∘.+⍨⍳⍵} 5
```

This will provide us with a 2D matrix where the values increase diagonally towards the bottom right corner, which for `5` would look like:

```
1 2 3 4 5
2 3 4 5 6
3 4 5 6 7
4 5 6 7 8
5 6 7 8 9
```

Next, we can use a comparison to create our staircase structure:

```apl
A ← {⍵ < ∘.+⍨⍳⍵} 5
```

With this Boolean matrix (`0`s and `1`s), where `1` indicates the positions to fill with the quad character:

```
0 0 0 0 1
0 0 0 1 1
0 0 1 1 1
0 1 1 1 1
1 1 1 1 1
```

### Defining the Function

Now, let's assemble our function `F` to generate the staircase:

```apl
F ← {' ⎕'[1 + ⍵ < ∘.+⍨⍳⍵]}
F 5
```

The output for `F 5` will give us:

```
     ⎕
    ⎕⎕
   ⎕⎕⎕
  ⎕⎕⎕⎕
 ⎕⎕⎕⎕⎕
```

## Improving Performance

After a bit of reflection, we realize that we could simplify the approach. Instead of generating the addition table and then mapping over it, we can perform a direct comparison:

```apl
G ← {' ⎕'[1 + ⌽∘.≥⍨⍳⍵]}
```

This will directly provide the correct triangular shape instead of building and flipping a matrix:

```apl
G 5
```

Also, we can use operations like `∘.≥`:

```apl
G2 ← {' ⎕'[1 + ∘.≥∘⌽⍨⍳⍵]}
G2 5
```

### Optimization with Index Origin

If we switch our counting system to start from zero instead of one, we can further optimize memory usage. This is because APL generally stores arrays in the smallest data type:

```apl
⎕SET 'quadIo' 0
```

By using zero indexing, we avoid adding `1` and accessing the characters directly.

### Alternative Approaches

Next, we can explore manipulating the quad character directly:

```apl
replicate ← 3 [1 2]
```

This allows us to create the staircase using replication of the quad character without building additional structures. We can combine these values through mapping operations.

### An Efficient Matrix Builder

Now that we understand how to create both the quad character and spaces, the final form can be defined succinctly. Here's an efficient function:

```apl
H3 ← {↑(⍳⍵)/¨'⎕'}
H3 5
```
This function efficiently maps the needed pairs and constructs the staircase.

## Performance Comparison

We can now compare the execution time of our functions. The functions `F`, `G`, and `H` can be benchmarked against one another using a utility:

```apl
cmpx ← {⍺ ⍵}
```

Upon running the comparisons, we note that `H3` stands out as being the most efficient method to build our staircase, while `F` is significantly slower.

## Conclusion

In this article, we explored various methods of building a staircase using APL, improving our approach as we identified inefficiencies. This exercise demonstrates not only APL's unique operators and functional programming paradigms but also the importance of performance considerations in programming.

We hope this guide enhances your understanding of APL and inspires you to explore creative solutions in array programming.
