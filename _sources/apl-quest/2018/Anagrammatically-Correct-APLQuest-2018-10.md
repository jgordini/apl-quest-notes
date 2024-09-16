
# Comparing Two Character Vectors: An Anagram Checker

In today's quest, we will explore how to compare two character vectors or scalars—specifically, the economic strings—and determine whether they are anagrams of each other. The definition of an anagram here is that the two strings contain the exact same letters. 

## Anagram Definition

- **Case Sensitivity:** We only care about one letter case at a time.
- **Spaces:** All spaces are ignored.
- **Punctuation:** We don't have to worry about punctuation.

Let's get started!

## Setting Up Arguments

I have prepared a couple of left arguments and a couple of right arguments that we can use. Below are the left and right arguments we will be comparing:

```apl
a ← 'ALBERT EINSTEIN' 'AB' 
b ← 'TEN ELITE BRAINS' 'CAB'
```

We will start by pairing them up correctly, with the left arguments on the left and the right arguments on the right. 

We will utilize an anonymous Lambda function to pair each element from the left arguments with the right arguments. The name of the left argument inside this function is `Alpha`, and the right argument is `Omega`, which represent the left and right most letters of the Greek alphabet, respectively.

### Initial Pairing

At this point, the pairs are not ready for comparison. We must first carry out a couple of preprocessing steps.

## Preprocessing Steps

### Step 1: Removing Spaces

The first preprocessing step is to remove spaces. We can accomplish this using the `without` or `set difference` function. Here, we are removing constants, specifically spaces, so we can bind this function to a constant. This creates a derived function, which we will call `without_spaces`.

In APL, we can express this step:
```apl
a {⍺⍵}¨ b
```
This results in the following output:
```
┌──────────────────────────────────┬─────────┐
│┌───────────────┬────────────────┐│┌───┬───┐│
││ALBERT EINSTEIN│TEN ELITE BRAINS│││A B│CAB││
│└───────────────┴────────────────┘│└───┴───┘│
└──────────────────────────────────┴─────────┘
```

### Step 2: Sorting Characters

Next, we need to ensure the ordering of letters is consistent. An easy way to achieve this is through sorting. We can utilize a helper function that takes an argument and finds the elements in the positions of the sorted version of that argument. 

In APL, we can perform this sorting and removal of spaces as follows:
```apl
a {⍺⍵}⍥(~∘' ')¨ b
```
This gives us the output:
```
┌───────────────────────────────┬────────┐
│┌──────────────┬──────────────┐│┌──┬───┐│
││ALBERTEINSTEIN│TENELITEBRAINS│││AB│CAB││
│└──────────────┴──────────────┘│└──┴───┘│
└───────────────────────────────┴────────┘
```

### Step 3: Comparison

Now that we have preprocessed both arguments, we can compare the two strings to determine if they are anagrams. 

In APL, we can utilize the following expression to compare the sorted strings:
```apl
a {⍺≡⍵}⍥({⍵[⍋⍵]}~∘' ')¨ b
```
This results in:
```
1 0
```

### Simplifying with a Lambda Function

We can simplify our approach further by observing that we have a Lambda which contains a single primitive function that merely takes arguments. This wrapping is unnecessary, so we can apply the primitive function directly.

Thus, we can directly compare the sorted arguments:
```apl
a ≡⍥({⍵[⍋⍵]}~∘' ')¨ b
```
Output:
```
1 0
```

## Final Steps

With our simplified approach in mind, we can give this a name and then compare each element from the left arguments with those in the right arguments. 

```apl
F ← ≡⍥({⍵[⍋⍵]}~∘' ')
a F¨ b
```
Output:
```
1 0
```

### Conclusion

By following these steps, we can effectively determine which pairs of character vectors are anagrams of each other. Thank you for watching!
