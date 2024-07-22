
# APL Quest: Delimiter Splitting Challenge

Welcome to the APL Quest! For details, please see the [APL Wiki](https://aplwiki.com).

## Introduction

Today's quest marks the 9th challenge from the 2016 round of the APL problem-solving competition. In this challenge, we will take a text input and split it based on a set of delimiters. However, there is a catch: we will not be using just one delimiter but multiple delimiters. 

## Sample Text

Let's start with a sample text that contains two different types of delimiters: commas and semicolons. We also have consecutive delimiters, which means we must respect them to produce empty segments in our output.

To handle this, our left argument will include both the comma and the semicolon. We utilize APL’s infix user-defined functions, specifically a Lambda-type function known as a definite function. In this function, the left argument is denoted by alpha (the first letter of the Greek alphabet), and the right argument is denoted by omega (the last letter of the Greek alphabet).

## Identifying Delimiters

The goal here is to identify the locations of the delimiters in our text. To do this, we can use the membership function, which vectorizes our search. We will examine every element of the right argument to check if it matches any element in the left argument, resulting in a Boolean mask that indicates where we will start our segments.

For instance, the two `1`s in the mask after five characters correspond to the two commas in our text. 

We can use the following APL expressions to identify our delimiters:

```apl
delimiters ← {⍺ ⍵}
isDelimiter ← {⍵∊⍺}
```

However, there is a problem. If we attempt to split using this mask with a partition function, we will lose the initial portion of the text (e.g., "hello"). The partitioning function splits each time it encounters a `1`, which causes the loss of segments preceding the first delimiter.

To resolve this, we need to begin our partitioning with a position marker right from the start. This requires us to insert a delimiter at the beginning of our text.

## A Note on Syntax

Before proceeding, I’d like to express my opinion about using parentheses in APL. I prefer not to use parentheses for controlling the order of execution due to APL’s long right scope. In APL, everything to the right of a function pertains to its right argument, and immediately to the left relates to the left argument.

Because we have a complex left argument (the whole expression in the partition function), we are often forced to add parentheses. If only we had a function that mirrored the partition function but with swapped arguments! Unfortunately, we don’t, but we do have a modifier, also known as a magnetic operator in APL terminology, that can modify a function's arguments.

## Using Membership and Modifiers

We can use this modifier to swap our arguments. We can formulate the partitioning expression as follows:

```apl
partitioned ← {⍵⊂⍨⍵∊⍺}
```

So now, we can place the omega on the left and the omega member of alpha on the right, achieving the desired effect.

Yet, we still face the issue of needing a delimiter at the start. How can we accomplish this? By substituting the omega for a variable.

We utilize the `Diamond` symbol (`♦`) to separate statements in APL, signifying unbreakable sequences. We can create our variable, which will represent the omega. Next, we want to prepend a delimiter.

To do this, we apply the `first` function to our alpha, yielding one of the delimiters. If we concatenate this value, it would end up at the end of the segments. Instead, by swapping the arguments, we can place it at the front.

This gives us segments in the right format. However, since each segment contains an extra delimiter, we need to drop one from each. This is where we can leverage the modifier, which acts like a mapping function, modifying the drop operation.

### A More Compact Expression

We can also write this in a more compact way by combining statements. If we place `T` (our result variable) at the end of the expression, we could rewrite it to simplify our code.

By swapping the membership, we can still achieve the same result. This allows us to write the entire operation as a single expression, and we still need to keep the assignment for subsequent use.

Here’s how we can write it:

```apl
result ← {t←⍵,⍨⊃⍺ ⋄ 1↓¨t⊂⍨t∊⍺}
```

Alternatively, we could choose to split on vowels or any other criteria as well.

## Conclusion

Thank you for watching! This concludes our introduction to the APL Quest and the effective problem-solving techniques in APL.
