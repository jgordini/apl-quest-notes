# [Mirror Mirror 2014-5](https://apl.quest/psets/2014.html?goto=P5_Mirror_Mirror)

**Problem:** A palindrome is a word or phrase whose letters read the same forwards and backwards. Write a dfn which returns a 1 if its character vector argument is a palindrome, 0 otherwise. For simplicity’s sake, you may assume that the vector is all one case.

**Video:** [https://www.youtube.com/watch?v=cPzQr2aJ7e4](https://www.youtube.com/watch?v=cPzQr2aJ7e4)

**Code:** [https://github.com/abrudz/apl_quest/blob/main/2014/5.apl](https://github.com/abrudz/apl_quest/blob/main/2014/5.apl)

In this article, we'll explore different methods to detect palindromes using APL (A Programming Language). We'll start with simple solutions and gradually optimize them for better performance. The goal is to create a function that returns 1 if the input character vector is a palindrome, and 0 otherwise.

## 1. Basic Intersection Method

Let's start with a simple approach using intersection:

```apl
A←{c←⎕C⍵ ⋄ l←c/⍨c∊⎕C⎕A ⋄ l≡⌽l}
```

This function does the following:
1. Case-folds the input (⎕C⍵)
2. Keeps only the letters (c/⍨c∊⎕C⎕A)
3. Compares the result with its reverse (l≡⌽l)

We can simplify this into a tacit (point-free) function:

```apl
A←≡∘⌽⍨∩⍥⎕C∘⎕A
```

This version uses the intersection (∩) of the case-folded input with the case-folded alphabet.

## 2. Optimized Intersection Method

To avoid case-folding the entire input, which can be expensive for large strings, we can modify our approach:

```apl
B←≡∘⌽⍨∩∘(⎕A,⎕C⎕A)
```

This version intersects the input with both uppercase and lowercase alphabets, potentially saving time on large inputs.

## 3. Range-based Method

Another approach is to use character ranges instead of set operations:

```apl
C←{≡∘⌽⍨⎕C⍵/⍨2|'A[a{'⍸⍵}
```

This function:
1. Uses interval index (⍸) to check if characters are in the ranges A-Z or a-z
2. Uses division remainder (2|) to keep only letters
3. Case-folds and compares with reverse

We can also write this as a tacit function:

```apl
C←≡∘⌽⍨∘⎕C⊢⊢⍤/⍨2|'A[a{'∘⍸
```

Or even more concisely:

```apl
C←⊢≡∘⌽⍨∘⎕C⍤/⍨2|'A[a{'∘⍸
```

## 4. Unicode Code Point Method

For potentially better performance, we can work directly with Unicode code points:

```apl
D←{≡∘⌽⍨32|u/⍨((65∘≤∧≤∘90)∨(97∘≤∧≤∘122))u←⎕UCS⍵}
```

This function:
1. Converts the input to code points (⎕UCS⍵)
2. Keeps only the code points in the ranges 65-90 (A-Z) and 97-122 (a-z)
3. Uses division remainder by 32 to normalize case
4. Compares with reverse

## Performance Comparison

To compare the performance of these methods, we can use the `cmpx` function from the `dfns` workspace:

```apl
'cmpx'⎕CY'dfns'
t←(70↑⎕A,⎕C⎕A,',.!?')[?1e5⍴70]  ⍝ Non-palindrome test data
p←,∘⌽⍨(70↑⎕A,⎕C⎕A,',.!?')[?5e4⍴70]  ⍝ Palindrome test data

cmpx 'ABCD',¨⊂' t'  ⍝ Test with non-palindrome
cmpx 'ABCD',¨⊂' p'  ⍝ Test with palindrome
```

The results show that:
1. Method B (optimized intersection) is faster than method A (basic intersection)
2. Method C (range-based) doesn't offer significant improvement
3. Method D (Unicode code point) provides the best performance in most cases

## Conclusion

We've explored several methods for palindrome detection in APL, ranging from simple set operations to more complex code point manipulations. While the simpler methods are easier to understand and implement, the more complex methods can offer significant performance improvements, especially for large inputs.

When choosing a method, consider the trade-off between code simplicity and performance based on your specific use case. For small inputs or infrequent operations, the simpler methods may be sufficient. For large-scale or performance-critical applications, the code point method (D) might be the best choice.

## Glyphs Used
- [Case Fold](https://aplwiki.com/wiki/Case_Fold) (⎕C)
- [Reverse](https://aplwiki.com/wiki/Reverse) (⌽)
- [Match](https://aplwiki.com/wiki/Match) (≡)
- [Intersection](https://aplwiki.com/wiki/Intersection) (∩)
- [Self-Reference](https://aplwiki.com/wiki/Self-Reference) (⍨)
- [Over](https://aplwiki.com/wiki/Over) (⍥)
- [Alphabet](https://aplwiki.com/wiki/Alphabet) (⎕A)
- [Replicate](https://aplwiki.com/wiki/Replicate) (/)
- [Membership](https://aplwiki.com/wiki/Membership) (∊)
- [Catenate](https://aplwiki.com/wiki/Catenate) (,)
- [Interval Index](https://aplwiki.com/wiki/Interval_Index) (⍸)
- [Residue](https://aplwiki.com/wiki/Residue) (|)
- [Atop](https://aplwiki.com/wiki/Atop) (⍤)
- [Right](https://aplwiki.com/wiki/Right) (⊢)
- [Less Than or Equal To](https://aplwiki.com/wiki/Less_Than_or_Equal_To) (≤)
- [And](https://aplwiki.com/wiki/And) (∧)
- [Or](https://aplwiki.com/wiki/Or) (∨)
- [Unicode Convert](https://aplwiki.com/wiki/Unicode_Convert) (⎕UCS)

## Concepts
- [Dfn](https://aplwiki.com/wiki/Dfn)
- [Tacit Programming](https://aplwiki.com/wiki/Tacit_programming)
- [Case Folding](https://aplwiki.com/wiki/Case_Fold)
- [Set Operations](https://aplwiki.com/wiki/Set_theory)
- [Character Ranges](https://aplwiki.com/wiki/Character)
- [Unicode Code Points](https://aplwiki.com/wiki/Unicode)
- [Function Composition](https://aplwiki.com/wiki/Function_composition)
- [Self-Reference](https://aplwiki.com/wiki/Self-Reference)
- [Scalar Function](https://aplwiki.com/wiki/Scalar_function)
- [Reduction](https://aplwiki.com/wiki/Reduce)
- [Scalar Extension](https://aplwiki.com/wiki/Scalar_extension)
- [Left and Right Arguments](https://aplwiki.com/wiki/Argument)
- [Performance Optimization](https://aplwiki.com/wiki/Performance)
- [ASCII Ranges](https://en.wikipedia.org/wiki/ASCII)
- [String Manipulation](https://aplwiki.com/wiki/String)
- [Boolean Operations](https://aplwiki.com/wiki/Boolean_function)
- [Character Set Manipulation](https://aplwiki.com/wiki/Character)
- [Palindrome](https://en.wikipedia.org/wiki/Palindrome)
- [Case-Insensitive Comparison](https://aplwiki.com/wiki/Case_Fold)


# Transcript
Welcome to the APL Quest CAPL wiki for details. Today's quest is the fifth problem from the 2014 round of the APL Problem Solving Competition. It's a pretty simple problem - we're just to find out whether a given text is a palindrome. A slight complication is that we need to make sure to ignore things like case and punctuation. Let's start with some test data.

Okay, so we need to get rid of case differences so that, for example, the first 'A' and the last 'a' in "Panama" match each other, and we can use ⍵C which is case fold for that now. And we just need to sort out the characters that we need to compare and get rid of those that we don't want to look at at all. One way we can do this is let's put this into a function so we can try this. This is the case folded one, and then we should look which characters are members of the case folded alphabet. Of course, it should be ⍵ here. There we go.

And then we can filter by that boolean vector. Let's call this just the letters. The last step is to see if the letters match themselves when they are reversed. We can see that "A man, a plan..." and so on is a palindrome, whereas "Hello world" is not. This works, but we can do it a little more elegantly by making some observations about what we've got here.

Firstly, filtering by membership is the same thing as intersection, so we can actually substitute this whole thing in and say then the intersection between the case folded argument and the case folded alphabet. Notice that we are applying intersection after preprocessing both arguments with case folding. This calls ∩ over. Finally, we are comparing this L to its reverse, an operation between the identity of some value and some pre-processed value, and that we could call that a hook construct.

But really, what is another way to think about it is that we are applying the match function between L and L ⌽ on itself. So that means we're doing a selfie, only that before we apply match, we preprocess the right argument of match with reverse. And then, since we're only using this variable once, there's really no point in assigning it, so we can just put it inline.

There's also possibility of making this a fully tacit and function. It's quite simple here because we just have a dyadic function applied between the argument and a constant, and then we apply another function monadically on that. So clearly this whole thing is in the top one thing applied and another thing applied, only that we have here a dyadic function where the one argument is constant. So we can bind the alphabet as a constant right argument to it, and that gives us a very neat tacit solution. Let's call this A.

It does have, however, a little bit of a performance issue, namely that we are case folding a potentially very large argument. All we need to do is we want to see to only keep those characters which are uppercase and lowercase letters, and the whole reason we're case folding the whole argument is just so that we can take the intersection with the letters. Now the input might be of an unknown size, but the alphabet is of a known size, and so we can optimize this a little bit by simply keeping the intersection but instead of case folding both arguments, we only case fold the alphabet.

Now this is a problem of course because this only gives us lowercase letters and that we might also have uppercase letters, so let's just supply the uppercase letters as well. This is a one-time operation when we define the function, generating an uppercase and lowercase alphabet, and then we just do the intersection on that. So that might save us from doing the case folding on the entire argument, and that might speed up things a little bit.

So these are the basic solutions, but we could actually go a whole different route, and that is to compare ranges. Instead of looking for intersection which is a set function, we can look at where in the Unicode character set do the characters fall, because all the uppercase letters are contiguous and all the lowercase letters are also contiguous in Unicode and ASCII. And so if we look at the values for the beginning of the uppercase alphabet, the end of the uppercase alphabet, and also the beginning of the lowercase alphabet and the end of the lowercase alphabet - oops, sorry, we need an each there.

Okay, so we can see from 65 to 90, from 97 to 122. Now interval index is what we're going to use for looking up ranges, and it is inclusive on the left and the beginning and exclusive on the end, so we need to go one up at the end. And then we can look at what those characters are. So these are the characters that we want to use for cutoffs, and so we can see that some characters fall inside this interval here. That's number one between these two, and then zero is before the first one, and then some fall over here, and then there might also be something that falls in punctuation. The force here, but that's pretty rare.

Which means that it's every other interval which we want. If it's zero, it's outside, we don't want it. If it's one, it's an uppercase letter. If it's two, it's lowercase. If it's three, it's some punctuation, and if it's four, then it's beyond the lowercase and small punctuation that we don't want. So we can take the division remainder when dividing by two, and that gives us a one for all the odd ones, which is exactly where we have uppercase and lowercase letters, and that is what we need to use to filter with.

So that's another way of doing the filtering, and then we can apply the actual palindromic testing as we've done before. Oops, and we've of course been missing the case folding. That's once we're done with that. There we go. Let's call this C. Actually, we can make this one and test it as well. Before we give it a name, let's just try that.

So there's an interesting problem here with the slash, which is a hybrid operator function. We can begin by fixing that within a top, and then we have a dyadic function with a constant left argument, so we can just bind that over here. And then we have the argument over here, case folding, and then comparison. So we could write all of it like this. See, but since we are anyway post-processing the result from the replicate or compress here, then we don't actually need to use an identity function to do with the top to force it to be a function. We could take this whole thing and move it in here as well. So let's call this C.

But this whole business of case folding and that means that you need to consider every character whether that needs to be case folded, that is potentially expensive. And if we can operate on raw code points, we might get a significant performance advantage. Now how is that going to work?

So if we start immediately by converting all the characters to code points, if they are all ASCII, then that's really cheap because that means we can - because the code points are essentially unsigned byte values, on-site integers. If there are some characters that are outside of ASCII, then we'll end up having values larger than 127, and we'll have to go to two-byte integers because the integers internally are signed. But still, it's going to be pretty cheap operation to switch to code points like this.

And then we need to check whether they are in this range that we used before, and we can write this in a tacit way that I really like for ranges. So there are two ranges we're looking at, and we want to know if it's in either those ranges. And so the way we can - APL doesn't allow you to write X or something like A≤X≤B because ≤ is just a function and it would bind wrong, but we can write that 65 is less than or equal to and the value is also less than or equal to 90. So that's the upper bound, and this kind of reads nicely, right? 65 is less than or equal to and it's less than equal to 90. So that's the uppercase, and then lowercase is 97 is less than or equal to and it's less than or equal to 122.

So this, I like writing ranges in APL like this. So this again gives us the elements that we're interested in, and then we need to use that to filter. But we're not filtering the characters now, we are filtered because then we need to case fold. We're filtering the code points. So we give this a name U, and then we'll filter U with that, and that gives us all these values.

Now it might not be easy to see what's going on here, but if we just temporarily apply ⎕UCS to it, we can do each again, then we can see all letters that we're interested in. Now here's the thing: ASCII, and then by extension Unicode because it's just a superset, is constructed in such a way that there's a single bit difference between uppercase and lowercase. And that means that we can do a division remainder with 32, and that, since we're not - it doesn't matter that there are many other values that would collapse to the same division remainder with 32 because we only look at uppercase and lowercase letters.

So anything we need to do to know is like the offset from the beginning of the alphabet, and 32 gives us exactly that. Now these aren't useful byte values, but we're not interested in byte values. We're just interested in these - should we say labels on the characters and see if they are the same. And then we can check using the exact same thing as before whether or not we've got a palindrome. So by working on code points, the code is significantly more involved, but we might potentially avoid some expensive operations there.

Okay, let's have a look at the performance. We're copying CMPX from dfns, and then we're going to - we need to create some test data of course. So let's create some test data. Say we overtake from the uppercase and the lowercase alphabet, much like we did - we let the application look alphabet before - followed by a little bit of punctuation that might happen there. So because this adds up to much less than 70, that means we'll get some spaces as well. So it kind of looks like natural text, and there are obviously 70 here. And let's just do 50 of them for now just to see what this looks like.

So this kind of looks like natural text with a little bit of punctuation there. It's not really very important. And so let's - so this is a case. So let's put it over here. 1E5 should be enough. And then - so this isn't obviously a palindrome, but we can create one that is a palindrome, and we can do that simply by - let's take half of this. So this is 5E4, and then we can just - so it's the same kind of construct. This is the hook contrast. We are self-concatenating it, and then we are reversing it and before we concatenate one of them. So this concatenated to its reverse could be read as competition. It's reversed, and this is obviously a palindrome.

And now we can say CMPX on A, B, C, and D, each one of them with the entire argument of T. So this is on a non-palindromic case, and we can see that our solution where we avoid case folding the input instead of having a both application lowercase alphabet for the intersection, that did save us significantly. And doing the intervals with raw characters, that's not worth it. However, switching to code points gives us a significant speed up in this case. And we can just, for good measure, try this with the palindrome as well. We'll probably see similar results. Yeah, that looks very much the same.

So that's all for checking for palindromes. Thank you for watching.
