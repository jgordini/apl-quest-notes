# Computing the Fibonacci Sequence

Welcome to the APL Quest see APL Wiki! Today we're going to compute the Fibonacci sequence. Note that we're focusing on computing the first **n** elements of the sequence rather than the nth element, which is a more traditional task.

## Fibonacci Sequence Definition

The Fibonacci sequence is usually defined recursively. We start with some seed values and compute the next value by summing the last two values in the sequence. 

The sequence can be expressed with a stopping condition as follows:

- For the first zero elements, we do not need anything at all - we can just return zero.
- For one element, we want a sequence starting with `[0, 1]`, which gives us `1` when summed.

Thus, if the argument is less than or equal to `1`, we can just return the element itself. In APL, this can be defined as:

```apl
Rec←{⍵≤1:⍵ ⋄ +/∇¨⍵-⍳2}
```

Otherwise, we derive the value from the function applied to `n-1` and `n-2`.

While this recursive definition is clear, it is also inefficient because it computes the same values multiple times, leading to slow performance.

## Efficient Computation

Instead of computing each value in a recursive fashion multiple times, we'll compute the entire sequence at once via a basic transformation function, which we'll call `∆` (delta). This function will extend the generated sequence by summing the last two elements:

```apl
∆←{⍵,+/¯2↑⍵}
```

Starting with `[0, 1]`, we can repeatedly apply this transformation.

### Recursive Function Implementation

We can write a recursive function where we check if the given element is less than or equal to one:

- If it is zero, return an empty numeric vector.
- If it is one, return a vector with the single value `[1]`.

For values greater than one, we extend the sequence by applying our delta function recursively:

```apl
Rec←{⍵≤1:⍵⍴⍵ ⋄ ∆∇⍵-1}
```

### Tail Call Optimization

One challenge with recursion is stack overflow. To avoid building up a stack, we can implement tail call optimization, which allows the interpreter to reuse the current stack frame for the recursive call if the result does not need post-processing.

We can implement this by passing the length of the sequence as an argument each iteration, thereby eliminating unused stack frames:

```apl
TCO←{⍺≤≢⍵:⍺↑⍵ ⋄ ⍺∇∆⍵} ∘ 1
```

### Pairwise Sum

Another efficient method is using a pairwise sum. This method reduces the angle of attack to continuously sum adjacent elements while ensuring we extend our sequence every time:

```apl
Sum←{{1⌈2+/0 0,⍵}⍣⍵⊢⍬}
```

### Transformation Matrix

We can also compute Fibonacci numbers using a transformation matrix:

```
| 1 1 |
| 1 0 |
```

We multiply by this matrix iteratively or recursively. The APL code to achieve this can involve using the power operator:

```apl
Ap2←{⍵↑∆⍣⍵⊢1 1}  ⍝ append 1 1, n times
```

The top right element gives us subsequent Fibonacci numbers. Using a scan, we can retrieve intermediary values without needing an identity element.

### Other Approaches

1. **Accumulation**: By maintaining a result variable and repeatedly transforming our current pair, we can generate the sequence step by step. An APL implementation could look like this:

    ```apl
    Acc←{r⊣{r,∘⊃←+\⌽⍵}⍣⍵⊢0 1⊣r←⍬}
    ```

2. **Direct Computation**: The nth Fibonacci number can also be computed directly using approximations of the golden ratio or summing binomial coefficients. For example, you can compute Fibonacci numbers directly using Binet's formula:

```apl
Bin←{s÷⍨(p*⍵)-⍵*⍨1-p←2÷¯1+s←5*÷2}⍳
```

### Performance Comparison

Finally, after implementing various approaches (recursive, pairwise sum, transformation matrix, etc.), we can conduct a performance comparison to evaluate the efficiency. We can observe that using Binet's formula yields the best performance overall.

```apl
'cmpx'⎕CY'dfns'
cmpx,∘'¨⍳20'¨⎕A⎕NL¯3
```

Thank you for following along in our exploration of computing the Fibonacci sequence!