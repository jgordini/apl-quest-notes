# How Tweet It Is 2014-2

**Problem:** Twitter(x) messages have a 140 character limit; what if the limit was even shorter? One way to shorten the message yet retain most readability is to remove interior vowels from its words. Write a dfn which takes a character vector and removes the interior vowels from each word.

**Video:** [https://www.youtube.com/watch?v=3X3l76njwfs](https://www.youtube.com/watch?v=3X3l76njwfs)

**Code:** [https://github.com/abrudz/apl_quest/blob/main/2014/2.apl](https://github.com/abrudz/apl_quest/blob/main/2014/2.apl)

## Getting Started

   Let's break down our approach to tackling this problem:

   1. **Identifying Spaces and Non-Spaces**: We begin by identifying spaces and non-space characters in our text. This identification allows us to partition the text effectively.

   2. **Partitioning the Text**: Using a mask that corresponds to runs of ones (letters) and zeros (non-letters), we can use a [partitioned enclose](https://aplwiki.com/wiki/Partitioned_Enclose) function that combines runs of letters into single elements while discarding anything represented by a zero.

   3. **Processing Each Word**: Since we need to handle words in a [case-insensitive](https://aplwiki.com/wiki/Case_insensitive) manner, we convert our text to uppercase. We then ascertain which characters are vowels, accounting for their positions within words.

   4. **Creating the Vowel Mask**: Each word has its own mask to identify vowels. However, we must ensure that any vowel at the end of a word is not mistakenly removed.

   5. **Finalizing the Compression**: After creating a mask, we determine which characters to keep and which to remove. By applying a [compression](https://aplwiki.com/wiki/Compression) technique, we join the words back together, ensuring to eliminate leading spaces.

## Test Data

   Let's start with some simple test data:

   ```apl
   t←'How are you'
   ```

## Solution A: Cut Method

   This method splits the text into words, processes each word separately, and then rejoins them.

   ```apl
   C←{1↓∊{' ',⍵/⍨1@1(≢⍵)~'AEIOU'∊⍨1⎕C⍵}¨⍵⊆⍨' '≠⍵}
   ```

   Detailed Explanation:

   1. `⍵⊆⍨' '≠⍵`: Split the input into words based on spaces using [enclose](https://aplwiki.com/wiki/Enclose).
   2. `{...}¨`: Apply the following function to [each](https://aplwiki.com/wiki/Each) word:
      - `1⎕C⍵`: [Uppercase](https://aplwiki.com/wiki/Uppercase) the word.
      - `'AEIOU'∊⍨`: Check which characters are vowels using [membership](https://aplwiki.com/wiki/Membership).
      - `1@1(≢⍵)~`: Create a mask with 1s at the start and end, 0s for vowels elsewhere using [at](https://aplwiki.com/wiki/At) and [tally](https://aplwiki.com/wiki/Tally).
      - `⍵/⍨`: Use this mask to filter the original word with [replicate](https://aplwiki.com/wiki/Replicate).
      - `' ',...`: Add a space before each processed word.
   3. `∊`: Join all processed words using [enlist](https://aplwiki.com/wiki/Enlist).
   4. `1↓`: Remove the leading space using [drop](https://aplwiki.com/wiki/Drop).

   This method is intuitive but less performant due to creating a nested array.

## Solution D: Drop Method

   This method processes the entire text at once, using array operations to identify interior vowels.

   ```apl
   D←{⍵/⍨(∊∘'AEIOU'⍲0,¯1↓' '(∧⌿≠)0 1 2↓⍤0 1⊢)1⎕C⍵}
   ```

   Detailed Explanation:

   1. `1⎕C⍵`: [Uppercase](https://aplwiki.com/wiki/Uppercase) the input.
   2. `0 1 2↓⍤0 1⊢`: Create a matrix where each row is a triplet of adjacent characters using [drop](https://aplwiki.com/wiki/Drop) and [rank](https://aplwiki.com/wiki/Rank).
   3. `' '(∧⌿≠)`: Check if all characters in each triplet are non-spaces using [not equal](https://aplwiki.com/wiki/Not_Equal) and [reduce](https://aplwiki.com/wiki/Reduce).
   4. `0,¯1↓`: Add a 0 at the start and remove the last element to align with original text.
   5. `∊∘'AEIOU'⍲`: Combine with a check for vowels using [membership](https://aplwiki.com/wiki/Membership) and [nand](https://aplwiki.com/wiki/Nand).
   6. `⍵/⍨`: Use this mask to filter the original text with [replicate](https://aplwiki.com/wiki/Replicate).

   This method is highly efficient, processing the entire text at once without splitting into words.

## Solution R: Reduce Method

   This method uses a sliding window approach with reduction to identify interior letters.

   ```apl
   R←{⍵/⍨(∊∘'AEIOU'⍲0,0,⍨' '(3∧/≠)⊢)1⎕C⍵}
   ```

   Detailed Explanation:

   1. `1⎕C⍵`: [Uppercase](https://aplwiki.com/wiki/Uppercase) the input.
   2. `' '(3∧/≠)⊢`: Use a sliding window of size 3 to check for non-spaces using [windowed reduction](https://aplwiki.com/wiki/Windowed_Reduction).
   3. `0,0,⍨`: Add 0s at the start and end to align with original text using [catenate](https://aplwiki.com/wiki/Catenate).
   4. `∊∘'AEIOU'⍲`: Combine with a check for vowels using [membership](https://aplwiki.com/wiki/Membership) and [nand](https://aplwiki.com/wiki/Nand).
   5. `⍵/⍨`: Use this mask to filter the original text with [replicate](https://aplwiki.com/wiki/Replicate).

   This method uses reduction techniques to streamline processing, offering excellent performance.

## Solution S: Stencil Method

   This method uses the [stencil](https://aplwiki.com/wiki/Stencil) operator to create a sliding window.

   ```apl
   S←{⍵/⍨(∊∘'AEIOU'⍲(' '(∧/≠)⊢)⌺3)1⎕C⍵}
   ```

   Detailed Explanation:

   1. `1⎕C⍵`: [Uppercase](https://aplwiki.com/wiki/Uppercase) the input.
   2. `(' '(∧/≠)⊢)⌺3`: Use a stencil of size 3 to check for non-spaces.
   3. `∊∘'AEIOU'⍲`: Combine with a check for vowels using [membership](https://aplwiki.com/wiki/Membership) and [nand](https://aplwiki.com/wiki/Nand).
   4. `⍵/⍨`: Use this mask to filter the original text with [replicate](https://aplwiki.com/wiki/Replicate).

   The stencil approach offers competitive results but can be slower than other methods due to complex operand handling.

## Handling Punctuation

   After the initial implementations, we faced challenges with punctuation, specifically letters adjacent to non-space characters, which were erroneously marked for removal. To handle punctuation correctly, we need to modify our solutions to check for letters instead of non-spaces:

   ```apl
   D←{⍵/⍨(∊∘'AEIOU'⍲0,¯1↓⎕A(∧⌿∊)⍨0 1 2↓⍤0 1⊢)1⎕C⍵}
   R←{⍵/⍨(∊∘'AEIOU'⍲0,0,⍨⎕A(3∧/∊)⍨⊢)1⎕C⍵}
   S←{⍵/⍨(∊∘'AEIOU'⍲⎕A(∧/∊)⍨{⍵}⌺3)1⎕C⍵}
   ```

   These modifications ensure that only alphabetical characters are considered as neighbors, resolving the issue with punctuation.

## Regular Expression Solutions

   While not as performant as the APL array solutions for larger inputs, [regular expressions](https://aplwiki.com/wiki/Regular_expression) can provide a concise way to solve this problem, especially for smaller datasets or more complex pattern matching scenarios:

   ```apl
   A←'(?<=\w)[aeiou](?=\w)'⎕R''⍠1     ⍝ look-Arounds
   B←'\b\w|\w\b' '[aeiou]'⎕R'&' ''⍠1  ⍝ word-Boundaries
   ```

   Explanation for A (look-Arounds):

   - `(?<=\w)`: Positive lookbehind for a word character.
   - `[aeiou]`: Match any vowel.
   - `(?=\w)`: Positive lookahead for a word character.
   - `⎕R''`: Replace matches with an empty string.
   - `⍠1`: Case-insensitive flag.

   Explanation for B (word-Boundaries):

   - `\b\w|\w\b`: Match a word character at the start or end of a word.
   - `[aeiou]`: Match any vowel.
   - `⎕R'&' ''`: Replace boundary matches with themselves, and other vowels with an empty string.
   - `⍠1`: Case-insensitive flag.

## Performance Comparison

   To compare the [performance](https://aplwiki.com/wiki/Performance) of these solutions, we can use the `cmpx` utility from the [dfns workspace](https://aplwiki.com/wiki/Dfns_workspace):

   ```apl
   'cmpx' 'dxb'⎕CY'dfns'
   ≢t3←dxb{⍵[?1e3⍴≢⍵]}65↑⎕A,⎕C⎕A,',.?!'
   cmpx'CDRSAB',¨⊂' t3'
   ```

   This code:

   1. Imports the `cmpx` and `dxb` functions from the `dfns` workspace.
   2. Generates a test string `t3` of about 1000 characters, including uppercase and lowercase letters, and some punctuation.
   3. Uses `cmpx` to compare the execution time of all our solutions (Cut, Drop, Reduce, Stencil, and both Regex approaches).

   This comparison allows us to evaluate the efficiency of different approaches to solving the vowel removal problem in APL.

## Glyphs

   - [Enclose](https://aplwiki.com/wiki/Enclose) `⊆` - creates a nested array from a simple array
   - [Not Equal](https://aplwiki.com/wiki/Not_Equal) `≠` - compares two arrays element-wise for inequality
   - [Uppercase](https://aplwiki.com/wiki/Uppercase) `⎕C` - converts characters to uppercase
   - [Membership](https://aplwiki.com/wiki/Membership) `∊` - tests if elements are members of a set
   - [At](https://aplwiki.com/wiki/At) `@` - modifies specific elements of an array
   - [Tally](https://aplwiki.com/wiki/Tally) `≢` - returns the number of major cells in an array
   - [Reverse First](https://aplwiki.com/wiki/Reverse_First) `⊖` - reverses the first dimension of an array
   - [Replicate](https://aplwiki.com/wiki/Replicate) `/` - selects or repeats array elements
   - [Enlist](https://aplwiki.com/wiki/Enlist) `∊` - flattens a nested array into a simple vector
   - [Drop](https://aplwiki.com/wiki/Drop) `↓` - removes elements from the beginning or end of an array
   - [Take](https://aplwiki.com/wiki/Take) `↑` - selects a specified number of elements from an array
   - [Reshape](https://aplwiki.com/wiki/Reshape) `⍴` - creates an array with a specified shape
   - [Reduce](https://aplwiki.com/wiki/Reduce) `/` - applies a function between all elements of an array
   - [Nand](https://aplwiki.com/wiki/Nand) `⍲` - performs a logical NAND operation
   - [Catenate](https://aplwiki.com/wiki/Catenate) `,` - joins arrays along a specified axis
   - [Rank](https://aplwiki.com/wiki/Rank) `⍤` - applies a function to specific ranks of an array
   - [Stencil](https://aplwiki.com/wiki/Stencil) `⌺` - applies a function to sliding windows of an array

## Concepts Used

   - [Dfn](https://aplwiki.com/wiki/Dfn)
   - [Tacit Programming](https://aplwiki.com/wiki/Tacit_programming)
   - [Boolean Mask](https://aplwiki.com/wiki/Boolean)
   - [Partitioned Enclose](https://aplwiki.com/wiki/Partitioned_Enclose)
   - [Each](https://aplwiki.com/wiki/Each)
   - [Compression](https://aplwiki.com/wiki/Compression)
   - [Windowed Reduction](https://aplwiki.com/wiki/Windowed_Reduction)
   - [Stencil](https://aplwiki.com/wiki/Stencil)
   - [Regular Expressions](https://aplwiki.com/wiki/Regular_expression)
   - [Performance Comparison](https://aplwiki.com/wiki/Performance)
   - [Dfns Workspace](https://aplwiki.com/wiki/Dfns_workspace)
   - [Array Operations](https://aplwiki.com/wiki/Array_programming)
   - [Text Manipulation](https://aplwiki.com/wiki/Text_processing)
   - [Case Insensitivity](https://aplwiki.com/wiki/Case_insensitive)

## Transcript:

Hello and welcome to the APL Quest. Today's quest is the second problem from the 2014 round of the APL Problem Solver Competition. We're given a text and have to find the words in that text and remove any vowels from the words, except if the vowel begins the word or the vowel ends the word. Let's get started with some test data.

Okay, we can identify where we have spaces and non-spaces in our text. Then we can use this to partition the text because partition will take elements (letters here) that correspond to runs of ones and group them together in a single element. Any letter or character that corresponds to a zero will be discarded, and at this point, we'll begin a new segment.

So, we partition using this mask. Now it's a question of processing each word separately because we need to be case insensitive. We have to handle all kinds of vowels in uppercase and lowercase. We can start by uppercasing our words, and we can then find out which letters are vowels. This gives us one mask per word.

There's a problem, however. You can see that in the third word, the last letter is marked as a vowel, and we really don't want to consider the vowel that can be removed. Also, our masks are inverses of what we actually want since we're going to use compress to remove vowels. Then we should have zeros for the characters we want to remove and one for those we want to keep. That part is super easy to fix; we just negate it.

Then we need to take care of the issue of putting a one always at the front and at the end. Well, that we can do. We can amend this vector with one at position one and also at the position of the length of the word. Now we're ready to do the compression. Looks good, and we just need to join things together with spaces.

Since we're already processing each word, we can just stick a space in front of each word, enlist the whole thing, and remove the leading space. This solution is nice in the sense that it expresses APL very much how we think about the problem. Let's call it "c" for cut.

There are other ways to address the problem, however, which avoid splitting up the text and processing each word one at a time. Rather, the ideal when doing array-based programming is to process the entire array in one go. Let's see how we can do that.

This time we're going to start with uppercasing everything, and then we need to match up the previous letter and the next letter with the middle letter in order to identify whether or not we are at a word and word boundary. Of course, the first letter doesn't have a left neighbor, but we could possibly supply that.

Now, in order to match up the left neighbor, the letter itself, and the right neighbor, we can drop. So, here's the left neighbor. The left neighbor of the "h" in "how" is that space. We drop one, we get the "h" itself, and if we drop two, then we get the neighbor on the right. We want to drop all three possibilities: zero, one, and two. And we want this dropping to be done on the entire vector.

So, we can say we want on and we want to drop using rank 0 every single number scalar from the left, and we want 1 because we want to treat the entire vector on the right. Now we can compare these this whole matrix to spaces, for example, and like this, we can put it inside the parenthesis. And we know that a letter is internal if all these three—the left neighbor, this letter, and the next letter—all are none spaces. So, and we can combine this not equal with a vertical and reduction.

The only problem we have now is that, and since we added a character, we have one character too many. And that we used this to push things to the right, and when we didn't drop enough, then one character from the end got pushed too far. We can see this above here. The last character we have is the "u," and its left neighbor and its right neighbor and here is another space that's been added which we don't actually want. We can fix this, however, just by dropping the last element.

Another way we could do it is by not adding the space on the left because that will just give us all the information for all the characters except the first one. We know that the first character is not one that we should consider an interior character because it's right next to the beginning. So, we can just add a zero on the left, and that will give us the same result exactly.

Now, the only thing that remains is to check if and the these the letters are also vowels. So, we can do this by simply saying member of AEIOU the vowels. That gives us this mask, and so these two masks are the ones we're going to combine. If a letter is both interior and it's a vowel, then that's a letter that we can remove. So, let's combine the two parts, and this points out which letters we have to remove. But again, we want to use compress, so we want to mark instead the letters that we want to keep. We could negate it, but we can also just combine the negation with and into an end.

Now we are ready to do the compression. That works very nicely. Let's call this one "d" for drop because we're using drop in various places. We talk about these neighbors, and we can look at these triplets another way to do this is by using nys reduce. So, let's start over with our text and uppercasing it. We can and we can look at triplets. Initially, we can try just concatenating them together. So, these are the triplets. But instead of applying and this invoice reduce on the letters themselves, let's do it on the boolean mask of whether there are none spaces. And now we just need to reduce each one of these with an end reduction just like we did before.

We don't need to do this outside of the nys reduction because analyze reduction is indeed an introduction on each sliding window of the size three in our case. And that gives us the mask for which letters are interior letters, which means we can just combine all of this with um our way of finding the um the vowels in exactly the same way. Oops, oh yeah, of course. Since we have sliding windows that don't um that begin at the very left edge and we have sliding window size three, that means that we don't have a corresponding element for the very leftmost and very rightmost letters. But we know that those are boundary letters, and so we can just supply those.

That gives us our mask, and we're ready to do the compression just like we did before. Let's call this one "r" for reduction and voice reduction. Another way to look at neighborhoods is using stencil. So, let's try this again. Uppercasing that, and this time we're going to use stencil. And stencil with a window size of three applies its operand on each sliding window. At the edges, if necessary, it pads, and it is necessary in our case. We want window sizes of three, and every element gets a chance to be the center of a neighborhood of size three. Stencil with pad with appropriate padding, which for text is spaces, and that's great. That's exactly what we want.

What operand are we going to give to stencil? We're not interested in the left argument to the operand, which is the padding information. We just want the right argument, and we again, we want to know where it is all true that the letters are different from space. That gives us our mask including the zeros. So, this is exactly what we had before with the end wise reduction, and we can just copy the rest of our code in. This is our stencil "s" function.

Now it will be interesting to compare the performance of these, wouldn't it? Let's do that. Um, but for our test case is tiny, we also need to generate some larger test data. So, now I'm going to copy in the cmpx utility, which measures performance, and also for convenience, I'll have the delete extraneous blanks in order to generate our test data. Copy those from the decent workspace. Okay, for our test data, and let's have some uppercase characters and some lowercase characters. And then we need to have some spaces as well and in a nice proportion. I'd say if we take about 60 and overtake then we get and a bunch of spaces at the end. Then then let's choose some random ones from this. So, random and we'll take a thousand of those from all of them the length of that.

So, this gives us a bunch of letters. If we just take the first hundred of those to have a look at what they could look like, we can see here at the end we have some some double spaces. So, that's why we need to apply delete extraneous blanks. And then that won't happen no more double blinks. Okay, then we're ready to assign this. It's not even though I asked for a thousand, it's of course not exactly going to be a thousand because we're deleting some spaces here and there, but it's close enough for purposes.

And let's generate some APL expressions that we're going to compare the performance of. And we had "c" for the cut method and "d" for the drop. We had "r" for reduce and "s" for stencil. Each one of those is going to become called on the entirety of this test data here. So, these are our three APL expressions, and now we're running the timings on those. See what that looks like. All right, well, that's pretty significant differences we've got there. And the cut method, which is our baseline, is not very good compared to uh to using drop and reduce. That's because uh draven uses are entirely flat uh solutions, whereas uh when we cut into individual words, then we get a pointer array and one pointer pro word, and that's going to be very expensive to traverse. So, that one's basically out. There's nothing we can do to fix that.

Stencil, that doesn't look good at all. And the reason is that we gave a rather complex operand to stencil, and there are just a few common patterns that when addressed when expressed as defense have been optimized very heavily, and they will give us way better performance. So, let's see if we can use one of those instead. So, I know that one thing we can do with stencil that's super fast is just getting uh getting the right argument. Now, since we have neighborhoods of three and from a vector, that means every such neighborhood is a vector in itself. And stencil will collect them into an array where the major cells are these vectors. So, an array that consists of vectors is a matrix. We'll get one neighborhood per row, and all we need to do now um is the exact same thing here. We're just comparing two spaces and then we are reducing across the rows. So, all this should just work in exactly the same way.

And let's try it on our small test case. Oops, yeah, I made a mistake here. I am missing a space. Nope, not necessarily. I made, I haven't parenthesis that could be missing or we can just remove this parenthesis over here. That's why it was read before. Okay, let's try it again. There we go now it works. Right. So, and let's do this comparison again with the new updated stencil version. But this time we're going to skip the one that that cuts using petition because that's hopeless. Stencil is still the slowest of the string, but uh it's not bad right. They're all very similar to each other, and if something is convenient to express using stencil, then by all means, it can work very nicely. And then you don't have to worry about how much padding you need for various sizes, which you didn't need to worry about for the anyways reduce, but there's another problem.

And that is let's update our uh our small test case with some punctuation. The problem here is with the final letter. Since we are detecting whether the characters that are non-spaces then question mark is a non-space and u will be considered an internal letter. So, for example, using this "s," we can see that "o" and "u" get removed, which is of course wrong. So, how can we fix this? Well, here are our definitions. The problem is that we are using the property of being a non-space to identify which characters are eligible to be uh be removed and which ones are have non-space neighbors. I really want to turn it upside down. We want in order for a character to be considered an interior letter, it's it's the determining factor there is that its neighbors are also letters, not just non-space characters, but letters. So, we just need to turn things around a little bit.

For the dropping method, the only thing that we need to do is to check if and characters are in the set of uppercase letters and membership goes the other way around. So, we can swap that. And if they are letters, all of them, then and we have an interior letter. And actually, the exact same thing applies to all of these solutions. So here, with an invoice reduce, instead of checking whether we have taken whether we have none letters, we just look whether or not they are members in uppercase alphabet. And so too with stencil. Instead of checking whether or not and we have none letters, we just check whether or not they are members of topics alphabet.

And now we can generate new test data. So, this time we're going to have uppercase letters and lowercase letters and also some punctuation. Let's say 65 overtaking that to get some some spaces there. And then we just use the same formula as before. We want random about a thousand of the length of the argument. And this time we don't need to remove extra blanks. Right. The comparison we're going to do is exactly the same as before. And the performance is very similar to what we had before, but this time we are correctly handling all of these. So, we can see it for example with the dropping on "t" and reduce on "t" and stencil and "t." You can see that the "u" remains right there. So, these are good solutions, APL solutions. There's another approach, though, and sometimes it's more convenient, and that is to use regular expressions.

And we found two interesting ways of doing this using regular expressions. What we can do is we can we want to look for some characters and then we want to remove them, and we want to do so case insensitively. The letters that we want to remove are the vowels, but we don't want to remove all the vowels. We want to make some assertions about these vowels. What we want to assert is that on the left we have a word character. If there's not a word character on the left, then we're not interested in this vowel. That also means is the first character in this in the input, then we're not interested in it. We also want to to make sure that on the right we have a word character. If it's the last character in the whole input, then there are no characters to the right, and we're also not interested. It's important to note that these look arounds or look behind look ahead are not part of what's being matched. They're just something that's being checked when we try to match them. So, that works as intended.

It can be hard to think about these uh assertions. I personally find it easier to think about things in a different way and that's with what you could call exception patterns to detect things and let them go through. So again, we we do want all the vowels and we want them removed, but we want to preserve some. Which ones are that we want to preserve? We want to preserve any any letter that is preceded by a word boundary. So, that means it's on the left edge of a word or at the right edge of a word. So, those will replace with themselves, and any vowel that remains after that that hasn't been consumed by the first pattern we're going to replace with nothing. So, let's call this one "b" for word boundaries and the one we had before we'll call it "a" for look around. And then we can compare the performance of these.

So now we have a drop, we have reduce, we have stencil, and then we have look arounds and word boundaries. Each one we're going to run on the entire expression of an entire argument of "t3." And we'll we can oh we didn't get the exact same result uh why is that? This is look ahead. Oh well, that's interesting. This works well. Let's do some debugging and see what uh what's happening here. We can start with some of our string. So, if you take a hundred from "t3" and then we can oh so we can even do it like this. We can say is "d" matching "a" for a hundred of "t3"? Nope, is it so for 50 of "t3"? How about for 25? Yes. 25 no okay so now we can look at 25 take "t3" and see what is it that's uh oh this is at the very first space at the very first space so "d" removes the internal vowels like this "o" for example and "a" we removed one more thing than "d" where they different oh did I simply forget a an "i" oh "d" didn't remove the "i" that's interesting. This "i" doesn't get removed but we clearly have an "i" here removes it uppercase "i" gets removed so what's going on here why is "d" not removing this oh I see it's because I've did I put in digits by mistake in our test test data that's what it is oh yes I'd put in a one over here that should have been an exclamation point so much for that there was some troubleshooting right there.

Let's try the performance again but it shouldn't really make a big big difference in the results that we get. There we go now we can see it finally uh so the performance using regular expressions is not good compared to the APL solutions and with multiple patterns it's even worse than with a single pattern with with look around but hey sometimes regex is the way to go especially if the smaller amount of data or it's something that's very complex to express or it's something you just need a one-off and not running times then it could be quite fine but we should definitely prefer an array oriented solution if at all possible. Thank you so much for watching.
