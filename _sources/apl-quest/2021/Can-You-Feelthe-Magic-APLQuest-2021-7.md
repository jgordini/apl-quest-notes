
# Checking for Magic Squares

In this article, we will explore how to determine whether a given square matrix is a magic square. A magic square is defined as a matrix where the sums of each row, each column, and the two main diagonals (the main diagonal and the anti-diagonal) are all equal.

## Definition of Magic Squares

To illustrate this concept, let's consider a predefined collection of matrices:

1. **Trivial Magic Square**: The first matrix with only one number is trivially magic. No matter how we sum it, we always get the same number.
   ```apl
   s←(⍪1)
   s
   ```
   Output:
   ```apl
   ┌─┐
   │1│
   └─┘
   ```

2. **Magic Square Example**: For the second matrix, we can verify that it is magic:
   - Row sums: \(4 + 9 + 2 = 15\) and \(3 + 5 + 7 = 15\)
   - Diagonal sums: \(4 + 5 + 6 = 15\) and \(2 + 5 + 8 = 15\)
   ```apl
   s←3 3⍴4 9 2 3 5 7 8 1 6
   s
   ```

3. **Non-Magic Square Example**: The third matrix is easy to see as non-magic. The sums \(1 + 2\) equal \(3\), but \(3 + 4\) does not equal \(3\).
   ```apl
   s←2 2⍴1 2 3 4
   s
   ```

4. **Another Non-Magic Square**: The last matrix shows increasing sums both vertically and horizontally, confirming that it cannot be magic either.
   ```apl
   s←3 3⍴⍳9
   s
   ```

From our analysis, the first two matrices are valid magic squares, while the last two are not.

## Approach to Checking for Magic Squares

To efficiently process each of these matrices, we can apply a lambda function, referring to the argument as Omega. Instead of calculating each sum separately, we can concatenate everything we need to sum and perform the summation in one go.

### Finding the Diagonal

To find the diagonal, we can traverse the matrix in order. Each time we move to the right, we also move one step down. This approach effectively maps both axes of the matrix to a single axis, allowing us to obtain the diagonal.

By applying the transpose operation, we can generalize our approach. The transpose maps elements to different locations within the matrix. If we transpose and then mirror horizontally, we can effectively get the diagonal sums.

Here's how you can visualize that in APL:
```apl
{⍵}¨s
```
This applies the identity function on each of the matrices.

### Summation Process

For our summarization process, we need to transpose the original matrix to calculate the sums correctly. We can also obtain the anti-diagonal by flipping the matrix horizontally and then taking the diagonal. We can achieve this flipping using a reverse function, giving us all the necessary column sums.

Below is an example showing how we can sum rows, columns, and diagonals:
```apl
{+⌿⍵,(1 1⍉⍵),(⍉⍵),1 1⍉⌽⍵}¨s
```

All that remains is to check whether all of these elements are the same. We can accomplish this by finding the unique elements, counting them, and checking if that count equals one.

## Optimization and Elimination of Redundancy

Upon inspection, there are redundancies in the code—specifically, the multiple instances where we take diagonals. We can optimize the solution by combining the transpose and horizontally flipped versions of the array.

We can confirm if a matrix is a magic square using:
```apl
{1=≢∪+⌿⍵,(1 1⍉⍵),(⍉⍵),1 1⍉⌽⍵}¨s
```
This operation checks if the unique sums are equal.

## Conclusion

This approach provides a streamlined way to check if a square matrix is a magic square without duplication in the code. The final check is straightforward: if the count of unique sums equals one, the square is magic; otherwise, it isn’t. Thank you for following along in our exploration of magic squares!
