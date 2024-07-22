
# Checking Character Vectors for Valid Letters

In this article, we will explore how to take a character vector and verify if every single character in it is one of the letters A, C, G, and T. 

## Defining the Character Vector

Let's start with an example character vector:

```
['a', 't', 'g', 'z']
```

In this case, the vector consists of valid letters (A, T, G) and an invalid letter (`z`).

## Function Definition

We will define a function, referred to as Omega (the rightmost letter of the Greek alphabet), to perform the check. We can leverage membership testing in our programming environment to see if each letter is among the set of valid letters (A, C, G, T). In APL, we can use a simple approach for this:

```apl
{⍵∊'ACGT'} 'ATGCTTCAGAAAGGTCTTACG'
```
This expression checks if each character in the string is a member of the set 'ACGT', outputting a vector of 1s (valid) and 0s (invalid).

The next step is to ensure that we check if all character checks return true. We can accomplish this using a logical `AND` reduction:

```apl
{∧/⍵∊'ACGT'} 'ATGCTTCAGAAAGGTCTTACG'
```
This will result in `1` (or `true`) if all characters are valid.

If we include a character that is not valid, the result would yield `0` (or `False`):

```apl
{∧/⍵∊'ACGT'} 'ATGCTTCAGAAAGGTxCTTACG'
```
The result here would be `0`, indicating the presence of an invalid character.

## Function Optimization

We can define this operation as a function and apply it. However, we can simplify some syntactic elements in this function definition by expressing it in a point-free style.

### Point-Free Style

To translate our operation into a point-free style, we need to recognize that we have two function applications: membership and the `AND` reduction. 

To express the membership function in point-free style, we can bind one argument to the membership function, thus deriving a new function that takes only one argument. In APL, we can define this function easily:

```apl
F ← {∧/⍵∊'ACGT'}
```

Thus, we eliminate the need to specify the argument while modifying the function definition.

## Final Implementation

At this point, we have two pure functions: 

1. The A, C, G, T membership function.
2. The `AND` reduction function.

We can now combine these into a single function, called `G`:

```apl
G ← ∧/∊∘'ACGT'
```

### Applying the Function

Now, we can apply this function to our character vector. Let's see what result we get when we check a string with an invalid character:

```apl
F 'ATGCTTCAGAAAGGTxCTTACG'
```
This would return `0`, indicating that not all characters are valid.

Meanwhile, checking a valid string:

```apl
G 'ATGCTTCAGAAAGGTCTTACG'
```
This will return `1`, confirming that all characters are valid.

## Conclusion

This approach demonstrates how to efficiently check character vectors for membership in a specified set using functional programming techniques. Thank you for reading!
