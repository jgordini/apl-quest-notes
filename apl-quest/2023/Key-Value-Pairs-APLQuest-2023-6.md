# Parsing Key-Value Pairs into a Matrix

In this article, we will explore how to parse a character vector that contains a custom notation for multiple key-value pairs. The key-value pairs in this notation are separated by slashes, and the keys are separated from their corresponding values by colons. Our goal is to create a matrix with a key column and a value column. 

## Custom Notation Example

Let's take a look at an example of the custom notation where key-value pairs are formatted as follows:

```
key1:value1/key2:value2/key3:value3
```

In this format:
- Key-value pairs are separated by slashes (`/`).
- Within each key-value pair, the key and value are separated by a colon (`:`).

This notation lends itself well to a commonly used operation known as "cutting" text or data.

## The Cutting Process

To demonstrate the cutting process, we will cut the strings based on the slashes. We can set up our process like this:

1. Use the slashes as the left argument to identify the positions where the cuts will occur.

   ```apl
   '/''≠'CTO:Morten/ATA:Brian/HLD:Adám'
   ```

2. Create a Boolean mask indicating which characters are different from the slash (1 for different, 0 for slash):

   ```apl
   '/''⊢''CTO:Morten/ATA:Brian/HLD:Adám'
   ```

   This will produce:

   ```
   CTO:Morten/ATA:Brian/HLD:Adám
   ```

3. This mask will help us isolate runs of characters from the right according to the cuts indicated by the mask:

   ```apl
   '/'(≠⊆⊢)'CTO:Morten/ATA:Brian/HLD:Adám'
   ```

   This results in:

   ```
   ┌──────────┬─────────┬────────┐
   │CTO:Morten│ATA:Brian│HLD:Adám│
   └──────────┴─────────┴────────┘
   ```

### Applying the Identity Function

We can take an identity function, which simply returns its input directly. By combining this with a partition function, we can compute:

- The mask to identify positions of slashes.
- The right argument, which consists of the original string.

The partition function then isolates runs of characters according to the mask.

## Parsing Each Key-Value Pair

We will also need to apply similar logic to each individual key-value pair. To achieve this, we can replicate our previous expression but replace the slashes with colons:

```apl
':'(≠⊆⊢)¨'/'(≠⊆⊢)'CTO:Morten/ATA:Brian/HLD:Adám'
```

This produces:

```
┌────────────┬───────────┬──────────┐
│┌───┬──────┐│┌───┬─────┐│┌───┬────┐│
││CTO│Morten│││ATA│Brian│││HLD│Adám││
│└───┴──────┘│└───┴─────┘│└───┴────┘│
└────────────┴───────────┴──────────┘
```

Using an `each` operator, we can apply this function to each key-value pair. However, what we now have is a list of key-value pairs, not yet a structured matrix.

## Creating the Matrix

The final step to convert our list of key-value pairs into a matrix is to use the `mix` function. This function combines the outer and inner axes to create an overall array.

### Function Definition

To make our process reusable, we need to define a function that accepts the slash and colon as parameters. The left argument will specify the character delimiters, and we will represent the right argument as Omega, while Alpha will represent the left argument. The final solution will solve our parsing problem, illustrated as follows:

```apl
'/:'{↑⍺[2](≠⊆⊢)¨⊃⍺[1](≠⊆⊢)¨⊂⍵}'CTO:Morten/ATA:Brian/HLD:Adám'
```

This results in:

```
┌───┬──────┐
│CTO│Morten│
├───┼──────┤
│ATA│Brian │
├───┼──────┤
│HLD│Adám  │
└───┴──────┘
```

## Removing Code Duplication

To improve our code's maintainability, we can simplify the logic that handles the `each` operator and the partitioning. 

- Instead of applying the `each` everywhere, we can apply it specifically to the partition function.

This approach leads us to a cleaner form where we handle both key-value pairs using a single function.

## Alternative Approaches

Instead of using two steps in parsing, we can directly check if any of the left argument elements were found within the right argument. Since the separators occur in a predictable pattern, we can utilize a membership check.

- We check for characters that are not separators using a logical `not` on the membership function and use that with the partition function to arrange the data into key-value pairs.

We can easily reshape the resulting array into a matrix form as shown below:

```apl
'/:'{↑⍺[2](≠⊆⊢)¨↓⍺[1](≠⊆⊢)⊂⍵}kvp
```

Which produces the same structured output for our matrix.

## Using the Stencil Operator

An alternative and elegant way to achieve the desired result can be done through the stencil operator. The stencil operator allows us to collect data using a windowed approach, where we can specify both window size and movement.

By defining the movement parameter, we can ensure that we do not have overlapping key-value pairs, thus achieving the correct formatting with ease.

For example:

```apl
'/:'(⊢⌺(⍪2 2)~⍤∊⍨⊆⊢)kvp
```

This would result in structured data in a similar matrix layout.

## Conclusion

In summary, we have explored how to parse a custom character vector containing key-value pairs into a structured matrix. We showcased different methods, including cutting, partitioning, and using the stencil operator, to achieve our goal efficiently. This process can greatly enhance our ability to manipulate custom formatted data in various programming contexts.

Thank you for watching!