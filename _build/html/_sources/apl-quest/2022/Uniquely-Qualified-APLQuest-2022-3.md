
# Finding the Symmetric Difference Between Two Sets

Today’s quest is to find the set difference between two sets that are provided as arrays. The difference we are looking for is symmetric; this means that we want only those elements that appear in exactly one of the arguments, but not in both.

## Getting Started

We have two character vectors:

- Vector A: `["A", "D", "A", "Y", "O", "G"]`
- Vector B: `["A", "L"]`

We can see that both vectors contain the characters "A" and "L," which should not appear in our final result. Thus, the elements we should receive are:

- Characters from Vector A that are not in Vector B: `["D", "Y", "O", "G"]`

### Implementing the Solution

To achieve the symmetric difference, we will define a Lambda function. We will refer to our left argument as `Alpha` and our right argument as `Omega`. Our approach will involve considering all the elements and then removing the ones that we want to exclude.

1. **Union**: We will start by computing the union of the two character vectors.
   ```apl
   'DYALOG' {⍺∪⍵} 'APL'
   ```

2. **Intersection**: Next, we will compute the intersection to find the common elements.
   ```apl
   'DYALOG' {⍺∩⍵} 'APL'
   ```

3. **Set Difference**: Finally, we will use the set difference between the union and the intersection. 

The formula can be represented as:

```
Symmetric Difference = (Union(Alpha, Omega)) - (Intersection(Alpha, Omega))
```
In APL, this can be expressed as:
```apl
'DYALOG' {(⍺∪⍵)~(⍺∩⍵)} 'APL'
```

### Using the Fork Construct

This process can be viewed as a function of three consecutive operations in isolation. The graphic representation is that we apply the union function to the arguments and the intersection function to the arguments, leading to the arguments for the set difference.

```apl
symmetric_difference = union(Alpha, Omega) - intersection(Alpha, Omega)
```

This is a neat way to write it. In APL, we can simplify this to:
```apl
'DYALOG' (∪~∩) 'APL'
```

### Alternative Approach

Another method to derive the symmetric difference is to compute:

- All the elements from `Alpha` except those that appear in `Omega`
- All the elements from `Omega` that are not in `Alpha`

We can then merge the results either by using a union or simply by concatenation, as we know that they must be all different.

In APL, we can express this as:
```apl
'DYALOG' {(⍺~⍵),⍵~⍺} 'APL'
```
Alternatively, it can also be written using the fork construct as:
```apl
'DYALOG' {(⍺~⍵),⍺~⍨⍵} 'APL'
```

### Modifying the Set Difference Function

In order to apply the fork construct, we need to ensure that the left argument is always on the left and the right on the right. To handle this, we can create a modified version of the set difference function. This new function will swap its arguments while maintaining the same functionality.

```apl
'DYALOG' {⍺~⍵} 'APL'
```
or
```apl
'DYALOG' {⍵~⍺} 'APL'
```

### Handling Higher-Rank Arguments

A crucial point to remember is that we are not guaranteed that our arguments are simply vectors or scalars; they may have higher ranks, leading to potential rank errors.

For instance, applying the `comma` function incorrectly could lead to:
```apl
'DYALOG' (~,~⍨) ⍪'APL'
```
This would generate a rank error as indicated here:
```
⍝ RANK ERROR
```

Similarly, using the fork directly could also result in potential errors:
```apl
'DYALOG' (∪~∩) ⍪'APL'
⍝ RANK ERROR
```

To avoid this, we should pre-process both arguments to ensure they are in the desired vector form. We can use a special flattening operator that prepares the arguments for processing by eliminating their outer shape while retaining all elements.

### Conclusion

By applying the solutions above, we can create two functions that handle the symmetric difference in a clean and efficient manner. We can give these functions appropriate names and apply them in line as previously discussed.

Thank you for watching!
