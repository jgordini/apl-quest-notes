
# Validating Dyadic Transpose Arguments

In this article, we will explore a quest to validate the left argument in a dyadic transpose function based on provided right argument characteristics. The goal is to determine the validity of the left argument given the dimensions and properties of the right argument.

## Overview

The process involves utilizing a lambda function that acts as an error guard, returning `0` for invalid left arguments and `1` for valid ones. To check for validity, we attempt to perform the dyadic transpose, discarding the result and observing for errors during this operation. If an error occurs, the left argument is deemed invalid; otherwise, it’s valid.

We can illustrate this with the following APL code that tests various left arguments against a given right argument:

```apl
X ← 2 5⍴(3 1 2)(2 1 2)(1 1)1⍬(2 3 2)(1 2)(1.2 2 3)1⍬
Y ← 2 5⍴(2 3 4)(2 3 4)(3 4)0⍬(2 3 4)(2 3 4)(2 3 4)⍬0⍴¨⊂⍳24
X {0::0 ⋄ 1⊣⍺⍉⍵}¨ Y
```

This produces the output indicating whether each left argument aligns with the right argument:

```
1 1 1 1 1
0 0 0 0 0
```

### Test Cases Setup

We have prepared a table of test cases structured as a 2x5 matrix, where the top row contains valid left arguments and the bottom row has invalid arguments.

It's crucial to understand that the actual content and size of the right argument are not the primary concerns; rather, the focus should be on matching the number of dimensions between the left and right arguments.

### Validity Criteria

To validate a left argument, it must meet two criteria:

1. **Shape Compatibility**: The number of elements in the left argument must match the number of dimensions of the right argument.
2. **Permutations**: The left argument must enumerate X's that map to existing X's in a consecutive manner, starting from 1, while allowing for duplicates.

We can validate this with the following APL commands:

```apl
X (⍴Y)  ⍝ Shape Compatibility Check
X (⍴¨Y)  ⍝ Check the shapes of each sub-array within Y
X (≢∘⍴¨Y)  ⍝ Check the number of elements per each sub-array shape
```

### Examples of Valid and Invalid Cases

- **Valid Cases**:
  - A permutation vector rearranging existing X's.
  - Mapping two X's to a single axis correctly.
  
- **Invalid Cases**:
  - Omitting mapping for the first axis.
  - Mismatching the rank (dimensions) of array arguments (e.g., rank 2 for left and rank 3 for right).
  - Using non-integer values (e.g., fractional indices).
  - Having too many or too few enumerations relative to the right argument’s shape.

### Detailed Approach

Let's delve into handling the two-part mentioned above.

#### Handling Permutation Vectors

To ensure the first part of the argument represents a valid permutation vector (allowing duplicates), we can use the `unique` function to filter out duplicates in the left argument. We’ll then use a grading function to check if the left argument constitutes a valid permutation. 

```apl
{∪⍵}¨X  ⍝ This returns the unique values in each left argument
```

This can be done by verifying that the original vector corresponds with the grades of grades of the vector:

```apl
{⍵≡⍋⍋⍵}  ⍝ Check if the permutation matches after grading twice
{(,⍵)≡⍋⍋,⍵}¨X  ⍝ Allows for double grading for validation
```

#### Matching Shapes

For the second part, we must confirm that the length of the left argument matches the dimensions (shape) of the right argument. After ensuring that the permutation criteria are satisfied, we can combine both criteria using logical operators.

### Final Steps and Implementation

1. **Permutation Check**: Check if the unique elements in the left argument match their grade of grades.
2. **Length Check**: Validate that the length of the left argument equals the length of the shape of the right argument.

Finally, we can combine these checks into a single function, which can be utilized to validate dyadic transpose arguments thoroughly.

### Conclusion

By understanding and applying these criteria, we can effectively validate the left argument for the dyadic transpose function.

```apl
F ← =⍥≢∘⍴∧{u≡⍋⍋u←∪⍺}
X F¨Y  ⍝ Executes the final validation against the configurations
```

Thank you for reading this exploration into validating arguments for mathematical operations, particularly focusing on the dyadic transpose.
