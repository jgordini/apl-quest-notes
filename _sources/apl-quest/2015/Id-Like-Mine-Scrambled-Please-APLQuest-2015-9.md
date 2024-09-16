# APL Quest: Swapping Interior Letters

Welcome to the APL Quest! For detailed information, check the APL Wiki. Today's quest is the ninth from the 2015 round of the APL problem-solving competition.

## Problem Description

We are given a word, represented as a character vector, and our task is to swap interior letters two at a time while keeping the first and last letters in place. This means:

- The second and third letters get swapped.
- The fourth and fifth letters get swapped.
- If there's a final interior letter without a partner, it remains unchanged.

Several approaches can be taken to solve this problem. Below, we outline a few methods along with simple test cases.

### Test Cases

To make the task easier to visualize, we will uppercase the letters that remain in place. The casing has no significance beyond helping us highlight the letters that do not change. 

For example:
- For the input "abcdef", we expect the output to be "abdcfe".
- For the input "a", the output should remain "a".
- For the input "ab", the output should remain "ab".

### Approach 1: Pairing and Flipping

Our first approach involves literally pairing up the letters and flipping them before putting them back together. 

To implement this:
1. Take the length of the argument and reshape it into partitions of size 2.
2. The first (always the first letter) and last letters remain untouched.

Using the partitioning function defined below, we can easily achieve this:

```apl
⍝ Function to partition and flip interior letters
F ← { ∊⌽¨⍵⊂⍨ 1@1(≢⍵)⊢ 0 1⍴⍨ ≢⍵ }

⍝ Example test case
word ← 'abcdef'
flippedWord ← F word
```

### Approach 2: Using Stencil

An alternative approach is to use stencil, which can efficiently traverse the array and chunk it into pieces. 

We can start off with a stencil with a window size of 2 and a step size of 2. This allows us to shift through the elements without overlap:

```apl
⍝ Stencil function for swapping letters
G ← { (⊢/⍵),⍨⍵∩⍨,⌽⊢⌺(⍪2 2)⊢' ',' ',⍨¯1↓⍵ }

⍝ Example using stencil
stenciledWord ← G word
```

### Approach 3: In-Place Reordering

Another method involves in-place reordering. We can manipulate the positions where they already are, thereby avoiding the need for additional memory allocation.

For implementation:
1. Create a list of indices for the medial elements.
2. Use a vector to iterate and swap elements.

A sample implementation using a reverse function:

```apl
⍝ Reverse function for reordering
H ← { {,⌽(2÷⍨≢⍵) 2⍴⍵} @(1+⍳0⌈2(⊢-|+⊣) ≢⍵)⊢⍵ }

⍝ Example for in-place reorder
reorderedWord ← H word
```

### Approach 4: Generating a Permutation Vector

Instead of reordering in-place, we could derive a permutation vector based on the relationship of the indices. This can then be used for indexing.

To build the permutation vector:
1. Create a sequence that details the necessary swaps.
2. Use the grade function to sort and create a permutation vector.

Example implementation:

```apl
⍝ Function to create permutation index
J ← { ⍵[n,⍨⍋¯1(⊢+*)⍳¯1+n←≢⍵] }

⍝ Example for generating permutation vector
permutationWord ← J word
```

### Performance Comparison

To evaluate the efficiency of the above methods, we can generate random words and measure the time taken by each approach. 

```apl
⍝ Example Random Word Generation
alphabet ← 'abcdefghijklmnopqrstuvwxyz'
w ← { ⎕A[?26⍴⍨?10] }¨⍳1000
results ← 'cmpx'⎕CY'dfns'
cmpx 'FGHIJ',¨⊂'¨w'
```

After testing all methods, we concluded that generating the permutation vector using grade yields optimal performance.

## Conclusion

In summary, swapping interior letters in a character vector can be approached in several ways, from literal pairings to generating permutation vectors. The most effective solution identified involves using grade for indexing, showcasing a clear, efficient APL approach.

Thank you for participating in the APL Quest!