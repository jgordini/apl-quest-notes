
# [It Is All Right 2014-1](https://apl.quest/psets/2014.html?goto=P1_It_Is_All_Right)

# APL Right Triangle Problem

**Problem:** Write a [dfn](https://aplwiki.com/wiki/Dfn) that takes the length of the legs of a triangle as its left argument, and the length of the hypotenuse as its right argument and returns 1 if the triangle is a right triangle, 0 otherwise.

## Getting Started

We are given the left argument, which consists of the two supposed shorter sides of a triangle, and the right argument, representing the longer side. Our task is to check if these three numbers can indeed form the lengths of a right-angled triangle.

### Approach

It is natural to use the [Pythagorean Theorem](https://en.wikipedia.org/wiki/Pythagorean_theorem) to solve this problem. Let's examine some test cases:

1. Shorter sides: `2` and `4`. Longer side: `4.5` → Result: **False**
2. Shorter sides: `3` and `4`. Longer side: `5` → Result: **True**
    According to the Pythagorean theorem, the sum of the squares of the two shorter sides must equal the square of the longer side. 

## Mathematical Representation

We can express this mathematically using the concept of self-multiplication or squaring:

1. The square of a number is the same as multiplying the number by itself.
2. The sum of the squares can be represented as an inner product of the shorter sides.
Given this, we can rewrite our check as:

```APL
(sum of squares of shorter sides) = (square of longer side)
```

This leads us to our first solution:

### Solution A

```APL
{(+/⍺*2)=⍵*2}
```

This solution implements the Pythagorean theorem directly. It squares the elements of the left argument (the legs), sums them, and compares the result to the square of the right argument (the hypotenuse).
1. `⍺*2` - Square each element of the left argument (the legs)
2. [`+/`](https://aplwiki.com/wiki/Plus_Reduce)`⍺*2` - Sum the squared values
3. `⍵*2` - Square the right argument (the hypotenuse)
4. `(+/⍺*2)=⍵*2` - Compare the sum of squared legs to the squared hypotenuse

We can also express this using an [inner product](https://aplwiki.com/wiki/Inner_Product):

### Solution B

```APL
{(+.×⍨⍺)=×⍨⍵} ⍝ inner product is equivalent for scalar functions on vectors
```

This solution uses the inner product to calculate the sum of squares for the legs, making it equivalent to Solution A for [scalar functions](https://aplwiki.com/wiki/Scalar_function) on vectors.
1. `+.×⍨⍺` - Use inner product to sum the squares of the left argument
2. `×⍨⍵` - Square the right argument
3. `(+.×⍨⍺)=×⍨⍵` - Compare the results

## Simplification

We can preprocess both arguments with self-multiplication (squaring) and then sum the left argument:

```APL
sum(left_arguments) = right_argument
```

This can be effectively represented in APL as:

```APL
=∘(+/)⍨⍥(×⍨)
```

Alternatively, we could break out the multiplication:
1. **Commuting Arguments**: We may preprocess one argument and then check for equality.
2. **Reduction Over a Single Element**: Notably, a [reduction](https://aplwiki.com/wiki/Reduce) of a single element doesn't change its value, allowing us to fold these operations effectively.
For a reduction, we can use:

```APL
(+/⍤⊣=⊢)⍥(×⍨)  ⍝ break out the squaring
```

These simplifications lead us to more concise solutions:

### Solution C

```APL
+.×⍨⍤⊣=×⍨⍤⊢
```

This is the [tacit (point-free)](https://aplwiki.com/wiki/Tacit_programming) equivalent of Solution B.
1. `+.×⍨⍤⊣` - Apply the sum of squares operation to the left argument
2. `×⍨⍤⊢` - Apply squaring to the right argument
3. [`=`](https://aplwiki.com/wiki/Equal) - Compare the results

### Solution D

```APL
(+/⍤⊣=⊢)⍥(×⍨)
```

This solution breaks out the squaring operation, applying it to both arguments before comparing.
1. `⍥(×⍨)` - Apply squaring to both arguments
2. `+/⍤⊣` - Sum the squared left argument
3. `=⊢` - Compare with the squared right argument

### Solution E

```APL
=⍥(+.×⍨)
```

This solution combines the sum of squares operation into a single function applied to both arguments before comparison.
1. `+.×⍨` - Calculate the sum of squares
2. `=⍥(+.×⍨)` - Apply the sum of squares to both arguments and compare

## Complex Number Approach

Another approach is to represent the two shorter sides as components in the complex plane. We can represent the sides as:

```APL
z = a + bi
```

Where `a` and `b` are the two shorter sides. The magnitude of the vector is given by the absolute value, which we can derive as follows:
1. Multiply the last element of the left argument by the imaginary unit.
2. Take the absolute value and compare it with the right argument.
In APL, we can calculate the magnitude of a complex number using:

```APL
{⍵=|(⊃⍺)+0J1×⊢/⍺}
```

This leads to our next set of solutions:

### Solution F

```APL
{⍵=|(⊃⍺)+0J1×⊢/⍺}
```

This solution uses [complex numbers](https://aplwiki.com/wiki/Complex_number) to represent the triangle.
1. `⊃⍺` - Take the first element of the left argument (one leg)
2. `⊢/⍺` - Take the last element of the left argument (other leg)
3. `(⊃⍺)+0J1×⊢/⍺` - Combine the legs into a complex number
4. `|( ... )` - Calculate the magnitude of the complex number
5. `⍵=|( ... )` - Compare the magnitude to the right argument (hypotenuse)

### Solution G

```APL
=∘(|⊃+0J1×⊢/)⍨
```

This is the tacit equivalent of Solution F.

### Solution H

```APL
⊢=∘|0J1⊥⊣
```

This solution uses i-base (0J1⊥) to combine the parts of the complex number.

We can also use the 4-circle function to calculate the hypotenuse:

### Solution I

```APL
{⍵=(⊃⌽⍺)×4○÷/⍺}
```

This solution uses the 4-circle function to calculate the hypotenuse.
1. `÷/⍺` - Calculate the ratio of the legs
2. `4○÷/⍺` - Apply the 4-circle function to the ratio
3. `(⊃⌽⍺)×4○÷/⍺` - Multiply by the second leg
4. `⍵=( ... )` - Compare the result to the right argument (hypotenuse)

**Final Solution Using Domain Concepts**
We can solve this using the **Domino** function, which represents a ratio between the inversions of both arguments:
1. Apply the function to both arguments.
2. Check if it matches the original ratio.
This method of inversion can be represented in APL as:

### Solution J

```APL
÷⍥⌹≡÷
```

This solution uses the [matrix inverse (domino) function](https://aplwiki.com/wiki/Matrix_Inverse) to check if the triangle is right-angled.
1. `⌹` - Apply matrix inverse to both arguments
2. `÷⍥⌹` - Divide the inversed arguments
3. `≡÷` - Check if the result is identical to the regular division of the arguments

This is derived from:

```APL
⍝ Derivation:
{((⌹⍺                ) ×⍵) ≡ ⍺÷⍵}  ⍝ unpacked
{((⍺ ÷ ((+/⍺*2)*÷2)*2) ×⍵) ≡ ⍺÷⍵}  ⍝ ⌹⍺ is equivalent to scaling ⍺ down by the square of its diagonal
{((⍺ ÷   +/⍺*2       ) ×⍵) ≡ ⍺÷⍵}  ⍝ *÷2 and *2 cancel out each other
{((  ÷   +/⍺*2       ) ×⍵) ≡  ÷⍵}  ⍝ divide both sides by ⍺
{( ⍵ ÷   +/⍺*2       )     ≡  ÷⍵}  ⍝ move ⍵
{(      (+/⍺*2)÷⍵    )     ≡   ⍵}  ⍝ reciprocal on both sides
{       (+/⍺*2)            ≡ ⍵*2}  ⍝ multiply by ⍵ on both sides
{(+/⍺*2)=⍵*2}
```

## Glyphs Used

- [Plus Reduce](https://aplwiki.com/wiki/Plus_Reduce) (+/)
- [Power](https://aplwiki.com/wiki/Power) (*)
- [Equal](https://aplwiki.com/wiki/Equal) (=)
- [Inner Product](https://aplwiki.com/wiki/Inner_Product) (+.×)
- [Self-Reference](https://aplwiki.com/wiki/Self-Reference) (⍨)
- [Commute](https://aplwiki.com/wiki/Commute) (⍨)
- [Atop](https://aplwiki.com/wiki/Atop) (⍤)
- [Left](https://aplwiki.com/wiki/Left) (⊣)
- [Right](https://aplwiki.com/wiki/Right) (⊢)
- [Over](https://aplwiki.com/wiki/Over) (⍥)
- [First](https://aplwiki.com/wiki/First) (⊃)
- [Multiply](https://aplwiki.com/wiki/Multiply) (×)
- [Imaginary](https://aplwiki.com/wiki/Imaginary) (J)
- [Magnitude](https://aplwiki.com/wiki/Magnitude) (|)
- [Decode](https://aplwiki.com/wiki/Decode) (⊥)
- [Reverse](https://aplwiki.com/wiki/Reverse) (⌽)
- [Divide](https://aplwiki.com/wiki/Divide) (÷)
- [Circle](https://aplwiki.com/wiki/Circle) (○)
- [Matrix Inverse](https://aplwiki.com/wiki/Matrix_Inverse) (⌹)
- [Match](https://aplwiki.com/wiki/Match) (≡)

## Concepts

- [Pythagorean Theorem](https://en.wikipedia.org/wiki/Pythagorean_theorem)
- [Tacit Programming](https://aplwiki.com/wiki/Tacit_programming)
- [Dfn](https://aplwiki.com/wiki/Dfn)
- [Scalar Function](https://aplwiki.com/wiki/Scalar_function)
- [Reduction](https://aplwiki.com/wiki/Reduce)
- [Inner Product](https://aplwiki.com/wiki/Inner_Product)
- [Complex Numbers](https://aplwiki.com/wiki/Complex_number)
- [Commute](https://aplwiki.com/wiki/Commute)
- [Atop](https://aplwiki.com/wiki/Atop)
- [Over](https://aplwiki.com/wiki/Over)
- [Right-angled Triangle](https://en.wikipedia.org/wiki/Right_triangle)
- [Matrix Inverse](https://aplwiki.com/wiki/Matrix_Inverse)
- [Point-free Style](https://aplwiki.com/wiki/Tacit_programming)
- [Function Composition](https://aplwiki.com/wiki/Function_composition)
- [Self-Reference](https://aplwiki.com/wiki/Self-Reference)
- [Scalar Extension](https://aplwiki.com/wiki/Scalar_extension)
- [Left and Right Arguments](https://aplwiki.com/wiki/Argument)
- [Domino Function](https://aplwiki.com/wiki/Matrix_Inverse)
- [4-circle Function](https://aplwiki.com/wiki/Circle)

## **Transcript**

Welcome to the APL quest! For details, refer to the APL Wiki. This is the first problem from the 2014 set of the APL problem-solving competition. We’re given the left argument, which represents the two supposed shorter sides of a triangle, and the right argument, which represents the longer side. Our task is to check if these three numbers together can work as the lengths of a right-angled triangle. Naturally, it’s appropriate to use the Pythagorean theorem here. Let’s put in some test cases: two shorter sides, 2 and 4; another case with shorter sides, 3 and 4. We’re going to try this with a longer side, 4.5 and 5. The first one is going to be false, and the second one is going to be true. The Pythagorean theorem states that the sum of the squares of the two shortest sides equals the square of the longer side.

We can write this in various ways. If we observe that squaring is the same as multiplication by itself, we can see that we are summing over a scalar function application. A scalar reduction over a replication of a scalar function application is the same as an inner product. Here, we have the same argument being used twice on the inner product, which means we can use the selfie or commute operator. We can do the same with the commute for multiplication. This is just a different way of stating the same thing.

We can also make a tacit form. We want this inner product applied on the left argument, and we want the self-multiplication applied on the right argument. It’s the same thing, just in a tacit form. We can also break out the multiplication because we really start with squaring both arguments and then summing one of them. By using the over operator, we can preprocess both arguments with self-multiplication (or squaring). Now we only need to sum the left argument, so we could write this as the sum of the left argument matching the right argument. Or we could use normal equality but preprocess an argument. We can’t represent the left form, but we can preprocess the right one with summation. The problem is, of course, that it’s the left argument we want to deal with, but we can fix this by commuting—swapping around the two arguments.

We could also start off by commuting. Then, we preprocess with squaring, and then we have the summation on the right. However, observe that a reduction over a single element doesn’t actually change it, so the fact that we’re preprocessing only the right argument with summation could be used to fold this reduction into our preprocessing of both arguments because summation of a single argument doesn’t matter. Here, we have equality where we preprocess both arguments with summation of the square. We don’t need to commute anymore because we’re treating both arguments exactly the same.

Of course, we can combine this plus reduction over the multiplication into an inner product if we prefer that style. A completely different way to approach this is by using complex numbers. In the complex plane, we can look at the two shorter sides as the two components: the real and the imaginary. Then, we have the diagonal being the magnitude, the whole length of that vector in the 2D space that the complex plane forms. Now, we just need to combine these two parts into a single complex number, and it doesn’t matter which one becomes the real part and which becomes the imaginary part because we’re going to take the absolute value of it anyway.

We can start off by saying the last element of the left argument—we multiply that by the imaginary unit—and then we take the first element there and add to that. This combines the two. Now we can take the absolute value of that and compare it to the right argument. We can also make this tacit. All this pre-processing of the left argument—so as before, we can swap our arguments around and preprocess the right argument instead. The last element we multiply here, and then the first element takes the absolute value of that—that’s how we preprocess. Another way we can write this is using negative 11 circles. That’s simply its definition. It just multiplies by the imaginary unit.

Then someone came up with a clever thing using a four-circle. If we apply the four-circle, we get back exactly what we mean on the ratio between the two elements in the left argument. Then, we multiply by the second element. That should match the right argument, and that holds for our test cases. Let’s prove that this is indeed the case. For that, let’s try to make it tacit again. We are preprocessing the right argument. So, we can write it: the ratio of these two—the four-circle on that—and then we just want the last argument, the last element of the original left argument. So, we can write that. We can either combine these two (take the first of the reverse), but we can also just use a right-tack reduction. It’s a right reduction, and we preprocess the right argument to the equality with that, and we just need to commute things around. So, this is the tacit form of that. Alternatively, we could use first, and commute the elements of the—sorry, commute the arguments of the division, and that would also work.

But how does this actually work? Let’s go back to our dense form with, let’s see, the four-circle right here. This one. So, the definition of a four-circle is the square root, which we don’t have in this APL, but we’re using it as a placeholder. We’re going to eliminate it later. So, the square root of one plus the square—this is going to be a little bit complicated using the elements of the left argument, so let’s give them names: A and B. Now, the last one is B, and the fraction denominator is just A divided by B. Here’s the square of a fraction—that’s the same thing as the fraction of the two squares. We have B outside the square root; we can get it into the square root by squaring it.

Now, we have one plus this fraction, where the denominator is B squared. That means that we can add on top of the fraction a B squared instead. Now, we can observe that this whole sum is being divided by B squared, and then it’s multiplied by B squared—those eliminate each other. We have a square root here, and we can just square both sides of the equality. Now, we have the sum of squares here, so we don’t really need these names anymore—it’s just the sums of A and B squared. A and B together are the left argument, so we can get rid of our temporary names, and this is exactly the Pythagorean theorem. So, we’ve proven that the solution using four circles is exactly the same thing.

Now, for the last solution, which is a bit involved and uses the rarely-used domino function, which is a matrix inversion (although we’re using it here only on vectors and scalars, so it’s a bit of a misnomer to call it matrix inversion—maybe extra inversion or just inversion). It’s very clever—it is the ratio between the inversions of both arguments. So, this is using over—we check if it matches the ratio between these arguments. Okay, what’s going on here? How does this work? It does actually work for our test cases, but let’s start to unpack this a bit.

First, we have a division here, and we’re preprocessing both arguments using this domino. Here’s the right argument, and here is the left argument. Then, we are checking if it matches the ratio between the arguments of all. Now, this inversion function, when applied to a scalar, is exactly the same thing as just a normal reciprocal, so we can replace that. We can also see that we’re dividing by a reciprocal—that’s the same thing as multiplication. So far, so good.

What does it actually mean to invert a vector? What it does is it finds a vector for which the dot product with the original vector gives one. So, in a sense, it’s inverse—just like 5 and a fifth multiplying by each other gives one. The vector is going to have the same direction but the reciprocal magnitude. This means that the inverse vector would need to be multiplied twice by the magnitude to get the original vector. Since multiplication once by the magnitude gets us halfway to one, multiplying twice by the magnitude gets us all the way back to the original.

Let’s test this out a bit. So, we invert 3 and 4, and then we can multiply that twice by that supposed magnitude. We can see that we’re right back where we started. If we try to do this for arguments that are not forming a right-angle triangle, we’ll see that it’s not going to work—they’ll get close, but not quite. Here’s our example from before. If multiplying it twice gets us all the way there, multiplying it once gets us halfway there—kind of meeting in the middle. So, if multiplying the inverse by the magnitude twice gets us all the way to the original argument, multiplying it once would be the same thing as starting from above, starting from the original, and dividing it once by the magnitude. Hence, what we have here is multiplication by the diagonal—the magnitude once by the magnitude is the same thing as dividing the original by the magnitude, and that only holds if it’s a right-angled triangle.

So, we need to test if they meet in the middle. If the inverted vector times the supposed magnitude matches the original divided by the supposed magnitude, then they met in the middle, and what we’ve supposed as the magnitude is actually the true magnitude. Okay, so we said that the inversion of this vector is the same thing as

 scaling it down twice by its magnitude. Let’s test that—let’s write that out. So, we’re scaling it down, we’re dividing it by its magnitude twice, and its magnitude is, of course, the square root of the squares of its components.

Next up, we see that we have a square root here, but it’s squared, so they cancel each other out. We had the square root of the sum of the squares, of course, to get the diagonal, and that was being squared—so these two cancel each other out, and we have the sum of the squares that we are dividing the original by. Now, we see that we have something over alpha divided by something here, and then multiplied by something. Here, we also have something over alpha. If we divide both sides of the equation by alpha, we can eliminate that. Now, we have the reciprocal of this times the right argument. So, a reciprocal multiplied by something is the same thing as that something divided by the value. Then, we can take the reciprocal of both sides of the equality—that eliminates this, and we just need to swap over the arguments here.

We divide by the right argument here, and here we just have the right argument, so let’s multiply on both sides of the equality by the right argument. That eliminates this division, and this self-multiplication is, of course, the right argument squared. Therefore, we have the Pythagorean theorem again: the square of the long side equals the sum of the squares of the two shorter sides. So, that’s how this very impressive five-character solution works, and it’s the exact same thing, just in a very disguised way. One caveat: since we’re doing all these divisions, if we have any zeros, it will fail, so it doesn’t actually work if any sides are zero, but still, it’s very clever.

Thank you for watching!
