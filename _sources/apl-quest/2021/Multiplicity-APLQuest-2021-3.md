# Grouping Integers by Divisibility

This task is to group a list of integers based on which other integer they are divisible by. We start with two lists: the targets (the integers by which we want to check divisibility) on the left, and the selection of integers to test on the right.

## Objective

We aim to return a vector (or list of lists) where each sublist contains the numbers from the right that are divisible by the corresponding target from the left.

### Example

- **Targets (Left)**: `2, 4, 7, 3, 9`
- **Selection (Right)**: `8, 12, 10, 5, 7`

#### Expected Results:

- Divisible by 2 (even numbers): 8, 12, 10
- Divisible by 4: 8, 12
- Divisible by 7: 7
- Divisible by 3: 12
- Divisible by 9: (empty list)

Given that we have five elements on the left, we will have a list of five elements on the right, where each sublist can have up to six elements, depending on the divisibility.

## Implementation Strategy

We'll implement this by looping over each target and applying a lambda function to test divisibility against the entire list of numbers on the right.

### Using the Modulus Operator

To check if a number `a` is divisible by another number `b`, we can use the modulus operator:

- If `a % b == 0`, then `a` is divisible by `b`.

We can create a boolean mask that checks for divisibility and then filter the right argument based on that mask.

#### APL Example for Mask Creation

In APL, we can create a mask for divisibility using the following expression:

```apl
2 4 7 3 9  {⍺|⍵}¨∘⊂  5 7 8 1 12 10
```

This results in a mask table where:
- `1` indicates divisibility,
- `0` indicates non-divisibility:

```
 ┌───────────┬───────────┬───────────┬───────────┬───────────┐
 │1 1 0 1 0 0│1 3 0 1 0 2│5 0 1 1 5 3│2 1 2 1 0 1│5 7 8 1 3 1│
 └───────────┴───────────┴───────────┴───────────┴───────────┘
```

### Filtering Function

The filtering function takes a list of `ones` (true values) and `zeros` (false values) and applies them to another list of data. Using a higher-order function allows us to properly direct our flow from the right data to the left mask.

#### APL Example for Filtering

With this mask, filtering can be performed using:

```apl
2 4 7 3 9  {0=⍺|⍵}¨∘⊂  5 7 8 1 12 10
```

The output would yield the results:

```
 ┌───────────┬───────────┬───────────┬───────────┬───────────┐
 │0 0 1 0 1 1│0 0 1 0 1 0│0 1 0 0 0 0│0 0 0 0 1 0│0 0 0 0 0 0│
 └───────────┴───────────┴───────────┴───────────┴───────────┘
```

### Advanced Solution

A clever solution includes the use of an outer product to create a remainder table, allowing us to see at a glance which numbers are divisible by others.

#### Creating a Remainder Table in APL

You can create a remainder table in APL using:

```apl
2 4 7 3 9  (∘.|)  5 7 8 1 12 10
```

The output will show the results as below:

```
1 1 0 1 0 0
1 3 0 1 0 2
5 0 1 1 5 3
2 1 2 1 0 1
5 7 8 1 3 1
```

### Steps Going Forward

1. **Create a Remainder Table**: This table displays the remainder when each number from the right is divided by each target from the left.
  
2. **Comparison with Zero**: We need to compare the results of the remainder table to zero to find divisible pairs.

3. **Selection Mechanism**: Using constructs with rank, we can efficiently select and filter the corresponding elements based on the established criteria, leading to our desired structured output.

4. **Concatenation with Inner Product**: Alternatively, we can visualize the solution as an inner product operation, where instead of summation, we concatenate filtered results.

#### Final APL Solution for Grouping

Here's the APL code that can give us the final structured output based on the divisibility check:

```apl
2 4 7 3 9  ((0=∘.|)⍨,./)  5 7 8 1 12 10
```

This will yield results grouped into lists of divisible numbers:

```
 ┌───────┬────┬─┬──┬┐
 │8 12 10│8 12│7│12││
 └───────┴────┴─┴──┴┘
```

## Conclusion

This method for grouping integers offers a clear way to visualize and analyze which integers are divisible by given targets. For more discussions and details around this approach, refer to the chat transcript linked in the video description. Thank you for engaging with this solution!