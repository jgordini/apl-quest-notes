
# Finding Locations of Identical Characters in Text

In this article, we will explore a method for identifying the locations of characters in a given text where those characters are followed by an identical character immediately to the right. Our goal is not to retrieve the characters themselves or their indices, but rather to produce a mask that indicates where such pairs begin.

## Overview

A classic example of text processing in APL is using the word "Mississippi," as it contains a variety of duplicated characters. However, it only has two identical characters in a row. To expand our example, we will consider cases where we have three consecutive identical characters, allowing for overlapping pairs. 

The output mask will contain:

- `0` for positions where the characters do not match.
- `1` for positions where identical characters are found.

For instance, in the string "Mississippi", we can generate the mask with the following APL function:

```apl
{2=/⍵}'Mississippi 39111'
```

This outputs:

```plaintext
0 0 1 0 0 1 0 0 1 0 0 0 0 0 1 1
```

Here, the last character is not followed by another character, so we end with a zero.

## Implementation with Lambda Function

We will start with a Lambda function and refer to the function's argument as `Ω`, which symbolizes the rightmost character of the Greek alphabet.

Using the `reducing` operation (represented by `NY`), we will examine all windows of length 2 and reduce them using equality, effectively inserting a comparison between the two characters. 

You might notice that if our string does not contain any pairs, we end up with an incomplete mask. As a remedy, we can use an alternative approach, like this:

```apl
{(2=/⍵),0}'Mississippi 39111'
```

This outputs:

```plaintext
0 0 1 0 0 1 0 0 1 0 0 0 0 0 1 1 0
```

### Handling Edge Cases

To address the issue of empty strings, we can extend the string with a character that doesn't appear elsewhere, allowing us to complete the expected output. Yet, if the last character is already such an added character (like a space or a plus), the result might be inaccurate. 

When examining special characters, we can attempt this with the added characters:

```apl
{2=/⍵,'+'}¨'Mississippi 39111' ''
```

This gives us a structured output, ensuring we address empty cases:

```plaintext
┌─────────────────────────────────┬┐
│0 0 1 0 0 1 0 0 1 0 0 0 0 0 1 1 0││
└─────────────────────────────────┴┘
```

## A More Robust Solution

One clever solution involves reversing the argument. By applying operations on the reversed string, we can safely check for the last character without affecting the initial characters. For instance:

```apl
{⌽⍵}¨'Mississippi 39111' '' 'C++'
```

This outputs:

```plaintext
┌─────────────────┬┬───┐
│11193 ippississiM││++C│
└─────────────────┴┴───┘
```

We also want to ensure we safely navigate through added characters. After extracting the right characters, we can generate a comparison:

```apl
{⊃'+-'~⊃⌽⍵}¨'Mississippi 39111' '' 'C++'
```

### Concatenating for a Safe Result

After appending our safe filler character, we can perform the reduction to ensure our results include a correct mask.

### Adding the Final Zero

An alternative approach is to explicitly append a zero at the end of our processed output. However, we must ensure we do not encounter length issues when dealing with empty inputs.

```apl
{2=/⍵,⊃'+'~⊃⌽⍵}¨'Mississippi 39111' '' 'C++'
```

This gives us:

```plaintext
┌─────────────────────────────────┬┬─────┐
│0 0 1 0 0 1 0 0 1 0 0 0 0 0 1 1 0││0 1 0│
└─────────────────────────────────┴┴─────┘
```

## Conclusion

This method of using Lambda functions and reducing operations gives us a clear path to creating a function that can reliably determine the positions of identical characters followed by the same characters within text. 

By transforming this function into a tested form, expressed explicitly through its structural relationships rather than direct references, we achieve a cleaner and more elegant solution.

Thank you for taking the time to delve into this fascinating topic!
