
# Compiling Simple Statistics on Grades

In this article, we continue from our previous discussion about compiling grades. Here, we will compile some simple statistics in a table based on a given set of grades. 

## Overview

We will create a table with three columns:
1. **Grade**: The letter grades ranging from A to D, and including F.
2. **Count**: The number of occurrences for each grade in the given list.
3. **Percentage**: The percentage of each grade, rounded to one decimal position.

### Sample Grades

For the sake of this discussion, we will assume that all letter grades are present and that they appear in groups. This will demonstrate our algorithm effectively.

```apl
g←9 3 8 4 7/'DABFC'
```

### Setting Up the Arguments

We can define a couple of arguments for our task:
- **Left Argument**: The letters of all the different grades (A, B, C, D, F).
- **Right Argument**: The grades we will be analyzing.

We will first determine how many of each grade are present, which will subsequently allow us to compute the percentages.

### Counting Grades

To find the counts for each grade, we can utilize an outer product to compare each element of the left argument (letter grades) with each element of the right argument (grades). This method will create a comparison table, allowing us to easily sum the occurrences for each grade.

For instance:
- If we execute the following, we can compile our counts:

```apl
'ABCDF'{⍺ ⍵} g
```

This results in:

```
┌─────┬───────────────────────────────┐
│ABCDF│DDDDDDDDDAAABBBBBBBBFFFFCCCCCCC│
└─────┴───────────────────────────────┘
```

### Computing Percentages

Next, to obtain the total number of letter grades, we can use tally marks to count the elements in the right argument. With the sums of counts in hand, we can compute the percentages by dividing the counts by the total and multiplying by 100.

To ensure it appears tidy, we can round these percentages to a single decimal position. We can achieve this via the format function, which will transform our numbers into a character vector.

Here's how we can sum the counts for each grade:

```apl
{⍺←'ABCDF' ⋄ +/⍺∘.=⍵} g
```

This returns:

```
3 8 7 9 4
```

### Rounding Percentages

Here is a neat way to format and round our percentages:
- By using the format function, we can apply a left argument that specifies the number of decimals. For example, to round the percentages to one decimal position, we can run:

```apl
{⍺←'ABCDF' ⋄ s←+/⍺∘.=⍵ ⋄ 100×s÷≢⍵} g
```

This generates:

```
9.677419355 25.80645161 22.58064516 29.03225806 12.90322581
```

We can round these results using a custom rounding function.

### Constructing the Final Table

To create our final table, we require a two-dimensional array. We can utilize the table function to generate a column vector from our vector of grades and concatenate it with the sums.

Compiling everything together, the code will look like this:

```apl
{⍺←'ABCDF' ⋄ s←+/⍺∘.=⍵ ⋄ ⍺,s,⍪⍎1⍕100×s÷≢⍵} g
```

Which returns:

```
A 3  9.7
B 8 25.8
C 7 22.6
D 9 29
F 4 12.9
```

### Safety and Performance Considerations

Our initial approach of converting to characters and back again raises some concerns—particularly around performance and potential vulnerabilities. A more efficient route would be to avoid this conversion and directly manipulate the numbers.

Although APL does not have a built-in rounding function, we can utilize a flooring function to create a custom rounding function. Instead of multiplying percentages by 100, we can scale by 1000 to work with tenths, and then apply our custom rounding logic:

```apl
{⍺←'ABCDF' ⋄ s←+/⍺∘.=⍵ ⋄ ⍺,s,⍪⌊0.5+1000×s÷≢⍵} g
```

This way, we ensure that numbers are rounded correctly.

### Conclusion

By following this approach, we can efficiently compile grades into a structured format while mitigating risks and maintaining performance. Thank you for reading!
