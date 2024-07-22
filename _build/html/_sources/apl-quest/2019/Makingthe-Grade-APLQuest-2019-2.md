
# Converting Scores into Letter Grades

In this article, we will explore how to convert a set of numerical scores into letter grades represented as letters. We will discuss a method to achieve this through the use of a lookup array and intervals.

## Background

We are given a collection of scores arranged in a two-row, three-column table. While the shape of the array does not matter, it is essential to ensure our method can handle any type of array. 

For example, consider the following array of test scores:

```apl
s ← 2 3 ⍴ 71 82 81 82 84 59
```

This represents a set of test scores:

```
71 82 81
82 84 59
```

## Implementation

We can start by defining a function (using a lambda function or a standard function definition) and refer to its argument with the Greek letter Omega (Ω), representing the rightmost letter of the Greek alphabet.

### The Interval Index Function

We will utilize the **interval index function** to find the indices of elements on the right side in relation to a specified lookup array on the left. This function not only finds the elements but also identifies the intervals they fall into. 

The array on the left needs to be sorted, as we will figure out which interval the right-side elements belong to.

### Illustration of Interval Lookups

Let’s illustrate this process with an example. Suppose we have our cutoff scores arranged in a list.

For instance, consider when we look up scores:

```apl
{0 65 70 80 90 ⍸ ⍵} s
```

The output of this function call will be:

```
3 4 4
4 4 1
```

These represent the indices for the corresponding intervals for each of the scores in our array.

Next, we can map these indices to letter grades. For this, we define a string of letter grades:

```apl
{'FDCBA'[0 65 70 80 90 ⍸ ⍵]} s
```

This will result in:

```
CBB
BBF
```

Here, each score from our original matrix is now converted into corresponding letter grades: 
- The first row `CBB` indicates the grades for scores `71`, `82`, and `81`.
- The second row `BBF` corresponds to the grades for scores `82`, `84`, and `59`.

### Handling Non-positive Scores

If there were any elements that go below zero (negative numbers), we would establish that they fall into interval number zero. However, by default, negative scores don't correspond to proper indices and would not be desired in our classification.

Thus, we begin our intervals at 0, which corresponds to the cutoff for the first element.

### Multi-indexing in APL

In APL, we can leverage multi-indexing. This means that when we index into an array (or a string, in this context), we can use multiple indices. 

The result of this indexing will always maintain the same shape as the indexer. For our example, if we have an array of two rows and three columns of indices, each of these indices will be applied to our lookup array sequentially. This effectively translates the indices to their corresponding letter grades.

### Resulting Letter Grades

Upon completion of the indexing and translation to letter grades, we will achieve an array that represents the letter grades corresponding to our initial scores.

## Conclusion

In summary, we have explored a systematic way to convert numerical scores into letter grades using a defined lookup array and interval indexing. Thank you for watching, and I hope this guide helps you in your programming endeavors!
