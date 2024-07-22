
# Welcome to the APL Quest

Today's quest is the first from the 2016 round of the APL Problem Solving Competition. We are simply to compute the mean, or arithmetic mean, the average. There are a couple of gotchas here, but for the very basic part of the problem, this is extremely simple.

The mean is defined as the sum divided by the count. We could define the parts of the mean and then combine them for the whole thing. We can do this like so:

We can define small lambda functions in APL using curly braces. Inside the curly braces, the argument is denoted `omega`. We need to compute the sum by inserting `+` between the elements, also known as reducing using `+`. So this is `+`, and this is a reduction. This function then sums.

Let's define this function. This is a list or a numeric vector; we can sum the numbers like this:

```apl
Sum ← {+⌿⍵}
p ← 3 1 4 1 5
Sum p  ⍝ Computes the sum
```

This will yield:

```apl
⍝ 14
```

Now we want the count. There's already a built-in function for the count in APL, known as `tally`:

```apl
Count ← {≢⍵}
Count p  ⍝ Computes the count
```

This will give us:

```apl
⍝ 5
```

Next, we can combine these functions. We define a mean function, which is the sum of the argument divided by the count of the argument. Note that I've put parentheses on the left here and not on the right. This is because APL's order of execution is such that any function takes as its right argument everything to its right until it gets stopped by the end of the expression or end of parentheses. The left argument only takes what's immediately to its left.

To clarify:

```apl
Mean ← {(Sum ⍵) ÷ (Count ⍵)}  ⍝ mean function
```

We could parenthesize the count too, but we don’t strictly need to. However, we do need to parenthesize the sum of the argument. Otherwise, without this, what `+` would take as an argument would be everything to its right. 

In fact, it would give the same result because we would be dividing all the elements by the count first and then summing them. But that's less precise and not less performant either.

Now we've defined the mean and can apply the mean to `p`, yielding the mean of those numbers:

```apl
Mean p  ⍝ Apply mean to p
```

This results in:

```apl
⍝ 2.8
```

There are some notational niceties we can do in APL as well. There's something called **tacit programming** or **point-free programming**, a fancy term meaning I'm not going to mention my arguments.

So, here we have a mention of the argument and over here we have another mention of the argument. What happens if we go test it is that we express everything in terms of functions. We have the sum function applied to the argument divided by the count function applied to the argument. This can also be expressed just as the sum function divided by the count function.

So we eliminate a lot of noise; we don’t even need the outer braces anymore. That's the indicator that we're going to use the argument name. We can just write it like this:

```apl
Mean ← Sum ÷ Count  ⍝ Tacit
```

These two outer functions are applied to the argument, and the middle function is applied between their respective results, and the function still works.

What's interesting here is that we've defined `sum` and `count`. In fact, we can redefine them as tested functions too. We can redefine `sum` as the plus reduction of the argument without mentioning the argument and removing the braces:

```apl
Sum ← +⌿
Count ← ≢
Mean ← Sum ÷ Count
Mean ← +⌿ ÷ ≢
```

Of course, this might seem a bit ridiculous. Why would I give a name `Sum` to something that's shorter than the name itself? `Sum` is three characters, but we probably can't find any name that would be as short as two characters, which is the definition of `some count` here being five characters. 

But we only need one character to express it, so we could just take these values and substitute them into our definition for the mean. 

Thus, we can just write:

```apl
Mean ← {+/⍵ ÷ (1 ⌈ ≢ ⍵)}  ⍝ Adjust for empty input
```

We can compute it like that. In fact, we don’t even need the spaces, so the entire mean definition can be written as:

```apl
Mean ← {+/⍵ ÷ 1↑≢ ⍵}
```

At this point, one might question why you would even bother calling the function `Mean` when you could just use these four characters for something that means the mean in a straightforward way.

However, there is a problem: the problem specification states that this also has to work on an empty list. If we try that, we have a symbol for the empty list, which we call "zelda," because it is a combination of a zero and the character tilde, pronounced together as *zelda*. It indicates that there are no numbers; it's an empty list.

If we attempt to calculate the mean of the empty list:

```apl
Mean ⍬  ⍝ Computes the mean of an empty array
```

We get `1`, which might be a bit mysterious. What’s happening here is that when we sum it, we get zero, and when we count the number of elements, we also get zero. Zero divided by zero is traditionally defined not as an error but as `1` in APL for consistency, such that all numbers divided by themselves give `1`.

To fix this issue, we ensure that in the case of zero elements, we get a sum that is zero divided by a certain value. If we divide by `1` instead, we yield zero, which is the result we want.

So we can fix this by taking the maximum of `1` and the count. If the count is `1` or more, it doesn’t make a difference. If the count is zero, we get `1`, effectively clamping it.

To introduce the maximum function:

```apl
Mean ← {+/⍵ ÷ (1⌽ ≢ ⍵)}  ⍝ Updated to handle empty input
```

Now `Mean` works as before, and if we apply it to an empty list:

```apl
Mean ⍬  ⍝ Should return 0 for empty input
```

We will return `0`, as required. We can also express this in a point-free style:

```apl
Mean ← {+/⍵ ÷ (1⌽ ≢ ⍵)}  
```

We can now take this `Mean` function and apply it to A, which yields a two-element vector or list, one per column. This works because it counts along the leading axis how many elements or sub-arrays are there.

Next, we can expand our capabilities: APL arrays can actually be multi-dimensional, not just one-dimensional. Let’s define a second number, `q`:

```apl
q ← 1 6 1 8 0
```

Now we have `p` and `q`, which are both one-dimensional. They can be combined into a two-column table or matrix. We can create each of them as one-column matrices and then concatenate them together. This can be accomplished by using the `,` operator, which is called *table*.

### Concatenate Two Arrays

We can create a two-column table by concatenating:

```apl
A ← p,⍥⍪q  ⍝ Create a 2D array
```

This gives us a two-column table. We can visualize this as having two axes: one for rows and the other for columns. 

Then we can take the mean of `A`, yielding a two-element vector. APL automatically pairs up the elements of arrays during arithmetic operations, allowing us to compute means across multiple dimensions:

```apl
Mean A  ⍝ Mean across the columns
```

This gives us:

```apl
⍝ 2.8 3.2  ⍝ Means of columns
```

If we wanted to sum and count along the rows, we could modify our mean function to apply to each row of the matrix.

### Using the Rank Operator

For that, we introduce the rank operator. If we apply the mean to each one-dimensional sub-array of the table:

```apl
Mean⍤1 A  ⍝ Computes mean along the rows
```

This results in scalar means for each dimension in the array.

### Conclusion

So that's all I wanted to show for today. Thank you for watching!
