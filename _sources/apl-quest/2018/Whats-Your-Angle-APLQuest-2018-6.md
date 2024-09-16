# A Simple Test for XML Validity

In this article, we will conduct a straightforward test to check the validity of some XML data. While this is not a comprehensive test, we are primarily focused on ensuring that the angle brackets are properly matched.

## Test Data

We will work with two examples:

1. A valid XML input.
2. An invalid XML input. The latter is invalid because it includes a statement "2 is less than 3," which misuses angle brackets and disrupts the balancing.

```apl
t←⍪'<name><first>Drake</first><last>Mallard</last></name>' '<math><relation>2<3</relation></math>'
```

```apl
t
⍝ ┌─────────────────────────────────────────────────────┐
⍝ │<name><first>Drake</first><last>Mallard</last></name>│
⍝ ├─────────────────────────────────────────────────────┤
⍝ │<math><relation>2<3</relation></math>                │
⍝ └─────────────────────────────────────────────────────┘
```

### Rules for XML Validity

To determine the validity of XML, we must adhere to the following three main rules:

1. Every opening angle bracket must have a corresponding closing angle bracket (i.e., every `<` must have a matching `>`).
2. Angle brackets cannot be nested inappropriately.
3. The sequence must conclude with all angle brackets properly closed; no character may be shifted to create mismatched pairs.

## Getting Started

Let's define our function to check the validity of the XML inputs. Our focus will only be on the angle brackets, while other characters will be ignored.

### Filtering Angle Brackets

To simplify our problem, we can filter the inputs to isolate only the angle brackets. This can be done by performing an intersection of the input characters and the angle brackets.

```apl
(∩∘'<>')¨t
```

```apl
⍝ ┌────────────┐
⍝ │<><><><><><>│
⍝ ├────────────┤
⍝ │<><><<><>   │
⍝ └────────────┘
```

After filtering, we can see only the relevant angle brackets, making it easier to analyze.

## Strategy to Identify Paired Brackets

Our strategy will involve identifying pairs of angle brackets. The valid input should consist entirely of alternating open and close brackets: `< > < > < >`. If we encounter two consecutive open brackets, we can conclude that the input is invalid.

### Searching for Angle Bracket Locations

To locate the angle brackets, we will transform our intersection function into a more complex compound function, known as a "fork." This function will:

- Take the input (left argument) and the angle brackets (right argument).
- Branch out to apply two outer functions into the arguments and then apply a middle function to the results.

This will create a Boolean mask with the same length as our input, indicating each angle bracket's presence.

For example, if we have a sequence of `< > < > < >`, the mask will show `1` for every angle bracket found.

```apl
((⊢⍷∩)∘'<>')¨t
```

```apl
⍝ ┌───────────────────────┐
⍝ │1 0 1 0 1 0 1 0 1 0 1 0│
⍝ ├───────────────────────┤
⍝ │1 0 1 0 0 1 0 1 0      │
⍝ └───────────────────────┘
```

## Validating the Mask

We need to check that our mask consists of uninterrupted alternating sequences of `1` and `0`, starting with `1` and ending with `0` to ensure proper closure.

If the sequence ends without a matching pair of brackets, it indicates that the XML is invalid.

### Final Calculation

Next, we will apply a function to compute the total length of the valid mask, reshaping it to ensure it corresponds to the original bracket sequence's length. The reshaped mask should maintain the order we expect.

```apl
((≢⍴1 0⍨)(⊢⍷∩)∘'<>')¨t
```

```apl
⍝ ┌───────────────────────┐
⍝ │1 0 1 0 1 0 1 0 1 0 1 0│
⍝ ├───────────────────────┤
⍝ │1 0 1 0 1 0 1 0 1      │
⍝ └───────────────────────┘
```

Finally, we will compare the generated mask with the original to determine whether they match element for element.

```apl
F←(⊢≡≢⍴1 0⍨)(⊢⍷∩)∘'<>'
F¨t
```

```apl
⍝ 1
⍝ 0
```

## Conclusion

Upon applying this methodology to our test cases, we can conclude that the first XML input is valid while the second is not.

We can encapsulate this solution in a function and apply it to all elements of our test dataset.

Thank you for reading!