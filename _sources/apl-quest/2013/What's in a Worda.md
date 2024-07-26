## [What's in a Word](https://problems.tryapl.org/psets/2013.html?goto=P3_What_Is_In_a_Word)

**Problem:** Write a dfn which returns the number of words in the given character scalar or vector.

**Video:** https://youtu.be/MgkM2qCPWas 
**Code:** https://github.com/abrudz/apl_quest/blob/main/2013/3.apl

This problem is based on the third challenge from the 2013 round of the APL Problem Solving Competition. The task is to create a function that can accurately count the number of words in a given text, where a word is defined as being space-delimited. The function should handle various edge cases, including multiple spaces between words, leading and trailing spaces, single-character inputs, and empty inputs.

**Test Data:**

```apl
s←'hyphen-dash string'
l←'x'
e←''
m←'  more spaces   go here '
```



### Example Solutions

```APL
F ← ≢' '∘≠⊆, ⍝ Tacit - binding the space to the not equal to make monadic. 
```

This tacit function splits the input on sequences of spaces and counts the resulting partitions. 

1. `' '∘≠`: [Bind](https://aplwiki.com/wiki/Bind) space to [Not equal to](https://aplwiki.com/wiki/Not_Equal_to), creating a monadic function.
2. `⊆,`: [Partition](https://aplwiki.com/wiki/Partition) the [Ravel](https://aplwiki.com/wiki/Ravel) of the input.
3. `≢`: [Tally](https://aplwiki.com/wiki/Tally) the resulting partitions.



### Advanced Solutions

```APL
G ← ≢'[^ ]+'⎕S 3
```

This function uses a regular expression to match non-space sequences and counts them. For those familiar with other programming languages, particularly Perl, this solution might feel more intuitive.

1. `'[^ ]+'`: Regular expression matching one or more non-space characters.
2. `⎕S 3`: [String Search](http://help.dyalog.com/18.0/index.htm#Language/System%20Functions/r.htm) with transformation code 3 (pattern number).
3. `≢`: [Tally](https://aplwiki.com/wiki/Tally) the matches.



```APL
H ← ≢∘⊃⎕VFI
```

This solution showcases APL's versatility by creatively using a function typically meant for numeric input parsing. This function utilizes the Verify and Fix Input system function to parse the input as if it were numeric fields. The Verify and Fix Input function (⎕VFI) is repurposed here to tokenize the input string and count the resulting tokens.

1. `⎕VFI`: [Verify and Fix Input](https://xpqz.github.io/cultivations/Constants.html?highlight=fix%20input#verify-and-fix-input-vfi) parses the input.
2. `⊃`: [Pick](https://xpqz.github.io/learnapl/indexing.html?highlight=first#pick) the first element (success flags).
3. `≢∘⊃`: [Bind](https://mastering.dyalog.com/Tacit-Programming.html?highlight=bind#binding) [Tally](https://aplwiki.com/wiki/Tally) to the result.

```APL
I ← {+/2</' '≠' ',⍵}
J ← {+/2</0,' '≠⍵}
K ← {(⊃m)++/2</m←' '≠,⍵}
L ← {+/2</1,⍨' '=⍵}
```



### Optimizations

These solutions represent increasingly optimized approaches to the problem. They use boolean masks and pairwise comparisons to efficiently identify word boundaries, avoiding the overhead of string manipulation or regex engines.

```apl
I ← {+/2</' '≠' ',⍵}
```

Function I:
1. `' '≠' ',⍵`: Create a [Boolean Mask](https://aplwiki.com/wiki/Boolean) by prepending a space and comparing.
2. `2</`: [Reduce](https://aplwiki.com/wiki/Reduce) comparing adjacent pairs.
3. `+/`: Sum the results to get the word count.



```apl
J ← {+/2</0,' '≠⍵}
```

Function J (optimized version of I):
1. `' '≠⍵`: Create a [Boolean Mask](https://aplwiki.com/wiki/Boolean).
2. `0,`: Prepend a 0 instead of adding a space.
3. `2</`: [Reduce](https://aplwiki.com/wiki/Reduce) comparing adjacent pairs.
4. `+/`: Sum the results.



```apl
K ← {(⊃m)++/2</m←' '≠,⍵}
```

Function K (further optimized):
1. `' '≠,⍵`: Create a [Boolean Mask](https://aplwiki.com/wiki/Boolean) of the raveled input.
2. `m←`: Assign the mask to a variable.
3. `(⊃m)`: Get the [First](https://aplwiki.com/wiki/First) element of the mask.
4. `2</m`: [Reduce](https://aplwiki.com/wiki/Reduce) comparing adjacent pairs.
5. `+/`: Sum the results.
6. Add the first element to the sum.



```apl
L ← {+/2</1,⍨' '=⍵}
```

Function L (optimized by appending instead of prepending):

1. `' '=⍵`: Create an inverted [Boolean Mask](https://aplwiki.com/wiki/Boolean).
2. `1,⍨`: [Append](https://aplwiki.com/wiki/Commute) 1 using [Swap](https://aplwiki.com/wiki/Commute).
3. `2</`: [Reduce](https://aplwiki.com/wiki/Reduce) comparing adjacent pairs.
4. `+/`: Sum the results.



### Performance

```APL
t←'abc '[?1e6⍴4] ⍝ Interesting use of bracket index to generate random words array
'cmpx'⎕cy'dfns'
cmpx'F t' 'G t' 'H t' 'I t'
```

We can evaluate the performance of each function by importing the [CMPX](http://dfns.dyalog.com/n_cmpx.htm) function from the [DFNS](http://dfns.dyalog.com/n_contents.htm) library. 

1. Using the 4 characters `'abc '` (abc and space).  
2. We use [Bracket Indexing](https://xpqz.github.io/learnapl/indexing.html#bracket-indexing) `[]` to randomly `?` pick one of the 4 characters a million `1e6` times. 
3. [Reshape](https://aplwiki.com/wiki/Reshape) ⍴ is being used to limit the index to 4. 
4. We can then [copy](http://help.dyalog.com/latest/Content/Language/System%20Functions/cy.htm) `⎕cy` CMPX from the DFNS library into our workspace.
5. We use cmpx to evaluate the performance of each function, with the first function as our baseline. 



### Glyphs Used:

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



### Concepts Used:

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

  