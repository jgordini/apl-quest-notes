
# Justified Text Transformation in APL

In this article, we'll explore how to justify text in APL, focusing on left truncation when the text exceeds a specified width. If you'd like to read the full description while watching the associated video, feel free to pause the video. Let's get started with a simple example.

## Example Overview

We'll begin with a basic character vector and create a small lambda function that takes a width argument, represented by the Greek letter Omega (Ω), which is the rightmost letter of the Greek alphabet. 

### Normalizing Incoming Data

Handling various types of data is essential. We need to normalize the incoming data using a convenient function similar to `enclose`, which wraps a character vector in an outer array only if it's not already nested. 

For example:

- If we provide a character vector: 
  ```apl
  'text'
  ```
  The function will enclose it, resulting in:
  ```apl
  ('text')
  ```

- If we give multiple elements:
  ```apl
  ('text1', 'text2')
  ```
  The function recognizes this is already nested and performs no further action.

Next, let’s assume we have a character vector with one level of nesting. We will define a left argument, say `5`, which will serve both as the width of the final result and the point at which we should truncate the text.

### Right Justification Process

To achieve right justification while truncating on the left, we will use APL's `take` function. Notably, to take from the right using `take`, we need to negate the left argument. The takeaway will be applied to each of the elements. 

If we call this on our initial vector like so:
```apl
5 {(-⍺)↑¨⊆⍵} 'Iverson'
```
We see the truncated output:
```
┌─────┐
│erson│
└─────┘
```

Finally, we will stack the individually truncated results using the `mix` function, which combines a nested array into a flatter array.

It’s also worth examining the behavior of a single scalar. If we execute:
```apl
5 {↑(-⍺)↑¨⊆⍵} 'K' 'E' 'Iverson'
```
We would get:
```
     K
     E
  erson
```
In this case, it remains unchanged but can be converted into a vector. The padding function adds spaces when character data is insufficient, and the `mix` function takes care of any extra enclosure, resulting in a vector as expected.

#### Performance Considerations

While this solution is straightforward, it’s not the most optimal regarding performance due to the use of nested arrays and operations that involve looping with the `each` operator. This approach advocates an anti-pattern in APL.

We can improve efficiency by removing any nesting as early as possible. We normalize the list again using mix padding on short elements. However, since padding occurs on the right (which we don't want), we can first reverse each element:

```apl
{⌽¨⊆⍵} 'K' 'E' 'Iverson'
```
Which gives:
```
┌─┬─┬───────┐
│K│E│nosrevI│
└─┴─┴───────┘
```
Next, we reverse again after taking the necessary actions. 

For truncation, instead of taking from the resulting matrix, we will apply the `take` function directly to the individual vectors. We will first truncate the data and then carry out the necessary reversal:
```apl
5 {(-⍺)↑⍤1⌽↑⌽¨⊆⍵} 'K' 'E' 'Iverson'
```

It results in:
```
     K
     E
  erson
```
### Performance Comparison

To compare the performance of our solutions, we will create some sample data. Using the alphabet, we will generate 100 random words of varying lengths. The comparison will be made between the original and optimized methods.

```apl
words ← (enclose alphabet) [1;] each ⍵
```

After constructing our sample data, we will measure the execution speed of the functions using the `compare execution facility` from the workspace.

### Final Thoughts 

In conclusion, we've explored several solutions for right-justifying text while truncating left. Each method demonstrates a different approach, weighing simplicity against performance. The complexity of the solution depends on the specific needs of your application. 

Thank you for reading, and I hope this exploration of text justification in APL proves helpful!
