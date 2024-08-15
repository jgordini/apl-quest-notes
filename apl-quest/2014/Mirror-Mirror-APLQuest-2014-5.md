# [Mirror Mirror 2014-5](https://apl.quest/psets/2014.html?goto=P5_Mirror_Mirror)

**Problem:** A palindrome is a word or phrase whose letters read the same forwards and backwards. Write a dfn which returns a 1 if its character vector argument is a palindrome, 0 otherwise. For simplicity’s sake, you may assume that the vector is all one case.

**Video:** [https://www.youtube.com/watch?v=cPzQr2aJ7e4](https://www.youtube.com/watch?v=cPzQr2aJ7e4)

**Code:** [https://github.com/abrudz/apl_quest/blob/main/2014/5.apl](https://github.com/abrudz/apl_quest/blob/main/2014/5.apl)

Today's quest is the fifth problem from the 2014 round of the APL Problem Solving Competition. The task is to determine whether a given text is a palindrome. A slight complication is that we need to ignore case differences and punctuation.

### Test Data

To illustrate our solution, we can start with some test data. We need to ensure that case differences are removed so that, for example, the first 'A' and the last 'A' in "Panama" match each other. To achieve this, we can use the `quad c`, which is case fold.

Next, we will sort out the characters we need to compare and eliminate any that we do not wish to consider. Let's put this into a function to process the data. An example of such a function is:

```apl
A←{c←⎕C⍵ ⋄ l←c/⍨c∊⎕C⎕A ⋄ l≡⌽l}
```

Here, we apply the process to ensure we filter by characters that are members of the case-folded alphabet.

The last step is to see if the letters match themselves when reversed. For example, "A man, a plan, a canal: Panama" is a palindrome, whereas "Hello World" is not.

### Optimizing the Process

While our initial method works, we can simplify the process with a few key observations.

Firstly, filtering by membership is the same as performing an intersection. Therefore, instead of pre-processing both arguments with case folding, we can just case fold one—the alphabet.

This helps avoid unnecessary case folding on potentially large arguments. However, we must be cautious, as this means we only get lowercase letters; thus, we can supplement our alphabet with uppercase letters as well. This is a one-time operation when defining the function and helps us optimize the intersection. An example of this optimized approach is:

```apl
A←≡∘⌽⍨∩⍥⎕C∘⎕A      ⍝ tacit
B←≡∘⌽⍨∩∘(⎕A,⎕C⎕A)  ⍝ avoid case folding argument
```

### Exploring Ranges

Another approach we can take is to compare Unicode character ranges instead of calculating intersections. All uppercase letters in Unicode and ASCII are contiguous, as are lowercase letters. By examining the values at the beginning and end of both cases (65 to 90 for uppercase and 97 to 122 for lowercase), we can determine which characters fall within these intervals.

We'll use an interval index to filter characters, and we can simplify this by utilizing the properties of character ranges. For instance, we can express this as:

```apl
D←{≡∘⌽⍨32|u/⍨((65∘≤∧≤∘90)∨(97∘≤∧≤∘122))u←⎕UCS⍵}
```

Finally, we will proceed to test for palindromes as before, but with the added benefit of avoiding constant rechecking of case-folding characters.

### Performance Considerations

One important aspect to consider is the performance implications of our approach. By starting with raw code points, especially when all characters are ASCII, we can optimize our processing. We wouldn't need to check every character for case folding repeatedly, which can be expensive.

Using ranges, we can efficiently filter the characters we are interested in and conduct our palindrome checks on these values. For performance testing, we can create larger test data sets like:

```apl
t←(70↑⎕A,⎕C⎕A,',.!?')[?1e5⍴70]
```

### Creating Test Data

We need to create some test data similar to natural text, which might include uppercase and lowercase letters along with punctuation. For a palindrome, we can self-concatenate half of our data to create a valid example by reversing one half and attaching it to the other.

```apl
p←,∘⌽⍨(70↑⎕A,⎕C⎕A,',.!?')[?5e4⍴70]
```

And measure performance using:

```apl
cmpx 'ABCD',¨⊂' t'
cmpx 'ABCD',¨⊂' p'
```

### 

### Conclusion

Through this exploration, we learned various methods to detect palindromes, optimizing for performance and efficiency. By considering both case sensitivity and character ranges, we have developed a robust solution.

Thank you for reading!

# Transcript

Here is the content rewritten in paragraphs, without summarizing or truncating:

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
