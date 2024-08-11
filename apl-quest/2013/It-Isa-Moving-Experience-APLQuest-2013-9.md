
# [It's a moving experience 2013-9](https://apl.quest/psets/2013.html?goto=P9_It_Is_a_Moving_Experience)

**Problem:** Write a dfn which produces n month moving averages for a year’s worth of data.

**Video:** [https://www.youtube.com/watch?v=txZiCW12lTE](https://www.youtube.com/watch?v=txZiCW12lTE)

**Code:** [https://github.com/abrudz/apl_quest/blob/main/2013/9.apl](https://github.com/abrudz/apl_quest/blob/main/2013/9.apl)

Hi and welcome to the APL Quest see the APL wiki for details! Today, we're looking at the ninth problem from the 2013 round of the APL Problem Solving Competition. The task is to find the average over a selected sub-period of a year's worth of data.



## Basic Solutions

### Naive Solution
```apl
(÷⌿÷≢)¨,/           ⍝ Naive solution
```
This is the simplest approach using n-wise reduction with concatenation. It creates windows of data and applies the average function to each window.

1. [Compress](https://aplwiki.com/wiki/Replicate) `,/` [N-wise Reduction](https://aplwiki.com/wiki/N-wise_reduction) with concatenation: This concatenates groups of elements, moving over one step each time to create windows.
2. [Each](https://aplwiki.com/wiki/Each) `¨` Apply average function to each window: This applies the average calculation to each of these windows.
3. [Reduce](https://aplwiki.com/wiki/Reduce) `÷⌿` Sum of array: Part of the idiomatic APL expression for average.
4. [Tally](https://aplwiki.com/wiki/Tally) `≢` Length of array: Used to calculate the average (sum divided by count).

### Better Solution
```apl
{(⍺+⌿⍵)÷⍺}          ⍝ Better solution
```
This is a more efficient solution that applies the calculation directly to each subsequence. It performs the n-wise sum and division in one step, avoiding redundant calculations.

1. [Reduce](https://aplwiki.com/wiki/Reduce) `⍺+⌿⍵` N-wise sum of right argument: This performs the sum for each window in one step.
2. [Divide](https://aplwiki.com/wiki/Divide) `÷⍺` Divide by left argument (window size): This completes the average calculation more efficiently.

### Tacit Equivalent
```apl
+⌿÷⊣                ⍝ Tacit equivalent
```
This is a tacit (point-free) expression of the better solution, eliminating explicit arguments. It concisely represents the n-wise sum divided by the left argument (window size).

1. [Reduce](https://aplwiki.com/wiki/Reduce) `+⌿` N-wise sum: Sums each window.
2. [Divide](https://aplwiki.com/wiki/Divide) `÷` Divide: Performs the division for the average.
3. [Left](https://aplwiki.com/wiki/Left) `⊣` Left argument (window size): Selects the window size for division.

## Handling n>13

```apl
{((⍺⌊13)+⌿⍵)÷⍺⌊13}  ⍝ Handle n>13
```
This solution addresses the edge case where the window size is larger than the data length. It clamps the window size to a maximum of 13, preventing errors for large window sizes.

1. [Floor](https://aplwiki.com/wiki/Floor) `⍺⌊13` Minimum of left argument and 13: This clamps the window size to a maximum of 13.
2. [Reduce](https://aplwiki.com/wiki/Reduce) `+⌿` N-wise sum: Applies the sum to each window.
3. [Divide](https://aplwiki.com/wiki/Divide) `÷` Divide by clamped window size: Completes the average calculation with the clamped size.



## For Any Length Right Argument

### Basic Solution
```apl
{((⍺⌊1+≢⍵)+⌿⍵)÷⍺}
```
This generalized solution works for any number of elements in the input data. It clamps the window size to the data length plus one, ensuring it works for all input sizes.

1. [Tally](https://aplwiki.com/wiki/Tally) `1+≢⍵` Length of right argument plus one: This allows the function to work with any number of elements.
2. [Floor](https://aplwiki.com/wiki/Floor) `⍺⌊` Minimum of left argument and length+1: Clamps the window size to the data length.
3. [Reduce](https://aplwiki.com/wiki/Reduce) `+⌿` N-wise sum: Sums each window.
4. [Divide](https://aplwiki.com/wiki/Divide) `÷⍺` Divide by left argument: Completes the average calculation.

### Beautiful Solution
```apl
{(⍺⌊1+≢⍵)(+⌿÷⊣)⍵}  ⍝ Using the beautiful solution
```
This solution combines the clamping with the tacit moving average function. It demonstrates how to use a fork to express the calculation concisely.

1. [Floor](https://aplwiki.com/wiki/Floor) `⍺⌊1+≢⍵` Clamped window size: Ensures the window size doesn't exceed the data length.
2. [Fork](https://aplwiki.com/wiki/Train#3-trains) `(+⌿÷⊣)` Tacit function for moving average: A concise way to express the moving average calculation.
3. Apply to right argument: Applies the moving average calculation to the data.

### Argument Swap
```apl
{⍵(+⌿÷⊣)⍨⍺⌊1+≢⍵}   ⍝ Argument swap
```
This version swaps the arguments for clarity and uses the commute operator. It shows an alternative way to express the same calculation with a different order of operations.

1. [Commute](https://aplwiki.com/wiki/Commute) `⍨` Swap arguments: Rearranges the function application for clarity.
2. [Floor](https://aplwiki.com/wiki/Floor) `⍺⌊1+≢⍵` Clamped window size: Ensures the window size is appropriate.
3. [Fork](https://aplwiki.com/wiki/Train#3-trains) `(+⌿÷⊣)` Tacit function for moving average: Concise moving average calculation.

### Unrolled Train
```apl
{⍺÷⍨⍵+⌿⍨⍺⌊1+≢⍵}    ⍝ Unroll train
```
This solution unrolls the train (fork) into a single expression. It demonstrates how to express the calculation without using a nested function structure.

1. [Floor](https://aplwiki.com/wiki/Floor) `⍺⌊1+≢⍵` Clamped window size: Ensures appropriate window size.
2. [Reduce](https://aplwiki.com/wiki/Reduce) `⍵+⌿⍨` N-wise sum of right argument: Performs window sums.
3. [Divide](https://aplwiki.com/wiki/Divide) `⍺÷⍨` Divide by left argument: Completes average calculation.

### Tacit Equivalent
```apl
⊣÷⍨⊢+⌿⍨⊣⌊1+≢⍤⊢     ⍝ Tacit equivalent
```
This is a fully tacit version of the unrolled solution. It shows how to express the entire calculation without any explicit arguments or function blocks.

1. [Rank](https://aplwiki.com/wiki/Rank_(operator)) `≢⍤⊢` Length of right argument: Determines data length.
2. [Floor](https://aplwiki.com/wiki/Floor) `⊣⌊1+` Minimum of left argument and length+1: Clamps window size.
3. [Reduce](https://aplwiki.com/wiki/Reduce) `⊢+⌿⍨` N-wise sum of right argument: Calculates window sums.
4. [Divide](https://aplwiki.com/wiki/Divide) `⊣÷⍨` Divide by left argument: Completes average calculation.

### Code Golf
```apl
⊣÷⍨⊢+⌿⍨⊣⌊≢⍤,       ⍝ Code golf
```
This is a code golf version, optimized for brevity rather than clarity or efficiency. It uses a trick of concatenating arguments to save a character, at the cost of clarity and performance.

1. [Rank](https://aplwiki.com/wiki/Rank_(operator)) `≢⍤,` Length of ravel of right argument: Determines total element count.
2. [Floor](https://aplwiki.com/wiki/Floor) `⊣⌊` Minimum of left argument and length: Clamps window size.
3. [Reduce](https://aplwiki.com/wiki/Reduce) `⊢+⌿⍨` N-wise sum of right argument: Calculates window sums.
4. [Divide](https://aplwiki.com/wiki/Divide) `⊣÷⍨` Divide by left argument: Completes average calculation.



## Using Error Trapping

### Basic Error Trapping
```apl
{5::⍬ ⋄ ⍺÷⍨⍺+/⍵}
```
This solution uses error trapping to handle cases where the window size is too large. It returns an empty vector if a length error occurs, otherwise performs the calculation.

1. [Error Guard](https://aplwiki.com/wiki/Dfn#Error-guards) `5::⍬` If length error, return empty vector: Catches the error when window size is too large.
2. [Compress](https://aplwiki.com/wiki/Replicate) `⍺+/⍵` N-wise sum of right argument: Calculates window sums.
3. [Divide](https://aplwiki.com/wiki/Divide) `⍺÷⍨` Divide by left argument: Completes average calculation.

### Using Adverse Operator
```apl
]aplcart adverse
_Adv_←{⍺←⊢ ⋄ 0::⍺ ⍵⍵ ⍵ ⋄ ⍺ ⍺⍺ ⍵}

(+⌿÷⊣)_Adv_{⍬}
```
This solution uses the Adverse operator to handle errors in a more general way. It allows specifying a custom error handler (returning an empty vector in this case) for any error that occurs.

Definition of [Adverse](https://aplwiki.com/wiki/Adverse) operator from APLcart: A specialized operator for error handling.

1. [Fork](https://aplwiki.com/wiki/Train#3-trains) `(+⌿÷⊣)` Moving average function: Concise expression of moving average.
2. `_Adv_` [Adverse](https://aplwiki.com/wiki/Adverse) operator: Applies error handling.
3. [Zilde](https://aplwiki.com/wiki/Zilde) `{⍬}` Return empty vector on error: Provides a fallback for errors.



## Checking the Argument

### Basic Argument Check
```apl
{⍺>≢⍵:⍬ ⋄ ⍺÷⍨⍺+/⍵}
```
This solution checks the input before performing the calculation, avoiding error trapping. It returns an empty vector if the window size is too large, otherwise performs the calculation.

1. [Tally](https://aplwiki.com/wiki/Tally) `⍺>≢⍵:⍬` If left arg > length of right, return empty: Checks for valid window size.
2. [Compress](https://aplwiki.com/wiki/Replicate) `⍺+/⍵` N-wise sum of right argument: Calculates window sums.
3. [Divide](https://aplwiki.com/wiki/Divide) `⍺÷⍨` Divide by left argument: Completes average calculation.

### Higher Rank Solution
```apl
{⍺>≢⍵:0⌿⍵ ⋄ ⍺÷⍨⍺+⌿⍵}  ⍝ For higher rank
```
This solution handles higher rank arrays by preserving the shape of the input when returning an empty result. It uses 0⌿⍵ to return an empty array with the same structure as the input, working correctly for matrices and higher-dimensional arrays.

1. [Tally](https://aplwiki.com/wiki/Tally) `⍺>≢⍵:0⌿⍵` If left arg > length, return empty of same shape: Handles higher rank arrays.
2. [Reduce](https://aplwiki.com/wiki/Reduce) `⍺+⌿⍵` N-wise sum of right argument: Calculates window sums for any rank.
3. [Divide](https://aplwiki.com/wiki/Divide) `⍺÷⍨` Divide by left argument: Completes average calculation.

This solution works for higher rank arrays and preserves the shape of the input, making it the most robust and industrial-strength solution.



## Glyphs Used:

- [Reduce](https://aplwiki.com/wiki/Reduce) `⌿` - N-wise sum
- [Divide](https://aplwiki.com/wiki/Divide) `÷` - Division
- [Left](https://aplwiki.com/wiki/Left) `⊣` - Left argument
- [Floor](https://aplwiki.com/wiki/Floor) `⌊` - Minimum
- [Tally](https://aplwiki.com/wiki/Tally) `≢` - Length of array
- [Plus](https://aplwiki.com/wiki/Plus) `+` - Addition
- [Commute](https://aplwiki.com/wiki/Commute) `⍨` - Swap arguments
- [Each](https://aplwiki.com/wiki/Each) `¨` - Apply to each
- [Compress](https://aplwiki.com/wiki/Replicate) `/` - Filter
- [Ravel](https://aplwiki.com/wiki/Ravel) `,` - Flatten array
- [Right](https://aplwiki.com/wiki/Right) `⊢` - Right argument
- [Diamond](https://aplwiki.com/wiki/Statement_separator) `⋄` - Statement separator
- [Zilde](https://aplwiki.com/wiki/Zilde) `⍬` - Empty numeric vector

## Concepts Used:

- [Dfn](https://aplwiki.com/wiki/Dfn) - Dynamic Function
- [Tacit Programming](https://aplwiki.com/wiki/Tacit_programming)
- [Fork](https://aplwiki.com/wiki/Train#3-trains)
- [Error Guard](https://aplwiki.com/wiki/Dfn#Error-guards) `::`
- [N-Wise Reduction](https://aplwiki.com/wiki/N-wise_reduction)
- [Clamping](https://en.wikipedia.org/wiki/Clamping_(graphics))
- [Rank](https://aplwiki.com/wiki/Rank_(operator))
- [Code Golf](https://en.wikipedia.org/wiki/Code_golf)
- [Error Trapping](https://aplwiki.com/wiki/Error_trapping)
- [Adverse Operator](https://aplwiki.com/wiki/Adverse)
- [Boolean Mask](https://aplwiki.com/wiki/Boolean)
- [Higher-Rank Arrays](https://aplwiki.com/wiki/Rank)

## Transcript

Welcome to the APL Quest see Wiki for details. Today's quest is the ninth problem from the 2013 round of the APL Problem Solving Competition. The problem is to find the average over a sub-period of a year's worth of data of numbers.

Starting off with some data in cells, the obvious approach here is to use n-wise reduction. Perhaps the simplest way to visualize n-wise reduction, at least for simple data, is using the adverb reduction using concatenation. So we have the sales, and then we can say, for example, a three-wise reduction of the sales using concatenation. That just concatenates together groups of three elements, moving over one step each time. You can see we get these little windows.

Now what we want is the average of each one of those, so we can use the very idiomatic APL expression for an average, which is the sum divided by the length, and apply it to each one of those. That gives us the solution where the left argument is three and the right argument is sales.

However, we should really package this as a proper function. So we can do that - these are two function applications. There's the comma slash using the 3 as left argument, and we should probably use slash bars to make this more general for higher rank arrays in general. Then there is the post-processing, which is the average function on each one. So the three can go outside here, and then we have on the top the n-wise reduction applied between these arguments (between three and sales), and then the average each is applied to the result of that.

This is a basic solution, but by far not the best solution. This is because we can actually go in and apply something directly to each subsequence. What we do here when we compute the average is again and again we take something of length three, sum it together, and then divide by its length (which is always three, of course). Instead, what we could do is we could just do the three-wise reductions, and then all of those could be divided by three. That would give us the same result.

We can express this as a little defined function. So what we want is the left argument, which is the size, that wise reduction over the right argument, and then we divide that by the left argument. That gives us the result, and this is a much better way to do it, certainly much more efficient.

We can even express this as a tacit function because it comes out very nicely that we have a function applied dyadically between the left argument and the right argument, and a middle function, and then a selection of the left or right. This can be expressed in terms of function application as the left function applied between the left and right argument, and that is a fork. So we can simply get rid of all these mentions of the argument and get this beautiful solution. That is as good as it gets for the specific way that this problem has been stated.

However, there's an interesting edge case which the testing framework (if you look on problems.tryapl.org) does not include. We could say that the n (the window size) is larger than a year. So for 12, we get the entire year averaged; for 13, we get no averages; and for 14, we get an error. How do we handle window sizes that are more than one step larger than the entire data that we've got? There are many different ways we could go about this. Let's have a look at some of them.

For this particular problem, an obvious approach would be to go back here and simply clamp the argument. So we have the left argument, but under no circumstances should it be larger than 13. If it's larger than 13, then we just want it to be 13. So we take the smallest value of the left argument and 13 and replace it with that. This works like normal as long as the left argument is small, and it works fine with 13 and greater values as well.

Now, you could observe, of course, that when we're dividing by a number, if ever the left argument is 13 or greater, then that means that what's on the left of the division sign is an empty vector. In which case, it doesn't matter at all what we divide by - there are no divisions going on. So we can remove this clamping from the right, and it will still work.

We can also generalize this, of course, so that it works on any number of elements in cells. We would do that by simply adding one to the length of the cells. This is a more general-purpose solution.

We could also use our original formulation, using the little train that we had before. We simply use the clamping size on the left, and then the fork which was the n-wise reduction divided by left, and then the data on the right. This will work as well, and it works for these values that we have been using as well.

We can, if we want, get rid of this parenthesis by moving things around. So we can put this plane argument over here, and we can put this formula on the right, and then we could swap here. This would work. However, since the only thing that's inside this train is a tack right or left and another function, we can also move this over and on this function and simply turn the tack around to be on the right, and that will still work.

We can also unroll the whole thing because we can see that what's actually happening here is that the n-wise reduction, where this is the n, and then over this, and finally we divide by the left argument. So we don't even need a train here inside the defined function. Then we can go ahead and make this tacit if we want, and there are various different ways we can do that.

Here we can say we want the tally of the right argument, and this is the left argument. We want the n-wise reduction over the right argument, and then here's division by the left argument. This would be the tacit equivalent. It's not necessarily better, but it's possible to write it like this.

Then there is a code golf trick for those who want to make the code as short as possible. That is, when we add one to the length, then we could actually get that out here where we are anyway applying the function tally atop the selection of the right argument. We can include this one plus by concatenating the arguments, since the left argument here is always going to be a single number. Concatenating it to the right argument gives something that's not meaningful, but it has the right length, namely one longer than the original right argument. So we can save a little bit of code here by doing it this way, but it's obscure and it's not efficient either because we are inserting an element at the beginning of potentially a larger amount of data. But if short code is what you strive for and you want people to not understand what it is you've written, then this is the way to go.

A whole different approach to dealing with this problem of the length error is to simply try it and then catch the error when things go wrong. So we can again write our formula as we did before, where we say that we divide by the left argument and then we have this n-wise reduction on the right argument, and that works fine. But when we do something that gets too big, then we get a length error. Now, length error is error number five, and so we can say we set up an error guard: whenever any error number five happens, return the empty vector. Then it will return the empty vector.

But you might also wish for a specialized operator, one that allows you to choose what happens when an error happens - how should we react to that? So here we had an explicit guard, but we could also use a function that can't handle the error and instead combine it together with some kind of error handling function for an overall function that does handle an error. This exists, for example, in the J language where it's called "adverse," and we can actually use APL Cart to find a definition for adverse. We find this definition (I won't go into exactly what it is), but we can just give it a name: adverse.

Now we can use it with any definition that we had from before. So we can say we want the sum divided by the left argument, but if anything goes wrong, then instead we apply a function which returns the empty vector. So this works as before as long as no error happens, and when an error happens, then we apply the empty vector function and we get an empty vector result.

However, I prefer when I do APL to not rely on catching an error and continuing. Rather, I test my input and make sure that everything is okay with it. So I would do that in this case by writing an assumption that if the left argument is greater than the length of the right argument, then return the empty vector; otherwise, we can do whatever we've been doing before. That works as well, with no error handling involved here.

Finally, there's an issue here if the input has higher rank. We're already using slash bar instead of slash in order to handle higher rank things, but if the length is too large and we end up with this guard, the results from the guard then aren't actually correct. Yes, it has to be empty, but not the empty vector.

Say that we have the sales in a matrix with a single column, and then we're doing this n-wise average down the columns. That means we are reducing the number of rows in the table, but the table is still a one-column table. This means if the left argument is too large, we should be getting a zero-row table, but not an empty list.

So if we make sales into a one-column table, then it might look okay, but if we look at the shape of it, it isn't quite right. Whereas if we do 13 here - so this is also too large, and 12 would be a one-by-one table.

If instead we redefined our function such that it can be larger than one (because we know that when it's one larger, the n-wise reduction still works), if we define the function to only go into the special guard when it is more than one - with the left argument more than one larger than the length of the right argument - then we can observe here that we get (notice there's no blank line) a zero-row, one-column table.

The problem is, of course, that we universally just return the empty vector if the left argument exceeds the length of the right argument. What we really should do is preserve the entire shape of the argument, only compressing the height of the table to have no rows if it's a two-dimensional table. Or if it's a larger array, we want to compress the first axis to have no content.

The way we can do that is, instead of returning this empty vector blanket, we use zero to compress along the first axis (the leading axis) and the right argument. Then we will see that it now works even for large arguments.

This is the ultimate industrial solution. Thank you for watching.
