# [Identity Crisis](https://problems.tryapl.org/psets/2013.html?goto=P5_Identity_Crisis)

**Problem:** An [Identity Matrix](https://en.wikipedia.org/wiki/Identity_matrix) is a square matrix (table) of 0 with 1’s in the main diagonal. Write an APL dfn which produces an n×n identity matrix.

**Video:** [https://youtu.be/vVaZ3wEdmpQ](https://youtu.be/vVaZ3wEdmpQ)

**Code:** [https://github.com/abrudz/apl_quest/blob/main/2013/5.apl](https://github.com/abrudz/apl_quest/blob/main/2013/5.apl)

## **Example Solutions:**

### **A**

```APL
n←5
A←(=/¨⍤⍳,⍨) ⍝ equality of x and y in all indices
```

1. [Catenate](https://aplwiki.com/wiki/Catenate) `,` **n** to [Itself](https://aplwiki.com/wiki/Commute) `⍨` we get a vector of 5 5
2. We can take that vector and use it as an input for the [Index Generator](https://aplwiki.com/wiki/Index_Generator). `⍳` this generates an array of shape 5 5 where the elements are the indices for each element.
3. [Equality](https://aplwiki.com/wiki/Comparison_function) [Reduction](https://aplwiki.com/wiki/Reduce) of [Each](https://aplwiki.com/wiki/Each) pair `=/¨` we can see where the horizontal and vertical indexes are equal.  This forms our identity matrix.
4. `⍤` The [Atop](https://aplwiki.com/wiki/Atop_(operator)) operator `f⍤g Y` performs  performs f on the result of g on Y.  This allows the expression to be [Tacit](https://aplwiki.com/wiki/Tacit_programming).

```APL
{({(=/)⍵}¨)(⍳(⍵,⍵))} ⍝ The expression as a Dfn from tacit.help
```

### **B** - Equailty Table using same indeces for both sides

```APL
B←(∘.=⍨⍳) ⍝ equality table for one dimensional indices
```

1. `∘.` [Outer Product](https://aplwiki.com/wiki/Outer_Product) `∘.` generates a table from the input vector
2. `⍨⍳` Same input vector on both sides. Uses [Index Generator](https://aplwiki.com/wiki/Index_Generator) `⍳` to create the values.
3. `=` [Comparison Function](https://aplwiki.com/wiki/Comparison_function) = checks for eqality beween the elements.
4. This forms our identity matrix.

### **C** - Assign to diagonal

```APL
{s←⍵ ⍵⍴0 ⋄ (1 1⍉s)←1 ⋄ s} ⍝ assign to diagonal
```

1. `⍵ ⍵⍴0` Reshape 0 to a 5 by 5 matrix and assign it to s
2. `(1 1⍉s)←1` Giving 1 1 to [dyadic transpose ](https://xpqz.github.io/learnapl/dyadictrn.html?highlight=assignment#dyadic-transpose-ab)returns the leading diagonal. 1 replaces those values becuase dyadic transpose allows for modified assignment.
3. `s` returns the new identity matrix. Diamond is the statement seperator.

### D - amend at (i,i)

```APL
{1@(,⍨¨⍳⍵)⊢⍵ ⍵⍴0} ⍝ amend at (i,i)
```

1. `,⍨¨⍳⍵` By using the Index Generator `⍳`  and [catenating](https://aplwiki.com/wiki/Catenate) `,` [each](https://aplwiki.com/wiki/Each) `¨`  value to [itself](https://aplwiki.com/wiki/Commute) `⍨` we can generate all the indices that need to be set to 1.  (1 1) (2 2) (3 3) (4 4) (5 5)
2. `1@` Sets 1 [At](https://xpqz.github.io/cultivations/Operators.html#at) each location.
3. `⊢⍵ ⍵⍴0` [Identity](https://aplwiki.com/wiki/Identity) `⊢` returns the  [Reshaped](https://aplwiki.com/wiki/Reshape) `⍴` array of ⍵ ⍵ filled with zeros.

### E - 1s at (i,i)

```APL
⍸⍣¯1,⍨¨⍳ ⍝ 1s at (i,i)
```

1. `,⍨¨⍳` Step 1 of D (1 1) (2 2) (3 3) (4 4) (5 5)
2. `⍸⍣¯1`  [Where](https://aplwiki.com/wiki/Indices) `⍸` returns the [indices](https://aplwiki.com/wiki/Index "Index") of all ones in a [Boolean](https://aplwiki.com/wiki/Boolean "Boolean") array. The [Power Operator](https://aplwiki.com/wiki/Power_(operator))  with `¯1` returns the inverse of the Where function. Given the indices in Step 1 it returns a boolean vector with ones at each position. The [inverse of indices](https://aplwiki.com/wiki/Indices#Inverse).
3. This generates our identity matrix.

### F

```APL
{⎕IO←0 ⋄ d←i+⍵×i←⍳⍵ ⋄ ⍵ ⍵⍴1@d⊢0↑⍨⍵*2} ⍝ amend at (i,i)ₙ
```

1. `⎕IO←0` Sets [Index Origin](https://aplwiki.com/wiki/Index_origin)  to 0
2. `d←i+⍵×i←⍳⍵` Taking the indices `⍳⍵` we can multiply by their length `w` we get the indices for the [leading axis](https://aplwiki.com/wiki/Leading_axis_theory) in [ravel order](https://aplwiki.com/wiki/Ravel_order) (0 5 10 15 20 25), adding the indices `⍳⍵` returns the diagonal (0 6 12 18 24). This is then assigned to `d` which we use in the next step.
3. `1@d` We then set 1s [At](https://xpqz.github.io/cultivations/Operators.html#at) `1@d` these indices in a vector `⊢` of 0s with length of `⍵*2` using [Overtake](https://aplwiki.com/wiki/Take#Overtaking)  `↑`
4. `⍵ ⍵⍴` The result is shaped into a matrix using [Reshape](https://aplwiki.com/wiki/Reshape) `⍴`

## Industrial Versions

### A

```APL
A ←{⍵ ⍵⍴1,⍵↑0} ⍝ insert 1 before n 0s
```

1. There are n zeros to the next 1. (1 0 0 0 0 0 1) ex. n=5
2. `1,⍵↑0` [Overtake](https://aplwiki.com/wiki/Take#Overtaking) `↑` A length larger than the argument length causes [fills](https://aplwiki.com/wiki/Fill_element "Fill element") to be inserted. In this case we use it to pad zero with `⍵-1` additional zeros. `1,` [Catenate](https://aplwiki.com/wiki/Catenate) a 1 to the result.
3. [Reshape](https://aplwiki.com/wiki/Reshape) `⍴` repeats an argument of any length, singleton or otherwise. We prefix it with `⍵ ⍵` to indicate the desired final shape.  A 5x5 matrix using the example in Step 1.

### B

```APL
B ←{⍵ ⍵⍴(⍵+1)↑1} ⍝ overtake
```

1.  Using the concept of Overtake we saw in Step 1 of A we can pad 1 with `⍵+1`  zeros and then reshape the result. Obtaining the same matrix.

### C - Tacit

```APL
C ←(,⍨⍴+∘1↑1⍨) ⍝ tacit form
```

1.  `,⍨⍴` Ravel the argument against itself and use it to reshape
2.  `+∘1` Bind + to 1 making it monadic. Add one to the argument.
3.  `↑1⍨` Use step 2 to Overtake 1. The Selfie `⍨` is used as a [Constant](https://aplwiki.com/wiki/Constant).

### D  - Signum

```APL
D ←(,⍨⍴+∘1↑×) ⍝ sign gives 1 (or 0 for 0)
```

1.  [Signum](https://aplwiki.com/wiki/Signum) `×A` - Sign of number  - on a real argument are `0`, `1`, and `¯1` (zero, positive and negative)

### E - Tally

```APL
E ←(,⍨⍴+∘1↑≢) ⍝ tally of scalar is 1
```

1.  [Tally](https://aplwiki.com/wiki/Tally) `≢` The tally of a Scalar is 1

## Expand

### A 

```APL
A ←{⍵ ⍵⍴1(-⍵)\1} ⍝ expand 1 into one 1 and n 0s
```

1. [Expand](https://xpqz.github.io/cultivations/Functions7.html?#expand) `\` - copies each [element](https://aplwiki.com/wiki/Element "Element") of the right [argument](https://aplwiki.com/wiki/Argument "Argument") a given number of times. Positive numbers on the left also replicate like with `/` but negative numbers insert that many prototypical (spaces for characters and zeros for numbers) elements at that position. 
2. `1(-⍵)\1`  `-⍵` is the number of zeros. `\1` is the number to prepend with. `1(-⍵)` is the number of times to prepend with a 1. 
3. `⍵ ⍵⍴`  Reshape into a `⍵ ⍵` matrix. 

### B

```APL
B ←(,⍨⍴1\⍨1,-) ⍝ tacit
C ←{(⍵,⍵)⍴((1,(-⍵))\1)} ⍝ tacit.help
```

1. `,⍨⍴1` Self concatenation of the argument reshaped by 
2. `1\⍨1` 1 expanded by 1 (See A step 2)
3. `,-` followed by the negation of the argument (generates zeros)
4. See C for [Dfn](https://aplwiki.com/wiki/Dfn) form

## Matrix - [Matrix Multiplication](https://en.wikipedia.org/wiki/Matrix_multiplication)

### A

```APL
A ←{⌹⍨?⍵ ⍵⍴0} ⍝ M × I = M
```

1. Reshape a matrix of random numbers against it's inverse. 
2. `?⍵ ⍵⍴0` This gives us a matrix of random floats between zero and one. 
3. [Matrix Divide](https://aplwiki.com/wiki/Matrix_Divide) `⌹` Using [Selfie](https://mastering.dyalog.com/Tacit-Programming.html?highlight=selfie#commute-and-selfie) `⍨` we echo the right argument to its left. In this case the matrix generated in Step 2 is divided by itself.
4. This produces the identity matrix using [matrix multiplication](https://en.wikipedia.org/wiki/Matrix_multiplication)

### B

```APL
B ←(⌹⍨⍤?,⍨⍴≡) ⍝ depth of simple scalar is 0
C ←{(?((⍵,⍵)⍴(≡⍵)))⌹(?((⍵,⍵)⍴(≡⍵)))} ⍝ tacit.help
```

1. Makes A a [Tacit Function]([Tacit Programming](https://aplwiki.com/wiki/Tacit_programming))
2. Can be read as Matrix division `⌹`, Selfie `⍨` , On `⍤`, random numbers `?` shaped `⍴` as the self concatentation `,⍨`(takes one input and makes it two) of [Depth](https://aplwiki.com/wiki/Depth) `≡` - returns an array's depth. On a scaler (our input) it reurns zero. 
3. See C for [Dfn](https://aplwiki.com/wiki/Dfn) form

## Base conversion

```APL
A ← (⍴∘2⊤2*⊢-⍳) ⍝ powers of two are 1 0 0 …
B ← {(⍵⍴2)⊤(2*(⍵-(⍳⍵)))} ⍝ tacit.help
```

### A

1.  Looking at our identiry matrix we can see that each column is a power of two spelled out in binary. 
2.  `2*⊢-⍳` We can generate these numbers by subtracting the initial [Identity](https://aplwiki.com/wiki/Identity) `⊢` from the  [Index Generator](https://aplwiki.com/wiki/Index_Generator)`⍳` of the argument and raising the result to the [power of](https://aplwiki.com/wiki/Exponential) 2. 
3.  We can then perform a base conversion. The left argument to [Encode](https://mastering.dyalog.com/Mathematical-Functions.html?highlight=encode#encode) `⊤` defines the number of digits in the new number system. In this case we are prefixing it with a 2.
4.  We [Bind](https://aplwiki.com/wiki/Bind) `∘` -  the Encode `⊤` with [Reshape](https://aplwiki.com/wiki/Reshape) `⍴` creating a derived function and a tacit result. 
5.  See B for [Dfn](https://aplwiki.com/wiki/Dfn) form

## Overtake, Mix and Scan

### A

```APL
A ← (-⍤⍳↑⍤0≢) ⍝ suffixes of 1
```

1. `-⍤⍳` Negation of the indices
2. Paired with the rank operator. Take using a length which is larger than the argument length causes [fills](https://aplwiki.com/wiki/Fill_element "Fill element") of 0's to be inserted.
3. Use tally to get a 1 allows function to be tacit. 
4. `{(-(⍳⍵))(↑⍤0)(≢⍵)}` is the Dfn version

### B

```APL
B ← (↑,⍨\⍤↑∘1) ⍝ cumulative reverse-concatenations
C ← {↑(({⍵,⍺}\)(⍵↑1))} ⍝ tacit.help
```

1. `,⍨\` Swapped concatentation of scan returns the reversed prefixes of a vector
2. `↑∘1` Take binded with one. Overtakes one with the arguments number of zeros. In this case n=5
3. `⍤` Atop seperates the functions returns the right and then the left. 

## Key Operator

### A

```APL
A←(×⌽⍤↑⌸⍤⍳) ⍝ {×(({⌽(⍺↑⍵)}⌸)(⍳⍵))}
```

1. Signum reversal atop of the the taking of the two arguments
2. `↑⌸⍤⍳`  We use the [Index Generator](https://aplwiki.com/wiki/Index_Generator) `⍳` to produce a list of numbers. [Key](https://aplwiki.com/wiki/Key)  `⌸`  groups each unique element as left argument, and the indices of that element in the data as right argument. We can then [Overtake](https://aplwiki.com/wiki/Take#Overtaking) `↑` with a length larger than the argument length causing  [fills](https://aplwiki.com/wiki/Fill_element "Fill element") of zeros to be inserted.
3. `×⌽` [Reverse](https://aplwiki.com/wiki/Reverse) `⌽` reorders the [elements](https://aplwiki.com/wiki/Elements "Elements") of the argument to go in the opposite direction along a specified [axis](https://aplwiki.com/wiki/Axis "Axis") We then use  [Signum](https://aplwiki.com/wiki/Signum) `×` to generate 1's, instead of the indices generated by Key in Step 2. 
4. `⍤` The [Atop](https://aplwiki.com/wiki/Atop_(operator)) operator `f⍤g Y` performs  performs f on the result of g on Y.  This allows the expression to be [Tacit](https://aplwiki.com/wiki/Tacit_programming). 
5. See Comment for the [Dfn](https://aplwiki.com/wiki/Dfn) version. 

### B

```APL
B←(⍸⍣¯1⍤⊢⌸⍳) ⍝ {({(⍸⍣¯1)⍵}⌸)(⍳⍵)}
```

1. Where inverse atop the right argument. Boolean vectors with 1 in each position. 
2. `⊢⌸⍳`   Same as in A we use the [Index Generator](https://aplwiki.com/wiki/Index_Generator) `⍳` to produce a list of numbers. [Key](https://aplwiki.com/wiki/Key)  `⌸`  groups each unique element as left argument, and the indices of that element in the data as right argument. However we use [Identity](https://aplwiki.com/wiki/Identity) `⊢` to just return the indices. 
3. `⍸⍣¯1` [Power](https://aplwiki.com/wiki/Power_(operator)) `⍣¯1` is used to access function inverses. [Where](https://aplwiki.com/wiki/Indices) `⍸` returns the indices of a boolean array. So this will pad our indices with zeros. 
4. `⍤` The [Atop](https://aplwiki.com/wiki/Atop_(operator)) operator `f⍤g Y` performs  performs f on the result of g on Y.  This allows the expression to be [Tacit](https://aplwiki.com/wiki/Tacit_programming). 
5. See Comment for the [Dfn](https://aplwiki.com/wiki/Dfn) version. 

## [Complex Numbers](https://aplwiki.com/wiki/Complex_number)

```APL
A ← {4=○÷12○⍵∘.+0j1×⍵}⍳ ⍝ π÷4 = arg(a+ai)
B ← {0=(2*÷2)||⍵∘.+0j1×⍵}⍳ ⍝ |a+ai| = 0 mod √2
```

### A

1. `⍵∘.+0j1×⍵` Using [Outer Product](https://aplwiki.com/wiki/Outer_Product) `∘.+` of the real part plus the imaginary part `+0j1` and Multiplying the imaginary part `0j1×⍵` by the Index `⍳` to create a table.  
2. `○÷12○` The [Circular](https://aplwiki.com/wiki/Circular)  `12○` function is the [Phase](https://en.wikipedia.org/wiki/Phase_(waves)) of ⍵. This determines the magnitude and the direction fo a complex number.  
3. `4=○÷` The diagonal values will have Phase of 45 degrees or one quarter of pi (0.785398163 radians). Dividing by pi `○÷` returns 4 and we can then select all the 4's in the matrix. Returning 1's for true. 
   B
4. `⍵∘.+0j1×⍵` Again using [Outer Product](https://aplwiki.com/wiki/Outer_Product) `∘.+` of the real part plus the imaginary part `+0j1` and Multiplying the imaginary part `0j1×⍵` by the Index `⍳` to create a table.  
5. When two complex numbers are added, they form the two sides of a right triangle in the complex plane, with the resulting complex number being the hypotenuse. The magnitude of the resulting complex number is equal to the length of the hypotenuse.
6. Becuase the horizontal and the vertical parts of this triangle are equal to each other( the same index is used on both sides of the outer product). The diagnals length is a multiple of the square root of 2. 
7. `(2*÷2)||` The first vertial bar takes the [Magnitude](https://aplwiki.com/wiki/Magnitude) `|` of the result of Step 1. The second bar calculates the remainder or [Residue](https://aplwiki.com/wiki/Residue) when the table is divided by the square root of two `(2*÷2)` 
8. `0=` Everywhere there is no remainder we are on the diagonal. 

## **Comment:**

```APL
J←{⍵ ⍵⍴(⍵+1)↑1} ⍝ overtake to insert 1 before n 0s
=/¨  ⍝ Compare Each
∘.=⍨ ⍝ Equailty Table using same indeces for both sides
1 1⍉s ⍝ Selects the diagonal of s
,⍨¨ ⍝ Catenate each to itself
x+.×y ⍝ matrix multiplication
,\ ⍝ prefix of a vector
```

## **Glyphs Used:**

- [Catenate](https://aplwiki.com/wiki/Catenate) `,`
- [Index of](https://aplwiki.com/wiki/Index_Of) `⍳`
- [Comparison Function](https://aplwiki.com/wiki/Comparison_function) =
- [Compress](https://aplwiki.com/wiki/Replicate) `/` - filters the right argument `=/¨` compare each
- [Each](https://aplwiki.com/wiki/Each) `¨`
- [Commute](https://aplwiki.com/wiki/Commute) `⍨`  - aka Selfie or Swap
- [Dyadic Transpose](https://xpqz.github.io/learnapl/dyadictrn.html?#dyadic-transpose-ab) ``x⍉y`` - allows you to select diagonals by giving one or more dimensions equal mapping
- [Reshape](https://aplwiki.com/wiki/Reshape) `⍴`
- [At](https://xpqz.github.io/cultivations/Operators.html#at) `@` - What’s on its left gets done at the position indicated by its right operand.
- [Identity](https://aplwiki.com/wiki/Identity) `⊢`
- [Where](https://aplwiki.com/wiki/Indices) `⍸` - returns the indices of a boolean array - mondadic
- [Power](https://aplwiki.com/wiki/Power_(operator)) `⍣¯1` - used to access function inverses
- [Power(Function)](https://aplwiki.com/wiki/Power_(function)) `*` -  `X*Y` is `X` raised to the power `Y`
- [Overtake](https://aplwiki.com/wiki/Take#Overtaking) `↑` - A length larger than the argument length causes [fills](https://aplwiki.com/wiki/Fill_element "Fill element") to be inserted
- [Bind](https://aplwiki.com/wiki/Bind) `∘` -  used to create a derived function with a single constant argument
- [Constant](https://xpqz.github.io/cultivations/Operators.html#constant-a) `A⍨` - always returns the operator array
- [Signum](https://aplwiki.com/wiki/Signum) `×A` - Sign of number  - on a real argument are `0`, `1`, and `¯1` (zero, positive and negative)
- [Tally](https://aplwiki.com/wiki/Tally) `≢`
- [Expand](https://xpqz.github.io/cultivations/Functions7.html?#expand) `\` - copies each [element](https://aplwiki.com/wiki/Element "Element") of the right [argument](https://aplwiki.com/wiki/Argument "Argument") a given number of times
- [Roll](https://aplwiki.com/wiki/Roll) `?0` - When zero Roll chooses a floating-point number between 0 and 1
- [Matrix Divide](https://aplwiki.com/wiki/Matrix_Divide) `⌹`
- [Rank](https://aplwiki.com/wiki/Rank_(operator)) `⍤` - applies its left [operand](. https://aplwiki.com/wiki/Operand "Operand") function to [cells](https://aplwiki.com/wiki/Cells "Cells") of its arguments specified by its right operand array.
- [Depth](https://aplwiki.com/wiki/Depth) `≡` - returns an array's depth
- [Decode](https://aplwiki.com/wiki/Decode) `⊥` - aka base
- [Encode](https://aplwiki.com/wiki/Encode) `⊤` - aka antibase
- [Bind](https://aplwiki.com/wiki/Bind) `∘` - used to create a derived function with a single constant argument
- [Key](https://aplwiki.com/wiki/Key)  `⌸` - groups [major cells](https://aplwiki.com/wiki/Major_cell "Major cell") and applies the [function](https://aplwiki.com/wiki/Function "Function") for each cell
- [Enclose](https://aplwiki.com/wiki/Enclose) `⊂` - An enclosed array is a [scalar](https://aplwiki.com/wiki/Scalar "Scalar"), which is subject to [scalar extension](https://aplwiki.com/wiki/Scalar_extension "Scalar extension").
- [Reverse](https://aplwiki.com/wiki/Reverse) `⌽` - reorders [elements](https://aplwiki.com/wiki/Elements "Elements") of the argument to go in the opposite direction along a specified [axis](https://aplwiki.com/wiki/Axis "Axis").
- [Circular](https://aplwiki.com/wiki/Circular)  12○ - Phase of ⍵ (omega)
- [Pi Times](https://aplwiki.com/wiki/Pi_Times) ○
- [Magnitude](https://aplwiki.com/wiki/Magnitude) `|` aka absolute value
- [Residue](https://aplwiki.com/wiki/Residue) `|` aka remainder

## **Concepts Used:**

- [Identity Matrix](https://en.wikipedia.org/wiki/Identity_matrix)
- [Dfn](https://aplwiki.com/wiki/Dfn)
- [Radix](https://en.wikipedia.org/wiki/Radix)
- [Index Origin](https://aplwiki.com/wiki/Index_origin) - Generating Functions with that work with 0 or 1 origin
- [Ravel Order](https://aplwiki.com/wiki/Ravel_order)
- [Outer Product](https://aplwiki.com/wiki/Outer_Product) `∘.`
- [Tacit Programming](https://aplwiki.com/wiki/Tacit_programming)
- [Matrix Multiplication](https://en.wikipedia.org/wiki/Matrix_multiplication)
- [Vector Prefix](https://aplwiki.com/wiki/Prefix)
- [Boolean Mask](https://aplwiki.com/wiki/Boolean)
- [Complex Numbers](https://aplwiki.com/wiki/Complex_number)
- [Phase](https://en.wikipedia.org/wiki/Phase_(waves))

## **Transcript:**

Welcome to this episode of the apl quest see APL wiki for details. Today's quest is generating an identity matrix of order n. It's a very simple task, but there are a lot of interesting ways we can do this. Let's get started with some serious solutions and then look at some more fun innovative solutions after that.

The first thing we can do is that we have a number n. Let's, for argument, say that n is five and we want to make a matrix that is five by five. So we can calculate n to itself, giving us five by five.

Next up, we can generate all the indices of an array of shape five five, and we can take these indices and look at where the horizontal and vertical index are the same by comparing each. This gives us our identity matrix. However, we can do this in a simpler way. We only need to generate the indices until n and then make an inequality table using the outer product and the selfie or commute operator to use the same indices on both sides of the quality. In fact, this is our simplest solution. So just the outer product selfie on the indices.

It isn't a very efficient solution, however, because we are comparing a lot of numbers in general that we have generated when we actually know where the ones are going to be in advance. So what we can do is we can start off by creating an empty matrix of zeros. So we take n and use that twice to reshape zero. This gives us a big empty vector like this, an empty matrix like this. No, it's not empty. It has a big zero matrix like this.

Then we can use dyadic transpose, which selects the um, it can collapse dimensions so that we get diagonals. We can illustrate this by saying 5 5 reshape iota 25, and then we can use the attic transpose mapping both dimensions to a single dimension, and that gives us the compromise between them diagonal.

Now we can use this with a selective assignment. We say one one transpose of s gates one, and the one that gets distributed over the entire s. And now s has been updated to become an identity matrix. We can put this into a function as s gets omega omega reshape zero, and then the diagonal of s gets one, and then return that s. And we can now give it the argument five fine.

This is verbose, but it works. It doesn't have the best performance necessarily, and it's a bit awkward because we have to have this middle statement where we update s before we then return s. We can also use the add operator to do something similar. We can start off by generating all the indices that need to be set to 1.

How can we do this? Well, if we start with this iota n in our case, then we know that it is the elements of position one one, two two, three three, four four, and that need to be set to one. So what we can do is we concatenate selfie concatenate to itself each one of them, and these are the indices that we need to set to one. And then we can use this, setting one at those indices in the array that is n and reshape zero, and that will give us an identity matrix.

We could also use these indices in a different way, and namely we could say, "Give me a boolean matrix that has ones in those positions." So where are all the ones in the boolean matrix? It's magnetic iota underbar, and the inverse we can use power negative one on that, and that gives us an identity matrix as well.

There are even more things that we could do along these lines. Instead of using a matrix, we can use a vector. The way we can do that is by observing that this is kind of an encoding of in in a special radix. So we want ones, and then when we do things like that, we need to set coordinate to zero, otherwise, it becomes too complicated.

What we can do is we have the indices iota n here, and then we can multiply those by n, and so this corresponds to, let's see, number zero is this element, and number five is this element, and number ten is this element in revel order. However, we need to offset one for each one, so if you take these indices and add them to this, that gives us in revel order that diagonal. We can actually see this if we say 5 5 reshape by yo to 25. We can see that 0, 6, 12, 18, 24, those are diagonals.

Once we have those, we can then use the add operator as before. So we can set the ones at that in a vector, which is zero reshaped to the shape of n squared, and this is our flattened identity matrix. Now we can take the proper shape and reshape it, and we get our identity matrix.

Let's change back to quarter one index origin one and then actually do some of the best performing solutions. We can observe similar to what we've done now. We can see that there are exactly n zeros onto the next one, and then again n zeros to the next one. So what we can do is we can begin with a one followed by n zeros, and then we can reshape that cyclically into our full shape. We'll use n here, and this is almost as good as it gets.

There's one problem for a very large n, and we create a boolean vector of all zeros. And by inserting one at the beginning, it gives us sub-optimal performance because we need to copy this entire array one step over, shifting everything by one bit to insert that leading bit. How can we avoid that? Well, we can use overtake. So if we say `n take` of one, it pads with additional zeros at the end. And the only thing we need to do here is really adding n plus one, and this gives us the full row. And now we can reshape into that shape.

This is going to be the best it gets. We can put this into a function as `omega omega reshape omega plus one take one`. We can also make this into a tested form, and we can play some tricks there. Let's split up the problem `omega omega` that is the self-concatenation of the argument. Then we reshape that, and then we want the argument plus one.

So we can tie or bind a 1 to plus, making a magnetic function. So that's an increment function, and we use that to take from. Well, we need a 1 here, but we can't have 1 at the end of a tested function because it's a constant, not a function. We can transform it into a function using the constant operator, so we can try this as well, and that works. And then for a little bit of trickery, we can actually avoid this construct of one constant by observing that the sine of five is one, and the problem was that we needed on the right hand to have a function, not a constant.

So this is a function applied to any number that's relevant, and we get one. If we want the zero by zero, it doesn't matter that the sine of zero is zero. It will still work because it becomes an empty array, so we can do this. We can say `i5` like this. Another possibility is observing that how many elements are there in a single number? There's only one, and that applies even to zero.

So we can do that as well. This is the fastest solution that we're going to get. This is a proper solution, whether you want to use a tested form or a defend. It should be about the same performance.

Now onto some more fun and innovative solutions that we could do. Remember again that we needed a single one followed by n zeros, and we can actually do that using expand. So if we have a one representing that we want `1 1` and then we have negative n representing n fill elements, we can use that with the expand function on a single one to get the same thing, and then we can reshape that to our identity matrix.

We can write this in a tested form, and so this is again the self-concatenation, reshapes one expanded by one followed by the negation, and it works for zero as well. What happens in the zero case is negation of zero is zero, so we get `1 0`. That means we expand one as a single one with no fill elements, reshape that to `0 0`, and we have an empty numeric matrix, so that works as well.

Here's one that almost always works. There is an astronomically small probability that it won't work, but it is rather fun. Let's say we have a matrix of random numbers. So with the zero as argument, `?` gives us random floats between zero and one. They won't be zero, they won't be one, and it's exceedingly unlikely that we'll have duplicates here.

Of course, now if this is a matrix, then there must exist a matrix such that `m * m` (multiplication here means matrix multiplication) will give us... but in traditional mathematics, just `m * m` will give us the matrix itself, and that is the identity matrix.

Now, if we move things around in this equation, we'll find that dividing the matrix by itself should give us the identity matrix. And indeed, that is so. So we can do m matrix divide with m, and that gives us an identity matrix. We can write the whole thing as matrix division selfie on the random numbers of the self-concatenation of zero (here's a constant zero). You can try this, and it works.

Similar to what we did with sine and tally to get a 1, there's also a function which, for a single number (a scalar), gives 0, and that is the depth function. So we can go up and amend our function to this very obscure looking thing which works just fine and is very, very inefficient because API will have to solve an equation system every time we generate an identity matrix. But hey, it's fun, right?

Here's another one which is very, very inefficient. Let's think about this: we've got the indices up to n. If we subtract these from n itself, that gives us descending powers from four down to zero, raised two to the power of that, and we've got descending powers of two. And now, if we go up and look in our identity matrix, then we can see that the first column is 16 spelled out in binary, and the second column is 8 spelled out in binary, and 4 and 2 and 1. So this means that if we represent all these numbers in base 2, then we would get the identity matrix.

So we could do something like this which auto-sizes, but we already know that we want n bits, so we can say n nreship2 encode on that, and that works as well. And then we can make the whole thing tacit by saying that it is the reshape of two. So this is a magnetic function which reshapes two encodes 2 to the power of the argument minus iota on the argument, so this works just fine but again, very inefficient doing base conversions when we just want to create an identity matrix. But fun!

Okay, a little bit more fun. We can generate the negative indices, and then we can overtake like we did before on a1, so each one of these will be used to take from a1. It takes from the rear padding, zeroes us at the front. Oops, that was too much - missing an each there. There we go. And now we just need to stack them up on top of each other, and there are various ways we could do that. We can mix or we could use the rank operator. So we want to pair these up, we need to do take pair these up with one and then it mixes everything together, so that works as well. And now we can put all this together to create a tested function.

So we have the negation of iota take rank 0 on... remember how to get a 1 without using literal one? We could use tally, for example, so this should work as well. And here's our density matrix in the rather roundabout way.

Another thing we can use is scan. So we can get normally prefixes of a vector like this, and if we instead of concatenate (this is a cumulative concatenation), we do a cumulative swapped concatenation, then we get these reversed prefixes instead. If we can have a way to get reverse prefixes and we have a way to get one followed by a bunch of zeros, then these give us our rows, and we just need to mix. 

So we can write this as an as a function the conclusion swapped scan and off the take of one so this is an end take one and then we mix that then we just need to put and a top here so we have two functions after each other and here we got our identity function in a very roundabout manner but lots of fun again.

Now let's move over to the key operator which we can also use for this. We can generate our our indices like this and then we can ask the key operator what are the indices so let's put it like this but now so this is saying index one is found or the number one is found at position one the number two is filter under position two only number three is found at position three that means the alpha here is one and omega is what f plus 2 omega is 2 and so on. Now we can use take here and that gives us these vectors and we can see how where we're going with this. We can then reverse this and now we just have the problem of the sign so we can take the sign of all of this and we need to stack them on top of each other as well.

So we could mix it like this but there's a better way but not enclosing them we already get the mix for free and now we just need to get the sign here and then we can make this tacit because it fits very nicely it is the reversal on top of the taking of these two arguments and that gives us our identity matrix. It's not quite a function yet but we can make it so by combining the key with the indices and now we have our identity matrix generator in a totally obscure way that nobody will be able to understand.

Don't do this in production code. Let's make it worse. Let's start again with this construct and here we are only interested in the right argument so that gives us these vectors of um indices one by itself two beta three beta four by five by itself and remember we used the uh iota underbar the where inverse to generate a boolean array and that has ones in those positions there's only one position in each one but we can still do this so this gives us these vectors and yes you recognize this remove the enclosure and we've got our identity matrix.

We can combine this. We can make the operand test it simply by saying that it's this where inverse on top of the right argument we have to have that because there's a left argument as well and so this is our function and that works again don't do this in production code but it sure is fun to look at.

Then somebody asked during the live chat event if we can't use complex numbers for this, and of course, we can use complex numbers for this. Okay, let's get started. So we have these indices, and let's make a table of complex numbers. So we do the other product of the real part plus the imaginary part, so we multiply the imaginary units with these indices. Oops, there shouldn't be n here; it should be that, and that gives us a complex number table. 

So this is 1 + 1i, 2 + 1i, 1 + 2i, 1 + 3i, next row 2 + 1i, and so on. And now what we need to do is we want to find out the ones that are down the diagonal and both actually down the diagonal. We can kind of see the angle of them, but it also happens to be that in a complex plane, these will have an angle or also known as the argument, which is 45 degrees or a quarter of pi. So we can ask for the argument of that, and we can see that going down the diagonal, they all have that 0.785 and so on. Now we can multiply that by, or rather, sorry, divide pi by that, so the same thing as taking the reciprocal and multiplying by pi, and then you can see that gives four. And now we can say where is 4 equal to that, and that gives us our identity matrix.

So this is our full function. We could either do iota omega here, or we could just use omega and put iota outside that as in the top, and we've got our identity matrix producing function here in a terrible way using complex numbers. And as if that wasn't enough, let's go in and modify this a bit. Starting again from here with our table of complex numbers, we can also ask what is the absolute value or the magnitude of these numbers. And since they are on the 45-degree angle, that means that the horizontal and vertical parts in this right-angle triangle are equal to each other. That means that the diagonal's length has to be a multiple of the square root of 2. So we can ask what is the divisional remainder when these numbers are divided by the square root of 2, and if there is no remainder, then we are on the diagonal, so we can compare this with zero, and we get our identity matrix using complex numbers.

That's enough fun, and what you should do, of course, is use the solution where we take the argument twice, reshape with one plus the argument to take over of and of one, or you can use the tested version where it's a self-concatenation of the reshape of the incremented number take off one or as a constant, or you can use the sign or the tally if you really want to go there. But these would be the industrial strength versions. You can also go up, and if you don't like parentheses like I personally don't do, then you can swap the arguments of this take as well. That's perfectly acceptable as well. Thank you for watching.

