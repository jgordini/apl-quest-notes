
# Understanding Boolean Vector Processing in APL

The problem of taking a Boolean vector and leaving only the very first `true` while all subsequent `true` values become `false` is conceptually simple. The APL solution to this challenge is extremely concise. The real challenge lies in understanding how this solution works.

## The APL Solution

Let's consider an example Boolean vector: `0 0 1 1 0` (`false false true true false`). In this case, we want to change the second `true` into `false` because only the first `true` should survive. This can be expressed in APL as follows:

```apl
<\ 0 0 1 1 0
```
This will yield the result:
```
0 0 1 0 0
```

The entire APL solution can be summarized in just two characters. But why does this work? To understand this, we need to explore what the backslash `\` operator does, as it represents a scan or cumulative reduction. We also need to delve into the properties of the less than (`<`) operation, which is typically associated with comparing numbers but is applied as a Boolean operation here.

## The Concept of Scan

Scan is a type of reduction over prefixes. For instance, if we take the first four elements of our vector, each element should not be treated individually, but rather as a whole. By obtaining the length and the indices of the length, we can derive all the prefix lengths we want. You can visualize the prefixes using the following APL expression:

```apl
Prefixes ← ⍳∘≢↑¨⊂
Prefixes 0 0 1 1 0
```

This will produce the following structure:
```
┌─┬───┬─────┬───────┬─────────┐
│0│0 0│0 0 1│0 0 1 1│0 0 1 1 0│
└─┴───┴─────┴───────┴─────────┘
```

Now, we perform a reduction over these prefixes:

```apl
</¨Prefixes 0 0 1 1 0
```
The resulting vector will be:
```
0 0 1 0 0
```

### Properties of Less Than in Boolean Context

In the context of Boolean values, there are two possibilities for the left argument (either `0` or `1` representing `false` and `true` respectively) and two possibilities for the right argument. 

If we take the outer product of these possibilities using the less than operation, we can visualize the results as follows:

```
| <  | 0 | 1 |
|----|---|---|
| 0  | 0 | 0 |
| 1  | 1 | 0 |
```

From this truth table, we can see that the only condition under which less than yields a `true` result is when the left argument is `0` and the right argument is `1`. Consequently, for a `1` to survive, it must always observe `0`s on its left.

## The Reduction Process

Returning to our prefixes, APL reduces from the right. The first prefix, which is just a single element, is unchanged. 

For the second case (the first two zeros), the result is `0 < 0`, which results in `false`. For the third prefix that includes a `1`, the evaluation `0 < 1` yields `true`, allowing the `1` to survive to the next prefix.

Continuing through the prefixes, we notice that whenever a `1` faces any `0`s on its left, it gets canceled out. Thus, only the first `1` can survive, as it has `0`s to its left (or none at all).

## Visualizing the Operation

To further illustrate this process, we can implement some lambdas or definitions that help us visualize what's happening during each step of the less than reduction and scan.

### Example Implementation

Let's draft a simple APL function to print the operations:

```apl
∇ R ← LessThanPrint A B
    ⍝ Print the comparison
    R ← A < B
    ⍝ Print formatted output
    'Comparing', A, '<', B, '=>', R
∇

∇ R ← LessThanReduction A
    ⍝ Print a less than reduction
    R ← / LessThanPrint A
    ⍝ Return the result
    R
∇

∇ R ← LessThanScan A
    ⍝ Print a less than scan
    R ← {LessThanReduction ⍵}¨[1] A
    ⍝ Return the result
    R
∇
```

### Running the Functions

By calling these functions with our vector (e.g., `0 0 1 1 0`), we can see the step-by-step evaluations that lead to the final result. Each invocation shows how the reduction progresses and what values are propagated.

## Conclusion

The essence of the less than scan operation in APL when handling Boolean data allows us to filter out all but the first `true` value effectively. With experience, one can start reading this as simply "keep the first `1`" rather than focusing on the less than reduction's mechanics.

There are numerous other Boolean scans in APL that can be useful, but this specific operation is one of the most prominent. 

Thank you for your attention!