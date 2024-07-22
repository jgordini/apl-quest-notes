
# APL Quest: Splitting Text on Spaces

Welcome to this very last APL Quest video. Please see the APL Wiki for details on the quest. 

## Today's Quest

Today's quest is to split a text on spaces, with the additional specification of a left argument that tells us how many segments to cut into. Our goal is to be greedy and split at the first occurring spaces until we have as many segments as required. If the number of segments required exceeds what we get simply by splitting on spaces, we will need to add empty segments at the end.

Let's get started! Here is a sample text. First, we will try this as a test function.

### Classic Ways to Split on Spaces

A couple of classic ways to split on spaces exist. We can start off with the left argument and concatenate another space in front. The reason for this additional space is to ensure we can compare with the space and create a mask that we can then use to partition the right argument. 

This gives us a cutoff set, but we are a bit off because we added an extra space at the beginning. To correct this, we can split the concatenated string instead of the original.

```apl
(' '(,)⊢)'this is a sample'
⍝  this is a sample
```

This looks more sensible to work with. Here’s a trick: since we might need to add empty segments at the end, we want our nested array to have a prototypical element of an empty character vector. We can inject an empty string at the beginning.

### Automatically Inserting an Empty Segment

We could do this manually, but we can also automate it. Remember how we created the mask? We know that if we add a 1, that tells the partition function we want two segments to begin with, resulting in an empty segment at the beginning. 

Now, we can use this to partition the concatenation of the added space with the original argument. This allows us to pad with empty elements at the end if we take too many elements.

```apl
(' '(⊣=,)⊢)'this is a sample'
⍝ 1 0 0 0 0 1 0 0 1 0 1 0 0 0 0 0 0
```

If we didn't do this and attempted to take too many elements (for example, six), we would end up with non-empty elements because they are based on the length of the first element. Thus, this solution resolves that issue.

### Merging Trailing Elements

All that remains is to merge as many trailing elements as required to match the right number. Finally, we need to remove this leading element that was added temporarily. 

Let’s add the left argument; for now, we can use 3. We can take the leading elements we want to preserve and then use a drop to get the trailing elements we want to join together. 

```apl
3(⊣↑' '(,⊂⍨2,=)⊢)'this is a sample'
⍝ ┌┬─────┬───┐
⍝ ││ this│ is│
⍝ └┴─────┴───┘
3(⊣↓' '(,⊂⍨2,=)⊢)'this is a sample'
⍝ ┌──┬───────┐
⍝ │ a│ sample│
⍝ └──┴───────┘
```

We can combine this by saying we take the leading elements followed by the trailing ones.

Before performing this concatenation, however, we will postprocess the drop by reducing it with concatenation, inserting concatenation between all these elements. This gives us a total of three elements (excluding the leading element we inserted).

This approach gives a fit for three and four segments, while for five or higher numbers, we get additional empty segments as required.

```apl
3(⊣(↑,↓)' '(,⊂⍨2,=)⊢)'this is a sample'
⍝ ┌┬─────┬───┬──┬───────┐
⍝ ││ this│ is│ a│ sample│
⍝ └┴─────┴───┴──┴───────┘
```

## Another Solution to the Problem

Here’s another solution to the problem. We can begin similarly by concatenating a space on the left and calling it `s`. We can create a mask using this space and change the mask to eliminate segments we don't want to create.

Instead of generating all segments and joining them, we can use a running count or scan that gives us the number of segments. If we clamp the segments, we can ensure that our mask remains intact.

The uniqueness of each number ensures we can track the first occurrence of each segment, allowing us to drop unnecessary segments while preserving the relevant ones.

### Handling Excess Segments

When we apply this mask and attempt to partition the text, everything works nicely. However, if we want too many segments, we will not have enough. To handle this, we can instruct the partition to include trailing elements by adding a number equal to the count of segments at the end of the mask.

```apl
(6↑' '(,⊂⍨2,=)⊢)'this is a sample'
⍝ ┌┬─────┬───┬──┬───────┬┐
⍝ ││ this│ is│ a│ sample││
⍝ └┴─────┴───┴──┴───────┴┘
```

We can then adjust to retrieve as many of the segments as we need, while discarding any unnecessary leading spaces from the results.

Thank you for watching!