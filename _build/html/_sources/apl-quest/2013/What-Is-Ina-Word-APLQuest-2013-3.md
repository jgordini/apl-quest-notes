# [What's in a Word 2013-3](https://problems.tryapl.org/psets/2013.html?goto=P3_What_Is_In_a_Word)

**Problem:** Write a dfn which returns the number of words in the given character scalar or vector.

**Video:** [https://youtu.be/MgkM2qCPWas](https://youtu.be/MgkM2qCPWas ) 

**Code:** [https://github.com/abrudz/apl_quest/blob/main/2013/3.apl](https://github.com/abrudz/apl_quest/blob/main/2013/3.apl)

This problem is based on the third challenge from the 2013 round of the APL Problem Solving Competition. The task is to create a function that can accurately count the number of words in a given text, where a word is defined as being space-delimited. The function should handle various edge cases, including multiple spaces between words, leading and trailing spaces, single-character inputs, and empty inputs.

## Test Data

Let's begin by creating some test data. We'll use a normal text with a dash to ensure we're splitting on the right thing, a single letter, an empty input, and a text with more spaces to test leading and trailing spaces.

```apl
s←'hyphen-dash string'
l←'x'
e←''
m←'  more spaces   go here '
```



## Example Solutions

### Solution F: Splitting on Sequences of Spaces

Let's start by comparing an input string with a space. This gives us a Boolean vector indicating where the spaces are. The [Partition](https://aplwiki.com/wiki/Partition) function groups runs of ones or elements corresponding to runs of one. We want to invert this and then use it to split. By using Partition on the string itself, we get the individual words, which we can then count.

```apl
F ← ≢' '∘≠⊆, ⍝ Tacit - binding the space to the not equal to make monadic. {≢((' '≠⍵)⊆(,⍵))}
```

1. `' '=s` [Equal To](https://aplwiki.com/wiki/Equal_to) compares arrays one [element](https://aplwiki.com/wiki/Element) at a time. Returns a boolean vector of 1 for match and 0 for no-match.

2. ```APL
   ' '=s ⍝ 'hyphen-dash string'
   0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0
   ```

3. `⊆` [Partition](https://aplwiki.com/wiki/Partition) splits on the 0s when the left argument is boolean. So we use [Not equal to](https://aplwiki.com/wiki/Not_Equal_to) `≠⊆` to create runs of 1s.

4. `⊆` Partition also requires an axis. So to use a [Comparison Function](https://aplwiki.com/wiki/Comparison_function) on a scalar, we must [Ravel](https://aplwiki.com/wiki/Ravel) `⊆,` first.

5. `' '∘≠` We [Bind](https://aplwiki.com/wiki/Bind) the space to the Not equal to to achieve a monadic function.

6. `≢` Lastly, we [Tally](https://aplwiki.com/wiki/Tally) to count the number of major cells or items.

### Solution G: Using Regular Expressions

If you come from other programming language backgrounds, especially Perl, you might reach for regular expressions for this task.

```apl
G ← ≢'[^ ]+'⎕S 3
```

1. Use [Regular Expressions](https://xpqz.github.io/cultivations/Regex.html). You can use [regexr.com](https://regexr.com/) to evaluate.

2. `⎕S` [String Search](http://help.dyalog.com/18.0/index.htm#Language/System%20Functions/r.htm) - The Regex will be enclosed in single quotes

3. `[^ ]+`  Regex matches anything that is not a space

4. The `3` option is a [Transformation Code](http://help.dyalog.com/18.0/index.htm#Language/System%20Functions/r.htm) and  tells `⎕S` to return a zero for each pattern which matched the regex (always 0 in this case, as there's only one regex). 

5. ```APL
   ⍝ Our Example
   ('[^ ]+'⎕S 3) 'hello 123 world'
   0 0 0
   ⍝ Returns a 0 for each patern match (word).
   
   ⍝ Example with two Regex
   ('[aeiou]' '[0-9]' ⎕S 3) 'hello 123 world' 
   0 0 1 1 1 0
   ⍝ e and o match in hello
   ⍝ 123 match in 123
   ⍝ o matches in world. 
   ```
   
6. In our case this produces a vector of 0s, one for each word in the input.

7. [Tally](https://aplwiki.com/wiki/Tally) to count the number of 0s (words)

### Solution H: VFI

Here's an interesting solution that abuses a built-in functionality, a system function called VFI (Verify and Fix Input).

```apl
H ← ≢∘⊃⎕VFI
```

1. `⎕VFI` - [Verify and Fix Input](https://xpqz.github.io/cultivations/Constants.html?highlight=fix%20input#verify-and-fix-input-vfi) - attempts to convert each of these string fields into a number, producing two vectors as output:

   - A boolean vector indicating success or failure of conversion for each field.
   - A numeric vector containing the converted values (or 0 for failed conversions).
2. Example:

   ```APL
   ⎕VFI '1e3 three 2.5 2..5'
   ┌───────┬────────────┐
   │1 0 1 0│1000 0 2.5 0│
   └───────┴────────────┘
   ```

3. `⊃` - Monadic [Pick](https://xpqz.github.io/learnapl/indexing.html?highlight=first#pick) picks the first element. In this case, the first vector.
4. `≢∘⊃` - [Bind](https://mastering.dyalog.com/Tacit-Programming.html?highlight=bind#binding) When we use the operator _bind_, we create a single derived function that is monadic. That way, we can give it a name.

## Using Boolean Masks

1. ### Solution I

   ```apl
   I ← {+/2</' '≠' ',⍵}
   ```

   1. `' ',⍵`: [Catenate](https://xpqz.github.io/cultivations/Functions7.html#catenate) a space to the beginning of the input.
   2. `' '≠`: Create a [Boolean Mask](https://aplwiki.com/wiki/Boolean) where 1 (true) represents non-space characters.
   3. `2</`: Use a 2-wise [Reduce](https://aplwiki.com/wiki/Reduce) to compare adjacent elements. This is true only when we transition from 0 (space) to 1 (non-space).
   4. `+/`: Sum the results using Plus [Reduction](https://aplwiki.com/wiki/Reduce) to count the number of words.

   ### Solution J

   ```apl
   J ← {+/2</0,' '≠⍵}
   ```

   1. `' '≠⍵`: Create a Boolean Mask where 1 represents non-space characters.
   2. `0,`: [Catenate](https://xpqz.github.io/cultivations/Functions7.html#catenate) a 0 to the beginning of the mask for performance.
   3. `2</`: Apply a 2-wise [Reduce](https://aplwiki.com/wiki/Reduce) to find transitions from 0 to 1.
   4. `+/`: Sum the results to count the words.

   ### Solution K

   ```apl
   K ← {(⊃m)++/2</m←' '≠,⍵}
   ```

   1. `' '≠,⍵`: Create a Boolean Mask for non-space characters.
   2. `m←`: Assign the mask to variable `m`.
   3. `⊃m`: Take the [First Element](https://aplwiki.com/wiki/first) of the mask.
   4. `2</m`: Apply 2-wise [Reduce](https://aplwiki.com/wiki/Reduce) to find word beginnings.
   5. `+/`: Sum the results of the reduce.
   6. `(⊃m)+`: Add the first element to the sum, accounting for a word at the start.

   ### Solution L

   ```apl
   L ← {+/2</1,⍨' '=⍵}
   ```

   1. `' '=⍵`: Create a Boolean Mask where 1 represents space characters.
   2. `1,⍨`: Use [Swap](https://aplwiki.com/wiki/Commute) to append 1 to the end of the mask.
   3. `2</`: Apply 2-wise [Reduce](https://aplwiki.com/wiki/Reduce) to find transitions from 1 (space) to 0 (non-space).
   4. `+/`: Sum the results to count the words.

## Performance Comparison

We can evaluate the performance of each function by importing the [CMPX](http://dfns.dyalog.com/n_cmpx.htm) function from the [DFNS](http://dfns.dyalog.com/n_contents.htm) library.

```apl
t←'abc '[?1e6⍴4] ⍝ Interesting use of bracket index to generate random words array
'cmpx'⎕cy'dfns'
cmpx'F t' 'G t' 'H t' 'I t'
```

1. Using the 4 characters `'abc '` (abc and space).
2. We use [Bracket Indexing](https://xpqz.github.io/learnapl/indexing.html#bracket-indexing) `[]` to randomly `?` pick one of the 4 characters a million `1e6` times.
3. [Reshape](https://aplwiki.com/wiki/Reshape) ⍴ is being used to limit the index to 4.
4. We can then [copy](http://help.dyalog.com/latest/Content/Language/System%20Functions/cy.htm) `⎕cy` CMPX from the DFNS library into our workspace.
5. We use cmpx to evaluate the performance of each function, with the first function as our baseline.

## Glyphs Used:

- [Not equal to](https://aplwiki.com/wiki/Not_Equal_to)

- [Partition](https://aplwiki.com/wiki/Partition) - Uses ones to Partition

- [Tally](https://aplwiki.com/wiki/Tally)

- [Bind](https://aplwiki.com/wiki/Bind)

- [String Search](http://help.dyalog.com/18.0/index.htm#Language/System%20Functions/r.htm) - ⎕S

- [Verify Fixed Input](http://help.dyalog.com/18.0/index.htm#Language/System%20Functions/vfi.htm?Highlight=Verify%20and%20Fix%20Input) - ⎕VFI

- [First](https://aplwiki.com/wiki/First)

- [Reduce](https://aplwiki.com/wiki/Reduce) - Pair wise and plus reduction

- [Ravel](https://aplwiki.com/wiki/Ravel) - adding a space or a 1

- [Commute](https://aplwiki.com/wiki/Commute) aka Swap

- [Bracket Indexing](https://xpqz.github.io/learnapl/indexing.html#bracket-indexing) - Generating Random string using roll and reshape

- [Roll](https://aplwiki.com/wiki/Roll)

- [Reshape](https://aplwiki.com/wiki/Reshape)

  

## Concepts Used:

- [Comparison Function](https://aplwiki.com/wiki/Comparison_function)
- [Dfn](https://aplwiki.com/wiki/Dfn)
- [Tacit Programming](https://aplwiki.com/wiki/Tacit_programming)
- [Boolean Mask](https://aplwiki.com/wiki/Boolean)
- [Reduction](https://aplwiki.com/wiki/Reduce)
- [Regular Expressions](https://xpqz.github.io/cultivations/Regex.html)
- [Windowed Reduce](https://aplwiki.com/wiki/Windowed_Reduce) - N-wise Reduction (pair-wise with left argument of 2)
- [Performance](https://aplwiki.com/wiki/Performance#Performant_usage)
- [Dfns Workspace](https://aplwiki.com/wiki/Dfns_workspace)
- [CMPX](http://dfns.dyalog.com/n_cmpx.htm)



## Transcript:

Welcome to this third Apl Quest! See the Apl Wiki for details. 

Today's quest is the third problem from the 2013 round of the Apl problem solving competition. What is in a Word? The task is to write a function which returns the number of words in a given text, which can be given either as a single character or as a vector of characters. 

What defines a word for this problem is a space delimited, but there could be multiple spaces between words that can be leading and trailing spaces in the input. We have to account for that. 

Let's begin by creating some test data. So this is a normal text but I put in a dash here so that we make sure that we're splitting on the right thing. This is a single letter and we can also have an empty input and then we have a text with more spaces so we can have some leading spaces and maybe some trailing spaces as well. 

Okay, let's get started. Maybe the most obvious approach is to split on sequences of spaces and we can do that. Or let's say if we start by comparing an input string with a space and this gives us a Boolean vector indicating where the spaces are. 

Now the partition function groups runs of ones or elements corresponding to runs of one. So we want to invert this and then we can use this to split. So we use partition on the string itself and that gives us the individual words and we can count them. 

If we try to do that on the string that has more spaces, we can see that it still works forwards there and that's because any run of zeros is an area that gets cut out and we split up at that point. Now this runs into a problem if we try to do it on a single letter and that's because we cannot petition when there are no access to petition along. So we must ravel first and then it works. It also works on the empty one. Um, that's not a problem. 

So we can put this together to a fairly straightforward tested function. Um, we want we want the tally of where the spaces are different from the argument. Partition enclosed the revel of the argument so we are binding the space to is different from function to achieve a magnetic function there. 

If you come from other programming language background and especially Perl, you might grab for regular expressions for this. So we can try that approach as well. 

And we have our string and then we have the quad s that's a string search regular expression search and the pattern we want here are with the inverted character class none spaces any number of of those one or more and then it doesn't really matter what we're going to return because we just want to count them, we don't actually want them. So the best option here is use code three which means the pattern num in is in the offset from the left and that since there's only one pattern that's just zero. 

So we get a bunch of zeros and then we can see we get one zero per word there and that works and also on the scalar letter, and it works also on the empty we just get nothing and then we just need to count them as you can see here. So that and that's our second solution right there. 

Okay, here's an interesting solution that I came up with that's it's kind of abusing a built-in functionality a system function called vfi that's verified and fixed input and really what it does is it parses numbers. So we can see if we give it some text then um it looks at this input as a space a space separate the fields we can also have multiple spaces and that's fine. Um, it removes all such extraneous spaces and it returns a two element vector. 

The first element is the success and it says one e3 that successfully was converted and the word 3 was not successfully converted 2.5 was and 2.5 and was not successfully converted and then the second vector are the values that we converted to and with zeros for those tokens that could not be converted correctly. Now we're not interested in what the actual values are we just want to count how many such space superior the tokens there were whether or not they could be converted successfully or not. 

So we get the first vector which is this boolean and then we can just count the number of elements there and that gives us four tokens. So this works for all our inputs even for the empty one and it works for the single letter as well. You just cheated as a text here's one with more spaces and our original string. 

So that's an additional solution. In order for this to be a proper function that we can give a name then we need to bind together compose together two functions. For example, the first two we could also compress the second two. It doesn't really matter right. Um, so far for these uh approaches where we're actually parsing and splitting up into tokens but there are better ways to do this in Apl but for that we have to work with boolean masks and the way we often do it in Apl we compare a scalar with a vector.

Here's our string and then we have bits for each one. Now we're not going to use this to split up, rather we're going to analyze it. We want to know how many words there are and what defines a word is that we have a separator and there could be multiple separators. 

Let's try it with m and then we have something that's not a separator. So we're looking for this pattern here where we're going from spaces to none spaces and again here from spaces to none spaces. From spaces it could be many spaces to none spaces and that's what gives us a count of words. 

That's one way to do it and the way we can do this is by comparing adjacent elements. So we do the env and wise reduction. So here it's a two wise reduction on this as this means we're taking every pair of two overlapping windows of two and comparing them to each other with less than y less than. Because in a boolean vector, we can use less than as a boolean function to find out it only becomes true when you have a zero on the left and a one on the right. 

One is not less than one and zero is not less than zero and one is not less than zero. So that's the only time when it will match and we can see here if we it gets one element shorter because we're doing pairs. If we line them up, we can see how this one corresponds to this zero one here or every time we have a one, we begin a word. 

So this is fine then we can we can sum this and that gives us a number of words. For however, there's a problem if we look at our string again where it doesn't begin with any spaces. Then let's go back and see what happens here. We compare this space and so far so good. But now when we do the pairwise less than then we're missing one element at the beginning because sure enough there is um and and um there's none space at the beginning of the string but we never go from zero to one because there's no zeros there. So we're missing a one at the front so how can we fix this? 

And we can insert a space. So by inserting one space doesn't matter if we have multiple spaces because you know from from space to space is just zero zero and that doesn't trigger. But this will insert a 1 at the beginning. You can see if we go back to the one that already has spaces then it doesn't add any additional ones. So this gives us the solution and we can sum it like this it gives us the number of number of words and we can just wrap this in braces and then we have our solution oops. 

And this is a pretty good solution if you want to optimize for performance even more than this. Then we have to think about how the data is represented in memory. Now as we come into our function, then we have this name a variable name omega referring to the whole argument and it may occur later again in the function and therefore the interpreter has to keep this value available at all times. When we concatenate a space at the beginning we'll need to make a new copy of this um and so this if it's a very large argument then we're going to spend a lot of time writing to memory it's just a copy of everything with a space in front. 

There are things we can do about this. Notice that here the data type is whatever type of character array it is. So normally it's one byte per character but if we have some unicode things in there you can end up with two bytes or four bytes per character as internal representation. It can be rather expensive to write the whole thing again. 

Once we've done the comparison then we are down to booleans so that's only one bit per character because it's in in the comparison and since we're adding a space in the beginning and space is not different from space so we know that we're going to begin with a zero and that means we can put in a zero here and avoid copying the whole array and that's going to give us somewhat better performance.

There is even more we can do to improve performance. We have a boolean array here and when we insert a zero in the front, every element has to move over one step. We can do that in place, but it's still a rewrite. 

The only reason we want to insert a bit at the beginning is because we need to make sure and to get the right result when there are no leading spaces. This means the first element of the mask indicates whether or not we're beginning by word. So we can just add that value to our total count. 

Instead of prepending, we can also append something to an array. It is often very cheap because we don't need to move all the elements of the array. Rather, we can just extend it by a little bit. To detect the end of the words, meaning going from none spaces to spaces, we only need to append rather than prepend a single value. 

To get the word count, we go from a 0 to a 1 and concatenate another one to the end. We only get an indication if we have a 0 on the left and a 1 on the right. We need to flip the comparison to an inequality. 

Let's look at the performance. Splitting up into sub strings is going to be expensive. Spinning up a regex engine is also expensive. Quad VFI is expensive because it parses every single token. The last four solutions will blow the first three out of the water. 

We created a million characters of random text and compared the four boolean solutions. As expected, the solution where we prepend the space and copied an entire array was the slowest. Changing to prepending a bit to a boolean array gave us a significant speed up. Avoiding the copying of the array either by saving the mask and looking at the first bit of it or by appending a bit rather than preventing a bit gave us the most significant savings. Thank you for watching and see you next week
