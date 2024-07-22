
# Checking for Consecutive Identical Letters in Words

In this article, we will explore how to determine which words from a given list contain consecutive letters that are identical. We will utilize a method based on pairwise comparisons and dynamic reduction to achieve this.

## Introduction

Let’s begin by examining a word that contains a duplicated letter. For instance, consider the lowercase letter `l` in the word `hello`. The most effective way to identify consecutive identical letters is via pairwise comparison.

### APL Example:
```apl
2=/'Hello'
```
This expression evaluates to:
```
0 0 1 0
```
This indicates that there is a duplicated letter in the word `Hello`.

## Methodology

### Pairwise Comparison

The basic approach involves comparing each letter with its immediate neighbor. In this case, we use the dynamic form of reduction, specifically an *equal reduction* and a *pairwise equal reduction*. This method involves traversing through pairs of letters (windows of size 2) and comparing them.

Here’s how it works:

1. **Identify all pairs of letters** in the word. 
2. Evaluate if each pair is equal.

For the word `hello`, we can see there are four pairs:

- `h` and `e`
- `e` and `l`
- `l` and `l` (this pair is equal)
- `l` and `o`

Since we are not interested in knowing the exact positions or counts of the duplicates, we will perform an *or reduction* across the comparisons. This essentially checks if there exists at least one pair that is equal (`0 or 0 or 1 or 0`), which yields a result of `1` (indicating that at least one pair is identical).

### APL Example:
```apl
∨/2=/'Hello'
```
This yields:
```
1
```
Indicating that `Hello` has at least one pair of identical consecutive letters. 

- For the word `world`:
```apl
∨/2=/'World'
```
The result is:
```
0
```
Indicating that `World` has no duplicated letters.

## Handling Scalars

While the above method works for words, there are some nuances to consider. We need to manage situations involving scalar characters, which may not always have dimensions. If a character is treated as a scalar without dimensions, the reduction fails with a *rank error*.

### APL Example:
```apl
∨/2=/'I'
```
This produces a rank error:
```
RANK ERROR
      ∨/2=/'I'
         ∧
```

To address this, we can use a technique called *reveling* to restructure the single character into a one-dimensional list. This enables us to perform reductions over the newly formed structure.

### APL Example:
```apl
∨/2=/,'I'
```
This confirms:
```
0
```
Indicating that the single character 'I' has no consecutive duplicates.

### Revisiting Multiple Words

Now that we can process individual characters, we can expand our solution to handle multiple words. For instance:
- For the words `"I"`, `"feed"`, and `"bookkeeper"`:
```apl
(∨/2=/,)¨'I' 'feed' 'the' 'bookkeeper'
```
This produces:
```
0 1 0 1
```
Indicating that `feed` and `bookkeeper` contain duplicates, while `I` and `the` do not.

- Testing `feed` individually:
```apl
(∨/2=/,)¨⊆'feed'
```
This results in:
```
1
```
Indicating that `feed` contains duplicates.

## Single Word vs. Multiple Words

An important consideration is how our function will behave with a single word versus multiple words. If we pass a single word without encapsulating it, the function will incorrectly apply to each letter of the word rather than treating the whole word as a single entity.

To remedy this, we can utilize a function commonly referred to as the *inclusive symbol* or simply *nest*. This function encloses the argument if it is a singular item; if multiple items are present, it does not encapsulate them. 

### APL Example:
```apl
F←(∨/2=/,)¨⊆
F 'I' 'feed' 'the' 'bookkeeper'
```
This gives:
```
0 1 0 1
```
Indicating duplicates present in `feed` and `bookkeeper`.

## Conclusion

In conclusion, we have successfully constructed a method to check for consecutive identical letters in words through a structured approach involving pairwise comparisons and appropriate handling of scalars and multiple words. We can now effectively apply this solution to any given list of words and identify duplicates seamlessly.

Thank you for reading!
