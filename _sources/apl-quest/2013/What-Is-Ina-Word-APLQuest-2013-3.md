
# What is in a Word? 2013-3

Welcome to the third APL Quest! For details, check the [APL Wiki](https://aplwiki.com).

## Problem Overview

Today's quest is based on the third problem from the 2013 round of the [APL Problem Solving Competition](https://problems.tryapl.org/psets/2013.html?goto=P3_What_Is_In_a_Word) titled "What is in a Word." The task is to write a function that returns the number of words in a given text. The input can either be a single character or a vector of characters.

### Definition of a Word

For this problem, a word is defined as being space-delimited. There can be multiple spaces between words, as well as leading and trailing spaces in the input, which we must account for.

## Test Data Preparation

Let's begin by creating some test data. Here’s a normal text but with a dash included to ensure that we are splitting on the correct delimiters:

- This is a normal text.
- This is a single letter: "A"
- Empty input.
- Text with leading and trailing spaces: "   Hello   World   "

## Initial Approach

The most straightforward approach is to split on sequences of spaces. We can compare an input string with a space, which gives us a Boolean vector indicating where the spaces are. The `partition` function can then be used to group runs of ones.

By partitioning the string itself with this mask, we can extract individual words and count them. This method works even for strings with multiple spaces.

Here’s how we can implement this in APL:

```apl
F ← ≢' '∘≠⊆ ⍝ Function to count words by splitting on spaces
```

### Handling Edge Cases

Using this method hits a snag when dealing with a single letter since there are no spaces to partition, so we must first reshape the input. Fortunately, this method also works for empty inputs.

## A Regular Expression Approach

If you come from other programming language backgrounds, like Perl, you might reach for regular expressions. In this case, we can apply the `quad s` function, a Regex search, with an inverted character class to find sequences of non-spaces.

The pattern would match any sequence of spaces (one or more), and while we don't need to return the actual matches, we can use it to count the occurrences instead. This method also holds up for single letters and empty inputs. Here’s the APL implementation:

```apl
G ← ≢'[^ ]+'⎕S 3 ⍝ Using regex to count sequences of non-spaces
```

## Utilizing Built-in Functions

An interesting solution involves using a built-in function called `vfi`, which verifies and fixes input. This function parses the text, removing extraneous spaces and returning useful metadata about the conversion process.

We simply count the boolean values indicating successful conversions and can do so for varied inputs, including empty strings and strings with extra spaces. The implementation in APL is as follows:

```apl
H ← ≢∘⊃⎕VFI ⍝ Using VFI to count words
```

## Optimizing with Boolean Masks

We can further increase performance by working with Boolean masks. This allows us to analyze the input, focusing on transitions between spaces and non-spaces directly.

By comparing adjacent elements with a pairwise reduction, we can find the beginning of words, indicated by a transition from zero to one in our Boolean mask. Here’s an example of this implementation:

```apl
I ← {+/2</' '≠' ',⍵} ⍝ Counting transitions from spaces to non-spaces
```

### Fixing Missing Transition Issues

However, if the string doesn't start with spaces, we may miss the first indicator of a word. We can fix this by inserting a space artificially at the beginning, ensuring our transition logic works as intended.

Alternatively, we can add the count of words indicated by the first element without modifying the input string, which improves performance by avoiding unnecessary copies.

To maximize efficiency, particularly for large inputs, we need to just focus on appending rather than prepending elements, leading to cheaper operations. This method is represented in APL as follows:

```apl
J ← {+/2</0,' '≠⍵} ⍝ Counting words while considering the leading space
```

## Final Function Implementation

After compiling the different proposed solutions, we compare their performance using a test string containing random elements. For our tests, we can generate a random string as shown below:

```apl
t ← 'abc '[?1e6⍴4] ⍝ Generating a random string of 'abc ' characters
```

We'll then evaluate the performance of each function.

```apl
'cmpx'⎕cy'dfns' ⍝ Importing CMPX for performance evaluation
cmpx 'F t' 'G t' 'H t' 'I t' ⍝ Evaluating performance of each function
```

## Performance Analysis

Ultimately, splitting into substrings and using the regex engine tend to be costly operations, while the last solutions utilizing Boolean masks are significantly faster.

From our tests, it is confirmed that appending bits rather than prepending yields the best performance, especially for large inputs.

Thank you for watching, and see you next week!

## Additional Resources

- [Tally](https://aplwiki.com/wiki/Tally)
- [Partition](https://aplwiki.com/wiki/Partition)
- [Verify and Fix Input](https://xpqz.github.io/cultivations/Constants.html?highlight=fix%20input#verify-and-fix-input-vfi)
- [String Search](http://help.dyalog.com/18.0/index.htm#Language/System%20Functions/r.htm)
- [Regular Expressions](https://xpqz.github.io/cultivations/Regex.html)
