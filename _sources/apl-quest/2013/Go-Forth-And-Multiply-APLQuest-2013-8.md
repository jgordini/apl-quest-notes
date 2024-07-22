
# Welcome to the APL Quest 

## Today's Quest: Go forth and Multiply

Today's quest is called **Go forth and Multiply**. It's really simple; we just need to create a multiplication table. This task is the eighth problem from the [2013 APL Problem Solving Competition](https://problems.tryapl.org/psets/2013.html?goto=P8_Go_Forth_And_Multiply).

### The Obvious Solution

For once, we are going to go straight to the obvious solution. We can generate the indices from **1** to a certain target number. Then, we simply need to provide the [outer product](https://mastering.dyalog.com/Operators.html?highlight=outer%20product#outer-product) using that argument, both on the left and the right side—so, vertically and horizontally in our table. This gives us our solution.

```apl
⍝ Basic solution
A ← ∘.×⍨⍳
```

Let’s get rid of the argument and give it a name. Now we can apply it as you want, and it works even on zero!

### Exploring Alternative Solutions

Now, let's have some fun, as the problem is already solved! The first thing we’re going to do is try to solve this without using the outer product, which is the obvious solution.

#### Using the Definition of the Outer Product

The outer product pairs up every element from the list on the left with every element from the list on its right. We can utilize a property of multiplication that it distributes over multiple arguments. If we pair up every element from our list of numbers with the entire list of numbers, that will be equivalent.

Let’s say we have the numbers here and then multiply using a rank. We want every element, which are scalars (rank 0), from the left paired with the entire vector (rank 1) on the right using `iota 7`, which gives us our solution.

```apl
×⍤0 1⍨⍳
```

This approach uses the outer product in a hidden way because it’s the definition of the outer product for scalar operands!

#### Generating Indices as Vectors

Interestingly, if you give a vector argument to `iota`, it generates all the indices of an array with that shape. This holds true even for a scalar one-element vector. Since these are the indices, those are the corresponding numbers that need to be multiplied together in the multiplication table.

We can simply say that we multiply across these or reduce each of these pairs of numbers:

```apl
B ← {×/¨⍳⍵ ⍵}
```

This results in our multiplication table!

### Reshaping for Fun

Let’s start again with these numbers. This time, we reshape them into the shape of our multiplication table. This just gives us repetition.

Now, what we see is that multiplication is just a series of additions. On the first row, we need our original numbers from **1** to **7**. On the second row, we want the numbers from **1** to **7** added with the numbers from **1** to **7** again. In the third row, we want it added again. This is simply cumulative addition going down.

We can easily write that as `+/\`. So this is the cumulative vertical addition, and that gives us our multiplication table as well.

We can then write this as a function:

```apl
D ← {+⍀⍵ ⍵⍴⍳⍵}
```

### Testing and Further Exploration

We can further observe that this is a function application of `iota` on the argument and this is duplication on the argument. Duplication could also be written as self-concatenation, expressed as `omega , omega`.

Now we can write this treatedly as self-concatenation with `iota` on the right. Next, let’s eliminate `iota`. 

If you take **7** and use it to reshape **1**, we get **seven ones**. Now we can do the same cumulative addition on those; that gives us the equivalent of `iota`, and then we can proceed as before.

### Using Cumulative Additions

We can write this testedly using the cumulative vertical sum of the self-concatenation reshaping the cumulative sum of reshaping with the right argument of **1**.

We can now apply this and get our multiplication table. 

```apl
E ← +⍀,⍨⍴⍳
```

It may seem silly, but it’s a nice exercise that can give insights into the relationship between functions.

### Going Further: Implementing Functions without Operators

Let’s take it one step further: let’s get rid of all APL operators. Now we're only allowed to use functions.

We will start by generating our numbers and then recycle these until we have enough to fill the entire multiplication table. This just repeats them over and over again.

```apl
H ← {⍵ ⍵⍴(⍵/⍳⍵)×(⍵×⍵)⍴⍳⍵}
```

Next, we need to multiply them with the corresponding numbers. The first seven numbers here need to be multiplied by **1**, and the next seven need to be multiplied by **2**. If we start with the numbers from **1** to **7** and replicate them by **7** each, we can then put these two things together, resulting in the multiplication table.

### Finding Alternative Methods

There are also other fun ways we can do this. We can take the numbers, reshape them repeatedly, and transpose that.

Now we have the corresponding vertical numbers just like in the outer product, and the horizontal numbers as we had for multiplication in the outer product. All we need to do now is to multiply these two together.

```apl
I ← {t×⍉t←⍵ ⍵⍴⍳⍵}
```

We can also multiply by the transpose, yielding a multiplication table!

If we wanted to make this into a function, we could just wrap it again or give it a name.

### Relying on APL's Scalar Extension

We can use APL's scalar extension to simplify matters. If we enclose the numbers from **1** to **7**, this makes it a scalar.

If we pair up these two, the scalar **1, 2, 3, 4, 5, 6, 7** gets paired with **1**, paired with **2**, paired with **3**, and so forth.

```apl
J ← {↑(⍳⍵)×⊂⍳⍵}
```
This gives the rows of our matrix. The only thing that’s missing is mixing the rows into a proper matrix.

### Final Challenge: Multiplication without Arithmetic

Finally, for the ultimate challenge, let’s implement the multiplication table without any arithmetic at all.

Though this might seem impossible, we can implement multiplication using the counting stick method.

Here is an example. We can generate the numbers with `iota` used twice.

```apl
M ← {≢¨,¨⍳¨⍳⍵ ⍵}
```

Now, we simply must count the number of elements in each cell by raveling it, giving us the multiplication table without using arithmetic whatsoever!

### Conclusion

There are many ways to implement the multiplication table in APL, from traditional using operators to clever functional approaches and methods without arithmetic. 

While the simplest solution remains the outer product with normal multiplication, the exploration of alternatives shows the power and flexibility of APL, revealing many ways it can be used to solve problems.

Thank you so much for reading!

## Additional Resources

- **Video Explanation:** [Dyalog APL Multiplication Table Video](https://youtu.be/O_l-nJYmDrs)
- **GitHub Repository:** [APL Quest Code Examples](https://github.com/abrudz/apl_quest/blob/main/2013/8.apl)