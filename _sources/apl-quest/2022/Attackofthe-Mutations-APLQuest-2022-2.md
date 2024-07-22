
# Comparing DNA Strings: A Guide

In this article, we will explore a method to compare two DNA strings, highlighting the process of determining the differences between their characters. Both strings are assumed to have the same length, which simplifies our task.

## Understanding the Problem

We have two DNA strings, and we need to find out how many characters differ between them. To achieve this, we can create a mask that indicates which characters are the same or different.

### Creating a Mask

1. **Identifying Similarities**: To identify characters that are the same, we can create a mask based on equality.
   ```apl
   'GAGCCTACTAACGGGAT' = 'CATCGTAATGACGGCCT'
   ⍝ 0 1 0 1 0 1 1 0 1 0 1 1 1 1 0 0 1
   ```

2. **Finding Differences**: Conversely, to find differing characters, we can use an inequality check.
   ```apl
   'GAGCCTACTAACGGGAT' ≠ 'CATCGTAATGACGGCCT'
   ⍝ 1 0 1 0 1 0 0 1 0 1 0 0 0 0 1 1 0
   ```

In both cases, the result will show us which positions have the same or different characters.

### Counting Differences

To count the number of differences, we can represent True and False using 1 and 0 respectively. Since these values are just numbers and not separate types, we can take advantage of summing.

We will utilize a method known as **plus reduction**, which allows us to reduce the result by summing the values on the right as arguments. This summing approach gives us the total number of differences. Here's how we can implement that in APL:
```apl
+/ 'GAGCCTACTAACGGGAT' ≠ 'CATCGTAATGACGGCCT'
⍝ 7
```

### Wrapping in a Function

The process can be wrapped in a function for reusability. We can name our left argument `Alpha` (the leftmost character in the Greek alphabet) and the right argument `Omega`. By marking this as a lambda function, we can create a clean implementation:
```apl
F ← {+/⍺ ≠ ⍵}
'GAGCCTACTAACGGGAT' F 'CATCGTAATGACGGCCT'
⍝ 7
```

### Simplifying the Function

We can simplify our function even further by using a "test it" mode. In this mode, we omit mentioning the arguments entirely. It's important to note that if we want to define the function inline, we need to use parentheses to ensure correct evaluation:
```apl
G ← +/≠
'GAGCCTACTAACGGGAT' G 'CATCGTAATGACGGCCT'
⍝ 7
```

### Using Inner Product

To streamline our process, we consider the inner product. The inner product can be used to compare two vectors or potentially higher-dimensional arrays, but our focus will remain on one-dimensional comparisons.

If we take, for example, the vectors `[1, 2, 3]` and `[10, 100, 1000]`, we can find differences by pairing corresponding elements. The inner product for two vectors is calculated as follows:
```
1 * 10 + 2 * 100 + 3 * 1000
```

To relate this back to our DNA comparison, we can replace multiplication with our inequality check. Thus, we keep the addition for summing results unchanged:
```apl
'GAGCCTACTAACGGGAT' (+/≠) 'CATCGTAATGACGGCCT'
⍝ 7
```

### Implementing the Final Function

To create a single derived function, we simply replace the slash with a dot operator, which combines these two functions into one. By doing this, we eliminate the need for parentheses, allowing us to call the function directly:
```apl
H ← +.≠
'GAGCCTACTAACGGGAT' H 'CATCGTAATGACGGCCT'
⍝ 7
```

### Conclusion

By following this process, we have successfully implemented a method for comparing two DNA strings and identifying the differences between them.

Thank you for reading!
