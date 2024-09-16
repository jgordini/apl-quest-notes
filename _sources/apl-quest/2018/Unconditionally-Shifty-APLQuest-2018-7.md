
# Shifting Boolean Data: An Introduction

Today, we will explore the process of shifting Boolean data. Our task involves modifying a given amount of Boolean data, shifting it in different directions based on specified amounts.

## Overview of Boolean Data Shifting

The shifting process is dictated by a specified amount. If the amount is negative, it implies a shift from the right; if positive, the shift occurs from the left. The data can be provided as a vector or a scalar, and our goal is to seamlessly integrate this into our solution.

Although there are many methods to achieve this, we will focus on just one approach. For a broader understanding, I recommend reviewing the transcript from the chat event that preceded this presentation.

## Sample Data and Shifting Amounts

We begin with a sample dataset outlined in the problem description. Our objective is to apply shifts of three different amounts:

1. Shift by 3 steps
2. Shift by 0 steps
3. Shift by -3 steps (i.e., shift in the opposite direction)

To implement this, we will employ a Lambda function, defining it inline anonymously. This function will be applied across our specified shifting amounts.

### Mapping Over the Shifting Amounts

We desire to map over these three amounts without applying them to separate elements of our Boolean data. Instead, we will enclose the operation, allowing it to apply fully to all elements. The scalar extension takes a single scalar from one side and pairs it with multiple elements on the left, ensuring the correct pairing of elements.

The function we create will yield a two-element vector or list, where the left element is denoted as `Alpha` and the right as `Omega`. This will enable proper alignment of the left argument elements with the corresponding right elements.

```apl
3 0 ¯3 {⍺⍵}¨⊂ 1 0 1 1 1 0 1 1  ⍝ pairing up arguments
```

The output for this will show how the arguments are paired:

```
⍝ ┌───────────────────┬───────────────────┬────────────────────┐
⍝ │┌─┬───────────────┐│┌─┬───────────────┐│┌──┬───────────────┐│
⍝ ││3│1 0 1 1 1 0 1 1│││0│1 0 1 1 1 0 1 1│││¯3│1 0 1 1 1 0 1 1││
⍝ │└─┴───────────────┘│└─┴───────────────┘│└──┴───────────────┘│
⍝ └───────────────────┴───────────────────┴────────────────────┘
```

## Step-by-step Implementation

### Step 1: Identifying Data to Keep

Initially, we must determine which data should be retained during the shifting process. When shifting positively to the right, it effectively pushes data to the right and causes the last three elements to drop off. Thus, we aim to keep all but the last three elements.

Using a drop function can give us what we need, but it removes elements from the wrong end. By negating the number, we can reverse this order to achieve the desired effect.

```apl
3 0 ¯3 {⍵↓⍨-⍺}¨⊂ 1 0 1 1 1 0 1 1  ⍝ which ones we want to keep
```

For this operation, the output will be:

```
⍝ ┌─────────┬───────────────┬─────────┐
⍝ │1 0 1 1 1│1 0 1 1 1 0 1 1│1 1 0 1 1│
⍝ └─────────┴───────────────┴─────────┘
```

### Step 2: Identifying Placement for Data

Next, we need to decide where the identified data should be placed in the final result. By obtaining the length of the right argument and enumerating its indices, we can ascertain where each element should end up:

- For a positive shift of three, the five elements should occupy the last three positions.
- For no shift, the arrangement remains consistent.
- For a negative shift, we push in from the right.

Consequently, we can derive the subset of indices where our data will be positioned by using the amounts to drop from the right side.

```apl
3 0 ¯3 {⍺↓⍳≢⍵}¨⊂ 1 0 1 1 1 0 1 1  ⍝ where we want them
```

The results for this will be:

```
⍝ ┌─────────┬───────────────┬─────────┐
⍝ │4 5 6 7 8│1 2 3 4 5 6 7 8│1 2 3 4 5│
⍝ └─────────┴───────────────┴─────────┘
```

### Step 3: Creating a Canvas

We require a canvas to draw our result. This canvas will be an array of the same shape filled with zeros. We can create this easily using a zero multiplication, as the Boolean values can be treated as numbers.

```apl
3 0 ¯3 {,0∧⍵}¨⊂ 1 0 1 1 1 0 1 1   ⍝ what canvas we want to draw on
```

The output will show the canvas:

```
⍝ ┌───────────────┬───────────────┬───────────────┐
⍝ │0 0 0 0 0 0 0 0│0 0 0 0 0 0 0 0│0 0 0 0 0 0 0 0│
⍝ └───────────────┴───────────────┴───────────────┘
```

### Handling Scalar Inputs

Moreover, we also have the scenario where the argument is a scalar. In this case, we can normalize it to a vector by using the `revel` function, which flattens the array into a simple list. If the argument is already a vector, it remains unchanged; if it’s a scalar, it transforms into a one-element vector.

### Combining All Parts

Now that we have identified the data and created the canvas, we can combine everything into one final procedure. We will place the data into the computed indices, thus completing the shifting process.

```apl
3 0 ¯3 {(⍵↓⍨-⍺)@(⍺↓⍳≢⍵),0∧⍵}¨⊂ 1 0 1 1 1 0 1 1  ⍝ putting it all together
```

The culmination of this process is shown in the following output:

```
⍝ ┌───────────────┬───────────────┬───────────────┐
⍝ │0 0 0 1 0 1 1 1│1 0 1 1 1 0 1 1│1 1 0 1 1 0 0 0│
⍝ └───────────────┴───────────────┴───────────────┘
```

- For a positive shift of three, three bits are added from the left and three bits drop off from the right.
- With a shift of zero, no changes occur.
- For a negative shift, we again shift from the right.

If we test a scalar case, such as '1', it normalizes to a vector. If we attempt to shift too much, leading to no remaining elements, we still hold a representation with a single zero. Conversely, if shifting by zero, we retain the original value.

## Conclusion

This approach offers one of many possible solutions to shifting Boolean data. For more insights and alternatives, I encourage you to examine the transcript from our previous session or participate in our live events every Friday.

Thank you for your attention!
