# Creating a Cover for the Dyadic Iota in APL

In this article, we will explore how to create a cover for the Dyadic Iota (or index of primitive) in APL (A Programming Language). Our implementation will behave exactly like the original, with one important exception: when using  Dyadic iota  to look up items from the right argument in the collection (the left argument), and the item isn’t found, the next index after the last position will be returned to indicate that the item is not found.

This behavior is particularly useful because it allows us to take indices where items are found and use those indices to map into another substitution collection. This enables us to perform a mapping from one thing to another and add an additional element at the end, which can be used to map all missing elements.

## The Problem

The challenge we face is to change the behavior of the original dyadic iota Instead of returning the next index after the last element, we want it to return zero. This makes sense in a one-based indexing context (which is the default in APL), where zero indicates an element before the first one.

## Understanding the Default Behavior

Let’s first analyze the normal behavior of dyadic iota.  When we have a character vector:

- If we look for 'D', it is found at position 3.
- When we look for 'Y', there are no matches, and the indication is position 7.
- Looking for 'A' returns position 4.

We can illustrate this with the following APL expression:
```apl
'DYALOG' ⍳ 'APL'
```
Result:
```
⍝ 3 7 4
```

## Approaches to Change the Behavior

There are different approaches to achieve the desired behavior. 

### Approach 1: Conditional Mapping

One way is to check whether the index obtained is larger than the length of the left argument. Here’s how we can implement this:

1. Check the index against the length of the left argument.
2. If the index is greater than the length, map it to zero.
3. We can achieve this using multiplication with a condition.

However, multiplying directly can yield incorrect results, as it would apply to existing indices. To illustrate this:

```apl
'DYALOG' (⍳>≢⍤⊣) 'APL'
```
Result:
```
⍝ 0 1 0
```

### Better Conditional Handling

Instead of checking if the index is greater than the length, we can invert this condition to check if it is less than or equal to the length. This allows us to multiply the indices, binding them correctly. 

While this approach works, it finds indices twice, resulting in inefficiency.

### One-time Index Function

We can optimize the function by passing the indices and the length of the left argument directly to a new function. This function does not need to access the original arguments – it only relies on the data provided.

### Post-processing with Modulus

Another way to tweak the behavior is by using a post-processing operation on the indices. We will wrap around to zero when we hit the limit, which can be effectively done using the modulus operation.

The expression could be structured as follows: 
```apl
indices mod (1 + length of left argument)
```
This format ensures we wrap to zero correctly. 

Alternatively, we could use the following expression for clarity:
```apl
'DYALOG' (⍳|⍨1+≢⍤⊣) 'APL'
```
Result:
```
⍝ 3 0 4
```

Additionally, we could eliminate parentheses by switching the arguments in the modulus function, making the expression a bit cleaner.

### Explicit Function Definition

Finally, we can define an explicit function for clarity and readability. This could help streamline the implementation while making it more understandable.

```apl
'DYALOG' ({1+≢⍺}|⍳) 'APL'
```
Result:
```
⍝ 3 0 4
```

## Conclusion

We have explored several effective solutions to modify the behavior of the DIIC Iota in APL to meet specific requirements. Each approach has its own merits, from conditionally mapping indices to leveraging modulus arithmetic for wrap-around functionality. Thank you for following along in this exploration of APL indexing.
