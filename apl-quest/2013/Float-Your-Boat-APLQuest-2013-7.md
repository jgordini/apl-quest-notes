
# [Float your Boat 2013-7](https://problems.tryapl.org/psets/2013.html?goto=P7_Float_Your_Boat)

**Problem:** Write a [Dfn](https://aplwiki.com/wiki/Dfn) which selects the floating point (non-integer) numbers from a numeric vector.

**Video:** [https://youtu.be/w5LvImFVi2M](https://youtu.be/w5LvImFVi2M)

**Code:** [https://github.com/abrudz/apl_quest/blob/main/2013/7.apl](https://github.com/abrudz/apl_quest/blob/main/2013/7.apl)

In today's quest, we are tasked with selecting the numbers from a vector that are floating point or non-integers. This is Problem Seven from the [2013 APL Problem Solving Competition](https://problems.tryapl.org/psets/2013.html?goto=P7_Float_Your_Boat).

### Getting Started

First, let’s create some data for ourselves. What defines a number that isn’t an integer? There are various ways to approach this, but a very simple and effective method is to compare the number to what happens if we round it. Any integer remains unchanged when rounded, while a non-integer will change.

We can find the integer values in our vector by using the floor function. This allows us to filter the non-integers. Here’s how we can implement this as a function called `A`

#### Rounding

```apl
v ← ¯3.1 4 1.5 92.6 ¯5 ⍝ Test Data
A ← {⍵/⍨⍵≠⌊⍵} ⍝ Compare the number against it's rounded version. Same is int. Different is Float.  
```

1. `⍵≠⌊⍵` [Floor](https://aplwiki.com/wiki/Floor) `⌊` Rounds down to the nearest real number.
2. [Not Equal to](https://aplwiki.com/wiki/Not_Equal_to) `≠` a [comparison function](https://aplwiki.com/wiki/Comparison_function "Comparison function")  tests whether arguments are unequal. This returns a boolean array where 1 indicates the non-integers. 
3. `⍵/`  [Compress](https://mastering.dyalog.com/Some-Primitive-Functions.html?highlight=compress#replicate) filters the right argument using the boolean array on the left. 
4. [Commute](https://aplwiki.com/wiki/Commute) `⍨` aka Swap used to put the boolean array generated in Step 2 on the left of the Compress. 

#### Tacit

Here’s the [tacit](https://aplwiki.com/wiki/Tacit_programming) version:

```apl
B ← (/⍨)∘(≠∘⌊⍨)⍨ ⍝ Tacit version of {(⍵≠(⌊⍵))/⍵}
```

1. `(≠∘⌊⍨)`: 
   - The rightmost `⍨` (Selfie) is used monadically.
   - It makes the function use the same argument on both sides.
   - For an input `⍵`, this is equivalent to `⍵ (≠∘⌊) ⍵`.

2. `≠∘⌊`:
   - This is a composition of not-equal (`≠`) and floor (`⌊`).
   - It first applies floor (`⌊`) to the argument.
   - Then it compares the result with the original argument using not-equal (`≠`).
   - So for an input `⍵`, this does `⍵ ≠ ⌊⍵`.

3. `(/⍨)∘`:
   - This creates a derived monadic function using composition (`∘`).
   - It takes a single right argument (the result of `≠∘⌊⍨`).
   - The `⍨` in `/⍨` then commutes the arguments:
     - It puts the result of `≠∘⌊⍨` as the left argument of `/`.
     - It uses the original input as the right argument of `/`.

In combination:
- `(≠∘⌊⍨)` creates a boolean mask identifying non-integers.
- `(/⍨)∘` uses this mask to filter the original input.
- The outermost `⍨`  ensures the same input is used for both mask creation and filtering.

This structure allows the function to create and apply a filtering condition in one concise operation.

1. See [Bind](https://mastering.dyalog.com/Tacit-Programming.html?highlight=selfie#binding) for more information. [Note](#note)

### Data Representation

Another approach is to use APL's internal representation of numbers.  By checking the representation of these values, we can see their actual types (e.g., 64-bit binary float or other types). This works well for most cases but can fail with very large numbers that use different internal representations.

```APL
x ← v,1e400 ⍝ Test Data
D ← {⍵/⍨645=⎕DR¨⍵} ⍝ 645 is 64 bit per element and 5 means it's floating point 
```

1. [Data Representation](https://help.dyalog.com/latest/Content/Language/System%20Functions/Data%20Representation%20Dyadic.htm) `⎕DR` - converts the data type of its argument Y according to the type specification X. Here we check if `⎕DR` at 645 (64 means the 64 bit per element and 5 means it's floating point) is equal to [Each](https://aplwiki.com/wiki/Each) `¨` element of omega. 
2. `⍵/⍨` First [Swapping](https://mastering.dyalog.com/Tacit-Programming.html?highlight=selfie#commute-selfie-and-constant) `⍨`  the arguments. [Compress](https://mastering.dyalog.com/Some-Primitive-Functions.html?highlight=compress#replicate) `⍵/` filters the right argument using the boolean array (Result of Step 1) on the left. 

```APL
x ← v,1e400 ⍝ Test Data
E ← {⍵/⍨645 1287∊⍨⎕DR¨⍵} ⍝ 1287 is a 128-bit decimal float. 7 indicates Decimal.  
```

1. `645 1287∊⍨⎕DR¨⍵` Swapping the arguments and checking if 645 or 1287 are [Members](https://aplwiki.com/wiki/Membership) `∊` of the Data Representiaton of Each element in omega. 
2. `⍵/⍨` We then filter the result against the original.  First [Swapping](https://mastering.dyalog.com/Tacit-Programming.html?highlight=selfie#commute-selfie-and-constant) `⍨`  the arguments. [Compress](https://mastering.dyalog.com/Some-Primitive-Functions.html?highlight=compress#replicate) `⍵/` filters the right argument using the boolean array (Result of Step 1) on the left. 

### Decimal Point Detection

A simple, human-readable approach is to check for a decimal point in the formatted number:

```apl
F ← {⍵/⍨'.'∊∘⍕¨⍵}
```

1. `⍕¨⍵` [Format](https://aplwiki.com/wiki/Format) `⍕` Each `¨` formats the right [argument](https://aplwiki.com/wiki/Argument "Argument") into a [simple](https://aplwiki.com/wiki/Simple "Simple") [character](https://aplwiki.com/index.php?title=Character&action=edit&redlink=1 "Character (page does not exist)") array.
2. `'.'∊` Checks if `'.'` is a member of the each formated element of Omega `⍵`.
3. `∘` Compose applies the Each  `¨`  to the Membership `∊` function. Without Compose the membership function uses the entire array as input.
4. `⍵/⍨` Filters the original argument against the result of Step 2.  



This method can be improved by increasing the print precision:

```apl
G ← {⎕PP←34 ⋄ ⍵/⍨'.'∊∘⍕¨⍵} ⍝ Solution for near integers
```

1. `⎕PP←34` [Print Precision](https://help.dyalog.com/latest/Content/Language/System%20Functions/pp.htm) `⎕PP` - number of significant digits in the display of numeric output. Default is 10. Max is 34. 
2. Apply the Function in F.
3. 

### Mathematical Approaches

We can use mathematical properties to identify non-integers:

```APL
H ← {⍵/⍨×1|⍵} ⍝ Using Modulus
I ← {⎕CT←0 ⋄ ⍵/⍨×1|⍵} ⍝ Comparison Tolerance 
J ← {⍵/⍨×1⊤⍵} ⍝ Using Encode
K ← {⍵/⍨0≠⍵-⌊⍵} ⍝ Subtract
```



#### Modulus

```APL
H ← {⍵/⍨×1|⍵} ⍝ Using Modulus
```

1. `1|⍵` [Residue](https://aplwiki.com/wiki/Residue) `|` - aka Modulo - gives the [remainder](https://en.wikipedia.org/wiki/Remainder "wikipedia:Remainder") of [division](https://aplwiki.com/wiki/Divide "Divide") between two real numbers.
2. `×`  [Signum](https://aplwiki.com/wiki/Signum) `×` -  three possible results of Signum on a real argument are `0`, `1`, and `¯1` : Positive, Negative and Zero. Signum will always be positive or zero in this case. 
3. If we check the remainder when divding by 1 we can filter the result based on if the Signum is 1 or 0.
4. Floating point numbers will have a positive signum of the remainder or 1. 
5. `⍵/⍨` We can then apply this [Boolean Mask](https://aplwiki.com/wiki/Boolean) against our orginal argument. 



#### Comparison Tolerance

[Comparison Tolerance](https://help.dyalog.com/latest/Content/Language/System%20Functions/ct.htm) `⎕CT` - determines the precision with which two numbers are judged to be equal. A value of 0 ensures exact comparison. 

```APL
T ← 1e¯13+⍳15 ⍝ Test Data using 13 decimals
14⍕w ⍝ Format using 14 decimals not all numbers represented
```

To address this issue, we can create a version of `A` that includes the comparison tolerance. By temporarily setting the comparison tolerance to zero, we ensure that all 15 numbers are classified as floating point values.

```APL
I ← {⎕CT←0 ⋄ ⍵/⍨⍵≠⌊⍵} ⍝ Set the comparison tolerance to zero and apply solution A. 
```



#### Encode

```APL
J ← {⍵/⍨×1⊤⍵} ⍝ Using Encode
```

1. `1⊤⍵` [Encode](https://mastering.dyalog.com/Mathematical-Functions.html?highlight=encode#encode) `⊤` - Checking if the smallest unit in the base is a one and how many ones there are. This is exactly the same as division remainder. Encode doesn't care about [Comparison Tolerance](https://help.dyalog.com/latest/Content/Language/System%20Functions/ct.htm) `⎕CT` it is always 0. 
2. `×`  [Signum](https://aplwiki.com/wiki/Signum) `×` -  three possible results of Signum on a real argument are `0`, `1`, and `¯1` : Positive, Negative and Zero. Signum will always be positive or zero in this case. 
3. `⍵/⍨` We can then apply this [Boolean Mask](https://aplwiki.com/wiki/Boolean) against our orginal argument. 



#### Subtract

```APL
K ← {⍵/⍨0≠⍵-⌊⍵} ⍝ Subtract
```

1. `0≠⍵-⌊⍵` Subtracting the argument from it's [Floor](https://aplwiki.com/wiki/Floor) `⌊`  and comparing the result against [Not Equal to](https://aplwiki.com/wiki/Not_Equal_to) `≠` Zero. 
2. `⍵/⍨` Use the result to filter the argument. 



### A Quirky Solution

For fun, here's an unconventional approach using replicate and error handling:

```apl
L ← ∊{0::⍵⋄⍵/⍬}¨ ⍝ If any error happens, that means that the test that the argument is non-integer, and we want it. Otherwise, we replicate the empty vector, which gives us the empty vector.
```

This function attempts to use each number as a replication factor on an empty vector. It will error on non-integers, which we catch and interpret as our desired result.

1. `⍵/⍬` [Replicate](https://aplwiki.com/wiki/Replicate) `/` - copies each [element](https://aplwiki.com/wiki/Element "Element") of the right [argument](https://aplwiki.com/wiki/Argument "Argument") a given number of times - left argument will error on any non integer. Apply Omega `⍵` against Zilde `⍬` - the empty vector.
2. `0::⍵` [Error Guard](http://help.dyalog.com/18.0/index.htm#Language/Defined%20Functions%20and%20Operators/DynamicFunctions/Error%20Guards.htm) `::` is a vector of error numbers :: expression to be evaluated
3. `∊{}¨` [Membership](https://aplwiki.com/wiki/Membership) `∊` - tests if [Each](https://aplwiki.com/wiki/Each) `¨` of the elements of the left [argument](https://aplwiki.com/wiki/Argument "Argument") appears as an element of the right argument. 



### Glyphs Used

[Floor](https://aplwiki.com/wiki/Floor) `⌊` - a [monadic](https://aplwiki.com/wiki/Monadic "Monadic") [scalar function](https://aplwiki.com/wiki/Scalar_function "Scalar function") that gives the [floor](https://en.wikipedia.org/wiki/floor_and_ceiling_functions "wikipedia:floor and ceiling functions") of a real number

[Equal to](https://aplwiki.com/wiki/Equal_to)  `=` - a [comparison function](https://aplwiki.com/wiki/Comparison_function "Comparison function") which tests whether argument elements are equal to each other.

[Not Equal to](https://aplwiki.com/wiki/Not_Equal_to) `≠` - a [comparison function](https://aplwiki.com/wiki/Comparison_function "Comparison function") which tests whether argument elements are unequal.

[Compress](https://aplwiki.com/wiki/Replicate) `/` - aka FIlter - requires the number of copies to be [Boolean](https://aplwiki.com/wiki/Boolean "Boolean"): each element is either retained (1 copy) or discarded (0 copies)

[Commute](https://aplwiki.com/wiki/Commute) `⍨` - aka Swap - used dyadically, the arguments are swapped. 

[Selfie](https://mastering.dyalog.com/Tacit-Programming.html?highlight=selfie#commute-selfie-and-constant) `⍨` - used monadically, the same argument gets used on both sides of the function. Thus, `F⍨y` is equivalent to - `y F y`.

[Format](https://aplwiki.com/wiki/Format) `⍕` - Dydactic column width and the number of decimal places for formatting [numeric](https://aplwiki.com/index.php?title=Numeric&action=edit&redlink=1 "Numeric (page does not exist)") arrays

[Comparison Tolerance](https://help.dyalog.com/latest/Content/Language/System%20Functions/ct.htm) `⎕CT` - determines the precision with which two numbers are judged to be equal

[Data Representation](https://help.dyalog.com/latest/Content/Language/System%20Functions/Data%20Representation%20Dyadic.htm) `⎕DR` - converts the data type of its argument Y according to the type specification X

[Each](https://aplwiki.com/wiki/Each) `¨` - applies its [operand](https://aplwiki.com/wiki/Operand "Operand") to each [element](https://aplwiki.com/wiki/Element "Element") of the [arguments](https://aplwiki.com/wiki/Argument "Argument")

[Membership](https://aplwiki.com/wiki/Membership) `∊` - tests if each of the elements of the left [argument](https://aplwiki.com/wiki/Argument "Argument") appears as an element of the right argument

[Print Precision](https://help.dyalog.com/latest/Content/Language/System%20Functions/pp.htm) `⎕PP` - number of significant digits in the display of numeric output

[Residue](https://aplwiki.com/wiki/Residue) `|` - aka Modulo - gives the [remainder](https://en.wikipedia.org/wiki/Remainder "wikipedia:Remainder") of [division](https://aplwiki.com/wiki/Divide "Divide") between two real numbers.

[Signum](https://aplwiki.com/wiki/Signum) `×` -  three possible results of Signum on a real argument are `0`, `1`, and `¯1` : Positive, Negative and Zero

[Encode](https://mastering.dyalog.com/Mathematical-Functions.html?highlight=encode#encode) `⊤` - `A⊤B`, turns `B` into a list(s) of digits in (mixed) base

[Replicate](https://aplwiki.com/wiki/Replicate) `/` - copies each [element](https://aplwiki.com/wiki/Element "Element") of the right [argument](https://aplwiki.com/wiki/Argument "Argument") a given number of times

[Error Guard](http://help.dyalog.com/18.0/index.htm#Language/Defined%20Functions%20and%20Operators/DynamicFunctions/Error%20Guards.htm) `::` - vector of error numbers :: expression to be evaluated



### Concepts Used

[Dfn](https://aplwiki.com/wiki/Dfn)

[Tacit Programming](https://aplwiki.com/wiki/Tacit_programming)

[Comparison Tolerance](https://www.jsoftware.com/papers/satn23.htm) 

[Function Composition](http://help.dyalog.com/latest/index.htm#Language/Primitive%20Operators/Operator%20Syntax.htm#Function_Composition)

[Hook](https://aplwiki.com/wiki/Hook)

[Derived Function](https://aplwiki.com/wiki/Derived_function)

[Modulo Operation](https://en.wikipedia.org/wiki/Modulo_operation)

<a name="note">**Note:**</a>

<mark style="background: #FAC898;">A</mark>  ← `{⍵/⍨⍵≠⌊⍵}`

<mark style="background: #FFF3A3A;">B </mark> ← Tacit Derived Function - Composed of Operators
Beginning with the first Parenthesis `(/⍨)∘(≠∘⌊⍨)⍨`

1.  ⌊<mark style="background: #ADCCFFA6;">⍨</mark> ⍵ - Compare Argument with it's own Floor:  <mark style="background: #ADCCFFA6;">Selfie</mark> - ⍨
2.  ≠<mark style="background: #BBFABBA6;">∘</mark>⌊⍨ ⍵ - Preprocess the right argument with `≠` using the floor:  <mark style="background: #BBFABBA6;">Jot</mark> - ∘
3.   /<mark style="background: #FFB8EBA6;">⍨</mark><mark style="background: #BBFABBA6;">∘</mark>⍺⍺- Preprocess the right parenthesis expression using <mark style="background: #BBFABBA6;">Jot</mark> and then <mark style="background: #FFB8EBA6;">Swap</mark> - ⍨
4.   ⍺⍺/ ⍵<mark style="background: #ADCCFFA6;">⍨</mark>⍵ - Filter initial array using result: <mark style="background: #ADCCFFA6;">Selfie</mark> - ⍨

⍵ is argument
⍺⍺ is result

Swap - <mark style="background: #FFB8EBA6;">⍺ f ⍨ ⍵</mark>  is  <mark style="background: #FFB8EBA6;">⍵ f ⍺</mark>  

Selfie- <mark style="background: #ADCCFFA6;"> f ⍨ ⍵</mark>  is  <mark style="background: #ADCCFFA6;">⍵ f ⍵</mark>

<mark style="background: #BBFABBA6;">Jot </mark> - {R}←{X} f∘g Y - Preprocess the right argument. Then apply the left.



### **Transcript**

Hello and welcome to the APL quest. See APL wiki for details. Today's quest is called Float your Boat. We are to select the numbers from a vector of numbers that are floating point or non-integers, and this is problem seven from the 2013 APL problem-solving competition. It's a bit of an interesting thing that it's not well defined what exactly constitutes a floating point number or a non-integer number because in APL, a number is a number. There's not really any good distinction, but we'll do our best, and any of these solutions would be considered correct.

Let's start off by creating some data for ourselves. What constitutes a number that isn't an integer? Well, there are various ways to approach this. A very simple one and probably the best method really is to compare the number to what would happen to it if we were to round it. So any number that's integer stays the same when rounded, and any number that isn't integer would change. The floor of this vector gives us these integers, and then we can compare, and these give us the integers, but we're actually interested in the non-integers, so let's go change that, and then we can use this to filter, and this gives us the non-integers.

We can put this into a function. Let's call that f and use the name of the argument, and there you go. Somebody who participated in the live chat event noticed that this can actually be written as an entirely derived function, not even a train but a tested derived function, that is a function that entirely composed of operators and functions together, and we can see how we can transform f into such a thing.

So let's have this tacit form. First, we want to compare the argument with its own floor, so the way we can do it is we want to use the function unequal dyadically using the same argument on both sides, so that means we need a selfie or commute operator here.

Let's get rid of some of this noise, and then we want to preprocess the right argument to unequal using the floor, keeping the left argument just the outer argument itself. 

This places the same argument on both sides, and we flow the right side, and then we feed it into unequal. I like to think of the jot or compose or beside and as preprocessing the right argument. So this is unequal while preprocessing the right argument with a floor using the same argument on both sides, and we can use that to filter.

And so this is the same pattern again. We have this filtering function, and we want to use the same argument, but the right side is preprocessed by this function, and the left argument is just the way it is. So we can do the same thing again. We use the preprocessing the right argument operator with parentheses like that and then use commute to put the same argument over on both sides.

So this is a fully tested version of f. However, I don't consider this very readable. It's perfectly correct. It's more for exercise sake that we do this conversion.

Now, as I mentioned, there are some interesting questions regarding what exactly is considered a non-integer and what exactly do we mean by floating point. Let's create some interesting data. Let's say we take a very small value, 1 times 10 to the power of negative 13, and we add it to the numbers 1 through 15. 

If we print these numbers, then they look like integers, and that is because by default, APL will round to about 10 digits of precision, and then because we've only added 10 to the power of negative 13 to each one of these, we don't notice this.

However, if we format using 14 decimals, then we can see that there is actually more to it. We could also, of course, say "w minus the floor of w," and then we can see that there's a bit of a difference there. It isn't exactly 1 times 10 to the power of "and," and that is because there are some floating-point inaccuracies at that level.

This is where things get interesting. Should these numbers in w be considered floating point or not? Well, if you try to apply a function f on w, then you can see it says, "Oh, the numbers 1 through 9 are considered non-integers, but the numbers 10 through 15 are considered integers," which is, of course, interesting and odd.

The reason is that APL, by default, has something called the comparison tolerance, which is a multiplicative fuzz factor allowing comparison as long as the ratio to each other does not differ by more than 1 to the power of negative 14 or 1 plus 1 to the time 10 to the power of negative 14. This first factor can be set the comparison tolerance, but this is the default value, and that is why I chose 1 times 10 to the power of negative 13.

So as soon as we hit 10 or more, then we have now reached the factor of 14 orders of magnitude, and their numbers are considered equal. So when we're comparing the floor with the original number, they are now considered equal and, therefore, they are filtered away.

Now we can counteract that by making a version of f, say, the comparison tolerance including version, and where we temporarily locally set the comparison tolerance to zero, and after that, we use the formula as before. Now when we use fc on w, then all 15 numbers are considered to be floating point because we are now exact in what we're doing. So this is the one definition that they compare to each other.

Another definition is the internal representation. Normally in APL, you don't care much about how things are represented internally unless possibly you're doing some performance optimizations but usually not for the values themselves. But we can actually ask APL what is the data representation of such values.

If we go back to v, we can see that v which we have here is stored as a 6 4 5 and the 6 4 means the 64 bit per element and 5 means it's floating point, a binary floating point. So, this is a 64 bit binary float array.

However, Quad DR also tries to compact every argument you give it before it tells you what the data type is. And if we apply Quad DR on each of these then we can see that trying separately on each element to compact them as much as possible, the first number can fit in a 64-bit float only and the second number 4 can fit in 8-3. That means 8-bit and 3 means integer. So, that's an 8 bit integer or 1 byte integer.

We can exploit this then. We can create a function g that selects the argument filtered by whether or not 645 is equal to the data representation of each element. And this will work on v. If we try it on w then we'll see that it also considers all these numbers to be floating point values because they're, in fact, stored as floating point even when they're compacted the most because they have this additional 1 times 10 to the power of negative 13 added to them. So, here comparison tolerance doesn't matter at all.

Let's make an interesting one. If we take the values from v and we also add a very large value and it should be noted that if I ask what is the data representation of 1 times 10 to the power of 400 it answers 1287.

This is not a 64-bit float because 64-bit floats do not reach such large magnitudes. Instead, it is a 128-bit float, and the 7 here indicates that it's not a binary that would be 5, and 3 is an integer but rather a decimal float. So this is using a 128-bit decimal float representation for the large magnitude, and of course, this gives a problem.

Now we have our x, and if we try to run g on x, then things fail spectacularly, and the reason is that apl will internally upgrade all of these numbers to be decimal floats, and then they get stuck there, and we compare them. So if you say the data representation of each one of x, then we can see that the floats all became decimal floats, and the integers are filtered away, of course. And then since we're only looking for binary floats, we're not finding anything.

But we can amend this function. So let's say we have a g which is also contains decimal values, and for that, we just check for membership in 645 or 1287. And now we can run gd on x, and it matches all of these. So this considers 1 times 10 to the power 400 floating point, which is correct as to the internal representation.

However, the problem specification also said none integer, and I'm sure you'll agree that 1 times 10 to the power 400 is very much an integer, not a non-integer. But this depends on how exactly you understand the problem.

So a very simplistic understanding would be from a human perspective: well, it's an integer if it's just a bunch of digits together, possibly negative, and it's not an integer if you need a decimal point to write out the number. And we can write this in APL as well. 

So what we'll do is we'll format each number to a character vector, and we can look whether or not there is a dot in each of these. And if there's a dot in the character representation of the number, then it would be a non-integer number. This is not going to work when you use this scaled format with an e inside, but for normal numbers, it's going to work.

You can also combine these two. Instead of running two loops, we can fuse the loops by saying we want membership, but we want the right argument to membership to be preprocessed with format. So this is a dot member of the format for each one of the numbers, and if there's a dot, then we want them; otherwise, we discard them. So we simply filter by that. And now we can try this on x, and we can see that the 1 times 10 to the power 400 is going to be filtered away.

However, if we run x on our w from before (remember w where these numbers from 1 to 15 were a little bit added), it considers none of them to be non-integers. So it's in a way more tolerant of being close to integer. The reason for that is because when we format the numbers in w, they look like this. But we can actually give a left argument to the format function, which is the number of decimals to add. So if we add, say, 14 decimals to it, then we can see that we get this one inside the decimals. So we could amend the function to do this. If we ask for too much, then it's going to add some underscores for digits that it cannot figure out based on the internal representation.

Another way is using something called the print precision, which by default is 10, which is why by default, we'll get 10 significant digits in our printouts. And if we change quad pp to something large, say 17, then doing the same expression will give us more. There's an implicit argument to the format function. Let's change that back to 10 here. And then we can write our function h as before, but this time we make a local change to pp, and I'll set it to the maximum value that's allowed, even for decimal floats. It would be 34 digits. So we take omega, filter that with whether or not a dot is a member in the format of each of the argument. And now we can try it on w, and it considers all these near integers to be non-integers. I should probably have given this a new name. I'll do that in the code that I post. Okay, and so much for regular ways.

Let's look at a little bit more exotic ways of solving this problem, and here's one. Let's say we have these numbers v. We can take the division remainder with one, so this is also known as modulus one or what is left over if I was to try to create this number just by adding ones together, and that is a non-integer if the number is non-integer and zero if it is an integer because you can create any zero any integer by multiplying an integer with one. Of course, that same number, and that means that we can compare with zero. 

So wherever we have zero, we want to get rid of that, and whenever we have a positive value and none nonzero, then we want to keep it. We could just do a comparison with zero; however, we can also just take the sign or signum of this because we'll never have any negative results from the division remainder or modulus. And so this gives us our mask, and we can select the values based on that. Let's put this into a function. There we go. And now we can try it on these values.

Here we can see we hit this problem again with near integers, and we could solve this by changing the comparison tolerance locally. So let's do ic with comparison tolerance so we can set that to zero. And then we have the same form as before, ic and w, and now it works for all these values. 

And then there is a tricky thing, which is the represent or encode. Encode with a takes a possibly mixed radix as on the left and represents the number or numbers on the right as in this base. However, here we're not actually interested in a full representation. We're not even interested in any representation. The only thing we want to know is that if the smallest unit in the base is a one, then would there or would there not be a one there, and how many ones would there be?

It's a bit interesting to explain like this, but let's have a look at what it looks like with v. And you can notice that this is exactly the same as division remainder, which is actually makes sense because when you're trying to convert to a base, then you keep subtracting as large units as possible, and then the remainder is left over here. So what's happening here is that we end up with how many ones are there that cannot be represented in the larger unit, and then we end up with a division remainder. Now what's interesting with encode is that it doesn't care about comparison tolerance; it's always precise. 

So we could actually abuse this and write it exactly the same way without specifying comparison tolerance, and then it would work even for these near integers. However, I don't think this is very clear. Don't write this in your production code. It's much better to set quad ct to zero to tell the reader what you're actually trying to do. Another way to work around it is, remember I mentioned that quad ct is like a multiplicative fuzz factor, and it's used to measure relative difference between things. 

Now if you multiply by zero, of course, you get zero, and the consequence of this is that any comparison with a true zero, the comparison tolerance doesn't matter. So even a value that is very, very small, say 1 times 10 to the power of negative 300, is not going to be considered the same as 0. How can we use this? Well, if we take these values and we subtract their floor like we spoke about in the beginning, and then we can compare this to zero, and this gives us also a true comparison.

So we can write now a subtraction based version of f that uses this system, and we can try fs on our special w. And, oops, sorry, this is wrong. This should be an unequal. Of course, we want the ones that are on floats. There we go. And we can see that all of these near integers are now considered to be non-integers, and that is because the difference between them and their floor is very small but is not equal to zero.

And finally, just for a bit of a joke solution, if we try to use the argument as left argument to replicate, but we're not actually interested in using any value, so we can just replicate the empty vector, which will always give the empty vector. Then the function is subject to the limitations in domain of the replicate function. 

Now the replicate function can take any integer, positive or negative, including 0 as argument. This means that it will error if any element is not an integer, and that's exactly what we're looking for. So we can set up an error guard that says that if any error happens, it's really the main error, but let's just do any error for now. If any error happens, that means that the test that the argument is non-integer, and we want it. Otherwise, we replicate the empty vector, which gives us the empty vector. Let's try this first. So if we do this on v, then we can see the gap here.

So we get an empty vector for every integer, and we get the integer and they get the number itself for numbers that are not integers. And all we need to do now is enlist, and that collapses all the empty vectors away, and we just get the result we want. So this solution also works. It has horrible performance. It's completely abusing the system, and it fails on numbers of very large magnitude, but well, it works, subject to comparison tolerance again like before, and we now know how we can deal with that if we want to, but that's it joking solution. Please don't do this.
