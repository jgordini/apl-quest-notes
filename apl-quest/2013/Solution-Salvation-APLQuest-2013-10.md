
# [Solution Salvation 2013-10](https://apl.quest/psets/2013.html?goto=P10_Solution_Salvation)

**Problem:** Write a [Dfn](https://aplwiki.com/wiki/Dfn) to produce a vector of the first n odd numbers.

**Video:** [https://www.youtube.com/watch?v=w-rzx2VNqbY]( https://www.youtube.com/watch?v=w-rzx2VNqbY)

**Code:** [https://github.com/abrudz/apl_quest/blob/main/2013/10.apl](https://github.com/abrudz/apl_quest/blob/main/2013/10.apl)

Hello and welcome to this APL quest! In today's episode, we're tackling the last problem from the 2013 round of the APL problem-solving competition. The objective is straightforward: we are given a set of linear equations and their corresponding results, and we need to find the values of the variables.

## Intro

### Setting Up the Equation System

Let's start by creating a simple example of a system of equations with three variables:

- $(4x + 1y + 1z = 2)$
- $(2x + 2y + 2z = 6)$
- $(6x + 3y + 1z = 4)$

A potential solution for this system could be:

- $(x = -1)$
- $(y = 3)$
- $(z = 1)$

We can verify this by substituting the values back into the equations and calculating the results. 

The equations simplify to:

- $(4 \times (-1) + 1 \times 3 + 1 \times 1 = 2)$
- $(2 \times (-1) + 2 \times 3 + 2 \times 1 = 6)$
- $(6 \times (-1) + 3 \times 3 + 1 \times 1 = 4)$

Indeed, these yield the correct outcomes.

### Finding the Missing Values

The next step is to compute the values of \(x, y,\) and \(z\) without knowing them a priori. We know the results \(2, 6,\) and \(4\), and we can express our goal as finding a vector \(v\) such that:

$[ M \cdot v = R ]$

Where \(M\) represents the matrix of coefficients and \(R\) represents our results.

## **Basic Solutions**

```apl
M←3 3⍴4 1 3 2 2 2 6 3 1
r←2 6 4
v←¯1 3 1

v ≡ r +.×⍣¯1⍨ M
v ≡ r +.×⍨∘⌹ M
v ≡ r ⌹ M
```

These are three equivalent primitive APL solutions for solving a set of linear equations:

1. `v ≡ r +.×⍣¯1⍨ M`: This uses the inverse of matrix multiplication.
   - `+.×` is the inner product (matrix multiplication)
   - `⍣¯1` applies the inverse of the function
   - `⍨` swaps the arguments

2. `v ≡ r +.×⍨∘⌹ M`: This uses explicit matrix inversion.
   - `⌹` is the matrix inverse operator
   - `∘` composes the matrix multiplication with the inverse
   - `⍨` swaps the arguments

3. `v ≡ r ⌹ M`: This uses the built-in linear equation solver.
   - `⌹` when used dyadically solves the system of linear equations



## Advanced Solutions

### **Hotelling-Bodewig Scheme**

```apl
⍝ Hotelling-Bodewig scheme:
⍝ Vᵢ₊₁ = Vᵢ(2I−AVᵢ)
⍝ Vᵢ₊₁ = 2Vᵢ−VᵢAVᵢ
⍝ Vᵢ₊₁ = Vᵢ+Vᵢ−VᵢAVᵢ
 Vi+Vi-Vi+.×A+.×Vi
 A(⊢+⊢-⊢+.×+.×)Vi
 ⊢(⊢+⊢-⊢+.×+.×)⍣≡
⍝ https://codegolf.stackexchange.com/a/213953
```

**Overview**

The Hotelling-Bodewig algorithm is an iterative method for refining an initial approximation of a matrix's inverse. The method is defined by the iteration formula:

$𝑉𝑖+1 = 𝑉𝑖(2𝐼 − 𝐴𝑉𝑖)$

where:

- $𝑉𝑖$ is the current approximation of the inverse of matrix 𝐴
- $𝑉𝑖+1$ is the next approximation
- $𝐼$ is the identity matrix

The process continues iteratively until $𝑉𝑖$ converges to $𝐴⁻¹$, the true inverse of the matrix 𝐴.

This formulation is equivalent to the previously given formula, but expressed in a more compact form. It directly shows how each iteration refines the approximation by multiplying the current estimate 𝑉𝑖 with a correction term ($2𝐼 − 𝐴𝑉𝑖$).

1. Start with the mathematical formula
2. Rearrange terms
3. Express in APL notation
4. Create a tacit function using trains
5. `⍣≡` applies the function on its left until the result doesn't change. Because of the way [equality testing works](https://help.dyalog.com/18.0/Content/Language/System Functions/ct.htm) in Dyalog APL, this terminates.

## 

### Soleymani method

```APL
⍝ Soleymani V₀:
⍝ Mᵀ÷tr(MMᵀ)
+/1 1⍉+.×∘⍉⍨M ⍝ tr(MMᵀ) Explicit matrix multiplication and diagonal sum
1 1⍉{⍺'+'⍵}.{⍺'×'⍵}∘⍉⍨3 3⍴⍳9 ⍝ Symbolic representation of the operation
+/×⍨,M ⍝ Sum of squared elements
+.×⍨,M ⍝ Inner product of raveled matrix with itself
(,+.×,)M ⍝ Compressed notation for the same operation
(⍉÷,+.×,)M ⍝ Complete initial guess calculation
⍝ https://www.opuscula.agh.edu.pl/vol33/2/art/opuscula_math_3322.pdf
```

The Soleymani method is an advanced iterative technique designed to solve ill-conditioned linear systems of equations. These systems are challenging because small changes in the input can lead to large changes in the output, making traditional methods less reliable.

**Problem Statement**

Consider the linear system:

$Ax = b$

Where:
- A is an n × n ill-conditioned matrix
- x is the unknown vector
- b is the known right-hand side vector

**Iterative Formula**

The Soleymani method uses the following iterative formula:

$x_{k+1} = x_k - (2I - AA^T)A^T(Ax_k - b)$

Where:
- $x_k$ is the kth iteration approximation of the solution
- $I$ is the identity matrix
- $A^T$ is the transpose of A

**Initialization and Convergence**

1. Start with an initial guess $x_0$ (often the zero vector or another reasonable starting point)
2. Iterate until a convergence criterion is met, e.g., $||Ax_k - b|| < ε$ for some small $ε > 0$

**APL Implementation of Initial Guess**

The initial guess for the Soleymani method, V₀, is given by:

$V₀ = M^T ÷ tr(MM^T)$

Where $M^T$ is the transpose of $M$, and $tr(MM^T)$ is the trace of $MM^T$.

## **Combined Hotelling-Bodewig and Soleymani Method**

```apl
⍝ Hotelling-Bodewig + Soleymani:
(⊢(⊢+⊢-⊢+.×+.×)⍣≡⍉÷,+.×,)M              ⍝ ⌹M
r(+.×⍨∘⊢(⊢+⊢-⊢+.×+.×)⍣≡⍉÷,+.×,)M        ⍝ v⌹M
{r+.×⍨∘(⊢(⊢+⊢-⊢+.×+.×)⍣⍵⍉÷,+.×,)M}⍤0⍳11 ⍝ show steps
```

**Matrix Inversion:**

```apl
(⊢(⊢+⊢-⊢+.×+.×)⍣≡⍉÷,+.×,)M
```

This line combines the Hotelling-Bodewig iteration with Soleymani's initial guess to compute the inverse of matrix M. Let's break it down from right to left:

- `(⍉÷,+.×,)M`: This is Soleymani's initial guess $V₀ = M^T ÷ tr(MM^T)$.
- `(⊢+⊢-⊢+.×+.×)`: This is the Hotelling-Bodewig iteration step.
- `⍣≡`: This applies the iteration until convergence.
- The outer `⊢` is used to make the function a monadic operator that takes M as its right argument.

**Solving the Linear System:**

```apl
r(+.×⍨∘⊢(⊢+⊢-⊢+.×+.×)⍣≡⍉÷,+.×,)M
```

This line solves the linear system $Mx = r$, where r is the right-hand side vector. It's similar to the previous line, but with these changes:

- `r` is prepended to multiply the result with the computed inverse.
- `+.×⍨∘⊢` is inserted to perform the matrix-vector multiplication.

**Showing Intermediate Steps:**

```apl
{r+.×⍨∘(⊢(⊢+⊢-⊢+.×+.×)⍣⍵⍉÷,+.×,)M}⍤0⍳11
```

This line shows the intermediate steps of the iteration:

- `⍳11` generates a vector from 1 to 11.
- `⍤0` applies the function to each element of this vector separately.
- The function is similar to the previous line, but `⍣≡` (iterate until convergence) is replaced with `⍣⍵`, where ⍵ is the current iteration count.

This implementation elegantly combines the Hotelling-Bodewig scheme with Soleymani's initial guess, providing an efficient method for matrix inversion and solving linear systems. The final line allows for visualization of the convergence process, which can be useful for understanding the algorithm's behavior and performance.

## **Gauss-Jordan Elimination**

```apl
⍝ Adapted from https://dfns.dyalog.com/n_gauss_jordan.htm
GaussJordan←{⎕IO ⎕ML←0 1               ⍝ Gauss-Jordan elimination
    Elim←{                            ⍝ elimination of row/col ⍺
        p←⍺+{⍵⍳⌈/⍵}|⍺↓⍵[;⍺]           ⍝ index of pivot row
        swap←⊖@⍺ p⊢⍵                  ⍝ swap ⍺th and pth rows
        mat←swap[⍺;⍺]÷⍨@⍺⊢swap        ⍝ col diag red to 1
        mat-(mat[;⍺]×⍺≠⍳≢⍵)∘.×mat[⍺;] ⍝ col off-diag red to 0
    }
    (⍴⍺)⍴(0 1×⍴⍵)↓↑Elim/(⌽⍳⌊/⍴⍵),⊂⍵,⍺ ⍝ Elim/ … 2 1 0 (⍵,⍺)
}
r GaussJordan M
```

This is an implementation of the Gauss-Jordan elimination method:
1. Define the main function and an inner elimination function
2. Find the pivot row
3. Swap rows and normalize the pivot element
4. Eliminate other elements in the column
5. Apply the elimination process iteratively

## **Old-style APL Matrix Inversion**

```apl
⍝ Adapted from https://www.jsoftware.com/papers/APL360TerminalSystem1.htm#fig4
    ∇  b←rec a;p;k;i;j;s
[1]    →3×⍳(2=⍴⍴a)∧=/⍴a
[2]    →0=⍴⎕←'no inverse found'
[3]    p←⍳k←s←1⍴⍴a
[4]    a←((s⍴1),0)\a
[5]    a[;s+1]←s A 1
[6]    i←j⍳⌈/j←|a[⍳k;1]
[7]    p[1,i]←p[i,1]
[8]    a[1,i;⍳s]←a[i,1;⍳s]
[9]    →2×⍳1E¯30>|a[1;1]÷⌈/|,a
[10]   a[1;]←a[1;]÷a[1;1]
[11]   a←a-((~s A 1)×a[;1])∘.×a[1;]
[12]   a←1⌽[1]1⌽a
[13]   p←1⌽p
[14]   →5×⍳0<k←k-1
[15]   b←a[;p⍳⍳s]
    ∇
A←{⍺↑⍵⍴1}
r +.×⍨rec M
```

This is an old-style APL implementation of matrix inversion:
1. Check input validity
2. Initialize variables
3. Augment the matrix
4. Find the pivot element
5. Swap rows
6. Normalize the pivot row
7. Eliminate other elements in the column
8. Rotate the matrix and continue the process
9. Rearrange the result

## Glyphs Used:

- [Shape](https://aplwiki.com/wiki/Shape) `⍴` - Create array with specified shape
- [Multiply](https://aplwiki.com/wiki/Times) `×` - Multiplication
- [Matrix Inverse](https://aplwiki.com/wiki/Matrix_inverse) `⌹` - Matrix division
- [Outer Product](https://aplwiki.com/wiki/Outer_product) `∘.` - Apply function to all combinations
- [Inner Product](https://aplwiki.com/wiki/Inner_product) `+.×` - Matrix multiplication
- [Transpose](https://aplwiki.com/wiki/Transpose) `⍉` - Transpose matrix
- [Identical To](https://aplwiki.com/wiki/Match) `≡` - Exact equality
- [Power Operator](https://aplwiki.com/wiki/Power_operator) `⍣` - Repeat function application
- [Commute](https://aplwiki.com/wiki/Commute) `⍨` - Swap arguments
- [Index Generator](https://aplwiki.com/wiki/Index_generator) `⍳` - Generate integer series
- [Reverse](https://aplwiki.com/wiki/Reverse) `⌽` - Reverse array
- [Reduce](https://aplwiki.com/wiki/Reduce) `/` - Apply function between elements
- [At](https://aplwiki.com/wiki/At) `@` - Replace elements at specified indices

## Concepts Used:
- [Matrix Operations](https://aplwiki.com/wiki/Matrix)
- [System of Linear Equations](https://en.wikipedia.org/wiki/System_of_linear_equations)
- [Hotelling-Bodewig Scheme](https://en.wikipedia.org/wiki/Hotelling%27s_iteration)
- [Iterative Methods](https://en.wikipedia.org/wiki/Iterative_method)
- [Gauss-Jordan Elimination](https://en.wikipedia.org/wiki/Gaussian_elimination)
- [Tacit Programming](https://aplwiki.com/wiki/Tacit_programming)
- [Dfn](https://aplwiki.com/wiki/Dfn) - Dynamic Function
- [Trains](https://aplwiki.com/wiki/Train)
- [Index Origin](https://aplwiki.com/wiki/Index_origin) `⎕IO`
- [Migration Level](https://aplwiki.com/wiki/Migration_level) `⎕ML`
- [Recursive Function](https://aplwiki.com/wiki/Recursion)
- [Control Structures](https://aplwiki.com/wiki/Control_structure) (e.g., `→`)
- [Rank](https://aplwiki.com/wiki/Rank)

## Transcript

Hello and welcome to this APL quest episode. See APL wiki for details. Today's quest is the last problem from the 2013 round of the APL problem solving competition. We are simply given a set of linear equations and the values that those equations add up to, and then we are to find the solution for the variables.

Let's start by creating this equation system. We'll have a simple example of just three equations with three variables. This is saying four x plus one y plus z, and two of each, and then six x plus three y plus z. They should add up to a result which is two, six, four. So four x plus one y plus three z equals 2, and 2x plus 2y plus 2z equals 6, and so on.

A solution to that is if x is negative one, y is three, and z is one. We can check this. We have the matrix, and then we'll multiply each row by these values, and then we can sum them up. We can see that we got these results. Indeed, four times x (where x is negative one) plus one times y (where y is three) plus three times z (where z is one) gives two, just like we're supposed to have it.

We can write this a little bit neater as an inner product. The problem here is that we don't know this result (-1, 3, 1). We want to compute it. What we do know are these values: 2, 6, and 4. In other words, we want to find a v such that M plus dot times this value gives 2, 6, 4. This matches our R.

Luckily, we can actually write this up. We can say we want to apply this negative one time to get this value. This is a power negative one, applying a function in reverse. Applying it negative one times really asks this question: what argument (in this case, right argument) can we give to M plus dot times such that we get R? And that solves the problem.

Now, in the problem specification, R goes on the left argument and M is the right argument. So we can type up our solution as plus dot times operator negative one, commute (just swap the two arguments like that), and then the matrix goes on the right and the vector goes on the left. That's a proper solution.

However, this matrix multiplication in reverse is actually the same as multiplying by the inverse. So we can state this instead as multiplying by the inverse. We can glue them together, so it's the same thing as the explicit formula like this. But for now, we'll have it in a proper assignable function like this. This is multiplication by the inverse, and the dyadic form of this character (which is often nicknamed "domino" as it looks like a one-one domino) is actually exactly that.

So the entire solution can just be that. In other words, this problem has a one-character solution in APL. Now, that's of course lots of fun, but it would be nice to see how we could really solve this without APL just doing all the work for us.

There are a couple of ways to do this. There's a really clever way called the Hotelling-Bodewig scheme (if I pronounce that correctly). It states that we can do an iterative approach to approximate better and better the correct solution to an inverse of a matrix. As we had before, if we have the inverse, then the problem is basically solved.

It states like this: we're going to iterate with this result, where every iteration depends on the previous value. The formula looks like this (I'm not going to go into exactly why this works, but this is what they state - you can look up their paper). They say that the next iteration is the previous iteration matrix multiplied by two times the identity matrix minus the grand matrix (the original matrix) that has been multiplied by the previous iteration.

We can rearrange this formula a little bit. We can take this Vi here and, so to say, multiply into the parenthesis. So that gives us 2Vi (because the Vi multiplied by the identity matrix is just Vi, of course) minus Vi times A (which is the original matrix) times Vi again.

We can then state this in APL. The way we would write that is: it's 2Vi, or we can write 2 times Vi, minus Vi plus dot times (which is the matrix multiplication) and A plus times and Vi. We can break this, avoid the parenthesis simply by having two Vi's here instead. It'll be the same thing as multiplying it by two.

Now we can make this a function of the original matrix on one side, so we have A, and then we make a function and we have the previous iteration as the right argument. So we'll do it as a tacit function. We start from the right here, build it up. First, we want the matrix multiplication of them (plus dot times), and then we want to multiply by Vi again. So Vi is the right argument plus dot times that. And then we want to subtract this from Vi. That's the right argument minus that, and then we add another one of the right arguments. We can write it up like this.

So here's a tacit way to compute this, and this is one iteration of it. However, we actually want to keep doing this until it becomes stable. The way we would then write that: we could take it as a function where the right argument function of the original matrix (here called A) becomes fed into our inner function as a left argument, and then we keep iterating with the power operator until two consecutive iterations are the same.

And so we then just need to apply this whole thing on our initial guess. That's the next problem. The problem is it's kind of hard to find an initial guess which will work out for us, but recently someone named Soleymani came up with a surefire way to determine an initial guess.

What he stated was that the transpose of the array divided by the trace of the matrix times its transpose is a good starting guess that will always come up. Again, see his paper if you want the details of how exactly that works out.

So again, the trace of the matrix times its transpose, and then we divide the transpose by that. First, we do the trace of the matrix times its transpose. We can have this matrix M, and we can transpose it, and then we can do a matrix multiplication with itself. And then we want the trace. The trace is the sum of the major diagonal from top left to bottom right, and that we can do as a 1 1 transpose. That's the trace of that, and then we sum that up.

So for our matrix M here, that magic value that we want to divide by is 84. And then we would go ahead and divide the transpose of M by 84, and that would be a good starting value.

Now, this can be - we could use this, but it can actually be simplified a little bit. And for that, we need to observe some characteristics of doing exactly this: the trace of the matrix multiplied by its transpose.

So what we're going to do is we'll start with a matrix that is easy to recognize where the bits and pieces are going. And instead of doing an actual multiplication with itself, we are going to take and model the plus and the times as functions that are just saying what they would do, rather than actually doing them.

So this will show us - we give great little boxes showing us what's going on, and we need to multiply it with itself, with the right argument to the matrix multiplication being transposed. So here we can see all the results that we're getting, but we're only interested in the diagonal. So we're taking the 1 1 transpose of that.

And now we can observe exactly what's going on. Remember, the trace is the sum of these, so really what will happen is we're going to add all these together, all these little boxes. And notice that it is 1 1 multiplied by each other, and 2 2, 3 3, and so on. That means every element of the entire matrix gets multiplied by itself squared, and then we just sum all these squares together.

Which means we can state this much easier: we can just ravel the matrix, square it, and sum it. Or we could, of course, square it first, ravel it, then sum it - many different ways of doing that. We can also combine this summing and the multiplication into an inner product. And that means that if we're going to write in the train - we want this as short as possible - then we can write the ravel plus times the ravel of the matrix, and that gives us that.

And now we just need to take the transpose of the matrix and divide by that. So we can take the transpose, divide by this, and that gives us our starting value, which isn't very interesting to look at. But let's put all of this together.

So what we - let's go up and get it from up here. We had this formula right here, and we stick it in here. And this is then the inverse that we get. We can compare this with the inverse primitive and see we got the exact same value.

And now remember how we solve this with V. So we can go in and say V plus dot times this inverse. Or instead - and this is a solution, but we want to glue these two things together to be a single function. So this right part here is the inversion of the matrix, and the left part is the matrix multiplication. So we multiply with the inverse, and that gives us our solution.

And remember, this is an iterative thing. So here inside here is the power match, which just runs over and over again until two consecutive things match each other. It would actually be neat to see how this would look. We can do that by doing each iteration separately.

Now, I happen to know that we only need to go through 11 iterations. So for every one of numbers from 1 to 11, we're going to apply it that many times. And then we can see the progression of better and better values for x, y, and z to solve this system until we're done - it becomes stable.

So this is a modern computational approach to this. The traditional way that you might have learned in school is the Gauss-Jordan method. And you can find it in the dfns workspace. Here is an adapted version of what you can find there. I'll try to explain it a little bit.

What it's doing here - if you learned it in school, you would have learned that there are these various actions you can take on your matrix together with the result values to slowly build up a diagonal matrix, and then you have the solution. When we're running it as computer code, then we can't go by feeling of what's easier; instead, we just go through all the steps every time.

So what we're building up here at the bottom is this: this is our equation system, these are the final values that we're putting next to it, and then these are the reversed indices because reduction runs from right to left. So that's what this comment is trying to say - that this is what we're going to reduce over. So this just eliminates here, eliminates here, eliminates here, in this order.

And every time we eliminate, we choose - for precision reasons - we choose the row that has the largest magnitude. So this gives us a specific column, and we start - because we're going down diagonals - so first we start with the first column. And then we get rid of the first few elements that have already been - those columns that have already been taken care of. Of course, with the first one, that means we're dropping zero. Notice that the index origin is zero up here.

And then we look at the magnitudes and choose the largest one, and that's what we call our pivot row. And then we swap things around. So where we're up to in the nth row and the pivot row, we're taking those and just flipping them. There's just two of them, so reverse just swaps the two around.

And now we've got a matrix that's modified by having these two swapped around. And then we want to normalize such that in that corner - or should we say, of the sub-matrix missing rows and columns that is on the intersection of the nth column and the nth row - that's why we have alpha semicolon alpha here. And we divide that - we divide all the other values there so that we get a 1.

And then finally, we have the step of adding or subtracting. And the way it's been implemented here is we are adding/subtracting not just for that single row, but we're doing the entire matrix. So it's built up using masks, essentially. When we add or subtract 0, then nothing happens, and we're using a mask. So these are all the indices for all the rows, and then we have a specific row number here which gets - so wherever it's different from, we get zeros, and that means we only get 1 on this single row.

Then we pick out from that column there and create a matrix with all the values that are in this particular row. And then that effectively just - we have a bunch of zeros, and we subtract the right values in the right place. Once that's done, since we've done a reduction, we have enclosed, so we open that up. And we're not interested in the entire matrix with result values; rather, we can chop those away. So that's what this is doing.

And then, just in case they were all identical, we use a single value - we just reshape it to have the right shape. And that's how the Gauss-Jordan method works. We can try that - it solves the whole thing immediately, like this, in exactly the same way.

And then I happened to look up in an old paper on APL 360, and it was actually interesting - it brought us an example of code, and this function, which is an inversion of a matrix, but implemented in old-style APL. I'm not going to go through and explain this - you can do it on your own. It's really very much - it is the Gauss-Jordan method. It's very much the same, but in an old style without using any of the new operators.

I've altered one slight thing - you can see a capital A in there. And that was an original function in APL 360. They had some functions called alpha and omega, which were prefix and suffix vectors. So alpha (or which I've changed to an A here, because alpha is now meaning something else) - and you can define it like this in our case here, where it's - so the left argument is the length of the vector, and the right argument is the number of leading ones in that boolean vector.

In our case, it could just be a take, but I suppose overtake (meaning you can take more elements than there are in an array) wasn't supported yet at that time. So you can actually replace these A's just with an up arrow. And this gives us our inverted matrix, as we can see from before - same thing as the primitive.

And that means that we could do the same thing here with multiplying the result of the inversion with our result - our desired result values. And that gives us our values for x, y, and z in the very oldest of fashions.

So this concludes the first year of APL problem solving competitions, and we're now going to continue next time with the problems from 2014. Thank you for watching.
