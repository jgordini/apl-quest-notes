# [Space The Final Frontier 2014-4](https://apl.quest/psets/2014.html?goto=P4_Space_The_Final_Frontier)

**Problem:** Write a dfn that removes extraneous (leading, trailing, and multiple) spaces from a character vector.

**Video:** [https://www.youtube.com/watch?v=aqfhItFpO2I](https://www.youtube.com/watch?v=aqfhItFpO2I)

**Code:** [https://github.com/abrudz/apl_quest/blob/main/2014/4.apl](https://github.com/abrudz/apl_quest/blob/main/2014/4.apl)

## Getting Started

First, let's set up our test data and performance measurement tool:

```apl
t←∘.{⍺,(40↑⎕A)[?1,1,⍨1e3⍴40],⍵}⍨0 7↑¨' '
)copy dfns cmpx
```

This creates a test vector `t` with random characters and spaces, and imports the `cmpx` function for performance comparison.

### Method 1: Comparing Adjacent Characters

Our first approach compares adjacent characters:

```apl
A←{(' '=⊃⍵)↓⍵/⍨2∨/0,⍨' '≠⍵}
B←' '∘(=∘⊃↓⊢⊢⍤/⍨2∨/0,⍨≠)  ⍝ tacit generalisation
```

Function `A` works as follows:
1. `' '≠⍵` creates a boolean mask where non-spaces are 1 and spaces are 0.
2. `0,⍨` prepends a 0 to this mask.
3. `2∨/` performs a sliding OR operation with window size 2.
4. `⍵/⍨` uses this mask to filter the input.
5. `(' '=⊃⍵)↓` drops leading spaces if present.

Function `B` is a tacit (point-free) generalization of `A`.

Let's compare their performance:

```apl
cmpx 'A¨t' 'B¨t'
⍝  A¨t → 5.6E¯6 |   0% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕         
⍝  B¨t → 7.1E¯6 | +27% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕
```

### Method 2: Cyclic Rotation

Next, we explore methods using cyclic rotation:

```apl
C←' '∘(1↓,⊢⍤/⍨1(⊢∨⌽)0,≠)
D←' '∘(=∘⊃↓⊢⊢⍤/⍨1↓1(⊢∨⌽)0,≠)  ⍝ conditionally remove instead of
E←' '∘{1↓(m∨1⌽m←0,⍺≠⍵)/⍺,⍵}
F←' '∘{¯1↓(m∨¯1⌽m←0,⍨⍺≠⍵)/⍵,⍺} ⍝ appending is faster than prepending
G←{⍵/⍨¯1↓(∨\∧⊢∨1⌽⊢)0,⍨' '≠⍵}
H←{⍵/⍨({⌽∨\⌽⍵}∧∨\∧⊢∨1⌽⊢)' '≠⍵}
I←{⍵/⍨m∨1⌽m><\m←' '≠⍵}
```

Let's break down function `I` as an example:

1. `m←' '≠⍵` creates a boolean mask where non-spaces are 1 and spaces are 0.
2. `<\m` performs a running "less than" scan, which effectively marks the first occurrence of each non-space.
3. `m>` compares the original mask with the result of step 2, identifying spaces that come after a non-space.
4. `1⌽` rotates the result one step to the right, effectively checking if a space is followed by a non-space.
5. `m∨` combines the results, keeping both non-spaces and single spaces between words.
6. `⍵/⍨` uses the final mask to filter the input.

Let's compare their performance:

```apl
cmpx ('C'iotag'I'),¨⊂'¨t'
⍝  C¨t → 7.5E¯6 |   0% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕              
⍝  D¨t → 9.0E¯6 | +19% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕         
⍝  E¨t → 7.9E¯6 |  +4% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕             
⍝  F¨t → 7.3E¯6 |  -4% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕               
⍝  G¨t → 8.7E¯6 | +15% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕          
⍝  H¨t → 1.2E¯5 | +54% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕
⍝  I¨t → 6.0E¯6 | -20% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕                   
```

### Method 3: Regular Expressions

Now, let's explore solutions using regular expressions:

```apl
J←'^ *| *$' ' +'⎕R'' ' '         ⍝ treat leading/trailing separately from multiple
K←'^ +| +$| +(?= )'⎕R''          ⍝ specify all to be removed using
L←'[^ ] (?=.*[^ ])' ' '⎕R'&' ''  ⍝ exempt spaces to be kept, removing all other
```

Let's break down function `K`:

1. `^ +` matches one or more spaces at the beginning of the string.
2. `| +$` matches one or more spaces at the end of the string.
3. `| +(?= )` matches one or more spaces followed by another space (using positive lookahead).
4. `⎕R''` replaces all matched patterns with an empty string.

Let's compare their performance:

```apl
cmpx'J¨t' 'K¨t' 'L¨t'
⍝  J¨t → 5.5E¯4 |    0% ⎕⎕⎕⎕⎕⎕⎕                                 
⍝  K¨t → 4.8E¯4 |  -14% ⎕⎕⎕⎕⎕⎕                                  
⍝  L¨t → 3.1E¯3 | +459% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕
```

### Method 4: Split and Join

Next, we'll look at solutions that split the string and then join it back:

```apl
M←{⊃(⊣,' ',⊢)/⍵⊆⍨' '≠⍵}  ⍝ fails on ''
N←{¯1↓∊,∘' '¨⍵⊆⍨' '≠⍵}   ⍝ fix that
O←' '∘{¯1↓∊,∘⍺¨⍵⊆⍨⍺≠⍵}   ⍝ generalisation
P←¯1↓' '∘(∊⊣,¨⍨≠⊆⊢)      ⍝ tacit form
```

Let's break down function `N`:

1. `' '≠⍵` creates a boolean mask where non-spaces are 1 and spaces are 0.
2. `⍵⊆⍨` splits the input into subarrays based on the mask (effectively splitting on spaces).
3. `,∘' '¨` appends a space to each subarray.
4. `∊` enlist (flatten) the result into a single array.
5. `¯1↓` removes the last element (extra space at the end).

Let's compare their performance:

```apl
cmpx('M'iotag'P'),¨⊂'¨t'
⍝  M¨t → 6.7E¯4 |   0% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕
⍝  N¨t → 2.8E¯4 | -58% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕                       
⍝  O¨t → 2.7E¯4 | -61% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕                        
⍝  P¨t → 2.3E¯4 | -65% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕                          
```

### Method 5: Using Find (⍷)

Lastly, we'll explore solutions using the find (`⍷`) primitive:

```apl
Q←{⍵/⍨(0 0∘⍷<∨\∧∘⌽∨\∘⌽)' '≠⍵}
R←{⍵/⍨~'  '⍷⍵}{(∨\' '≠⍵)/⍵}∘⌽⍣2  ⍝ use idiom twice
S←{({- ⊃⌽⍵}↓⍵/⍨1 1∘⍷⍱∧\)' '=⍵}
```

Let's break down function `R`:

1. `{(∨\' '≠⍵)/⍵}` removes leading spaces using the idiom.
2. `∘⌽⍣2` applies the previous step twice, effectively removing both leading and trailing spaces.
3. `{⍵/⍨~'  '⍷⍵}` removes multiple spaces by filtering out where two consecutive spaces are found.

Let's compare their performance:

```apl
cmpx'Q¨t' 'R¨t' 'S¨t'
⍝  Q¨t → 8.5E¯5 |   0% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕
⍝  R¨t → 2.3E¯5 | -73% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕                             
⍝  S¨t → 8.5E¯5 |   0% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕
```

### Final Comparison

Now, let's compare the best performers from each group

```apl
cmpx 'AIKPR',¨⊂'¨t'
⍝  A¨t → 6.1E¯6 |     0%                                         
⍝  I¨t → 6.0E¯6 |    -2%                                         
⍝  K¨t → 5.0E¯4 | +8052% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕
⍝  P¨t → 2.4E¯4 | +3754% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕                     
⍝  R¨t → 2.1E¯5 |  +248% ⎕⎕                                      
```

From this comparison, we can see that functions `A` and `I` are significantly faster than the others, with `A` being slightly faster than `I`. Let's compare these two directly:

```apl
cmpx 'AI',¨⊂'¨t'
⍝  A¨t → 5.5E¯6 |   0% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕      
⍝  I¨t → 6.5E¯6 | +17% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕
```

Let's break down these two functions for a final comparison:

Function `A`:
```apl
A←{(' '=⊃⍵)↓⍵/⍨2∨/0,⍨' '≠⍵}
```
1. `' '≠⍵` creates a boolean mask where non-spaces are 1 and spaces are 0.
2. `0,⍨` prepends a 0 to this mask.
3. `2∨/` performs a sliding OR operation with window size 2.
4. `⍵/⍨` uses this mask to filter the input.
5. `(' '=⊃⍵)↓` drops leading spaces if present.

Function `I`:
```apl
I←{⍵/⍨m∨1⌽m><\m←' '≠⍵}
```
1. `m←' '≠⍵` creates a boolean mask where non-spaces are 1 and spaces are 0.
2. `<\m` performs a running "less than" scan, which effectively marks the first occurrence of each non-space.
3. `m>` compares the original mask with the result of step 2, identifying spaces that come after a non-space.
4. `1⌽` rotates the result one step to the right, effectively checking if a space is followed by a non-space.
5. `m∨` combines the results, keeping both non-spaces and single spaces between words.
6. `⍵/⍨` uses the final mask to filter the input.

## Conclusion

After comparing various methods for removing extraneous spaces in APL, we can draw the following conclusions:

1. The fastest method is `A`, which uses adjacent character comparison and is slightly more efficient than `I`.

2. The second fastest method is `I`, which uses cyclic rotation and exclusive-or operations.

3. Regular expression methods (`J`, `K`, `L`) are significantly slower than other approaches, with `K` being the fastest among them.

4. Split-and-join methods (`M`, `N`, `O`, `P`) perform better than regex but are still slower than the top performers, with `P` being the fastest in this category.

5. The find (`⍷`) based methods (`Q`, `R`, `S`) show mixed results, with `R` performing well but still not matching the top two.

### Key takeaways:

1. Simple, primitive-based operations tend to outperform more complex approaches like regex.
2. Careful use of boolean operations and array manipulations can lead to highly efficient solutions.
3. While tacit (point-free) expressions can be elegant, they may introduce slight performance overhead.

It's worth noting that while performance is crucial, code readability and maintainability are also important factors to consider. The fastest solution might not always be the best choice if it sacrifices clarity or makes the code harder to understand and maintain.

In practice, the choice of method may depend on various factors such as:
- The specific use case and typical input characteristics
- Performance requirements
- Code maintainability needs
- Integration with existing systems

For most general purposes, function `A` provides an excellent balance of performance and readability. However, if you need a more flexible solution that can handle different separator characters, function `I` or one of the generalizable methods might be more appropriate.


## Glyphs Used:

- [Compress](https://aplwiki.com/wiki/Replicate) `/` - Used for filtering in `⍵/⍨`
- [Rotate](https://aplwiki.com/wiki/Rotate) `⌽` - Used in cyclic rotation methods
- [Reduce](https://aplwiki.com/wiki/Reduce) `/` - Used in `2∨/`
- [Scan](https://aplwiki.com/wiki/Scan) `\` - Used in `<\` and `∨\`
- [Commute](https://aplwiki.com/wiki/Commute) `⍨` - Used in `0,⍨`
- [Or](https://aplwiki.com/wiki/Or) `∨` - Used in boolean operations
- [Less Than](https://aplwiki.com/wiki/Less_than) `<` - Used in `<\`
- [Not Equal](https://aplwiki.com/wiki/Not_equal) `≠` - Used in `' '≠⍵`
- [Enclose](https://aplwiki.com/wiki/Enclose) `⊂` - Used in `⊂'¨t'`
- [First](https://aplwiki.com/wiki/First) `⊃` - Used in `(' '=⊃⍵)`
- [Drop](https://aplwiki.com/wiki/Drop) `↓` - Used in `(' '=⊃⍵)↓`
- [Exclusive Or](https://aplwiki.com/wiki/Xor) `>` - Used in `><\`
- [Enlist](https://aplwiki.com/wiki/Enlist) `∊` - Used in split-and-join methods
- [Partition](https://aplwiki.com/wiki/Partition) `⊆` - Used in split-and-join methods
- [Find](https://aplwiki.com/wiki/Find) `⍷` - Used in find-based methods
- [Power](https://aplwiki.com/wiki/Power) `⍣` - Used in `∘⌽⍣2`
- [Bind](https://aplwiki.com/wiki/Bind) `∘` - Used in various tacit expressions

## Concepts Used:

- [Dfn](https://aplwiki.com/wiki/Dfn) - Used for defining most functions
- [Tacit Programming](https://aplwiki.com/wiki/Tacit_programming) - Used in function `B` and others
- [Boolean Mask](https://aplwiki.com/wiki/Boolean) - Used extensively for filtering
- [Idioms](https://aplwiki.com/wiki/Idiom) - Used in function `R`
- [Each](https://aplwiki.com/wiki/Each) - Used in performance testing with `¨`
- [Outer Product](https://aplwiki.com/wiki/Outer_product) - Used in test data generation `∘.`
- [Fork](https://aplwiki.com/wiki/Train#3-trains) - Used in some tacit expressions
- [Performance Optimization](https://aplwiki.com/wiki/Performance) - The main focus of the article
- [Comparison](https://aplwiki.com/wiki/Comparison_function) - Used in boolean operations
- [Reduction](https://aplwiki.com/wiki/Reduce) - Used in `2∨/`
- [Scan](https://aplwiki.com/wiki/Scan) - Used in `<\` and `∨\`
- [Dfns Workspace](https://aplwiki.com/wiki/Dfns_workspace) - Used for `cmpx` function

## Regular Expressions:

- [Replace](https://aplwiki.com/wiki/Replace) `⎕R` - Used in regex-based methods
- Patterns used:
  - `^ *` - Matches leading spaces
  - ` *$` - Matches trailing spaces
  - ` +` - Matches one or more spaces
  - `(?= )` - Positive lookahead for a space
  - `[^ ]` - Matches any non-space character
  - `(?=.*[^ ])` - Positive lookahead for a non-space character


# Transcript

Welcome to the APL Quest. See the APL Wiki for details. Today's quest is the fourth from the 2014 edition of the APL Problem Solving Competition. The idea is that we're given a text and it may have spacing that we don't want, and we want to normalize this in the sense that any trailing spaces at the end of the text are removed, any leading spaces at the beginning of the text are removed, and also if any words are separated by more than one space, they will be compacted down to be a single space.

Let's start with a sample. The basic thing that we want to do here is we want to compare adjacent spaces in order to remove those extra spaces in the middle. Then we need to take care of the spaces at the very end because they might not be adjacent to another space. If there's just one space, or rather if we don't do anything but remove adjacent spaces, then we also reduce the leading and trailing spaces into a single space.

Let's get started. The first thing we want to find out is where our non-spaces are, and we want to make sure to catch also the spaces at the end. We want to make sure that as if the last space is also adjacent to another space, and so that would be an extra zero at the end. Now we can do an adjacent pairwise reduce and we want to see if any of those are non-spaces. A space that's next to a non-space is something we'd want to keep. That gives us this. We can see that we start off with a couple of two spaces and then we have a space which is adjacent to the 't' in 'this', and then we have the four letters of 'this', and then the first space and there is some 'a', and then we have the 'um', and then we continue on with 'and'. We can see that we have ones for non-spaces and also for the single spaces between the words. Then we have the trailing spaces.

Okay, now we can use this to filter the text, and that almost solves the problem. Now there are no spaces here at the end because we made sure to add that extra zero at the end, but there is a problem of a leading space. We can drop this conditionally if we know that the text begins with a single space and with one or more spaces that means we also have to drop one more space that otherwise wasn't caught. We can easily check that if a space is equal to the first of the argument text, then we drop it. This would give one if it is. We could also invert it here just by negating the vector credit here, but this is very little work to do. The only real work that we have here is dropping that leading space because that would mean rewriting everything in memory. That solves the problem. Let's give this the name 'a' because we're going to have a lot of different solutions here.

Okay, and let's then for our next solution take this and generalize it. I mean, and while we're making it also test it just to see some possibilities. What do you mean by generalize? It is that instead of taking space as this element that needs to be removed from the beginning at the end and deduplicate it in the middle, we're going to allow you to specify that character as a left argument and then we can bind space as the left argument in order to make it do our specific task. To make this tested is actually quite simple because we're going to put out the space as a left argument and that means that this different from is just going to be a different from like this, and then we have to, of course, this is becoming a test function, another defense, and the rest of this will just work. 

This is a dyadic function here, the static function here. There's one problem: replicate or compress here doesn't behave like a function when it is next to another function and the right tack here, but we can fix that with a right tack top. Then here we have the left argument and the right argument, and that means that we essentially have it equal except we want to pre-process the right argument of equal with a first and we can write that just with a beside the composition. So that's what the entire thing comes out to here. We can try it with our sample text, and that means we can give this a name and just remember to either bind a left argument here or we could have put a right tack on the right to make it a fork. It'll be interesting maybe to see which one is faster of these two. So let's try that and at the same time let's also generate some test data.

Test data is going to be a bit interesting because we want to try all the different cases that may be with so there'll always be some internal duplicator spaces, but we also want some with some leading spaces and some with some trailing spaces and all the combinations of that. So how might we do that? Well, and there are different ways we can do it, but let's start by generating some spaces. So we want no spaces and yes spaces, and we can't actually see those, but we can, it helps maybe to do it like this right. So we got no spaces and yes spaces. Then we want all the combinations of that, so that be an outer product of all of those, and it's still not really going to be very visible here, but now we're going to use these as prefixes and suffixes. So on the left, we have the prefixes, and on the right, we have the suffixes, and then we're going to have some garbled text in the middle. Let's take 4D overtake on the alphabet that gives us the alphabet with a bunch of spaces at the end, and then we just want some random numbers there. Let's say just for now for the display we're taking 20 reshape 40. Yeah, not again not very visible. This helps a little bit actually. We should probably use display as to see it entirely. So here we can see yeah, it goes over the edge of the screen, but we can see that we have added spaces in the beginning and the end. The problem is that our randomness here it caused us to have some space in the beginning that we didn't want to. 

So how can we make sure that we have a non-space in the beginning and the end? Well, we can just stick an 'a' at the beginning and the end right there. Actually, let's turn rows on as well so that we don't so we don't run over the edge of the screen and maybe make these a little bit shorter also so we can see it there we go. So now we have our test data. We have one that doesn't have any spaces beginning in the end and one and then we have one that has only beginning one at the end one at the beginning and the end, and we can see we're getting some internal space here of course. In the first three cases, there are no multiple internal spaces because they're very very short, but we're going to generate a giant test data so that's not a problem. It'll definitely be multiple internal spaces so that's it. So then we're going to test things when for speed comparison then we'll be testing it all four of these. I'm copying in the performance comparison from the defense workspace, and then we can run cmpx a on each of these four cases and b on each of these four cases, and we can see the a is somewhat faster. So maybe it wasn't so good to try to test it after all.

Okay, another whole different way of doing this instead of using this adjacent with the difference from from a space we could also rotate things around and that gives us so if we compare the ebola vector with it it's rotated by one step that also gives us this adjacency but it at the same time allows us to rotate cyclically and that lets us get rid of of having to deal with it with the edges so especially. 

So we can try this. Let's take our our sample here and we start off with the exact same way. Actually, we can we can start even making it general so let's just put it outside so this gives us our vector of none spaces and we have the same thing with adding one at the edge. Now the important thing that we're going to do next is we when we rotate this and one step here then because we've added a zero at the beginning we know that when we rotate it one step to the end we are now getting a zero at the end instead. So if we now take these two together so we want the one rotate and also the original and we can write that. 

Let's actually begin with well so we want to combine combine these two but let's just stack them on top of each other first. We can do that with mix up top comma over in close we can see these are the two that we're going to combine. So now what we want to do is we want where to preserve anything that is true in either one or the other so either it is a non-space or it is an adjacent to a non-space so these are the ones we want to want to keep and then we just need to to do the same thing as before and remember to stick an attack on top of that of that slash. Now there's one problem here that we've added one element and that means that what we can't just do is compress because it will be a length there we want to take the not the right argument but rather the concatenation of the space and the right argument and that gives us this and because we've added a space on the left then we need to drop that and we can do that like this. Okay, let's give this a name this is going to be c. Don't forget to bind the argument here to the function so that's one way of doing it cyclically but there are other ways that we could do it.

Let's look at this again. So we can we can optimize the performance here. There's a problem that we are concatenating and with a big argument on the right it's going to be expensive having to write over the data in memory all again and we could possibly save ourselves and some of this work by working on the on the boolean vector over here removing one element from from that and instead then we don't need to concatenate we can just take that right argument and like this only problem is then we're back to and so that's we are back to another problem that we get that space at the beginning if it's not then we don't get a space because now we're not considering the spaceness or not spaceness of the of the first element in anymore and the way we can we can fix that is much like we did we did before namely that if space the left recommend is equal to the first element of the argument then we drop from there so that then this works and let's give that the name and d. Okay, but there are plenty of ways to do this we can also start by the concatenation and and go with that. 

So let's start by having this the left argument here this the space and then concatenate it in the beginning of the right argument the main argument that we're working on and then we're going to generate a vector the compression vector for this entire thing so we can we can start by saying there we which they're different and then adding a zero on the front like we're doing before we could say give that a name for a mask and then rotate it and then use or that so this is this would be just a different it's it's an explicit version of what we've done before this is of c and then we're doing it doing one drop and on that so things look a little bit different when we can assign temporary variables like this okay this is e and now again we have a problem that we're concatenating on the left and we know that that's potentially slow canceling on the right when the interpreter will reserve additional space for the array to grow and then it can just write into that space so that's going to be much cheaper than rewriting the whole thing so how can we reformulate this to concatenate on the right instead so we're concatenating here on the right on the space on the right and then that just means that we have to move our corresponding zero over on the right as well and that and then similarly we have to rotate the other direction and then dropping from the opposite direction and then no more spaces here at the end so that potentially should be faster f should be faster than than e.

Okay, there are even more ways we can play. We've got plenty of ways to write this, so let's start off with our normal comparison. Now we're adding that spaces as always, so it's a space indicator in our boolean vector: zero. Then we're going to process that in much the same way as we've done before. We are rotating it one step and then doing an OR with itself. So far so good, that's the same as what we've been doing before. We're just writing it inline here rather than taking the one outside.

The trick I want to get here is this gives us this, then we also want to make sure to not catch anything at the beginning. So if we start here with "Well, I'm going to explain this. This is a test," these are all fine, but if we have one space here, that's not right because it's adjacent to a non-space. We want to get rid of that. If we have more spaces, then we start detecting that it's a space addition to another space. That's not okay.

The cheap way of fixing this is by saying that any space, any character that appears before the first non-space, shouldn't be regarded at all. Of course, any character before the first non-space is going to be a space. We can do that by taking the running OR. Because we have our comparison vector here are the num spaces, that means we start with zeros for all the spaces and then we get a one.

This means as soon as we hit the first one going from the left, any character after that will also have a one. Similarly, any character up to the first one has a zero. This is a strict condition. We can then take that and put it up here that we only want the ones here, but we have this problem here with this one if it's also true that it comes after the first one.

Now this gives us a good mask that we can work on, and then we just use this to filter our argument. We can try that with s we had before. What am I doing wrong here? Oh yeah, of course, we have to drop the zero from the end after we're done with our logic. Here we go.

We could also use this kind of method of this cumulative OR or scan to spell out all our conditions. Starting with that same vector here, let's spell out our conditions, and then we don't need to worry about this cyclical thing. The way we're going to spell it out is again we're saying that it is the adjacency to a non-space. So it has to be a non-space or adjacent to a non-space, and it also has to come after the first non-space, and it also has to come before the last non-space.

The last non-space we can write as a little defend itself. We reverse the argument and then we do our AND OR scan and then reverse it back again. So here we've just spelled out the conditions for keeping a character: it is adjacent to a non-space or it's a non-space, and it comes after the first one, and it comes before the last one.

One final way that we can potentially use this is if we take the non-spaces as always, and then we let's give that a name: the mask. Then we use the less than scan. It's a bit of a tricky one. You kind of have to know this, but what it does is it turns off all ones that appear after the first one.

Let's say we have the mask like this. Here's our mask, and we can see that it leaves only a one at the first one, and all other ones in this whole vector are turned off. That's what we're doing now. Then we can specify that for something to be preserved, it has to be a non-space and it's not only. So we could write an AND NOT like this, but AND NOT is only true if this is one and this over here is zero. For boolean, that just means that it is strictly greater than.

Effectively what happens here is it's exactly the same vector as before, the different from space vector, except that we have forced the first one that's there to become a zero. Now we can use this to cyclically rotate, and that is safe because we know that the first element cannot be a one. That means that when we rotate it one step, we for sure get a zero added at the end. Then we can compare that with our mask.

So it has to be a non-space or adjacent to a non-space as before, but adjacent to does not wrap around. It looks much like what we had before, but we don't have the problem of wrapping around and messing with the training ones. We're wrapping a zero around there, and then we can use that to filter it over here. Even if we use something that doesn't have spaces at the end, it doesn't matter. They are still adjacent to the non-space that's being rotated one step to the left. We're not nulling that out.

Now for comparison of all these different ways of using the cyclic rotation, that were all the letters from c to i, let's instead of having to spell those out, use another utility from the defense workspace. It's the generalized iota, and not only does it handle non-numeric data, it also handles a start point and an endpoint rather than starting always at one or zero if you're using code i zero.

That means that we can write, for example, k to iota g w. We get all the letters from k to j w inclusive, and that means that we can say we want letters from c. We would say iota g, and we want them all the ones to i. Then we want each one of them concatenated to an each and the t. That gives us all our expressions that we want to run.

Then we can run cmpx on that, and it's pretty clear that our last one here, the clever one that avoids the problem of rotating the wrong data around, is the fastest one. Good to know.

Hey, how about regex? We can pretty much guess that it's going to be slow, but there are different ways of doing it. They're interesting to see how we could do that.

For a regular solution, one way we can do it is by defining exactly which spaces to remove and which spaces to condense. The ones that need to be removed are at the beginning of our text (any number of spaces) or any number of spaces at the end of the text. The only thing that leaves us is getting rid of the multiple internal spaces.

Now we can say once all of those are gone, then we also want to remove any run of spaces with a single space. We could also say any space followed by any number of spaces, but it's probably not going to make a big difference. That solves the problem. Let's call that j.

Another way we could do it is using a single pattern just to specify all the spaces that need to be removed. This just moves all of them, replaces with nothing. But what exactly is a space that we want to remove? Well, we can start off like we did before: any number of spaces at the beginning or any number of spaces at the end.

But there's one more possibility: the internal spaces that are redundant. What does it mean that they're redundant? It means that they're adjacent to another space, just like we've been using pure APL to do before. So we have a space, and then we want to look ahead and see that there's another space. If there is another space coming up but not included in this match, then we should remove that space. That just leaves the last space in every group of spaces. This solves our problem as well.

Finally, we can make a solution where we start off by protecting certain things. I call it like an exception pattern solution. We replace them with themselves, and then anything that's left over using a different pattern is then changed.

What we want to keep are spaces that are in between two non-spaces. How can we do that? Well, we could use a look behind and look ahead. So if we have a non-space followed by a space followed by an upcoming (that's a look ahead) any number of characters. The problem here is that this could be the last character, the last letter in our text, and it will be followed by a space. Then we say any number of characters that come after that, and that will also match that there should be a space at the very end, but we don't want to keep that.

We need to make sure that something follows after, and we can't consume a non-space because then we might have non-space space non-space space, and we need that middle non-space to be used to justify both of the spaces that are adjacent to it. But what we can say is that it follows any number of characters (look ahead), and then there is something somewhere after that which is also a non-space. Those are the spaces we want to preserve. Any other space we want to remove.

Let's try this out. We could also say that we want any space, any number of spaces followed by any non-space, but that would only preserve those places that are just a single space. We don't want that. We want to preserve one of each of the spaces that are in sequences of spaces as well.

So this is another way of doing it with regex. Three different ways of doing it:
1. The first one was to do two different patterns to do the two transformations: leading/trailing and then separately treat multiple spaces and make them one.
2. The one where we are specifying exactly which spaces to be removed using an OR and three different patterns.
3. This one where we are accepting the spaces that we want to keep and then removing all other spaces.

Let's try that. We want j each of k a h of t and k each of t and l each of t. Three different ways of doing regex to see which one is faster in our case. Well, pretty clear that using the two transformations would be faster in our case. This might not be true in every case.

Now here's a fun thing. Because our problem is very specific - we're only dealing with spaces and non-spaces, and we want to get rid of any runs of spaces other than them being a single space inserted there - we can use a little trick. That is using the classic way of splitting on spaces or on any other character really.

We partition by where we have non-spaces. Because non-spaces are indicated by zeros and any element that corresponds to zero is removed when we're using partition, that means that all the spaces are removed: leading, trailing, all the internal ones. Now we remove too much because we want to have exactly one space between each word, but that's not so bad because what we can do then is join on spaces.

We could write that as the left argument followed by space followed by the right argument, but this will fail if we have an empty vector. That will attempt to need the identity element for this function, for which there isn't one. Firstly, APL can't figure it out for non-primitive functions, but secondly, there is no argument you can give to this on one side so that we preserve the argument from the other side because it always adds a single space.

Instead, what we can do is just add a space to each one. We know that it's probably faster to add things on the right, so instead of just doing space concatenated to each one, we'll bind the space on the right side of concatenation. This just adds a trailing space to each one. We could also use commute for this, but this will work.

Now we just need to flatten it all down, and then we have a trailing space that comes out here. We just need to drop the last one because we've added a space to each one. That gives us our results right there.

This is one way to split and join. I didn't give a name to this one. This should be good. While it's not really valid, it'll be interesting to see if there's a difference in speed as well between join on spaces and add a space to each one and then flatten it all out and removing one. We can still compare them even if we know that it's not really valid.

Let's try to generalize this a little bit. That's really trivial if we take this one, then we can just use the left argument here and a left argument here. That would be a generalization of it just to show how we can do that. This is actually a kind of useful thing to be able to bind an argument with a function. It's just what I want to demonstrate.

But this form also has an additional benefit in that it is extremely amenable to becoming tested. How might we write this as a tested form? Well, this is just application between the arguments, and this is the right argument. So we could write this as a right tack here, but since we're just flipping the arguments of the partition and we have a single primitive over here, then there's no point in writing it like that.

So we can just flip them around. We can write that in the proper order. Now we want to add the left argument concatenated on each but flipped around. Then we flatten this, and then we need to change our braces to parentheses. We could combine this because this is a monadic function, so we're just pre-pressing the right argument to the negative one. But instead of that, we can actually just let it be on the top. I find it on the top here.

So we have this fork here which has a fork right argument, a right tine, and then a single function. That's on the top, and then we can just state the negative one drop outside as well. It saves us from this somewhat awkward composition of it. We can try this, and this works as well in a test form.

These were all based on splitting and joining. Let's compare them with each other. So let's do this was m g p and each one is with an enclosed and each of t. These are all the split and join. They're probably not going to be fast, but we can still compare them with each other.

Now the matches are there, and now you can see that the first one was very slow. That's the one that's doing the reduction, and it wasn't completely right anyway because it couldn't handle the empty argument. So that's good, and the other ones are much faster than that.

Finally, a function that's often overlooked is the find function. The find function indicates the beginning of any subarray in an array. We've got our s here, and then we can say we want to find places where we have doubled spaces. We can see that we have three spaces at the beginning, and that means there are two instances of double spaces here. There's a double space over here, and then there are all the trailing spaces that cause double spaces at the end.

We can use this. Let's start off with something that just like we've been doing before, different from space, and then we're going to do something like that. Here when we have different space, we want to look at places where we got zero zero. This corresponds to what we're doing over here. We just do it using it on the boolean instead of using it directly on our text.

Now we'll come back to this. Let's just do the basic thing first, which is going to be that we want to make sure that we... This thing will take care of the double spaces eventually. We can see that already here. If we negate this, then that indicates all the places except for a space that is followed by another space, which are the redundant spaces. If we use this already to compress here, that gets rid of our double spaces but doesn't get rid of our leading and trailing spaces other than compressing them down to become single spaces.

But we can fix this. Leading and trailing spaces we can get rid of by the same method we did before with the scan. We want to find anything that follows the first one but not anything before that, and anything that comes before the last one. We can do this reversal, and then we do an OR on that, and then we do reversal again. That gives us a mask indicating ones all the way up to the very last one. That takes care of all the trailing spaces.

Then we can combine it with a regular OR scan. We want both of these to be true. It has to be true: this after the first one and before the last one. We need to bind these together as well because this is a monadic, so we need to pre-use. We do that by pre-processing the right argument to AND. That gives us the internals there.

Then the only thing we want to also be true is that it isn't a space which is followed by another space. We forgot to bind by the argument to that. This is wrong anyway because we want this to be false. It has to be not a space that's next to another space, and this has to be true. It has to be in the internal part. So it's like the AND NOT but backwards. This has to be on the right, has to be greater than what's on the left, and that gives us our mask. Then we can use that to filter the argument, and that gives us our result. We call that q.

Another idea we can use now that we know how to take care of duplicate spaces: we are free to explore other ways of getting rid of leading and trailing spaces. Now there's this thing called idiom recognition where certain phrases are not actually taken at face value but are interpreted as a single kind of token. The interpreter internally uses a very fast algorithm for doing the same work that this function would have done.

One of them is actually exactly this to remove spaces. Apparently, that's something APLers do a lot, and they want to run fast. If we type this up, notice that it turned a different color here. That is indicating that this is an idiom and therefore going to run very fast. The problem is, of course, this only removes leading spaces. This is exactly that mask on the leading non-spaces.

We also want to do it from the reverse, but we can do that simply by reversing our argument and then applying this, which removes leading spaces, and then reversing it again back to how it was before and removing the leave space. This whole thing just has to run twice.

Once that's done, we can try this on our sample. This gets rid of all leading and trailing spaces. Then we can apply atop that this exact method that we had before. We want the argument where it is not true that we have adjacent a space that's adjacent to another space on its right. That gets rid of that. This may be fast because we're using this idiom for the leading and trailing spaces, even though we're using find for the middle spaces that need to be removed. Let's call this r.

Finally, let's try to use a bit of work with find straight on the bit mask in a bit different way. What we're going to do here is we're going to start, for once, with things that are spaces. This is exactly the opposite of what we did before. But the good thing about it is that we can then do an AND scan. That gives us all the leading spaces, and then we can do the one-one find that gives us all the duplicated spaces. We don't want any of those.

So neither this nor that. We can try this. In fact, let's put it in here. That's what we're going to do. All the leading spaces were removed, and now we only have trailing spaces. It's a little bit hard to see that we've got trailing spaces here, but if we use display, then we can see that we've got a trailing space.

There'll only ever be one trailing space because we've reduced any runs of spaces to a single space. That means that the only thing we need to do is remove a trailing element, which is a very fast operation if the last character of our input is a space.

How can we find the last character of the input? Well, if we reverse it and then take the first, that's the last. Then we need to drop one if that's true. Since it's from the end, we can do negate on top of that. This might be a bit faster if we allow the interpreter to use its idiom like this, but we can't do that when it's tested. So let's just write it like this instead.

Now it should be able to recognize it as an idiom. It's interesting it's really not written. Yeah, it thinks it's not an idiom when there's an adjacent space. It seems like a bug in the syntax color.

Okay, so this finds the trailing space. If we have the last element being in this vector indicating where there are spaces, then we negate that. If it's zero, it just stays zero, and then we drop that many elements on the right. That should work. We can try to display here. We can see that there are no spaces at the end, and we'll call this s.

Then we are ready to test our find-based methods. So this is cmpx, and we've got qh on t and rh on t and sh on t. We can see that r is by far the fastest one of these. Which one was r? That was the one where we were using the idioms to remove leading and trailing spaces. So that's interesting to know.

So in each category, we found out which one was the fastest one. If I recall correctly, those were:
- a from the category of adjacent characters
- i from the cyclical rotation
- k from the regex
- p from where we're splitting and joining
- and now we had r here where we are using find

So that's these. We'll take these and compare them to each other. That shows us that a and i are fastest, but they're so close to each other that it's kind of hard to decide when it's being drowned out by other things. So let's try to just do these two, and it turns out that our very first solution is actually the fastest one.

Very nice. Thank you so much for watching.
