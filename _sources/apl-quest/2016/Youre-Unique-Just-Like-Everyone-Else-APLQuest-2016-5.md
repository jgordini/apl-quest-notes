
# Welcome to the Appeal Quest

Welcome to the APL Quest! For more details, please see the APL Wiki. Today's quest is the fifth problem from the 2016 round of the APL problem-solving competition. Our objective is to find the elements in a list that appear only once, meaning those that have no duplicates.

## Defining the Function

Let's start by defining a function. We're using an anonymous function here, giving it a name for reference. A very simple way to approach this is by comparing each element in the array (let's call it `list a` or a one-dimensional array) to every other element. 

Here's an example of such an anonymous function in APL:

```apl
{(1=+⌿⍵∘.=⍵)⌿⍵}
```

### Comparison Table

We'll create a comparison table by checking every possible combination of elements, not just for equality. This creates a quality table. For example, imagine we have the letters of "hello world." The letters are listed both down and across.

In this table, the diagonal will be all ones (since elements match themselves), and we can observe duplicates when multiple elements match. By counting how many matches exist for each element, we can determine which ones appear only once.

### Summing Matches

To find out how many times each letter appears, we can sum along the columns or rows. For this example, let's sum along the columns. We will use a reduction method such as `plus`. Each number will correspond to how many ones (matches) are in the column above.

Now, we only want the numbers that are one. By comparing the sum to one, we can filter our list to get the unique elements. 

Using a bit mask from our comparison, we can filter the original input to retrieve letters like "H" and "E" that appear only once, while we skip letters like "L" and "O," which appear more than once.

We can represent this in APL as follows:

```apl
{(1=+⌿⍵∘.=u)⌿u←∪⍵}
```

## Improving Computation

This is one solution, albeit not the most efficient due to excessive computation. The comparison table is larger than necessary. Instead of comparing every element to every other, we can simply compare to the unique elements.

### Finding Unique Elements

We can use the `unique` function to find the unique elements quickly and compare against them to create a smaller table. If we count the occurrences of each unique element, we can apply a mask similar to before.

However, we notice we're computing the unique elements twice, which seems wasteful. To improve this, we'll give the computed unique values a name, say `U`, and reuse them. Here's how that can look:

```apl
{(1={≢⍵}⌸⍵)⌿∪⍵}
```

## Leveraging Built-in Functions

The APL can accomplish much of this work for us and do so more efficiently. There's a special operator called `key`, which applies a function to properties of the argument.

When we apply it to unique elements, the function runs for each unique element. For example, the letters "H" and "E" are positioned uniquely in the output.

However, we only care about the count of these occurrences, not their actual positions. We can use the `tally` function to get the counts for each unique letter.

After obtaining the counts, we compare them to one and apply a mask to the unique elements to solve the problem:

```apl
⊃{⌿⌿,⌿{⍺,⍨1=≢⍵}⌸⍵}
```

## Final Adjustments

The `key` operator uses the available unique elements as a left argument. To optimize the retrieval process, we can incorporate our comparison directly inside the function call.

Using a mask derived from the comparison, we can concatenate the unique elements we filtered, as shown here:

```apl
{⍵~⍵/⍨~≠⍵}
```

### Handling Multi-dimensional Arrays

It's important to note that when we reduce the dimensions of our array, we may encounter packaging issues as APL prefers multi-dimensional arrays. Opening and closing these boxes will help us produce the desired result.

## Clever Solutions with `unique mask`

An ingenious solution involves using the `unique mask` function, which returns a mask indicating the first occurrence of each unique element. We can identify duplicates and apply logical negation to create a mask of elements that are not the first occurrence.
```apl
{≠⍵}'hello world'
1 1 1 0 1 1 1 0 1 0 1
{⍵⌿⍨~≠⍵}'hello world'
lol
{⍵~⍵⌿⍨~≠⍵}'hello world'
he wrd
```
We can apply this mask to the original input, and through this method, we remove all duplicates. We're using a set difference approach, indicated by the tilde (~), to retrieve all unique items that are present in the list.

## Conclusion

By following these steps, we successfully determine the unique elements in a list. Thank you for watching!
