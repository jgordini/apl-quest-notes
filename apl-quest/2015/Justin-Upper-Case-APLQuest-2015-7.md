
# APL Quest: Problem 7 from the 2015 APL Problem Solver Competition

## Introduction

Welcome to the APL Quest! In this article, we will discuss today's problem, which is the seventh challenge from the 2015 round of the APL Problem Solver Competition. The task at hand is quite simple: we need to extend membership testing so that it becomes case insensitive.

## Problem Overview

Let’s begin with two arrays. We will take the first six letters of the alphabet and some random four letters. When we attempt to check for membership, we find that it fails to recognize letters that have different cases. For example, even though we expect 'c' and 'd' to be members, the current implementation indicates they are not:

```apl
letters = 'abcdef'
randomLetters = 'CDEF'
membership = randomLetters ∊ letters  ⍝ This will return 0
```

The previously defined membership function does not account for case differences.

## Normalizing Case

To address this issue, we need to apply a normalization procedure known as "case folding." We will use the `quad c` operator to case fold both our left and right arguments so that we can compare them in a case-insensitive manner:

```apl
membership = quad c randomLetters ∊ quad c letters  ⍝ This will return 1
```

With this adjustment, we can see that 'c' and 'd' are indeed members of the set.

## Improving the Code

Now, let's optimize our approach by converting this into a tested function. Instead of using `omega`, we will use `write tech` and replace `alpha` with `left tech`. This still works, but we can improve readability:

```apl
membership = {⊃((quad c ⍵) ⍋ quad c) ⊆ (quad c ⍵)}  
```

Here, we preprocess both the left and right arguments simultaneously without duplicating the case-folding function. Since this isn’t a train anymore, we can simplify it as a derived function without parentheses.

## High Rank Arrays Issue

The problem statement specifies that the solution should also work for high rank arrays. Let’s create a high rank array with 3 rows and 2 columns and check membership:

```apl
highRankLetters = (3 2⍴⎕A)  ⍝ A matrix of the first 6 letters
membership = highRankLetters ∊ 'cdxy'  ⍝ This will return 0 1 0
```

Now we should query whether specific rows are members. For instance, the row containing 'c' and 'd' should be present in the matrix on the right. When we try it, however, we might receive unexpected results because the membership test works element by element, checking if 'a' is a member, then 'b,' and so forth, rather than checking the entire row.

## Full Row Match

We need an approach that checks for membership of entire rows instead. This can be achieved by isolating the major cells and performing membership checks on them:

```apl
membership = {∧(⎕C⊣ ⍤⊢⍴⎕C) ⊆ (⎕C⊢⍤⊣ ⍵)}  ⍝ Check for complete rows
```

This effectively tests membership case insensitively on the enclosed major cells.

## Alternative Solution

There’s actually a more elegant method that avoids using the membership operator altogether. We can leverage `tyadik iota`, which provides indices with opposite argument order:

```apl
F ← ⍳⍨⍥⎕C≤≢⍤⊢
membership = (3 2⍴⎕A) F (2 2⍴'cdxy')  ⍝ This will return indices where matches occur
```

This implementation checks where the major cells from the right are found in the left argument.

## Conclusion

In summary, by evaluating whether the index of each major cell is less than or equal to the maximum length of the right argument with functions like `F`, we determine membership. This yields a concise solution that elegantly handles the requirements posed by the problem statement.

Let’s finalize by naming our function, allowing us to use it effectively without the need for parentheses.

```apl
(3 2⍴⎕A) F (2 2⍴'cdxy')  ⍝ Final function call demonstrating membership
```

Thank you for watching!
