
# Welcome to the APL Quest

## Introduction
Welcome to the APL Quest. Today's Quest is the sixth from the 2016 round of the APL Problem Solving Competition.

## Quest Overview
In this task, we need to take a list of arrays, specifically a list of vectors or possibly scalars, and sort them by their length. The shortest ones should come first, and the longest ones should be at the end. This is a straightforward task.

## Creating Test Data
Let's create some test data. We have a list, or vector as we call it, consisting of six elements, including scalars and empty vectors:

```apl
d ← 1 'two' 'three' 4 '' (5 6 7 8)
```

When we print this vector `d`, we see:

```
┌─┬───┬─────┬─┬┬───────┐
│1│two│three│4││5 6 7 8│
└─┴───┴─────┴─┴┴───────┘
```

## Testing the List
To analyze the list further, we can determine how many elements it contains:

```apl
≢ d
```

This returns `6`, indicating there are six elements in our vector.

Next, we want to find the lengths of each individual element. In APL, we can use the tally function, but in this context, we will apply it to each element using the `each` operator:

```apl
≢¨ d
```

This yields:

```
1 3 5 1 0 4
```

This tells us:
- The number `1` has a length of `1`.
- The word `two` has a length of `3`.
- The word `three` has a length of `5`.
- The number `4` has a length of `1`.
- We have an empty string `''` with a length of `0`.
- The array `(5 6 7 8)` has a length of `4`.

## Grading the Elements
Next, we can use this information for grading. Grading is a fundamental APL operation, similar to sorting, but it doesn't reorder the elements directly. Instead, it provides us with the indices of the elements in the order we would need to sort them. 

We can do this by applying the grade function to the lengths:

```apl
⍋ ≢¨ d
```

The output of this will be:

```
5 1 4 2 6 3
```

This means the order to sort by length will be:
1. Element 5 (the empty string)
2. Element 1 (the scalar `1`)
3. Element 4 (the scalar `4`)
4. Element 2 (the string `two`)
5. Element 6 (the array `(5 6 7 8)`)
6. Element 3 (the string `three`)

## Indexing the Elements
We can now use this information to index into the list `d` using square bracket indexing:

```apl
d[⍋ ≢¨ d]
```

This will reorder the elements, and the printed result will be:

```
┌┬─┬─┬───┬───────┬─────┐
││1│4│two│5 6 7 8│three│
└┴─┴─┴───┴───────┴─────┘
```

## Converting to a Function
However, the result we have obtained is just an expression, not an actual function. We can convert this into a lambda function by putting braces around it and denoting the argument with `⍵`. This signifies that `⍵` represents the right argument in APL.

We can define a function called `SbL` like this:

```apl
SbL←{⍵[⍋ ≢¨ ⍵]}
```

Now, we can call this function on our original list `d`:

```apl
SbL d
```

And it will yield the same ordered result:

```
┌┬─┬─┬───┬───────┬─────┐
││1│4│two│5 6 7 8│three│
└┴─┴─┴───┴───────┴─────┘
```

## Conclusion
And that's really all there is to it. Thank you for watching!
