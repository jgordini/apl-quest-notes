# APL Quest: Anagrams Problem

Welcome to the APL Quest! For more details, please see the APL Wiki.

Today's quest is the first from the 2015 round of the APL problem-solving competition. We are given two character vectors and need to check whether or not these are anagrams.

## Understanding Anagrams

Here's a simple test case: we need to compare two character vectors to see if they're the same. However, we want to ignore various aspects such as capitalization, punctuation, and spacing. In other words, we want to focus solely on the actual letters present.

### Filtering Letters

To achieve this, we can filter the letters such that they are members of the alphabet, either in uppercase or lowercase. We can use the following APL expression to check the membership of letters in a string:

```apl
y ← 'Nag A Ram!'
{⍵/⍨⍵∊⍥⎕C⎕A} y
```

Next, we need to paste fold these letters so that we can compare the ones from the two different character vectors. Filtering by membership is essentially the definition of intersection, so we can rephrase this as performing a case-insensitive intersection:

```apl
{⍵∩⍥⎕C⎕A} y
```

After obtaining the letters, they need to be arranged in a universal order. If two sets of letters are anagrams of each other (i.e., they are scrambles or shuffles of each other), sorting them will yield the same order. Thus, by sorting the letters, we can define a function with this definition:

```apl
{l[⍋l←⍵∩⍥⎕C⎕A]} y
```

### Normalization and Comparison

We preprocess the arguments `x` and `y` using this normalization, allowing us to determine if they are anagrams. We can compare the sorted versions of the filtered letters with:

```apl
x ← 'anagram'
x ≡ ⍥{l[⍋l←⍵∩⍥⎕C⎕A]} y
```

This approach may be one of the shortest solutions available, but it does come with a few issues.

For example, grading can be an expensive operation, while sorting can be accomplished more quickly. For the fastest sort, we should use an idiom optimized for this purpose. We can define a function `A` to represent this optimized sorting:

```apl
A ← ≡⍥{l[⍋l←⍵∩⍥⎕C⎕A]} ⍝ shortest
```

Furthermore, if there is a lot of punctuation, we are inadvertently case-folding those characters unnecessarily. Instead, we could first find the intersection and only case-fold afterward. To facilitate this, we need to consider both uppercase and lowercase letters by first processing lowercase letters and then adding uppercase letters accordingly.

### Efficiency Improvements

It is also important to note that we are computing the total alphabet of letters every time we run the function. If we are executing this function multiple times, it may be wasteful. To address this, we could define a "tested" function that establishes this alphabet once instead of repeatedly during function calls.

By using a slightly modified function, we can now apply this optimized approach for better performance:

```apl
B ← ≡⍥{{⍵[⍋⍵]}⍵∩⍥⎕C⎕A}
C ← ≡⍥{{⍵[⍋⍵]}∘⎕C⍵∩⎕A,⎕C⎕A}
D ← ≡⍥({⍵[⍋⍵]}∘⎕C∩∘(⎕A,⎕C⎕A))
```

## Testing the Function

Let's test the function's performance against various scenarios. We can start by constructing a large test case that consists of both uppercase and lowercase letters of the alphabet, along with some punctuation. We will generate this data structure to assess the function’s efficiency using a timing comparison.

### Constructing Test Cases

To do this, we can construct a dataset with this APL snippet to create random test cases:

```apl
t ← (⊢↑⍨∘⌈1.2×≢) 1000⍴',.;:!?',∘⎕C⍨⎕A
ta ← {⍵[?⍨≢⍵]} t
tb ← '-'@1⊢t
```

To execute our comparisons efficiently, we can use a defined timing comparison such as:

```apl
'cmpx' ⎕CY 'dfns'
cmpx 't∘'∘,¨ 'ABCD',¨⊂ '¨1000⍴ta tb'
```

### Performance Comparison

As we run the comparisons using the defined set of functions, we should observe progressive improvements in efficiency:

```apl
t∘A¨1000⍴ta tb → 2.7E¯2 |   0% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕
t∘B¨1000⍴ta tb → 1.8E¯2 | -35% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕              
t∘C¨1000⍴ta tb → 1.3E¯2 | -52% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕
t∘D¨1000⍴ta tb → 1.2E¯2 | -55% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕                      
```

## Conclusion: Understanding Anagrams

However, it's essential to acknowledge that the definition of anagrams can be subjective based on the problem's specifications. While the problem states to "use all the letters" and "ignore spacing, capitalization, and punctuation," there is room for interpretation.

To better understand the inclusion of various character types (like digits or special characters), we can leverage Unicode properties. We can apply a similar function to remove non-letter characters:

```apl
u ← 'Björn' 'Ma/dá' '-123' '3.14'
v ← 'Bjørn' 'Adám:' '321%' '2.71'

E ← ≡⍥({⍵[⍋⍵]}∘⎕C'\PL'⎕R'') ⍝ remove non-letters
u E¨v
```

Additionally, we may want to filter out spacing marks and punctuation:

```apl
F ← ≡⍥({⍵[⍋⍵]}∘⎕C'[\pM\pZ\pP]'⎕R'') ⍝ remove spacing marks, spaces, punctuation
u F¨v
```

## Final Thoughts

In conclusion, while there are various ways to implement an anagram comparison function, considerations of efficiency, character inclusion, and definition interpretations are critical in arriving at a robust solution.

Thank you for joining us in this APL Quest!