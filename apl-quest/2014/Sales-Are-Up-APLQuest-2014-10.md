
# APL Quest: Analyzing the Largest Percentage Increase

Hello and welcome to this APL Quest. Today’s quest focuses on the 10th and last problem from the 2014 round of the APL Problem Solving Competition.

## Problem Statement

We are given a vector of non-zero numbers, and our task is to identify the largest percentage increase from one number to the next.

## Approach

To approach this problem, we'll start with a simple test case from the problem statement. One effective method is to calculate the pairwise differences (or deltas) between the numbers in the vector. The goal is to determine the increase in percentage compared to the starting number. 

For example, given a vector of monthly sales figures:
```apl
t ← 80 100 120 140
```

### Step-by-Step Process

1. **Calculate Pairwise Differences**: 
   We need to find the differences between consecutive numbers in the vector.

   This can be implemented in APL as follows:
   ```apl
   diffs ← ¯2 - ⍵
   ```

2. **Percentage Calculation**:
   The percentage increase can be calculated using the formula:
   - For the first increase: Divide the increase by the starting number (e.g., the first increase from 80 to 100).
   - Continue this for subsequent numbers.

   The generalized formula in APL to compute the percentage increase is:
   ```apl
   {100 × ⌈⌿(¯2 - ⌿⍵) ÷ ¯1↓⍵}
   ```

3. **Identify the Maximum Percentage**:
   After calculating the percentage increases, we need to determine which one is the largest. It's essential to convert these fractions into percentages by multiplying by 100.

   An example of this implementation can be viewed using the function:
   ```apl
   A ← {100 × ⌈⌿(¯2 - ⌿⍵) ÷ ¯2⊢⌿⍵}
   ```

### Function Development

Let’s encapsulate the above logic into a function that takes a vector as an argument and finds the maximum percentage increase. 

We can implement this with:
```apl
s ← ?⍴⍨1000
'cmpx' ⎕CY 'dfns'
cmpx 'A s' 'B s'
```

This will benchmark implementations \(A\) and \(B\) which may utilize different approaches to calculate the maximum percentage increase. For example:
```apl
A s → 3.5E¯6 |     0% ⎕                                       
B s → 1.7E¯4 | +4850% ⎕⎕⎕⎕⎕⎕⎕⎕
```

## Edge Cases

An interesting observation relates to cases where there might be decreasing values in the vector (e.g., a negative drop). To handle this, we consider selecting the left value for each window of size 2, similar to how we calculated the deltas.

To ensure proper functionality, we might need to employ a pairwise reduction method but adjust our arithmetic functions to focus on left and right values appropriately.

### Performance Considerations

While we can combine calculations for efficiency, it's crucial to note that certain combinations, especially involving frequent n-wise or pairwise operations, may lead to performance inefficiencies. For instance, using specialized cases efficiently can significantly improve performance compared to generalized methods.

### APL Implementation Examples

To illustrate this, we can benchmark the performance of two implementations:
```apl
C ← {100 × ¯1 + ⌈⌿¯2 ÷ ⌿⍵}
cmpx 'A s' 'C s'
```

Results can be as follows:
```apl
A s → 3.4E¯6 |   0% ⎕
C s → 2.5E¯6 | -27% ⎕
```

## Conclusion

Upon testing a large sample set (e.g., 1000 random numbers), we can compare the performance of both implementations. This analysis will reveal the importance of optimizing reduction strategies for improving computational efficiency.

In the end, our refined implementation will yield a function that not only achieves the desired outcome more succinctly but also performs better than the original approach.

Thank you for following along with this detailed exploration of the APL Problem Solving Competition problem!
