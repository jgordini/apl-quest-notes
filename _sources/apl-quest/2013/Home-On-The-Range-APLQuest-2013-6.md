
# APL Quest: Understanding Numeric Range Calculation

Welcome to the APL Quest! Today's discussion revolves around a problem from the [2013 round of the APL Problem Solving Competition](https://problems.tryapl.org/psets/2013.html?goto=P6_Home_On_The_Range). The task is straightforward: finding the numeric range of an array, defined as the highest value minus the lowest value. However, there's a specific edge case we need to address, and we'll explore some generalizations along the way.

## Generating Sample Data

Let’s start by generating some sample data in the form of a numeric vector. The highest value in this vector is determined using the maximum reduction function, while the lowest value is found using the minimum reduction function.

```apl
vector ← 1 3 5 7 9
highest ← ⌈/ vector   ⍝ Maximum value
lowest ← ⌊/ vector    ⍝ Minimum value
numeric_range ← highest - lowest
```

This gives us the basic numeric range calculation.

## Implementing the Function

Next, we’ll encapsulate this logic within a function. The function will compute the numeric range using the maximum and minimum reductions:

```apl
numeric_range_function ← { (⌈/⍵) - (⌊/⍵) }  ⍝ Function for non-empty vectors
```

With this function, we can easily find the numeric range for our vector, and it seems to work well. However, we soon encounter a limitation:

### Handling Matrices

The function we created needs to work on any array, including matrices. For example, if we construct a matrix that has two rows and four columns filled with the same numbers as our vector:

```apl
matrix ← 1 3 5 7 9
matrix ← 1 3 5 7 9  ⍝ Create a matrix
```

When we apply our function on the matrix, it returns the numeric range for each row, but we want the range for the entire array. We can resolve this by raveling the array first:

```apl
numeric_range_function ← { (⌈/-⌊/),⍵ }  ⍝ Full range for the entire array
```

This ensures our function will give us the full range.

### Edge Case: Empty Arrays

A critical requirement is that our function must also work with empty arrays. When the function is applied to an empty vector, it raises a domain error instead of returning zero. This is because the maximum of an empty vector is treated as the smallest representable number in the numeric system.

To rectify this, we can modify our function to check if the array is empty by examining its shape:

```apl
numeric_range_function ← {
    0∊⍴⍵:0 ⋄ (⌈/-⌊/),⍵  ⍝ Return zero for empty arrays
}
```

Additionally, we could emphasize that:

```apl
⌈/⍬ ⍝ Maximum of empty vector is the smallest representable number. Minimum reduction produces the opposite value.
1⌈≢ ⍝ Check if the length is larger than one. 
```

This guarantees that if the array's shape includes a zero, the function will return a range of zero.

## Further Optimizations

There are several more clever methods to achieve the same results efficiently:

1. **Sorting Method**: By sorting the array after raveling, we can easily access the last and first elements to calculate the range:

```apl
numeric_range_function ← { (⊃⍵[⍋⍵]) - (⊃⍵) }  ⍝ Last element minus First element
```

2. **Appending a Default Value**: Instead of checking the shape and then appending a zero, we can simply append a conditionally generated zero based on the array’s emptiness:

```apl
numeric_range_function ← {
    (0∊⍴⍵:0 ⋄ (⌈/-⌊/),,0/⍨0∊⍴) ⍝ Appending default value
}
```

3. **Using Enlist**: When dealing with complex arrays, the `enlist` function can flatten them. This can help prevent structural issues that may arise with nested vectors.

```apl
numeric_range_function ← {
    ((⌈/-⌊/)⊢↑⍨1⌈≢)∊ ⍝ Handle nested arrays
}
```

This way, we can leverage all potential numeric arrays while ensuring consistent output.

## Conclusion

Through exploring various methods to calculate numeric range, we’ve tackled edge cases and considered a diverse range of inputs. Thank you for joining today’s APL quest. I look forward to seeing you next week for more exploration into the world of APL!

For further study, you can refer to the [video explanation](https://youtu.be/36HlHsEjUIQ) and the complete code for this example available on [GitHub](https://github.com/abrudz/apl_quest/blob/main/2013/6.apl).
