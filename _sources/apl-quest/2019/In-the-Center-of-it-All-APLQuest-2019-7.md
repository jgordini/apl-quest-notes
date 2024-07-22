# Centering Words in a Matrix

In this article, we will explore a method to center a collection of words within a specified width. To achieve this, we may need to trim or add spaces around these words to ensure they fit into the defined space.

## Creating the Matrix

We start by generating a matrix, as it is orthogonal, meaning it has an equal number of columns in each row. This geometric property allows us to pad rows with spaces as needed, which is essential for our final result. 

Our process begins with mixing the words together into a single array that can be transformed into rows of the matrix.

### Applying the Mix Function

To create the matrix, we use the mix function, which combines inner arrays into a single array, where each element of the inner array becomes a row in the matrix. Here is an example of creating our initial list of words:

```apl
w ← 'APL' 'Problem' 'Solving' 'Competition'
↑w
```
The output will be:
```
⍝ APL        
⍝ Problem    
⍝ Solving    
⍝ Competition
```

## Truncating Rows

Next, we need to define the width we want our matrix to conform to. For instance, let's say our desired width is 10 characters. 

We utilize the `take` function on each row of our matrix, ensuring that we only truncate to the desired width without affecting the overall structure. This is important because each row can have a different length, and we want to apply this operation to each row vector separately.

```apl
10↑⍤1↑w
```
The output will be:
```
⍝ APL       
⍝ Problem   
⍝ Solving   
⍝ Competitio
```

## Adjusting Spaces

Now that we have truncated our rows appropriately, we can begin repositioning the spaces. This involves determining how many spaces were added during the process, which is critical for achieving the centered output.

### Calculating Space Padding

To find out how many spaces we have per row, we create a Boolean mask to identify where the spaces are. By summing these spaces, we can calculate how many spaces have been added:

```apl
{' '=⍵}10↑⍤1↑w
```
This will result in:
```
⍝ 0 0 0 1 1 1 1 1 1 1
```

Now we can sum and average those values to calculate the spaces needed for centering:

```apl
{+/' '=⍵}10↑⍤1↑w
```
Output:
```
⍝ 7 3 3 0
```

Calculating the average:
```apl
{2÷⍨+/' '=⍵}10↑⍤1↑w
```
Output:
```
⍝ 3.5 1.5 1.5 0
```

Rounding down:
```apl
{⌊2÷⍨+/' '=⍵}10↑⍤1↑w
```
Output:
```
⍝ 3 1 1 0
```

And negating for space adjustment:
```apl
{-⌊2÷⍨+/' '=⍵}10↑⍤1↑w
```
Output:
```
⍝ ¯3 ¯1 ¯1 0
```

## Rotating Rows for Centering

Next, we need to rotate the spaces within each row. We will take spaces from the right side and move them to the left, which requires a slight adjustment.

We can define a function to perform this task:
```apl
{⍵⌽⍨-⌊2÷⍨+/' '=⍵}10↑⍤1↑w
```
And the output will be:
```
⍝    APL    
⍝  Problem  
⍝  Solving  
⍝ Competitio
```

## Implementing the Function

After solving our problem, we still have a large expression but not yet a function. To create a functional form out of our solution, we can define a function for ease of use.

We can wrap the above logic into a named function using the composition operator:
```apl
F ← {⍵⌽⍨-⌊2÷⍨+/' '=⍵}↑⍤1∘↑
```
Finally, applying our function to the word list:
```apl
10 F w
```
Output:
```
⍝    APL    
⍝  Problem  
⍝  Solving  
⍝ Competitio
```

### Final Thoughts

This method ultimately gives us a clear and structured approach to center our words within a specified width. The functionality can be refined further by wrapping it in a named function which allows for repeated application.

Feel free to test this method using the specified word list and width to observe the resulting centered output.

*Thank you for reading!*