
# [Go forth and Multiply 2013-8](https://problems.tryapl.org/psets/2013.html?goto=P8_Go_Forth_And_Multiply)

**Problem:**  Write a dfn which produces a multiplication table.

**Video:** [https://youtu.be/O_l-nJYmDrs](https://youtu.be/O_l-nJYmDrs ) 

**Code:** [https://github.com/abrudz/apl_quest/blob/main/2013/8.apl](https://github.com/abrudz/apl_quest/blob/main/2013/8.apl)

Today's quest is called **Go forth and Multiply**. It's really simple; we just need to create a multiplication table. This task is the eighth problem from the [2013 APL Problem Solving Competition](https://problems.tryapl.org/psets/2013.html?goto=P8_Go_Forth_And_Multiply).

## Examples:

## **Outer Product**

For once, we are going to go straight to the obvious solution. We can generate the indices from **1** to a certain target number. Then, we simply need to provide the [outer product](https://mastering.dyalog.com/Operators.html?highlight=outer%20product#outer-product) using that argument, both on the left and the right side—so, vertically and horizontally in our table. This gives us our solution.

### A

```APL
A ← ∘.×⍨⍳ ⍝ for n=4 : same as 1 2 3 4 ∘.× 1 2 3 4
```

1. `⍨⍳` [Index of](https://aplwiki.com/wiki/Index_Of) `⍳` generates the integers 1 through n.
2. `∘.×`  [Outer Product](https://mastering.dyalog.com/Operators.html?highlight=outer%20product#outer-product) builds a "times table". It has no left argument so [Selfie](https://aplwiki.com/wiki/Commute) `⍨`  puts the index from Step one on both sides. 



## **Without Outer Product**

```APL
B ← {×/¨⍳⍵ ⍵}
C ← ×⍤0 1⍨⍳
D ← {+⍀⍵ ⍵⍴⍳⍵}
E ← +⍀,⍨⍴⍳
F ← +⍀,⍨⍴+⍀⍤⍴∘1
G ← +⍀,⍨+\⍤⍴≢
```



### B

```APL
B ← {×/¨⍳⍵ ⍵}
```

1. Using the definition of Outer Product we pair up every element from the list on the left with every element from the list on its right.
2. `⍳⍵ ⍵` Builds a table where every element is a pair of indices. 
3. `×/¨` Multiply Each pair of indices and return the result. Multiply Reduction by itself would only give the product of the columns. 

### C

```APL
C ← ×⍤0 1⍨⍳
```

4. Multiplying a list of scalers (rank 0)  on the left and pairing with the entire vector (rank 1) `×⍤0 1` on the right. 
5. Using `⍨⍳7` as both right and left argument. 
6. Uses the definition of Outer product applies the [operand](https://aplwiki.com/wiki/Operand "Operand") function on each [element](https://aplwiki.com/wiki/Element "Element") of the left array with each element of the right array.

### D

```APL
D ← {+⍀⍵ ⍵⍴⍳⍵}
```

7. Build a 7 row table with the numbers 1 to 7. 
8. use cumulative addition to create the multiplication table
9. `7 7⍴⍳7` [reshapes](https://aplwiki.com/wiki/Reshape) [iota](https://aplwiki.com/wiki/Index_Generator) 7 into a table with 7 rows and 7 columns. 
10. `+⍀` sum [scans](https://aplwiki.com/wiki/Scan) the columns showing each summed iteration



### E    

```APL
E ← +⍀,⍨⍴⍳
```

11. Tacit equivalent of D. 
12. Recognizes that `⍵,⍵` is duplication or self [concatenation](https://aplwiki.com/wiki/Catenate).  `,⍨` 
    



### F 

```APL
F ← +⍀,⍨⍴+⍀⍤⍴∘1
```

13. Build Iota from first principles
14. Cumulative addition on the reshape of 1 is the equivalent of iota.  `+⍀⍴1`
15. `⍤` [Rank](https://aplwiki.com/wiki/Rank_(operator)) applies the long left argument to cells of the right. `+⍀,⍨⍴+⍀⍤⍴∘1` the reshape of 1. The [Bind](https://aplwiki.com/wiki/Bind)  `∘` character binds reshape and 1 without a left argument for reshape. 

### G   

```APL
G ← +⍀,⍨+\⍤⍴≢
```

16. Recognizes that a scaler has a total count of elements of 1 so we can replace 1 with [tally](https://aplwiki.com/wiki/Tally) and then using a horizontal and vertical sum scan to create the table. 



## **Without Operators (Functions only)**

```APL
H ← {⍵ ⍵⍴(⍵/⍳⍵)×(⍵×⍵)⍴⍳⍵}
I ← {t×⍉t←⍵ ⍵⍴⍳⍵}
J ← {↑(⍳⍵)×⊂⍳⍵}
K ← ↑⍳×(⊂⍳)
L ← (↑⊢×⊂)⍳
```

### H

```APL
H ← {⍵ ⍵⍴(⍵/⍳⍵)×(⍵×⍵)⍴⍳⍵}
```

1.  `(⍵×⍵)⍴⍳⍵` generate the numbers and reshape to fill table. 
2.  `(⍵/⍳⍵)` generate the numbers and replicate them `⍵` times each. 
3.  `⍵ ⍵⍴` Put the two vectors together and reshape into a matrix



### I

```APL
I ← {t×⍉t←⍵ ⍵⍴⍳⍵}
```

1.  `⍵ ⍵⍴⍳⍵` generate the numbers and reshape into a matrix
2.  `t×⍉t←` use t for transpose and shift the rows into columns multiply `t ⍵` together. 



### J     

```APL
J ← {↑(⍳⍵)×⊂⍳⍵}
```

3. Using [Scaler Extension](https://aplwiki.com/wiki/Scalar_extension)

4. `(⍳⍵)`generate the numbers

5. `×⊂⍳⍵` multiply by the Scaler [enclose](https://aplwiki.com/wiki/Enclose) of the numbers.

6. `↑` [Mix](https://aplwiki.com/wiki/Mix) the result into a matrix



### K

```APL
K ← ↑⍳×(⊂⍳)
```

7.  Tacit version of J. 
8.  `(⍳⍵)×⊂⍳⍵` [Fork](https://aplwiki.com/wiki/Train#3-trains) Enclose iota and iota are applied to the argument. So we can remove the argument `⍵`
9.  `↑⍳×⊂⍤⍳` Enclose [of](https://xpqz.github.io/cultivations/Trains.html?highlight=trains) `⍤` iota
    



### L    

```APL
L ← (↑⊢×⊂)⍳
```

10.  Tacit version of J. 
11.  `(↑⊢×⊂)⍳` putting the expression atop iota.
12.  `(↑⊢×⊂)⍳` enclose `⊂` of iota `⍳` multiplied by the [identity](https://aplwiki.com/wiki/Identity)  `⊢` of iota `⍳` and mixed. 



## **Without Arithmetic** 

```APL
M ← {≢¨,¨⍳¨⍳⍵ ⍵}
N ← ≢⍤,⍤⍳¨⍳⍤,⍨
O ← ∘.{≢⍺/⍵/#}⍨⍳
P ← ≢⍤⍸¨⍳∘./⍳
Q ← ∘.{≢#,⍣⍺⍣⍵⊢⍬}⍨⍳
```



### M ([Counting Stick](http://jwilson.coe.uga.edu/EMAT6680Fa2012/Faircloth/Essay1alf/ChineseStickMultiplication.html))

```APL
M ← {≢¨,¨⍳¨⍳⍵ ⍵}
```

1.  `⍳⍵ ⍵` iota for a vector argument generates a matrix of the [indices](https://aplwiki.com/wiki/Index "Index") of it's  [elements](https://aplwiki.com/wiki/Element "Element")
2.  `⍳¨⍳⍵ ⍵` iota mapped to this matrix generates a nested matrix of the number of rows times the number of columns
3.  `,¨⍳¨⍳⍵ ⍵` Ravel to squash this matrix down to 1 dimension
4.  `≢¨,¨,¨⍳¨⍳⍵ ⍵` Count the number of elements in each cell



### N

```APL
N ← ≢⍤,⍤⍳¨⍳⍤,⍨
```

1.  Tacit version of M
2.  `,⍨` Self concatination
3.  `⍳⍤,⍨` Applying Iota on the self concatenation of the argument
4.  `⍤,⍤⍳¨` Fusing together the three [each](https://aplwiki.com/wiki/Each) using [rank](https://aplwiki.com/wiki/Rank_(operator))



### O ([Unary](https://en.wikipedia.org/wiki/Unary_numeral_system))

```APL
O ← ∘.{≢⍺/⍵/#}⍨⍳
```

1.  `∘.{#}⍨⍳`  [outer product](https://aplwiki.com/wiki/Outer_Product) with a custom function that just returns a value `#`  [Selfie](https://aplwiki.com/wiki/Commute) `⍨` puts the index on both sides. 
2.  `∘.{⍺ ⍵ #}⍨⍳` Placing the index values as arguments `⍺ ⍵`
3.  `∘.{⍺/⍵/#}⍨⍳` Replicating the  Replication of the value #
4.  `∘.{≢⍺/⍵/#}⍨⍳` Tally to convert unary to natural numbers
    P ([Where](https://aplwiki.com/wiki/Indices))
5.  `∘./⍨⍳` outer replicate on the argument
6.  `⍸¨∘./⍨⍳`  [Where](https://aplwiki.com/wiki/Indices) on [each](https://aplwiki.com/wiki/Each) since the array is not Boolean, the values are taken to mean the repeat count for each index. 
7.  `≢⍤⍸¨⍳∘./⍳` fuse a tally on the result to return a multiplication table. 
    Q (Finger Counting)
8.  `∘.{#,⍬}⍨⍳`  Empty vector for every result. Concatenate a #
9.  `∘.{#,⍣⍵⊢⍬}⍨⍳` Concatenate #,  `⍵` times using [power](https://aplwiki.com/wiki/Power_(operator))`⍣` 
10.  `∘.{#,⍣⍺⍣⍵⊢⍬}⍨⍳` Concatenate #,  `⍺` times using [power](https://aplwiki.com/wiki/Power_(operator))`⍣`
11.  `≢` tally on the result to return a multiplication table. 



## **Glyphs Used:**

- [Catenate](https://aplwiki.com/wiki/Catenate) `,`
- [Index of](https://aplwiki.com/wiki/Index_Of) `⍳`
- [Comparison Function](https://aplwiki.com/wiki/Comparison_function) `=`
- [Compress](https://aplwiki.com/wiki/Replicate) `/` - filters the right argument `=/¨` compare each
- [Each](https://aplwiki.com/wiki/Each) `¨`
- [Commute](https://aplwiki.com/wiki/Commute) `⍨` - aka Selfie or Swap
- [Dyadic Transpose](https://xpqz.github.io/learnapl/dyadictrn.html?#dyadic-transpose-ab) `x⍉y` - allows you to select diagonals by giving one or more dimensions equal mapping
- [Reshape](https://aplwiki.com/wiki/Reshape) `⍴`
- [At](https://xpqz.github.io/cultivations/Operators.html#at) `@` - What's on its left gets done at the position indicated by its right operand.
- [Identity](https://aplwiki.com/wiki/Identity) `⊢`
- [Where](https://aplwiki.com/wiki/Indices) `⍸` - returns the indices of a boolean array - mondadic
- [Power](https://aplwiki.com/wiki/Power_(operator)) `⍣¯1` - used to access function inverses
- [Power(Function)](https://aplwiki.com/wiki/Power_(function)) `*` - `X*Y` is `X` raised to the power `Y`
- [Overtake](https://aplwiki.com/wiki/Take#Overtaking) `↑` - A length larger than the argument length causes [fills](https://aplwiki.com/wiki/Fill_element) to be inserted
- [Bind](https://aplwiki.com/wiki/Bind) `∘` - used to create a derived function with a single constant argument
- [Constant](https://xpqz.github.io/cultivations/Operators.html#constant-a) `A⍨` - always returns the operator array
- [Signum](https://aplwiki.com/wiki/Signum) `×A` - Sign of number - on a real argument are `0`, `1`, and `¯1` (zero, positive and negative)
- [Tally](https://aplwiki.com/wiki/Tally) `≢`
- [Expand](https://xpqz.github.io/cultivations/Functions7.html?#expand) `\` - copies each [element](https://aplwiki.com/wiki/Element) of the right [argument](https://aplwiki.com/wiki/Argument) a given number of times
- [Roll](https://aplwiki.com/wiki/Roll) `?0` - When zero Roll chooses a floating-point number between 0 and 1
- [Matrix Divide](https://aplwiki.com/wiki/Matrix_Divide) `⌹`
- [Rank](https://aplwiki.com/wiki/Rank_(operator)) `⍤` - applies its left [operand](https://aplwiki.com/wiki/Operand) function to [cells](https://aplwiki.com/wiki/Cells) of its arguments specified by its right operand array.
- [Depth](https://aplwiki.com/wiki/Depth) `≡` - returns an array's depth
- [Decode](https://aplwiki.com/wiki/Decode) `⊥` - aka base
- [Encode](https://aplwiki.com/wiki/Encode) `⊤` - aka antibase
- [Bind](https://aplwiki.com/wiki/Bind) `∘` - used to create a derived function with a single constant argument
- [Key](https://aplwiki.com/wiki/Key) `⌸` - groups [major cells](https://aplwiki.com/wiki/Major_cell) and applies the [function](https://aplwiki.com/wiki/Function) for each cell
- [Enclose](https://aplwiki.com/wiki/Enclose) `⊂` - An enclosed array is a [scalar](https://aplwiki.com/wiki/Scalar), which is subject to [scalar extension](https://aplwiki.com/wiki/Scalar_extension).
- [Reverse](https://aplwiki.com/wiki/Reverse) `⌽` - reorders [elements](https://aplwiki.com/wiki/Elements) of the argument to go in the opposite direction along a specified [axis](https://aplwiki.com/wiki/Axis).
- [Circular](https://aplwiki.com/wiki/Circular) `12○` - Phase of ⍵ (omega)
- [Pi Times](https://aplwiki.com/wiki/Pi_Times) `○`
- [Magnitude](https://aplwiki.com/wiki/Magnitude) `|` aka absolute value
- [Residue](https://aplwiki.com/wiki/Residue) `|` aka remainder
- [Floor](https://aplwiki.com/wiki/Floor) `⌊` - a [monadic](https://aplwiki.com/wiki/Monadic) [scalar function](https://aplwiki.com/wiki/Scalar_function) that gives the [floor](https://en.wikipedia.org/wiki/floor_and_ceiling_functions) of a real number
- [Equal to](https://aplwiki.com/wiki/Equal_to) `=` - a [comparison function](https://aplwiki.com/wiki/Comparison_function) which tests whether argument elements are equal to each other.

## **Concepts:**

- [Ravel Order](https://aplwiki.com/wiki/Ravel_order)
- [Dfn](https://aplwiki.com/wiki/Dfn)
- [Tacit Programming](https://aplwiki.com/wiki/Tacit_programming)
- [Outer Product](https://aplwiki.com/wiki/Outer_Product) `∘.`
- [Sort](https://xpqz.github.io/learnapl/manip.html?highlight=sort#grade-up-down) `data[⍋data]` 
- [Overtake](https://aplwiki.com/wiki/Take#Overtaking) `↑` - A length larger than the argument length causes [fills](https://aplwiki.com/wiki/Fill_element "Fill element") to be inserted
- [Fork](https://aplwiki.com/wiki/Train#3-trains)

## **Transcript:**

Welcome to the APL quest! See APL Wiki for details. Today's quest is called "Go Forth and Multiply". It's really simple, we just need to make a multiplication table. It's the eighth problem from the 2013 round of the APL problem solving competition. For once, we're going to go straight to the obvious solution.

Well, we can generate the indices from one to a certain target number, and then we simply need to provide the outer product using that argument both on the left and the right side, so both vertically and horizontally in our table, and this gives us our solution. Just get rid of the argument, and we can give it a name, and now we can apply it as we want, and it works even on zero.

Now let's have some fun because this problem is already solved. The first thing we're going to do is try to solve this without using the outer product, which is otherwise the obvious solution. And there are a couple of different ways that we can do that.

The first thing is to use the definition of the outer product. The outer product pairs up every element from the list on the left with every element from the list on its right. Now we can actually use a property of the multiplication that it maps or distributes over multiple arguments. So if we pair up every element from our list of numbers with the entire list of numbers, then that will be the equivalent. Let's say we have the numbers here, and then we multiply using a rank, and we want every element, so those are scalars rank 0 from the left, and pair them up with the entire vector rank 1 on the right using this iota 7 as both right and left argument, and that gives us our solution. So this is just using outer product in a hidden way because this is the definition of outer product for scalar operands.

We can do one more fun thing. I think a lot of people are not aware that if you give a vector argument to iota, then it generates all the indices of an array with that shape. This actually holds true even for a scalar one element vector as well. And now, since these are the indices, those are also the corresponding numbers that need to be multiplied together in a multiplication table. So we can simply say that we multiply and across these, or we reduce each of these pairs of numbers and with multiplication, and that gives us our solution as well.

And there's even more fun we can have. Let's start again with these numbers, and this time we reshape them into the shape of our multiplication table, so this just gives us repetition. And now what we can see is that multiplication is just a series of additions. So on the first row, we need our original numbers from one to seven. On the second row, we want the numbers from one to seven added with the numbers from one to seven again, and in the third row, we want it added again. So this is simply the cumulative addition going down, and we can easily write that as the plus slash bar. So this is the cumulative vertical addition, and that gives us our multiplication table as well. And we can then write this as a function, wrap it in braces, replace the sevens here with the argument, and that gives us our solution as well.

We can even make this test it. We can observe that this is a function application of iota on the argument and this is duplication on the argument. Duplication could also be written as self-concatenation because we could express this as omega comma omega. So now we can write this testedly as self-concatenation with iota on the right, and then this is our tested equivalent.

Let's have even more fun. Let's eliminate the iota. How can we eliminate the iota? Well, if you take seven and use it to reshape one, we get seven ones. And now we can do the same thing, the cumulative addition on those, that gives us the equivalent of the iota, and then we can proceed as before. So we can write this testedly using the same technique as before: you want the cumulative vertical sum of the self concatenation, reshaping the cumulative sum of reshape with the right argument of one. Now we can apply this and we get our multiplication table. Yeah, I know it's silly, but it's a nice exercise and can give some insights into the relationship between the functions.

We can even take this one more step. We can say that instead of one here, we can observe that a scalar has a total count of elements which is one, so we could use this as well. Let's do this step by step. We take the self concatenation and reshaping the one, and then it gives us all ones. And then we just need to do the summation row-wise, and then we can do it column-wise like that. And we can put all this together to a single tested function as follows: we just keep this one at the top, at the end, and the horizontal summation becomes on top of the reshape, and there we go, we've got no iota and you're not even implementing anything, just defining everything in terms of cumulative additions.

Okay, so we can see that it's not a problem to implement this multiplication table using other functionality than outer product. Let's take it one step further. Let's get rid of all APL operators. Now we're only allowed to use functions. How can we do this? Well, what we can try to do is we can start by generating our numbers, and now we can recycle these until we have enough numbers for them to fill the entire multiplication table. This just repeats them over and over again, and then we need to multiply them with the corresponding numbers, which means the first seven numbers here need to be multiplied by one, the next seven needs to be multiplied by 2.

So, if we start off with the numbers from 1 to 7, and we now replicate them by 7 each, and now we can put these two things together, and those are the numbers in our multiplication table. The only thing we now need to do is to reshape them into the right shape, and we've got a multiplication table. We can write this whole thing as a function simply by replacing all the sevens here with the name of the argument, and there we have it, multiplication table implemented only using functions, no operators.

If you don't like operators, there are other fun ways that we can do this, and we can take again reshaping the numbers over and over, and then we can try transposing that. And then we can see that all we need to do is multiply. Now we have the corresponding vertical numbers as in when we had the outer product, and the horizontal numbers as we had with our as the right argument in the for multiplication in the outer product. And then we only think we need to do is multiply these two together. 

Now, if we want to write this in a function without using operators, we can start by defining a function that generates the numbers from 1 to the argument, like we did before. Then, we can use the repeat function to repeat these numbers by the argument. Next, we can use the transpose function to get the transpose of this array, and then we can use the outer product function to multiply these two arrays together. Finally, we can reshape the resulting array into the shape of a multiplication table, and we've got our solution.

So, there you have it. We've implemented a multiplication table using a variety of different techniques, from the obvious outer product to more creative approaches that eliminate operators altogether. While some of these solutions may not be the most efficient or practical, they demonstrate the power and flexibility of APL and the many ways it can be used to solve problems.

If we wanted to make this into a function we could just wrap it. Alternatively, we could give it a name, but there are even simpler ways of doing this. That is by relying on APL's scalar extension. You can always scale or extend by using a scanner function together with an enclose. So, how is this going to work? Well, we've got our numbers from one to seven, and then we can enclose that. It makes it a scalar.

Now, if we pair up these two, then the scalar one, two, three, four, five, six, seven gets paired up with one and paired up with two and paired up with three. So, we can simply write iota seven times the enclose of iota seven, and that gives us the rows of our matrix. The only thing that's missing is mixing the rows into a proper matrix, and we can write this tacitly simply removing the arguments. So here's we have a fork; we have enclosed iota applied in the argument, and the yodes are applied on the argument.

We can get rid of the mention of the argument and make it 0.3, and we need to enclose off the iota, and there's our tacit equivalent solution. Now what you can observe here is that we are computing the range, the iota first, and we can actually break that, so to say, out of the expression by making it in the top of an iota. So we want the enclose of iota and the identity of the iota, and then we mix that, and that's applied to the iota itself. This is a more efficient silly solution.

Finally, for the ultimate challenge, is to implement the multiplication table without any arithmetic at all. So by arithmetic, we need to we mean things like plus and times, and of course, this might seem impossible, but we can actually implement multiplication in the old-fashioned counting stick way. And there are different ways we could do it.

Here is an example. Let's make it a bit smaller so we can see what we're doing. We know that iota can generate the numbers that we need to get multiplied together by using two of the same, but how do we actually multiply them? So what we can do is we each of these pairs themselves can be an argument for iota. And this gives us, and for each one of these pairs gives us the indices of an array of those dimensions. But of course, that implies actually some multiplication. Say if we have three and two, that gives us an array that has three rows and two columns, and that has six elements. Which is because it's the number of rows times the number of columns. That's where we're going with it.

So, the one the only thing we need to do to know now is how many elements are there in each one? Well, if we ravel them, and then we can count how many elements are there in each one, and we just implemented multiplication table without using any arithmetic whatsoever. So we can make this into a function and that works or we could make it test it by observing that here we again have the um self-concatenation and we are applying iota on that and then we have these three loops the three eaches that we can fuse together and we've got ourselves a tested solution.

There are other ways, let's look at the numbers again and now we use outer product, and we're going to write a custom function for the outer product. The function that just returns a value, the value I'm using here is a hash or a reference to the root namespace. It doesn't matter at all. I'm just using it as a placeholder value just to show that I'm not using any numbers or any characters any values whatsoever. It could have been any array whatsoever as long as it's just a scalar. Oops, sorry, I needed the selfie here.

Now, this gives us a multiplication table but missing the values. We just have a scalar in each position. However, we do have the numbers as arguments, so we can write the arguments in here, and what we need we can then do is we can replicate using this. So we just instead of having a single reference to the root namespace, we now are going to have one reference, two references, three references, and so on. And then we can replicate again using the left argument, and effectively, this is a multiplication. It's the replication of a replication, and here is the multiplication table in unary. We can convert from unary to normal numbers simply by doing a tally.

We've got a multiplication table, so this is another solution here. Here's another fun one. We can take the numbers and do an outer replicate on these. So, here we have one ones, two ones, three ones, one two, two two, two three, two, and so on. We can already begin to see where we are going with this.

Now, what we can do is that we need to know how many do they add up to in total, and this is where the function where comes in. So, if you do a where on each as what does where do it normally gives us the indices where where there are ones in a boolean array. However, for the first column, it will give us in this index one and then index one and index two, index one and two, and j3 if the but actually what it does is it gives us this many of the corresponding index. So, in the second column, we're going to get two ones and then the next row two ones and two twos, etc. And now we're done because this is the multiplication table in unary, completely ignoring those actual values.

So, if we just fuse a tally on that, we have a multiplication table. It isn't quite a valid tested function, but there are various ways around it. We could fuse these two together, and then it would be valid, or we could compute iota twice, give it this left argument and right argument to the outer product. That would also be valid.

Finally, maybe for the most basic of counting on fingers type way of doing this, let's try with these numbers and we're making an outer product on that with a custom function. And we are starting off with the empty vector, so this gives us one empty vector for every result, these are placeholders. And now we are going to take a value, I'm using the reference to hash again as just a placeholder value, and we're going to concatenate that to the empty vector. So that gives us a one limit vector for each one, but we're not going to concat it with cardinal catenated just once. We're going to concatenate it as many times as the right argument shows.

So, for the columns in the first column, we're going to concatenate it once. In the second column, we're going to concatenate it twice and so on, as we can see here. But we're not going to just do that either. We're going to use to do this whole thing also as many times as the left argument says. So, the first row we're going to concatenate this reference to the empty vector and we are, so the first one we're going to concatenate it once, once in the second row, first column we're going to concatenate it twice, once in the first row, second column we're going to concatenate it once, but doing so twice, etc. And this gives us our unary multiplication table.

And as before, we can insert tally to generate our multiplication table. Of course, these are all silly, and what you should be doing if you want the multiplication table is just the regular outer product with normal multiplication. Thank you so much for watching.
