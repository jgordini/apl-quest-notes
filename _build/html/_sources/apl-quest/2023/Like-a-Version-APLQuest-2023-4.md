
# Comparing Version Numbers

In this article, we will explore how to compare version numbers, which consist of three parts. The goal is to determine whether one version is earlier, the same, or later than another. Let’s dive into the topic with a practical example.

## Example

Consider the version numbers `1.2.3` and `1.3.2`. At first glance, it is apparent that the version on the right (`1.3.2`) is newer. However, the comparison involves more nuance as we need to analyze the individual parts of the version numbers.

### Step-by-Step Comparison

1. **Identify the Differing Parts**: 
   - Compare the version numbers from left to right.
   - The first parts are the same (`1`), so we move to the second parts.

2. **Relevant Parts Only**: 
   - For this comparison, we only care about the second part of the versions since the first part is the same.
   - Comparing the second parts, `2 < 3`, indicates the left version is earlier.
   - In APL, this comparison can be expressed as:
     ```apl
     1 2 3  (-)  1 3 2
     ⍝ Result: 0 ¯1 1
     ```

3. **Prioritize Differences**: 
   - If we have differing parts, we only need the first significant difference to determine the relationship.
   - In this case, the third parts (`3` and `2`) do not influence the comparison.

### Using Mathematical Approaches

To formalize the comparison, we can utilize mathematical functions.

- **Subtraction and Set Differences**: Using subtraction to find differences will help us determine which version is newer or older. For example:
  ```apl
  1 2 4  (-)  1 3 2
  ⍝ Result: 0 ¯1 2
  ```
- **Zero Constant Function**: By employing a zero constant function, we can eliminate non-contributing parts (like zeros) during the comparison process:
  ```apl
  1 2 4  (-~0⍨)  1 3 2
  ⍝ Result: ¯1 2
  ```

### Functional Analysis

To make the comparison functional:
1. Remove zeros using set difference.
2. Apply the Signum function to the differences, which will allow us to extract the sign of the differences:
   ```apl
   1 2 4  (×-~0⍨)  1 3 2
   ⍝ Result: ¯1 1
   ```
3. Finally, return the value of the first significant difference.

### Alternative Evaluation

An interesting approach can be made by treating the version numbers as binary numbers, where negative digits are also included.

1. **Binary Representation**:
   - Represent the differences in base two, treating negative values as part of the binary system.

2. **Calculating Total**: 
   - The positions of the bits (potentially negative) could total to a value that reflects the comparison. 
   - Here's an example with different version numbers:
   ```apl
   6 2 5  (×⍤-)  7 1 3
   ⍝ Result: ¯1 1 1
   ```

3. **Signum Application**: 
   - Similar to previous methods, we finalize the comparison using the Signum function to ensure the result is either `-1`, `0`, or `1`.

### Understanding the Methodology

You might wonder why this binary evaluation works despite negative values being present. The essence of binary representation holds that:
- **Trailing Zeros**: These do not add positively to the value.
- **Inclusion of Negative Ones**: These further limit the potential for false positives since they can only add negatively.

Thus, through clever manipulation and understanding of binary arithmetic, we can reliably assess which version is greater without leading to misleading results.

## Conclusion

In summary, comparing version numbers can be approached mathematically and functionally. By focusing on significant parts and utilizing techniques like subtraction, binary evaluation, and the Signum function, we can derive accurate comparisons between version numbers efficiently. Here is a full demonstration using APL:
```apl
6 2 3  (+/4 2 1 × ×⍤-)  7 1 3
⍝ Result: ¯2
```

Thank you for reading!
