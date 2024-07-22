# Counting DNA Letters in a Character Vector

In this article, we will explore a method to count the occurrences of the letters A, C, G, and T in a given character vector or scalar. This task is essential in bioinformatics and genetics, where we often need to analyze DNA sequences.

## Sample DNA String

We start by defining a sample DNA string, which contains the letters A, C, G, and T. Our goal is to compare each of these letters with the entire string. To achieve this, we can use an outer product, which allows us to generate all combinations of elements from the left (the set of letters) with elements from the right (the DNA string).

```apl
dna ← 'AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC'
```

## Creating the Boolean Table

The outer product will produce a Boolean table indicating the presence of each letter in the DNA string. Our next step is to count the number of ones in each row of this table. We can easily reduce the data to find these counts.

```apl
'ACGT'∘.=dna
+/'ACGT'∘.=dna
```

The first line generates a Boolean table showing where each letter appears, while the second line sums these occurrences, producing:

```apl
20 12 17 21
```

### Handling Single Letters

However, we encounter an issue when we only have a single letter, such as 'C'. In this case, the outer product gives us a vector instead of a matrix. Consequently, when we sum the rows, we obtain a single number instead of distinct counts for each letter. 

To address this, we can use the `revel` function, which ensures scalars are treated as vectors:

```apl
'ACGT'∘.='C'
+/'ACGT'∘.='C'
```

This results in a correct count for 'C':

```apl
1
```

## Creating a Function

We can then encapsulate this entire process into a single test function that works seamlessly with our DNA string.

### Alternative Approach: Using the Key Operator

Another approach to solving this counting problem is to utilize the key operator. However, this method has an issue with ordering.

The key operator works by returning each unique element as the left argument to the function, while the indices of the original data are provided on the right. Because of this, we might miss elements if they aren’t all present.

To ensure we capture all letters, we can insert "ACGT" before our data. This guarantees that each letter will be encountered in the correct order and that there will be at least one occurrence of each letter. After counting, we simply need to subtract one from the results to eliminate the dummy entries we added.

```apl
{¯1+{≢⍵}⌸'ACGT',dna}
```

This will yield our final counts:

```apl
20 12 17 21
```

## Writing the Function Neatly

Here’s how we can formulate this solution in a neat function. Additionally, I have an idea for an extension that could make this process even cleaner. We can achieve this by importing a model from my GitHub account that includes a special operator called `quad`.

### Implementation of the Extended Key Operator

By renaming the operator to something more intuitive, we can now try out our new approach. Instead of taking a function as an argument, this operator takes a vocabulary (in this case, "ACGT"). We can then apply it to our DNA string, producing a list of indices for each unique letter.

```apl
]get github.com/abrudz/dyalog_vision/blob/main/QuadEqual.aplo
Ⓚ←#.QuadEqual
(≢¨'ACGT'Ⓚ)dna
```

This adjustment will lead us to a more efficient and user-friendly counting process, producing our desired counts of:

```apl
20 12 17 21
```

## Conclusion

Counting the occurrences of DNA letters is a vital task that can be executed using a variety of methods, from straightforward approaches to more advanced operator extensions. By understanding and utilizing these techniques, we can simplify our analysis of DNA sequences. Thank you for reading!