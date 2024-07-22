
# Counting Visible Buildings

When given a list of heights of buildings, imagine that you are standing in front of that list and looking at the buildings. The visibility rule is simple: you cannot see a lower building if it is behind a taller building, but you can see a taller building behind a lower building. Our goal is to determine how many buildings are visible.

## Understanding Visibility

Let’s consider some test data:

```apl
t←5 5 2 10 3 15 10
```

- We have two buildings of the same height (5). The second one is entirely obscured by the first.
- A lower building (2) is also obscured.
- A taller building (10) is visible.
- A lower building (3) behind a building of height 10 and two buildings of height 5 is likewise obscured.
- Finally, there’s a building of height 15, which is taller than the previous maximum height of 10. 

Through this example, we can see that we can initially see three buildings. We can express this visibility calculation in APL as follows:

```apl
{⌈\⍵}t
```

This expression computes the cumulative maximum of the heights, resulting in:

```
5 5 5 10 10 15 15
```

Next, to count the unique visible heights, we can use:

```apl
{∪⌈\⍵}t
```

This evaluates to:

```
5 10 15
```

Finally, to count the number of visible buildings, we can determine the length of this unique set:

```apl
{≢∪⌈\⍵}t
```

This gives us:

```
3
```

## Creating an APL Function

We want to implement an APL function that can calculate the number of visible buildings. We can start by defining an anonymous lambda function which will refer to our test case. But how do we compute visibility?

### Traversing the List

The approach is to traverse the list of building heights from left to right while keeping track of the maximum height observed so far. We can utilize a scan (cumulative reduction) technique, using the maximum function. 

The maximum of subsequent buildings allows us to determine visibility:

```apl
{⌈\⍵}t
```

This function captures the concept of comparing current heights to the maximum height observed thus far.

### Counting Visible Buildings

To count the number of distinct visible heights, since we can never see a taller building after a shorter one, we only count the first appearance of each height. As illustrated above, we can achieve this in APL with:

```apl
{≢∪⌈\⍵}t
```

This function counts the unique visible heights effectively.

## Alternative Approaches

### Cumulative Maximum Comparison

An alternative method involves examining mathematical relationships between heights:
- We can look for increases between consecutive adjacent buildings. 
- By employing reductions with comparisons (e.g., less than), we can assess visibility but must be cautious, as we may miss some buildings.

To address the edge case of no visible buildings, we can prepend a zero to our list. This ensures we get an increase from zero to the first building's height, allowing the visibility function to work correctly:

```apl
{2</⌈\0,⍵}t
```

This returns:

```
0 0 1 0 1 0
```

Here, the zeros represent buildings that are obscured, while the ones indicate visible buildings.

### Performance Considerations

Comparing the two methods, the first option (using unique) may be inefficient as it does not leverage the already known ordered nature of our input. It might necessitate additional checks and memory overhead.

The second method, which computes visibility with cumulative maximums and counts increases directly, is more memory-efficient because it uses boolean arrays and requires less space and processing time.

To handle edge cases effectively, we can introduce an early exit condition for empty lists, allowing the algorithm to return zero buildings visible without unnecessary computations:

```apl
H←{⍬≡⍵:0 ⋄ 1++/2</⌈\⍵}
```

## Performance Testing

To assess the differences in performance, we can use a comparator tool while generating a large dataset (e.g., 1000 buildings of varying heights). By comparing the performance outputs of different implementations, we can determine which method is not only faster but also easier to read and maintain:

```apl
'cmpx'⎕CY'dfns'
s←?⍳1000
cmpx 'F s' 'G s' 'H s'
```

The results for different implementations would be:

```
F s → 6.3E¯6 |   0% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕
G s → 2.7E¯6 | -58% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕     
H s → 2.1E¯6 | -68% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕   
```

### Conclusion

In summary, while both methods could yield results, leveraging mathematical properties of the list and minimizing data manipulations allows for a more efficient computation. As always, balancing code neatness and performance is crucial in software development.

Thank you for reading!