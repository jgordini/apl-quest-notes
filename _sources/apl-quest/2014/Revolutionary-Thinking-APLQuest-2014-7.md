# [Revolutionary Thinking 2014-7](https://problems.tryapl.org/psets/2014.html?goto=P7_Revolutionary_Thinking)

**Problem:** Two circles touch. One remains stationary while the other rolls along its surface until it returns to its starting point. Write a dfn which takes the diameters of the stationary and mobile circles and returns the number of revolutions the mobile must traverse until the tangent points meet again.

**Video:** [https://www.youtube.com/watch?v=aiEOXOy56iw](https://www.youtube.com/watch?v=aiEOXOy56iw)

**Code:** [https://github.com/abrudz/apl_quest/blob/main/2014/7.apl](https://github.com/abrudz/apl_quest/blob/main/2014/7.apl)

## **Example Solutions:**

### **A - Recursive**

```APL
R←1{0=⍺|⍺⍺×⍵:⍺⍺ ⋄ ⍺((⍺⍺+1)∇∇)⍵}
```

Step-by-step explanation:
1. `⍺|⍺⍺×⍵`: Calculate the remainder of (counter × rolling circle diameter) divided by the stationary circle's diameter.
   - `|`: [Residue](https://aplwiki.com/wiki/Residue) function, gives the remainder after division.
2. `0=`: Check if the remainder is zero.
3. `0=⍺|⍺⍺×⍵:⍺⍺`: If the remainder is zero, return the counter (⍺⍺).
4. `⍺((⍺⍺+1)∇∇)⍵`: If the remainder is not zero:
   - `⍺⍺+1`: Increment the counter.
   - `∇∇`: Recursive call to the function.
   - `⍺(...)⍵`: Pass the original arguments along with the new counter.

This is a recursive solution that keeps incrementing and calling itself. It starts with a counter of 1 and checks if the product of the counter and the mobile circle's size is divisible by the stationary circle's size. If not, it increments the counter and calls itself again with the same arguments.

### **B - Iterative**

```APL
I←{1+⍣(0=⍺|⍵×⊣)0}
```

Step-by-step explanation:
1. `⍵×⊣`: Multiply the rolling circle diameter (⍵) by the current count (initially 0).
2. `⍺|`: Calculate the remainder when divided by the stationary circle's diameter (⍺).
3. `0=`: Check if the remainder is zero.
4. `1+⍣(...)0`: 
   - `1+`: Increment operation.
   - `⍣`: [Power](https://aplwiki.com/wiki/Power_(operator)) operator, repeats the increment until the condition is true.
   - `0`: Initial value to start incrementing from.

This is an iterative solution that starts with a count of zero and increments it until the condition is fulfilled. It's much shorter but a bit more involved. It uses the power operator to repeatedly increment the count until the product of the count and the mobile circle's size is divisible by the stationary circle's size.

### **C - Handling Zero Diameter**

```APL
R←1{0=⍺:0 ⋄ 0=⍺|⍺⍺×⍵:⍺⍺ ⋄ ⍺((⍺⍺+1)∇∇)⍵}
I←{0=⍺:0 ⋄ 1+⍣(0=⍺|⍵×⊣)0}
```

Step-by-step explanation (additions to A and B):
1. `0=⍺`: Check if the stationary circle's diameter is zero.
2. `0=⍺:0`: If the diameter is zero, return 0.
3. `⋄`: Statement separator, equivalent to "else".
4. The rest of the function remains the same as in A and B.

These versions handle the case where the stationary circle has a diameter of zero. In this case, the result is always zero because no revolutions are needed. This guards against infinite loops or undefined behavior when the stationary circle has no size.

### **D - Greatest Common Divisor (GCD)**

```APL
G←{⍺÷⍺∨⍵}   ⍝ GCD
G←⊣÷∨        ⍝ Tacit form
```

Step-by-step explanation:
1. `⍺∨⍵`: Calculate the GCD of the two diameters.
   - `∨`: [GCD](https://aplwiki.com/wiki/Greatest_common_divisor) primitive, finds the greatest common divisor.
2. `⍺÷`: Divide the stationary circle's diameter by the GCD.

Tacit form explanation:
1. `⊣`: [Left](https://aplwiki.com/wiki/Left) function, returns the left argument.
2. `∨`: GCD primitive.
3. `⊣÷∨`: Divide the left argument by the GCD of both arguments.

This solution uses number theory, specifically the concept of greatest common divisor (GCD). It calculates the GCD of the two circle sizes and then divides the stationary circle's size by this GCD. This gives the number of revolutions needed for the mobile circle to return to its starting position and orientation.

### **E - Least Common Multiple (LCM)**

```APL
L←{(⍺×⍵)÷⍵} ⍝ LCM
L←∧÷⊢        ⍝ Tacit form
```

Step-by-step explanation:
1. `⍺×⍵`: Multiply the two diameters.
2. `⍵`: The GCD of the two diameters.
3. `(⍺×⍵)÷⍵`: Divide the product of diameters by their GCD.

Tacit form explanation:
1. `∧`: [LCM](https://aplwiki.com/wiki/Least_common_multiple) primitive, finds the least common multiple.
2. `⊢`: [Right](https://aplwiki.com/wiki/Right) function, returns the right argument.
3. `∧÷⊢`: Calculate LCM of arguments, then divide by the right argument.

This solution uses the concept of least common multiple (LCM). It calculates the LCM of the two circle sizes and then divides it by the mobile circle's size. This gives the number of revolutions needed for the mobile circle to return to its starting position and orientation.

## **Usage Example:**

```APL
∘.R⍨⍳10
```

Step-by-step explanation:
1. `⍳10`: Generate a vector of integers from 1 to 10.
2. `∘.`: [Outer product](https://aplwiki.com/wiki/Outer_product) operator, applies the function to all combinations of elements.
3. `R⍨`: Apply the R function with swapped arguments (mobile circle diameter as left arg, stationary as right).

## **Performance Comparison:**

```APL
'cmpx'⎕CY'dfns'
s←0,⍳100
m←⍳100
cmpx's∘.R m' 's∘.I m' 's∘.G m' 's∘.L m'
```

This code compares the performance of the different solutions using the `cmpx` function from the `dfns` workspace.

## **Glyphs Used:**

- [Residue](https://aplwiki.com/wiki/Residue) `|` - Remainder when divided
- [Power](https://aplwiki.com/wiki/Power_(operator)) `⍣` - Repeat until condition is met
- [GCD](https://aplwiki.com/wiki/Greatest_common_divisor) `∨` - Greatest Common Divisor
- [LCM](https://aplwiki.com/wiki/Least_common_multiple) `∧` - Least Common Multiple
- [Right](https://aplwiki.com/wiki/Right) `⊢` - Returns right argument
- [Left](https://aplwiki.com/wiki/Left) `⊣` - Returns left argument
- [Outer Product](https://aplwiki.com/wiki/Outer_product) `∘.` - Apply function to all combinations of elements

## **Concepts Used:**

- [Dfn](https://aplwiki.com/wiki/Dfn) - Direct function
- [Recursion](https://aplwiki.com/wiki/Recursion) - Function calling itself
- [Iteration](https://aplwiki.com/wiki/Iteration) - Repeating a process
- [Tacit programming](https://aplwiki.com/wiki/Tacit_programming) - Programming without explicit arguments
- [Number theory](https://en.wikipedia.org/wiki/Number_theory) - Mathematical study of integers

## **Transcript:**

**Welcome to the APL Quest**

Today's quest has us imagine two circles that are touching each other. One of them stays where it is, while the other one rolls on the first one's surface or circumference all the way around until it reaches the place where it started.

Now, obviously, depending on the exact sizes of these two circles, it may not end up in the same position relative to the stationary circle. It may not have the same orientation or may not be pointing in the same direction as it started. So, today's problem, which is the seventh from the 2014 round of the Pill Problems on the Conversation, is to see how many times the rolling circle needs to go around until it has rolled all the way around the stationary circle but also is pointing in the same direction and has the same orientation as the way it started.

There are different ways that we can attack this problem. Let's just start by actually simulating the problem. We have two arguments here: the size as the left argument of the stationary circle and the size of the mobile circle, the one that's rolling around. Officially, they're given as diameters, but it doesn't really matter because the circumference, of course, is just a constant times the diameter, and that's the same for both, so that kind of goes out of the equation. But what we want to see is whether the amount of revolutions that we have done on the mobile circle times its size ends up with something that can be divided by the stationary circle.

So, the way we can write this up is we are done if there's no division remainder when we are dividing by the stationary circle and how far we've gone so far. We're going to use an operand for that, so that's how many revolutions we've done of the diameter—well, actually, the circumference of the mobile circle. And if that divides, then we're done, and so that's the number of revolutions. Otherwise, we are going to try again, but this time we're going to increment the counter of revolutions. So, we take one more revolution of the mobile circle and then we feed that into the same operator. So, it doesn't operate another function; the arguments stay constant, and the upper end stays incremented every time, and then we just need to start with a 1. So, this is a recursive solution. It keeps incrementing and calling itself.

Let's consider an example: a stationary circle of diameter (or circumference) 10 and a mobile one that's 5. After it has rolled one time around itself, it's on the opposite side. Then it rolls one time again around itself and comes back to where it was. If we try to flip the two, then we only need one revolution of the mobile one. What's happening is that it only needs to go half a turn to come back to where it was, but it will keep going for another half a turn in order to come back and face the same direction that it started with as well.

We can try all the possibilities by making a table of this. This is an outer product, and then all the numbers up to 10. This gives us a full table of the revolutions. There's one interesting issue, and that is zero. Now, it doesn't really make sense that the mobile circle should have a diameter, and therefore circumference, of zero because it's point-shaped. It doesn't matter then how many times it will turn around itself; it's never going to get anywhere. So every time around, it will move zero; it will not move at all unless also the stationary circle is point-shaped, in which case nothing can really move, and it doesn't really make sense to ask how many times. I mean, any number of times would be good: zero, one, two, infinite. So, you could say the number, the result is zero, or you could say that one, or after zero times, it's also turned one full revolution around the zero-zero case doesn't really matter.

However, if the stationary circle is zero, then the result is most certainly zero because we don't need to get anywhere. Even though the mobile circle has the ability to revolve, it doesn't actually need to revolve. So, we can handle this additional case by adding in an extra guard. So, if the left argument, the circle standing still, is zero, then the result is zero. Otherwise, we just continue as before.

Now we can go and make a test case where there's even a zero on the left but not on the right, as that doesn't really make sense, and we can see you get the row of all zeroes there, of course. Right, so this is one way to do it. This was recursive; let's try to do an iterative way. Here we just start off with a count of zero, and then we increment as we go along until it works out. It's a little bit shorter but a little bit more involved.

So, the way we can do it is we start off with zero, and then we need to increment it, and we want to increment it until our condition has been fulfilled. Now, what is that condition? That is that the left argument, because we are comparing the previous and the next iteration, and so that would be the left and right argument of our comparison function, which is one that determines when it's true, then we have fulfilled our condition. And when that multiplied by the circumference of the mobile circle evenly divides the circumference of the circle that's standing still, then we're done.

And so, we should get exactly the same here as well. But again, we have a problem with zero because if we start off with zero on the left, then we're going to try to apply this function. So, we add and add one, so we get one and zero, and then we want to check if it divides. Let's try that. So, if we start with zero here and say two on the right, then the first time around, we'll try to apply this function. So, we add and add one, so we get one and zero, and then we want to check if it divides.

So, we can just do it like this right here. So, if we start with zero here and say we have two, and then we get zero, and then we want to stop. However, once we increment it, then we get the full remainder because zero doesn't add up to anything in effect. What happens is that if we try to run this with a zero, then we'll go into an infinite iteration; we'll never get there. So, let's interrupt that, and then we can redefine to have the same kind of stop guard as we did with the recursive version. So, if there's a zero on the left, then we stop with a zero right away. Otherwise, we can start iterating.

Okay, how do they compare in performance to each other, the iterative version and the recursive version? Let's copy in `cmpx` from dfns, and then we can compare them. We can make the table a little bit bigger and try them. So, let's say the stationary one is zero and all the numbers up to 100, and then the mobile one are all the numbers up to 100, and then we can compare all the possibilities, the requested version, and all the possibilities with the iterative version. And the iterative version is much faster, and that's probably because we're not entering into any new functions, trying calling again and again, not binding together an operand with the operator over and over again, which is staying in the same place just running the power operator.

But we can do much better than this by using some number theory because think about the way that we're describing this. If this multiple divides, so really, and what we want to find out is what is the smallest number that we can multiply with to end to be divisible. And so, we can express this in terms of the greatest common denominator or least common multiple. It actually comes out very much the same.

So, let's say again we have 10 on the left and then on the right we have 5, and so the least common, sorry, the greatest common denominator between the two is 5. So that means we can divide both of them by 5, and then we can see well if that's the case, then how many times 5 do we need to get in order to get all the way around the stationary one. So, we just divide the left argument by that. So, that's one way to state it using the greatest common denominator.

What's greatest common divisor opposite? We can also look at the least common multiple. So here we are asking what is the smallest number that we can multiply up with these two numbers in order to match each other. So that's 10, that would be 1 times 10 gives 10, and 2 times 5 gives 10 as well. And then we can divide that by the right organ. So, this is saying that in order for these to match up, then we need to have traversed 10 or to go all the way around. And since the right argument is this actual size that of the moving circle, then the total distance divided by its circumference will give us how many times we need to go around.

And so, we can define this using the least common multiple as well. Now, there's an interesting thing about these two functions and here and that is they are really really amenable to write in a tacit version. Why is that? Because let's look at, let's look at, we if we think of things in terms of functions, then here we have a function application between the arguments and then we have a function that takes that result as its argument. Now, the only problem is here on the left, we don't, there's no function being applied between the left and right arguments giving us a full fork. However, we could say there is one, namely the density function of the left argument.

So, if we wrote it like this instead, then effectively this function would select the left argument, which means all this we can remove all mention of our arguments making everything point-free or tacit like this. Oops, and then a parenthesis function it is just the function itself, and then we have parenthesis around the fork that gives us this fork as well. And we can do exactly the same thing for the function here again. It's there's an implicit and identity function that selects the right argument. So, we can remove all the mentions of arguments, and then we're done.

And now if we compare these, so we know that was the fastest one of two before the iterative version. So let's compare the fastest of of those of and with these two number theoretical functions and. And we should see that these sort of say built-in functions where pretty much everything we need to do is always built into the language are going to be much faster. If we try to just raise them against each other, then we'll find that it doesn't really make a difference which ones that we use. They are all built on the same exact principle. Thank you for watching.
