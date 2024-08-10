# [Keeping Things In Balance 2013-4](https://problems.tryapl.org/psets/2013.html?goto=P4_Keeping_Things_In_Balance)

**Problem:** Write an APL dfn which returns a 1 if the opening and closing parentheses in a character vector are balanced, or a zero otherwise.

**Video:** https://youtu.be/El0_RB4TTPA
**Code:** https://github.com/abrudz/apl_quest/blob/main/2013/4.apl

## **Example Solutions:**

```APL
Di ← {1 ¯1 0['()'⍳⍵]} ⍝ Indexing into an array, 1 is left paren, ¯1 is Right and 0 is all other characters. 
Df ← '('∘= - =∘')' ⍝ Tacit, subtracts the comparisons to get the depth changes. 
Bn ← (¯1∊+\)⍱0≠+/ ⍝ checks for no ¯1 and no 0 in scan
F ← (¯1∘∊⍱0≠⊢/)'('∘=+\⍤-=∘')' ⍝ Moves scan to be atop on comparisons +\⍤ 
```

## **Parenthesis depth changes**

### **Di**

```APL
Di ← {⍵ ↑⍤,⍥⊂ 1 ¯1 0['()'⍳⍵]} ⍝ Convert the data to norrmalized form. 
```

1. `['()'⍳⍵]` - [Index of](https://aplwiki.com/wiki/Index_Of) `⍳` shows a 1 if left paren, 2 if right paren, and 3 if not found. 
2. `1 ¯1 0` - map the result of step 1  to (1 left,  -1 right, 0 not found)
3. `↑⍤,⍥⊂` -  [Enclose](https://aplwiki.com/wiki/Enclose) `⊂`  - Create a nested scaler  [Over](https://aplwiki.com/wiki/Over)  `⍥` -  Preprocess the right argument  [Merge Axis](https://aplwiki.com/wiki/Rank_(operator)#Merge_axes) -  `⍤,` concatenate the two axis  [Mix](https://aplwiki.com/wiki/Mix)  `↑` - trades one level of [depth](https://aplwiki.com/wiki/Depth) (nesting) into one level of [rank](https://aplwiki.com/wiki/Rank). 

### **Do**

```APL
Do ← -⌿'()'∘.=⊢
```

1. `'()'∘.=⊢` Applying an [Outer Product](https://mastering.dyalog.com/Operators.html?highlight=outer%20product#outer-product) using a comparison `=` Because this is a tacit function [Right Tack](https://aplwiki.com/wiki/Identity) acts as omega `⍵` and just returns the function it is pointing to. 
2. `'()'∘.=⊢` The `'()'` is the comparison that the outer product is applying against the identity. This creates a table. 
3. The first row a [Boolean Mask](https://aplwiki.com/wiki/Boolean) of 1's (true) where the left parenthesis is found and 0 (false) where is it not found. 
4. The second row is 1's where the right parenthesis is found. 
5. The result of step 2 is already a matrix. So we can use [Table](https://xpqz.github.io/cultivations/Functions7.html#table) `⍪`  - to ravel the major cells of the array and make each one of them into a row with the identity on top. This is just explanatory. 
6. -⌿ Subtracting the bottom row from step 2 from the top row in step 2 using a vertical minus [Reduction](https://aplwiki.com/wiki/Reduce) gives us the  depth changes.  

### **Df**

```APL
Df ← '('∘= - =∘')'
```

1. We can do the two [Comparison Functions](https://aplwiki.com/wiki/Comparison_function) independently
2. `'('∘=` Making a boolean mask of the left parenthesis. 
3. `=∘')'` Making a boolean mask of the right parenthesis.
4. After subtracting the two results to give us the depth changes we can turn this into a [Tacit Function](https://aplwiki.com/wiki/Tacit_programming) 
5. [Bind](https://aplwiki.com/wiki/Bind) `∘` is used to create a derived function with a single constant argument for each comparison. 
6. This creates a [3-train Fork](https://aplwiki.com/wiki/Train#3-trains) where the two outer functions are applied first, and their results are used as arguments to the middle function in this case subtract `-`. 

## **Performance**

```APL
'turtle' 'joy' 'cmpx'⎕cy'dfns'
(y n)←(⊢⍴⍨100×⍴)⍤⎕VR¨'turtle' 'joy'
cmpx'D',¨'iof',¨⊂' y'
```

We can evalute the performance of each function by importing the [CMPX](http://dfns.dyalog.com/n_cmpx.htm) function from the [DFNS](http://dfns.dyalog.com/n_contents.htm) library. 

1.  We can  [copy](http://help.dyalog.com/latest/Content/Language/System%20Functions/cy.htm) `⎕cy` CMPX  along with TURTLE and JOY from the DFNS library into our workspace.
2.  We know that Turtle has matched parenthesis and Joy has unmatched parenthesis so we can use these two functions as our test cases. 
3.  In the next line we are taking the [Vector Representation](https://xpqz.github.io/cultivations/CodeManagement.html?highlight=vr#visual-representation-vr) - ⎕VR of [Each](https://aplwiki.com/wiki/Each) `¨` function.
4.  [Rank](https://aplwiki.com/wiki/Rank_(operator)) `⍤` - applies its left [operand](. https://aplwiki.com/wiki/Operand "Operand") function to [cells](https://aplwiki.com/wiki/Cells "Cells") of its arguments specified by its right operand array.
5.  `⊢⍴⍨100×⍴` Using [Commute](https://aplwiki.com/wiki/Commute) `⍨`  - we first take the [Shape](https://aplwiki.com/wiki/Shape) of the idenitity `⊢⍴` and and then  [Reshape](https://aplwiki.com/wiki/Reshape) `100×⍴` it using 100 times it's current shape. 
6.  In the next line we are doing some meta programming to use cmpx to evalute the performance of each function. 
7.  Every function begins with a D. We [Concatenate](https://aplwiki.com/wiki/Catenate)  [Each](https://aplwiki.com/wiki/Each) `,¨` of the suffixes 'iof' and then  [Concatenate](https://aplwiki.com/wiki/Catenate)  [Each](https://aplwiki.com/wiki/Each) `,¨` to the entire function ' y' using [Enclose](https://aplwiki.com/wiki/Enclose) `⊂` - An enclosed array is a [scalar](https://aplwiki.com/wiki/Scalar "Scalar"), which is subject to [scalar extension](https://aplwiki.com/wiki/Scalar_extension "Scalar extension").

## **Balanced?**
We are checking if two condtions are realized. 
1. Our final parenthesis level needs to be zero. 
2. As our function proceeds our parenthesis level should not drop below zero. 
3. Both expressions are then evaluted for performance using simlar steps to above

### BA

```APL
Ba ← (∧/0≤+\)∧0=+/
```

1. `∧/` [And](https://aplwiki.com/wiki/And) [Reduction](https://aplwiki.com/wiki/Reduction "Reduction")  tests if it is true for ALL that the parenthesis depth is greater than or equal to zero. 
2. `0≤+\` Plus [Scan](https://aplwiki.com/wiki/Scan) `+\` gives us the parenthesis depth. The [Comparison Function](https://aplwiki.com/wiki/Comparison_function) `0≤` checks if zero is less than or equal to the running sum. 
3. `∧0=+/` [And](https://aplwiki.com/wiki/And)  also checking if it is true that zero = the full sum `0=+/`. 
4. Both conditions must be true for BA to return 1 (for true).

### BN 

```APL
Bn ← (¯1∊+\)⍱0≠+/
```

1. `¯1∊+\` Checks if -1 is a [member](https://aplwiki.com/wiki/Membership) `∊` of the running sum or [Scan](https://aplwiki.com/wiki/Scan) `+\`. 
2. `0≠+/` Checks if zero is not equal to the total. 
3. `⍱` [Nor](https://aplwiki.com/wiki/Nor) tests if neither argument (Step 1 or 2) is true: it returns 1 if both are false (0) and 0 if at least one is true (1)

### BNS

```APL
Bns ← (¯1∘∊⍱0≠⊢/)+\
```

1. Move the Scan to outside the parenthesis
2. `∘` [Bind](https://aplwiki.com/wiki/Bind) the enclose to the scaler. Tacit so the identity element is implied. 
3. `⊢/` Right Reduction picks the last element of the Scan we moved in step 1. 
4. Evaluate for performance. 

### F

```APL
F ← (¯1∘∊⍱0≠⊢/)'('∘=+\⍤-=∘')'
```

1. Take our BNS solution which is an [Atop](https://aplwiki.com/wiki/Train#2-trains) or 2-train. The left function is applied [monadically](https://aplwiki.com/wiki/Monadic_function "Monadic function") on the result of the right function.
2. Take our Df Solution which is a [Fork](https://aplwiki.com/wiki/Train#3-trains) or 3-Train. The two outer functions are applied first, and their results are used as arguments to the middle function.
3. `+\⍤-` To combine these solutions we use an [Atop](https://aplwiki.com/wiki/Atop_(operator)) `⍤` operator  on Df to post process the result of the subtraction using a scan `+\`. 
4. The depth change in Step 3 is then passed to BNS. 

## **Find and Replace** - Regular Expressions

Find all the parenthesis and eliminate pairs of parenthesis until none are found. If we have an empty set Parenthesis are matched. Any parenthesis that are left means they are unbalanced.

### RE

```APL
t←'(1 2)×(3+(3÷4))×(1+2)÷8' ⍝ Test Data
Re ← ''≡'\(\)'⎕R''⍣≡⍤∩∘'()'
```

1.  `∩∘'()'` [Intersection](https://aplwiki.com/wiki/Intersection) `∩` removes elements from the left which are not present in the right. In this case we remove everything but the parenthesis. 
2.  `'\(\)'⎕R''` [Regular Expression](https://xpqz.github.io/cultivations/Regex.html?highlight=regular%20expressions) using `⎕R` to find parenthesis and replace with an empty string. Each parenthesis is escaped using `\` Performs this operation one time. 
3.  `''≡` [Match](https://aplwiki.com/wiki/match) `≡` is checking if the result matches an empty string. 
4.  `⍣≡`  [Power Match](https://xpqz.github.io/cultivations/ConditionControlledLoops.html?highlight=power)  `⍣≡` - Iterating until a fixed point is reached. In this case when no more parens are found. 
5.  `⍤` [Atop Operator](https://aplwiki.com/wiki/Atop_(operator)) takes the two monadic functions and glues them together. 

### RE0

```APL
Re0 ← ''≡'()'⎕R''⍠'Regex'0⍣≡⍤∩∘'()'
```

1. [Variant](https://aplwiki.com/wiki/Variant) `⍠` - Switch Regex to plain text using `'Regex'0`
2. This allows us to use `⎕R` to search and replace parenthesis without escaping them
3. The same function is then applied. 

### FI

```APL
Fi ← ''≡(⊢(/⍨)¯1(⊢⍱⌽)'()'∘⍷)⍣≡⍤∩∘'()' ⍝ Tacit Version
Fi ← {''≡(({(('()'⍷⍵)⍱(¯1⌽('()'⍷⍵)))/⍵}⍣≡)(⍵∩'()'))}
```

1. `⍣≡⍤∩∘'()'` Step 1,4,5 from RE
2. `'()'∘⍷` Using the [Find](https://aplwiki.com/wiki/find) `⍷` function returns a boolean mask where 1 indicates the start of an set of open and closed parens. 
3. `¯1(⊢⍱⌽)`  Takes the [mask]([Boolean Mask](https://aplwiki.com/wiki/Boolean)) generated in Step 2 `⊢` and [Rotates](https://mastering.dyalog.com/Working-on-Data-Shape.html?highlight=rotate#rotate-vectors) `⌽` it one step `¯1`.  This indicates where the closed parens are.  We want to remove parens with the mask so we are using  [Nor](https://aplwiki.com/wiki/Nor) `⍱`. To retain parens we would use [Or](https://aplwiki.com/wiki/Or)  
4. `⊢(/⍨)`  Use the result of Step 3 to [Filter](https://en.wikipedia.org/wiki/filter_(higher-order_function) "wikipedia:filter (higher-order function)")  the string **t** using [Compress](https://aplwiki.com/wiki/Replicate) `/` We use [Commute](https://aplwiki.com/wiki/Commute) `⍨`  and the [Identity](https://aplwiki.com/wiki/Identity) `⊢` to maintain right to left evaluation becuase this expression is [Tacit](https://aplwiki.com/wiki/Tacit_programming).  This will be more clear if we look at the Dfn version generated by [tacit.help](https://tacit.help/)

7. `''≡`  Step 3 from RE

## **Abusing APL's Parser** 

The APL interpreter can parse paired and unpaired parenthesis and braces and will return an error if unpaired. We can use this in our expressions. 

### ND

```APL
t←'(1 2)×(3+(3÷4))×(1+2)÷8' ⍝ Test Data
Nd ← {0::0 ⋄ (⍎'{} '['()'⍳⍵])/1}
```



1. `⍎'{} '['()'⍳t]`  This is the same process as Step 1 of Di. We are getting the [Index of](https://aplwiki.com/wiki/Index_Of) `⍳` our string **t** and then [Mapping](https://xpqz.github.io/learnapl/indexing.html#bracket-indexing)  the result to open and closed brace `{}` and a blank space.  We then [Execute](https://aplwiki.com/wiki/execute) ⍎ this function.
2. `/1`  [Reduction](https://aplwiki.com/wiki/Reduction "Reduction") `/` over a scaler. Applying a function to a scaler doesn't change the function and will let APL evaluate it. It will return the 1 if it does not error. 
3. `0::0⋄`  [Error Guard](https://help.dyalog.com/latest/#Language/Defined%20Functions%20and%20Operators/DynamicFunctions/Error%20Guards.htm#ErrorGuards) `::` Error numbers 0 and 1000 are catch-alls for synchronous errors and interrupts respectively. [Diamond](https://aplwiki.com/wiki/Statement_separator) `⋄` is a statement Seperator. If the expression from Step 1 and 2 generates an error, its immediately preceding: `0::0` catches it and returns 0.
4. Evaluted on the [Vector Representation](https://xpqz.github.io/cultivations/CodeManagement.html?highlight=vr#visual-representation-vr) - ⎕VR of two Dfns 'turtle' and 'joy'. 

### NP

```APL
Np ← {0::0 ⋄ ⊃∊⍎⍕1,1,¨⍵∩'()'}
```

1. `1,1,¨t∩'()'` We evaulate the set [Intersection](https://aplwiki.com/wiki/Intersection)  `∩` of our string against open and closed parens `()` Then we [Concatenate](https://aplwiki.com/wiki/Catenate) a 1 in front of  [Each](https://aplwiki.com/wiki/Each) `1,¨` character. Then we concatenate a 1 in front of the entire expression.  `1,` 
2. `⊃∊⍎⍕` We then [Format](https://mastering.dyalog.com/Execute-and-Format-Control.html#the-format-primitive) ⍕  the result into a character array. Numeric and nested arrays are converted into vectors or matrices of characters and [Execute](https://aplwiki.com/wiki/execute) ⍎ it. [Flattening](https://xpqz.github.io/learnapl/manip.html?highlight=enlist#ravel-catenate-enlist-member) `∊` any nested arrays and [Picking](https://aplwiki.com/wiki/first) ⊃ the first element which should be the 1 we concatenated to the front in Step 1. 
3. `0::0⋄` we use the same Error Guard as in Step 3 of ND to check for unpaired parenthesis. 

## **Glyphs Used:**

- [Index of](https://aplwiki.com/wiki/Index_Of) `⍳`
- [Bracket Indexing](https://xpqz.github.io/learnapl/indexing.html#bracket-indexing)  [ ]  - Mapping 
- [Mix](https://aplwiki.com/wiki/Mix)  `↑`
- [Merge Axis](https://aplwiki.com/wiki/Rank_(operator)#Merge_axes)  ,⍤
- [Over](https://aplwiki.com/wiki/Over)  `⍥`
- [Enclose](https://aplwiki.com/wiki/Enclose) `⊂` - creates a nested scalar by wrapping its argument under one level of nesting
- [Outer Product](https://aplwiki.com/wiki/Outer_Product) `∘.`  - using a comparison `∘.=`
- [Laminate](https://aplwiki.com/wiki/Catenate)  `⍪` Catenate First - Add a line to a matrix
- [Reduce](https://aplwiki.com/wiki/Reduce) `⌿` Vertical Minus Reduction
- [Bind](https://aplwiki.com/wiki/Bind) `∘`
- [Vector Representation](https://xpqz.github.io/cultivations/CodeManagement.html?highlight=vr#visual-representation-vr) -`⎕VR`
- [Rank](https://aplwiki.com/wiki/Rank_(operator))  `⍤` - applies its left operand function to cells of its arguments specified by its right operand array. 
- [Identity](https://aplwiki.com/wiki/Identity) `⊢`
- [Reshape](https://aplwiki.com/wiki/Reshape) `⍴`
- [Commute](https://aplwiki.com/wiki/Commute) `⍨`  - aka Selfie or Swap
- [Tally](https://aplwiki.com/wiki/Tally) `≢`
- [Each](https://aplwiki.com/wiki/Each) `¨`
- [Scan](https://aplwiki.com/wiki/Scan) `+\`  - Plus Scan
- [Sum](https://aplwiki.com/wiki/Add#Reduction) `+/` - [Reduction](https://aplwiki.com/wiki/Reduction "Reduction") with Add gives the sum of the whole list.
- [And](https://aplwiki.com/wiki/And) `∧` - tests if both arguments are true: it returns 1 if both are true (1) and 0 if one or both are false (0)
- [Nor](https://aplwiki.com/wiki/Nor) `⍱` - tests if neither argument is true: it returns 1 if both are false (0) and 0 if at least one is true (1)
- [Enlist](https://aplwiki.com/wiki/Enlist)  `∊` - Enlist flattens over all layers of nesting
- [Intersection](https://aplwiki.com/wiki/Intersection)  `∩`
- [Match](https://aplwiki.com/wiki/match) `≡`
- [Power Match](https://aplwiki.com/wiki/Power_(operator))  `⍣≡` - Iterating until a fixed point is reached.
- [Atop](https://aplwiki.com/wiki/Atop_(operator)) `⍤` - takes two (monadic) functions and glues them together.  Uses the left operand to process the right

## Regular Expressions

- [Variant](https://aplwiki.com/wiki/Variant) `⍠` - Switch Regex to plain text
- [Find](https://aplwiki.com/wiki/find) `⍷`
- [Rotate](https://aplwiki.com/wiki/rotate) `⌽`
- [Or](https://aplwiki.com/wiki/or) `∨`
- [Compress](https://aplwiki.com/wiki/Replicate) `/` -  Outside of APL, [filter](https://en.wikipedia.org/wiki/filter_(higher-order_function) "wikipedia:filter (higher-order function)") typically provides the functionality of Compress
- [Execute](https://aplwiki.com/wiki/execute) ⍎
- [Diamond](https://aplwiki.com/wiki/Statement_separator) ⋄ - Statement Seperator
- [Format](https://aplwiki.com/wiki/format) ⍕ - Flatten
- [First](https://aplwiki.com/wiki/first) ⊃

## **Concepts Used:**

- [Comparison Function](https://aplwiki.com/wiki/Comparison_function)
- [Dfn](https://aplwiki.com/wiki/Dfn)
- [Tacit Programming](https://aplwiki.com/wiki/Tacit_programming)
- [Boolean Mask](https://aplwiki.com/wiki/Boolean)
- [Reduction](https://aplwiki.com/wiki/Reduce)
- [Fork](https://aplwiki.com/wiki/Train#3-trains)
- [Dfns Workspace](https://aplwiki.com/wiki/Dfns_workspace)
- [Boolean Functions](https://aplwiki.com/wiki/Boolean#Boolean_functions)
- [Logical Conjunction](https://en.wikipedia.org/wiki/Logical_conjunction)
- [Logical Nor](https://en.wikipedia.org/wiki/Logical_NOR)
- [Fork and Atop Problem](https://aplwiki.com/wiki/Train#Problems_caused_by_function-operator_overloading)
- [Regular Expressions](https://xpqz.github.io/cultivations/Regex.html)
- [Intersection](https://en.wikipedia.org/wiki/Intersection_(set_theory))
- [Error Guard](https://aplwiki.com/wiki/Dfn#Error-guards) `::`
- [Performance](https://aplwiki.com/wiki/Performance#Performant_usage)
- [CMPX](http://dfns.dyalog.com/n_cmpx.htm)

## **Reference:**

- [Sixteen APL Amuse-Bouches](http://archive.vector.org.uk/art10501480) - #5
- [Learn Regular Expressions](https://www.regular-expressions.info/)

## **Transcript:**

Hello and welcome to this fourth APL Quest. Check APL Wiki for details. Today's Quest is called 'Keeping Things in Balance'. Here, we take a character vector and it has parentheses in it. We need to check whether the parentheses are balanced, so it looks like a normal mathematical expression, or whether things are wrong. Say we begin with closing parentheses that aren't there, or we end with some open parenthesis. 

Let's get started. Let's start by having a test data just to see how this works. So, we create a character vector, and let's put in some expression there. For example, something like this: okay this is a balanced one. 

And the approach we're going to start off with today is that we're going to find out where the depth of the parenthesis nesting changes, and there are a few different ways we can do that. Then later, we'll move on to actually finding out whether or not the parentheses are balanced or not. 

A very simple approach and a classic one in APL is to convert the input into a normalized form. So, we can look up every character in this test case, the indices of its characters in the open plan and closed paren, and APL does this that if an element isn't found in a lookup array, then we get the next index. So, one and two are the open and close, and three is any character which wasn't found. 

Now, we need to map these to indicate when the parenthesis level changes. So, and we use this to index into a vector and we say when we have open parenthesis, then we increase the parenthesis level; when we have a closing pan, then we decrease the parenthesis level; and any other character we map to zero, as it doesn't affect the level. 

Let's stack this together with original input. So, we're going to mix the concatenation of the enclosures with the original, and we can see how when we have open parenthesis the parenthesis level increases, closing parenthesis decreases, and any other character leaves the parenthesis level unaffected. 

We can make this into a function. Let's call this the parenthesis depth changes using indexing, and so it's going to take this formula. But there are other ways that we can do this. We can in a similar manner, but instead of lookup, we can do a comparison. 

If we take the character vector consisting of these parentheses and do an outer product with the characters here, we get a table and we can do the same trick as before to stack up on top and we can see here that the first row of this Boolean matrix indicates whenever the parenthesis level increases and the second row indicates when it decreases, and then the other row is of course zero. 

Then we can do this clever thing that we can subtract the bottom row from the top row. The top row minus the bottom row, that's a vertical minus reduction, and that gives us the same thing. Now we need to stack them on top of each other. Now we get the same thing as before. So, this is a different way of doing it, and we can call this the parentheses depth changes using the outer product over outer product.

So we can even do this as a tacit function because it's so simple and the argument is just the identity right there. But there are more ways we can do this. We can also do the two comparisons each by themselves. So let's say we take the comparison to the left parenthesis and the comparison with the right parenthesis and put them next to each other. That gives us these two vectors. We could of course stack them on top of each other and then we get just like the other product. 

But since we're going to subtract them from each other we can just put the minus in between and that gives us the parenthesis depth changes right away. We can give this a name and we can again make it into a tested function because it's really simple. So we can and it looks very nice as well symmetric like this. 

So we can bind this to equal making equal equals and left parenthesis in a magnetic function and subtract the same thing. We can put the because equal is computed so we can put the argument on either side. I'd like to put it like this because it looks really cool. So this is the depth using a fork with the two outer tines equality to the two parenthesis and then subtracting the two from each other.

Now this is on a tiny little test case. Let's get some real data that we can try this on and then let's do some performance comparison before we move on to the second part of the problem because we haven't solved the whole thing yet. We need to find out are they balanced or not. So for that, I'm going to copy in some functions from the defense workspace and we're not going to use these functions other than just their source as example data. So there's a turtle function, there's a joy programming language interpreter, and then we need the comparison and performance comparison as well. We copy those from defense right and they are large functions. 

These turtle enjoy but not really large enough, so let's create some data. We have some data. I know that turtle has parentheses that are well balanced and joy has parenthesis that are not well balanced. I looked that up before. So this gives us these two test cases. Let's call it yes and no and whether or not they are balanced. I'm going to take the source code of each one so the vector representation of each of turtle turtle and joy and then I'm going to make them a little bit bigger so we're going to take that source code and reshape it using 100 times its current shape and this gives us some large test data. We can see here that y is a bit of a million and n is a couple of million so now we can compare them.

But instead of typing out the expressions with these three different functions let's use an apl expression to generate the expressions that we're going to time a little bit of meter programming here. So every function begins with a d and we concatenate that to each of these suffixes i o and f and then we concatenate each of those to the entire argument y so this gives us these three expressions and we can run cmpx on those and we can see that the df the one that just that is the fork just compares it to one parenthesis and the other parenthesis and subtracting them is by far the fastest one for these cases. And what if we do it on something that isn't balanced and again interestingly enough here the i and the o are approximately the same speed but df still wins out. So this is the first part of the problem determining when the parenthesis level changes goes up and down.

Next, we're going to use this to compute whether or not they're actually balanced or not. So we can use df that was the fastest one on our test case that gives us these ones and zeros and now we have to think about what does it mean that it's balanced. So there really two things to it, one is that when the whole input is finished when we reach the end we have to reach down to parenthesis level zero and when we go along we're never allowed to dip below zero because that would mean that we have closed more parenthesis than we have opened. 

So we want the running total of the parenthesis depth, that's very simple we can do that with a scan and this is then the parenthesis depth. And we also want to know what is the left element whether or not it is zero, that would be the sum of them and that's zero. So now we can just put together these two conditions, the first condition being that it is always true, it's true for all that they are greater than or equal to zero in the running sum and also it has to be true that 0 equals the full sum. Let's give this a name and we'll call it ba because we're using this and condition. Both this condition has to be true and this condition has to be true.

But we can also do it a different way, a little bit more succinct at least the first part. If we're saying it has to be all true, that's the end reduction that all of the elements have to be greater than or equal to zero. Now the parenthesis level can only change by one step at a time, there's no double open parenthesis there's only single open parenthesis and they can only go down one level. 

So the first condition which is to check that we never reach a negative level, it would have to pass negative one in order to become negative. It might continue further on but it's a sufficient check to see whether or not we have any negative ones. 

So we can say negative one is a member of the running sum means it's invalid and the second and then so now we're doing it in reverse we're using a negative conditions and similarly we have to say that 0 is different from the sum. These are things that are not allowed to be present and therefore if neither of them are present then our expression is well balanced. So instead of having an and we have to use a nor so we can call this balanced using nor.

Let's compare the performance of these two and similarly we can create the expressions that we want. So we start off with ba and bn we could we can just spell it out since the only two of them bn and each one of them concatenated to the entire yd here so we have we haven't assigned this yet we should go up and assign this so this is the depth for y and we should do the depth fun for n as well and then we can get these two expressions and cmpx on that and yeah it's about the same. 

You can do the same thing for the nose and that's a bit faster and we can probably reason our way for that because in ba we did the comparison of everything in the running sum and then we check whether they're all true whereas in bn we're not doing any comparisons and for we're not doing comparisons for all of the elements we just start looking for negative one and as soon as we hit any negative one we're done. So the membership function will just terminate right there it doesn't have to look through the entire array so in some cases that can be faster and so here bn in some cases can be faster than ba. And that means we can potentially put together a whole solution here based on these.

Then we can get these two expressions and cmpx on that and yeah it's about the same you can do the same thing for the nose and that's a bit faster and we can probably reason our way for that because in ba we did the comparison of everything in the running sum and then we check whether they're all true. 

Whereas in bn we're not doing any comparisons and for we're not doing comparisons for all of the elements we just start looking for negative one and as soon as we hit any negative one we're done so the membership function will just terminate right there it doesn't have to look through the entire array so in some cases that can be faster and so here bn in some cases can be faster than ba and that means we can potentially put together a whole solution here based on these.

We take the dfn from before and supply its results to bn, which should give us the answer. We can do f on each of y and n, which should give it one and zero, and that worked. We can also spell it out.

We can improve performance by breaking out the scan and picking out the right element from this scan, the cumulative sum, instead of using a new reduction. We break out the scan and glue these together with a bind operator. This is bns. We compare bn and bns, each one concatenated to the yd, and got a bit of a speed up. We can try it again with nd as well, and got a bit of a speed up there again.

We can put all of this together and have a final solution. We define f and take the definition from b and s. We apply this function, which is a fork, and then we want to apply this function, which is at a top. We have a fork as the right part, with two comparisons, and the scan of the subtraction as the middle part. This gives us the results.

As an alternative solution, we can use regular expressions. We start off by applying the function of intersection with the parenthesis, and then write a regular expression. We apply this on our test case and remove the parentheses. We do this until there are no more changes, and if the result is an empty character vector, that means it's balanced. We can also use quad r, a feature added to apl, which is for replacements of plain text. We switch regex off and now we don't need to escape the parentheses anymore because now it's just plain text replace from these two parentheses to nothing so let's call this well it's not really regular expressions anymore it's replace but well no regex i guess.

We can try implementing the method we are thinking of in APL and that could give better performance. To find the open and close parenthesis, we can use the find function. We need to remove all characters that are not parentheses first and compare it with an empty character vector. We can do a rotate so we can do both the mask that we just computed and OR when it's rotated one step and this indicates both the opening and the closing parentheses. We can flip the OR to a NOR and this gives us a mask indicating just the characters we want to keep. 

We can put all of this together, and use the find function to get a one and zero. We don't need to repeat the process of removing the parentheses, but instead, we need to repeat squeezing away the open and close parentheses. We can do the same thing with powermatch and then compare it to an empty character vector. 

We can put it all together and glue this together again. This is using find. We can try to compare the performance of these. We have RE and RE0 and FI and we're comparing them to Y and N. We can see that the regular expression engine is very heavy weight, and it's much faster to do it either with replace without regex or implementing it ourselves. 

Finally, we can kind of circumvent the problem, because the same kind of parenthesis matching is happening in mathematics and programming languages as well. We can leverage this and use the same thing when APL evaluates an expression. We can start off using the braces and doing the same mapping as before. 

We can wrap this in a DFN, put in an error guard, and if we don't get an error, we need to apply this function in a way that won't error. We can take this function and reduce over a scalar or one element vector, and APL will never actually use the function. 

Finally, we can use the nesting depth of parentheses and use a stranding of parenthesis to try and parse the expression. We can flatten it in case it's nested, and see whether or not that works. 

These are just some fun solutions of abusing the system.

Thank you very much for watching
