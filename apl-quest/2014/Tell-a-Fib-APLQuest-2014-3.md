# [Tell A Fib 2014-3](https://apl.quest/psets/2014.html?goto=P3_Tell_a_Fib)

**Problem:** Write a dfn that takes an integer right argument and returns that number of terms in the Fibonacci sequence.

**Video:** [https://www.youtube.com/watch?v=7J4hJmgWlJo](https://www.youtube.com/watch?v=7J4hJmgWlJo)

**Code:** [https://github.com/abrudz/apl_quest/blob/main/2014/3.apl](https://github.com/abrudz/apl_quest/blob/main/2014/3.apl)

## Getting Started

The Fibonacci sequence is typically defined recursively. We start with seed values and compute each subsequent value by summing the two preceding values. The sequence can be expressed with a stopping condition as follows:

- For zero elements, we return an empty sequence.
- For one element, we want a sequence `[1]`.
- For two elements, we want `[1, 1]`.
- For more than two elements, each new element is the sum of the two preceding ones.

## Examples

### Basic Recursive Implementation

We can express this in APL as follows:

```apl
Rec←{⍵≤1:⍵ ⋄ +/∇¨⍵-⍳2}¨⍳
Rec 10
⍝ Result: 0 1 1 2 3 5 8 13 21 34
```

Step-by-step explanation:
1. `{...}¨⍳`: This applies the function to [each](https://aplwiki.com/wiki/Each) number from 1 to the input (10 in this case).
2. `⍵≤1:⍵`: If the input is 0 or 1, return the input itself.
3. `⍵-⍳2`: Generate the two previous numbers (n-1 and n-2).
4. `∇¨`: Recursively apply the function to these two numbers.
5. `+/`: [Sum](https://aplwiki.com/wiki/Reduce) the results of the recursive calls.

This implementation computes the first 10 Fibonacci numbers. However, it's inefficient because it recomputes the same values multiple times for each element of the sequence.

### Efficient Computation: Fundamental Fibonacci Function

To improve efficiency, we'll compute the entire sequence at once using a fundamental Fibonacci transformation function, which we'll call `∆` (delta):

```apl
∆←{⍵,+/¯2↑⍵}
∆ 1 1
⍝ Result: 1 1 2
∆ 1 1 2
⍝ Result: 1 1 2 3
```

Step-by-step explanation:
1. `¯2↑⍵`: [Take](https://aplwiki.com/wiki/Take) the last two elements of the input.
2. `+/`: [Sum](https://aplwiki.com/wiki/Reduce) these two elements.
3. `⍵,`: [Catenate](https://aplwiki.com/wiki/Catenate) this sum to the original input.

This function extends the current sequence by one element, summing the last two elements of the input.

### Recursive Function with Tail-Call Optimization

We can use this fundamental function in a recursive implementation:

```apl
Rec←{⍵≤1:⍵⍴⍵ ⋄ ∆∇⍵-1}
```

However, this approach can lead to stack overflow for large inputs. We can implement tail-call optimization to avoid this:

```apl
TCO←{⍺≤≢⍵:⍺↑⍵ ⋄ ⍺∇∆⍵}∘1
10 TCO 1
⍝ Result: 1 1 2 3 5 8 13 21 34 55
```

Step-by-step explanation:
1. `⍺≤≢⍵:⍺↑⍵`: If the desired length (⍺) is less than or equal to the current sequence length ([tally](https://aplwiki.com/wiki/Tally) ≢), [take](https://aplwiki.com/wiki/Take) the first ⍺ elements.
2. `⍺∇∆⍵`: Otherwise, apply ∆ to extend the sequence and recurse.
3. `∘1`: This [binds](https://aplwiki.com/wiki/Bind) 1 as the right argument, so the function starts with [1].

### Power Operator Approach

We can also use the [power operator](https://aplwiki.com/wiki/Power_operator) to apply our fundamental function multiple times:

```apl
Ap2←{⍵↑∆⍣⍵⊢1 1}
Ap2 8
⍝ Result: 1 1 2 3 5 8 13 21

Ap0←{1⌈∘∆⍣⍵⊢⍬}
Ap0 8
⍝ Result: 1 1 2 3 5 8 13 21
```

Step-by-step explanation for Ap2:
1. `1 1`: Start with the seed values [1, 1].
2. `∆⍣⍵`: Apply the ∆ function ⍵ times.
3. `⍵↑`: [Take](https://aplwiki.com/wiki/Take) the first ⍵ elements of the result.

Step-by-step explanation for Ap0:
1. `⍬`: Start with an empty vector.
2. `1⌈∘∆`: Apply ∆, but ensure at least one element (handles the case of 0).
3. `⍣⍵`: Repeat this process ⍵ times.

### Reduction as Iteration

Another approach is to use [reduction](https://aplwiki.com/wiki/Reduce):

```apl
Red←{⍵↑⊃∆/1⍴⍨1⌈⍵}
Red 8
⍝ Result: 1 1 2 3 5 8 13 21
```

Step-by-step explanation:
1. `1⌈⍵`: Ensure at least one element (handles the case of 0).
2. `1⍴⍨`: [Reshape](https://aplwiki.com/wiki/Reshape) to create a vector of 1s with this length.
3. `∆/`: Apply ∆ between all elements ([reduction](https://aplwiki.com/wiki/Reduce)).
4. `⊃`: Extract the result from its enclosure.
5. `⍵↑`: [Take](https://aplwiki.com/wiki/Take) the first ⍵ elements.

### Pairwise Summation

We can also compute the sequence using pairwise summation:

```apl
Sum←{{1⌈2+/0 0,⍵}⍣⍵⊢⍬}
Sum 8
⍝ Result: 1 1 2 3 5 8 13 21
```

Step-by-step explanation:
1. `⍬`: Start with an empty vector.
2. `0 0,⍵`: [Catenate](https://aplwiki.com/wiki/Catenate) two zeros to the current sequence.
3. `2+/`: Perform pairwise summation ([windowed reduction](https://aplwiki.com/wiki/Windowed_Reduction)).
4. `1⌈`: Ensure at least one element (handles the case of 0).
5. `⍣⍵`: Repeat this process ⍵ times.

### Matrix Multiplication Approach

Another interesting method uses a transformation matrix:

```apl
Mul←{1 2∘⌷¨+.×\⍵⍴⊂2 2⍴0 1 1 1}
Mul 8
⍝ Result: 1 1 2 3 5 8 13 21
```

Step-by-step explanation:
1. `2 2⍴0 1 1 1`: Create the transformation matrix [[0,1],[1,1]].
2. `⍵⍴⊂`: [Replicate](https://aplwiki.com/wiki/Replicate) this matrix ⍵ times.
3. `+.×\`: Perform cumulative matrix multiplication.
4. `1 2∘⌷¨`: Extract the [1,2] element from each resulting matrix.

### Accumulation Using Pairs

We can also generate the sequence by accumulating pairs:

```apl
Acc←{r⊣{r,∘⊃←+\⌽⍵}⍣⍵⊢0 1⊣r←⍬}
Acc 8
⍝ Result: 1 1 2 3 5 8 13 21
```

Step-by-step explanation:
1. `r←⍬`: Initialize an empty result vector.
2. `0 1`: Start with the pair [0,1].
3. `⌽⍵`: [Reverse](https://aplwiki.com/wiki/Reverse) the pair.
4. `+\`: Compute the running sum ([scan](https://aplwiki.com/wiki/Scan)).
5. `⊃`: Take the first element of the sum.
6. `r,∘⊃←`: [Catenate](https://aplwiki.com/wiki/Catenate) this element to the result vector.
7. `⍣⍵`: Repeat this process ⍵ times.

## Direct Computation Methods

There are also methods to compute Fibonacci numbers directly without building up the sequence:

### Approximations of the Golden Ratio

```apl
Phi←{1∧÷+∘÷\⍵⍴1}
Phi 8
⍝ Result: 1 2 1.5 1.666667 1.6 1.625 1.615385 1.619048
```

Step-by-step explanation:
1. `⍵⍴1`: Create a vector of ⍵ ones.
2. `÷\`: Compute the running reciprocal ([scan](https://aplwiki.com/wiki/Scan)).
3. `+∘÷`: Add 1 to each reciprocal.
4. `1∧÷`: Take the minimum of 1 and the reciprocal of each result.

This computes successive approximations to the golden ratio.

### Sum of Binomial Coefficients

```apl
Coe←(+.!∘⌽⍨¯1+⍳)¨⍳
Coe 8
⍝ Result: 1 1 2 3 5 8 13 21
```

Step-by-step explanation:
1. `¯1+⍳`: Generate the sequence 0, 1, 2, ..., n-1.
2. `!∘⌽⍨`: Compute [binomial coefficients](https://aplwiki.com/wiki/Binomial) with these values.
3. `+.`: Sum these coefficients.
4. `¨⍳`: Apply this process for [each](https://aplwiki.com/wiki/Each) number from 1 to the input.

### Binet's Formula

```apl
Bin←{s÷⍨(p*⍵)-⍵*⍨1-p←2÷¯1+s←5*÷2}⍳
Bin 8
⍝ Result: 1 1 2 3 5 8 13 21
```

Step-by-step explanation:
1. `s←5*÷2`: Compute √5.
2. `p←2÷¯1+s`: Compute φ (golden ratio).
3. `(p*⍵)-⍵*⍨1-p`: Apply Binet's formula.
4. `s÷⍨`: Divide by √5.
5. `⍳`: Apply this to the sequence 1, 2, ..., n.

## Performance Comparison

To compare the [performance](https://aplwiki.com/wiki/Performance) of these different implementations, we can use the `cmpx` function from the [dfns workspace](https://aplwiki.com/wiki/Dfns_workspace):

```apl
'cmpx'⎕CY'dfns'
cmpx,∘'¨⍳20'¨⎕A⎕NL¯3
```

This will run each implementation for the first 20 Fibonacci numbers and compare their execution times.

## Glyphs

- [Enclose](https://aplwiki.com/wiki/Enclose) `⊆` - creates a nested array from a simple array
- [Not Equal](https://aplwiki.com/wiki/Not_Equal) `≠` - compares two arrays element-wise for inequality
- [Tally](https://aplwiki.com/wiki/Tally) `≢` - returns the number of major cells in an array
- [Reverse First](https://aplwiki.com/wiki/Reverse_First) `⊖` - reverses the first dimension of an array
- [Replicate](https://aplwiki.com/wiki/Replicate) `/` - selects or repeats array elements
- [Enlist](https://aplwiki.com/wiki/Enlist) `∊` - flattens a nested array into a simple vector
- [Drop](https://aplwiki.com/wiki/Drop) `↓` - removes elements from the beginning or end of an array
- [Take](https://aplwiki.com/wiki/Take) `↑` - selects a specified number of elements from an array
- [Reshape](https://aplwiki.com/wiki/Reshape) `⍴` - creates an array with a specified shape
- [Reduce](https://aplwiki.com/wiki/Reduce) `/` - applies a function between all elements of an array

## Concepts Used

- [Dfn](https://aplwiki.com/wiki/Dfn)
- [Tacit Programming](https://aplwiki.com/wiki/Tacit_programming)
- [Boolean Mask](https://aplwiki.com/wiki/Boolean)
- [Each](https://aplwiki.com/wiki/Each)
- [Compression](https://aplwiki.com/wiki/Compression)
- [Windowed Reduction](https://aplwiki.com/wiki/Windowed_Reduction)
- [Array Operations](https://aplwiki.com/wiki/Array_programming)
- [Performance Comparison](https://aplwiki.com/wiki/Performance)
- [Dfns Workspace](https://aplwiki.com/wiki/Dfns_workspace)

## Transcript

Welcome to the APL Quest. Today, we're going to compute the Fibonacci sequence. Note that we're computing the first \( n \) elements of the sequence, not just the \( n \)th element, which is a more usual task.

The Fibonacci sequence is usually defined as being recursive. It starts with some seed values, and the next value is computed by summing the last two values in the sequence. We can express this with a stopping condition. If we start the sequence with 0 and 1, for the Fibonacci sequence, we say that for the zero elements, we don't need anything at all and can just return 0. For the element number 1, we want a 1. When we sum them together, we get the sequence 0, 1, 1, 2, and so on. If the argument is less than or equal to 1, that means it's 0 or 1, and we can return the element itself. Otherwise, we want the sum of the function itself applied to each one of the arguments minus 1 and 2.

We can try this on 1, 2, 3, and so on, but we don't want the \( n \)th element; we want all the elements up to \( n \). We can apply this on each of the numbers here. While this works, it is exceedingly inefficient. Not only do we compute the same sequence over and over again for \( n \) minus 1 and \( n \) minus 2 for every element of the sequence, but we're also doing this whole thing over and over again, which becomes ridiculously slow very quickly. So, that's not a good way to do it, but it very clearly expresses what the sequence is about.

Instead, we're going to focus on computing the entire sequence at once. The way we're going to do that is by using a fundamental function, which I call a fundamental Fibonacci transformation function. Let's call that delta. The fundamental function is that we are extending the currently generated sequence with one more element by summing the last two elements of the current sequence. So, the current sequence concatenated to the sum of the last two elements taken from the current sequence. If we start by applying this to a 1, taking the last two elements will give you a 0 and a 1, and then we can apply it over and over again.

How can we actually use this and how can we define things in terms of this function? Now we can write a recursive function where we are looking at the element at the argument. If it's less than or equal to 1, then we know exactly what the sequence is going to be. If it's zero, it's going to be the empty numeric vector. If it's one, it's going to be a vector one. We can transform a one into a vector one and zero into a zero element vector simply by letting the argument reshape itself. We want to extend the sequence otherwise. What sequence are we going to extend? We're going to extend the sequence that we got for one less than the current number we're at, and then we just need to extend it. Let's call this a recursive version, and this works but it has one problem.

This problem approaches the field of tail call optimization. Tail call optimization is a method where we do not need to keep track of the caller when we are recursing by not having to build up a stack because the final result value is not going to be post-processed in any way. The problem that we have up here is that after we're recursing, we're taking the result value and modifying it essentially. We're building up a sequence on the stack, which is just waiting for a value that can be extended more and more. We really should try to avoid that both for efficiency and not to run out of stack space either.

If the interpreter is still called optimized, then it will detect that we're not using the result just returning it, and then it will not build up a new stack frame; we'll just replace the old stack frame with a new one. For that, we want to know when to stop rather than just returning a value which is then used. The way we know how to stop is when we've generated enough of the sequence, meaning when the generator sequence is long enough. We'll feed every iteration of this function the stop condition in the form of a length how long we need to make it, and that's going to be a left argument. That left argument is given in the initial call. Our argument is 10, which means we want to keep going until we've got 10.

Of course, we can't make a function that just takes a left argument, so we'll use as argument the seed value, and that we're going this the beginning sequence we're going to start with. If the cutoff point is less than or equal to the length of the currently generated sequence, then we're either done or beyond done. So, we would in principle just return the sequence, but the problem is it might have been too long, and it only really happens if the argument is zero and we begin with a seed value of a one. Then we need to chop it down just like we did before. We can do a take which just caps the sequence to the correct length.

Now, since we know we're not done yet, then it's safe to just extend the sequence, and then we need to check again, which means we need to recurse. The limit for the sequence length is still going to be the same, so we feed that along to the next iteration. Here we can see that the last call is go, which is the recursive call with the left argument, but the result isn't being used for further computation. Therefore, this is still called optimized. Then we just need to start off with the seed, which is a one. It doesn't matter; it's a scalar because we're going to do the take on it, so it's going to become a vector anyway, and we're going to extend it in all other cases. This is a tail-call optimized version.

Another way we could see this use of the fundamental function is by applying it multiple times, and we can express this using the power operator. If we use the power operator with a number on some seed, then we're going to extend it. The problem is we're just generating a little bit too much, but we can use take again to chop it down. We don't want to start with 0, 1 either because then we get a 0 at the beginning. We can express this just by using the argument over here. This is using the power operator with two beginning values, so we're appending to the first two.

The problem is if you want to start with an empty sequence and append to that, then when we try to take the last two elements, we'll be padding with zeros, and that's going to be zero, zero, zero sum together zero, and we add a zero, and the sequence will stay zero forever. How can we ensure that we always get at least one? We can do that by clamping to be above one or doing a max with a one. If we start with an empty sequence and then we apply the basic transformation function on that \( n \) times, max with a one, we need to bind these together. Essentially here, what's happening is the power operator is applying max over and over again, always with the constant one as the left argument, but right before it applies it in the next, the next time it pre-processes the right argument with the fundamental extension function, which just then adds one more element to the sequence, and that does the job. This is appending to the first zero elements.

Another way to iterate is using reduction, and there's a bit of a trick here going on. If we look at our definition of delta, it's a dyad, and it doesn't have an alpha in there, so it doesn't use the left argument. That doesn't mean we can't give it a left argument; that works perfectly fine. Therefore, we can start off with our sequence and then we can apply with some random value here; it doesn't actually matter. This is a reduction. We have a sequence 42, 42, 1 in this case, but all these values except for the last one don't matter because only the right and right side is going to be used as our seed value, and then we're just inserting this delta in between them. So, we just need to generate a sequence that ends with a 1; it doesn't matter what it is. We might as well just use all ones for that, and then we can reduce using delta, and that gives us this. Notice that it's enclosed because reduction has to reduce the rank from one vector to zero scalar, so it encloses that, but we can just disclose that and come back. This is a very short way of defining it and using a reduction.

There is one problem, however, and that is if you try to run this on zero. Zero ratio one is an empty vector, and then we're trying to reduce over an empty vector, which requires that the operand has a known identity element, and we don't have that because it's a user-defined function, and in fact, there isn't one anyway. We can't do that. We have to extend the sequence by one and then remove one element again, and it will be a little bit ugly to do that, but it can be done. So, instead of using omega to reshape the one, let's use one plus or a one max and omega. That just means that if you have zero, it becomes one; all the other numbers stay the same. And then finally, we'll have too many elements just in that case of zero, but we can fix that as we've done before by just taking the first \( n \) element. In most cases, it's not going to be a no-op, but just for zero, it's going to chop the one down to a zero, and now that works, and it works still for larger numbers as well.

Okay, that's it for using this fundamental Fibonacci extension function, but there are other ways to compute it, and one is by using a pairwise sum. A pairwise sum is related to what we're doing because we want to add the last two elements in order to build up the next element, but we want to extend the sequence, not shorten it down. A pairwise sum, otherwise reduce with \( n \) being two, always removes reduces the length of the argument by one because it's taking two adjacent elements and combining them into one. So, we need to extend; we need to pad with additional numbers. That means we could, if we have a pairwise sum of zero and one, that gives us the next element, but we need to have more elements added up. So, if we, if we add more elements, so we need to, to extend with one element every time around the loop, and pairwise reduction removes one, so we need to add two.

If we do this, oh no, no, this isn't working. Oh yeah, of course, the problem is that we need to have more; we need to have more ones here. We need to make sure that the minimum value is a one. So, we can do the same trick as we did before with the max with a one. So, let's try that here. Now, now we don't actually need any start values anymore, and we can apply this again, and we can see how the sequence is building up. So, we just need, and we just need this transformation here to be applied over and over again. So, we take the argument, the sequence as far as we've built it up so far, and put two more zeros on the left, pairwise reduction, make sure that we start off generating ones, and we do that \( n \) times beginning with an empty sequence. This is a pairwise sum.

Another way to compute the Fibonacci sequence is by using a transformation matrix, and that matrix is a tiny little matrix that looks like this. If we multiply that by itself and keep doing that, then if we look at the generated matrices along the way, we can spot the Fibonacci sequence in there. For example, in the top right corner, we're going down one, one, two, three, five, eight, and so on. Again, we have here \( m \) all over the place, and we have matrix multiplications in and in between them. This means that we can define a vector of \( m \)'s and then we can reduce those using the matrix multiplication to get the tenth element. However, we want all the intermediate values. Instead of using reduction, we can use a scan, and then we just need to have the top right element of each one, and that gives us the Fibonacci sequence.

If you try to use it on a 0, it works fine because we have an empty vector with a reduction and with a known identity element. When there aren't any, there's nothing that needs to be done; we don't need to curse on any value out; we don't need an identity element, which would have been the identity matrix anyway, but this is using matrix multiplication. We can hard code our vector in our matrix inside here so it's standalone.

Okay, another way to do it is by the only information we need to compute the next value in the sequence are the last two elements. What it means is that when we're going from the current last two elements to the next last two elements, then the last element becomes the first element, and the sum of the two becomes the last element. Consider here two and three; let's say those are our last two elements, and if we do a scan on those, then the first element becomes the sum of the two. That's very close to what we wanted. We want to preserve the last element and then have the sum, and we can do this simply by reversing the two. And now the three became the first, and the sum of two and three became the last, which means we can, if we do this again, we get the next values, and then we can, if we extract every time around the loop then, and one of the elements, the first one, for example, then we can build up the sequence. We just need to store them somewhere.

So, we can define a function where we have a result variable. We're not going to use it initially, but we're going to apply this transformation here, the plus scan on the reverse of the current pair, and then we want to take the first element from that and append that to the result variable, and then we want to return the new pair, which is this whole thing. Here's a trick: instead of taking the first element, let's leave the whole thing, the whole and when we do the concatenation to the result variable, we pre-process the new value that is being added to the result with first, but still, this whole function is the modifying function in this modified assignment, and the assignment is here. There's a principle that the assignment always returns whatever is on the right. So, even though we're only actually using the first value, the result of this whole assignment is going to be this whole pair, and that's the whole pair that we actually interested in.

Now we can do this, and we want to do it \( n \) times, and we just need a starting pair, which is zero and one. So, the first time, so if we do this zero times, we have \( r \) already set to an empty vector. If we do it one time, then that means we are adding them up; we're getting one, one taking the first value that's one, adding to that, then the second time around the loop, we do one, one, and adding up is two, so we get one, two, and we get another one, and so on. And once we've done that \( n \) times, then \( r \) has accumulated all the values that you want, and we're not interested in the last pair, which would be the result from this application with the power operator. We just want the resulting value, so that gives us our sequence using accumulation, and that's it for all the methods we're going to look at for building up the results slowly.

We can actually compute the entire result in one go, and there are because it's possible to compute the \( n \)th Fibonacci number directly without building it up to it, and there are various ways of doing so. One way is by using approximations of the golden ratio. If we have a bunch of ones, so for this series, and then we can reduce using addition to the reciprocal, that gives so this gives us an approximation of the golden ratio. If this value is large enough, then we get a very good value for the golden ratio, but as we get there, all the intermediary values, which we can get with the scan, are approximations, and these approximations are exactly ratios of two adjacent elements in the Fibonacci series. So, if they're fractions of the two adjacent elements, that means if you can get either the numerator or the denominator, then we can get the sequence, and we can do that with the least common divisor with a one. Although you can see here, we are, we're missing one; we want actually the other number in the pair, and we can just flip the ratio upside down, taking the inverse or reciprocal of that, and that gives us the series directly computed. However, we're both using a scan using a custom function here and we're using a number theoretical function on the floats, so the performance is not going to be great. It is neat looking, though.

We can also use the sum of the binomial coefficients to compute the \( n \)th Fibonacci number. The way it works is that we start with the numbers from 1 to \( n \) minus 1, so and then we can give those a name and reverse them, and then we can pair them up with themselves in the normal order. This pairs up 0 and 9, 1 and 8, and so on, and doing the binomial on that and then we've sum that, and that gives us the \( n \)th Fibonacci number. In this way, notice that we have a scalar function reduction over a scalar vector application. We can combine that to be an inner product, and we want the same argument on both sides. \( i \) goes on both sides; we only want to preprocess the right argument to this inner product with reverse, so it can be stated like this as well. And that means we can make this into a tested function, apply it on 10 to get the 10th Fibonacci number, and we can therefore get all the numbers up to 10 by applying on each on the energy just like we did in the very beginning with the recursive version. Of course, this is hugely inefficient both because of the expensive functions that we're using, the binomial, and also because we're recomputing it and over and over for every number, but it's kind of fun and short. This is based on the coefficients.

Finally, we can use Binet's formula. It's rather long and involved, but it's not using any difficult math, and it's all scalar functions, and that has the benefit then that we can just compute the \( n \)th Fibonacci number directly on the whole sequence just by feeding it the all the indices that we want. I'm going to type it up. There's nothing really to explain other than this is a formula you can look it up online; it can be stated in various ways because of some equivalences, but it's not really important. And so, we want that on the entire sequence, and that computes the sequence directly.

Okay, on to the finishing stage here, which is going to be performance comparison. Let's copy `cmpx` from Dyalog's workspace, and then we need to build up all the expressions that we want to run. We can get all the functions that we have defined like this, but there's actually a feature that maybe not so well known, and that `quadname` can take a list of letters that it will then filter its result with to only include functions that begin with any of those letters. Notice here that all our solutions begin with an uppercase letter, `cmpx` begins with a lowercase letter, and `delta` isn't a normal letter at all. So, if you give it uppercase English alphabet, that filters and out and each one of them. Well, we want to apply to some argument or arguments, and in order to get some balance, it should be a large number, a small number. So, let's apply to all the numbers up to some limit. So, we're applying it to each one up to say, iota 20, and we are doing that on each. These are all the expressions we're going to run, and then see `cmpx` on that, and this might take a little while, so I might cut this out of the video.

Here's our result, and we can see that using Binet's formula to compute the values is the clear winner here. And even though there's cute, the binomial coefficients is not going to be able to compete with anything. Thank you for watching.