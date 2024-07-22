
# APL Quest: Generating Odd Numbers

Hello and welcome to this very first episode of the APL Quest, where we explore one problem each week from past APL problem-solving competitions. For more details, take a look at the [APL Wiki](https://aplwiki.com).

## Today's Problem

Today's problem is the first from 2013, where we are asked to generate odd numbers. Let's dive in by generating some numbers. For instance, if we want to generate the first 10 odd numbers, we start with the following concept:

### Generating Odd Numbers

We can generate adjacent integers and then manipulate them to get our odd numbers. If we multiply by two, we generate every other number, and we can then offset it by one. For instance, we can take a one and subtract it—swapping the arguments in the minus function.

Here’s how we can define a function that generates odd numbers if we start counting from one:

```apl
⍝ Using ⎕IO←1
F ← {1 - ⍨ 2 × ⍳ ⍵}  ⍝ F will generate the first n odd numbers
```

For more examples, consider the following definitions:
```apl
F←{1-⍨2×⍳⍵} ⍝ Starting from one
G←(⍸1 0⍴⍨2×⊢) ⍝ Adjusted for index origin zero
H←{⍸2|⍳2×⍵} ⍝ Flexible for either Index Origin
I←{+\2-⍵↑1} ⍝ Cumulative Sum to Generate Odd Numbers
```

Alternatively, to generate odd numbers from an index origin of zero, we could define the function as follows:

```apl
⍝ Using ⎕IO←0
⎕IO ← 0
F ← {1 + 2 × ⍳ ⍵}  ⍝ F will generate the first n odd numbers
```

As you can see, by default, APL starts counting from one. However, some computer scientists and mathematicians prefer starting from zero, and APL allows you to choose that. You can set the index origin to zero:

```apl
⎕IO ← 0
```

Now we count from zero instead. This has both upsides and downsides. The upside is flexibility for your problem context, while the downside is the potential for miscommunication when sharing code with others.

### Handling Different Index Origins

If you share code with others, you must make sure to manage the correct index origin; otherwise, you can end up with entirely wrong results. The corresponding function for an index origin of zero, instead of subtracting one, would require you to add one:

```apl
⍝ Index Origin Adjustment
G ← (⍸ 1 0 ⍴ ⍨ 2 × ⊢)  ⍝ F will account for an index origin of zero
```

Although the problem asks for a defined function, we can also write tested functions in APL. Here’s another approach using a tested function framework:

```apl
H ← {⍸ 2 | ⍳ 2 × ⍵} ⍝ Flexible for either Index Origin
```

Now let's switch back to index origin one, but this might not work without adjustments. Instead, we just need to flip the zeros and ones.

### A Flexible Solution

What if we want to write a function that can work with either setting of the index origin? Here’s a clever solution:

```apl
oddNumbers ← {⍸ 2 | ⍳ 2 × ⍵}  ⍝ A flexible solution that works regardless of index origin
```

In this function, we start by multiplying the argument by 2 and checking the parity, giving us the correct result regardless of the index origin.

The function works in both scenarios—when `⎕IO` is one and zero—because the index generator **iota** and the **where** function (for true values) cancel each other out.

### A Mathematical Approach

Dealing with indices leads us to explore a mathematical approach. If we observe that we start with 1 and increase by 2 every time, we derive an interesting property:

```apl
A ← 1 + 2 × ⍳ 10  ⍝ Generates the first 10 odd numbers
```

Using the cumulative sum (plus scan) gives us all odd numbers without any index-related functionality, making it immune to index origin changes:

```apl
I ← {+\2 - ⍵↑1} ⍝ Cumulative Sum to Generate Odd Numbers
```

### Revisiting the Original Approach

Now, let's revert to our original formulation of generating odd numbers by adjusting how we handle the index origin. We can map our operations mathematically:

```apl
oddNumbers ← {2 × ⍵ + (¯1 × ⎕IO)}  ⍝ Adjusting for index origin
```

By using negative one raised to the power of `⎕IO`, we can handle both cases without additional complexity.

### Another Clever Solution

Here's another clever solution using a tacit function:

```apl
oddNumbers ← {⍳ + ⍳ - ≢}  ⍝ Tacit function to generate odd numbers
```

This tacit function utilizes a **fork** structure, where we subtract the tally from the indices and use that to add to the **iota** applied to the argument.

### Conclusion

And that's all for today! Thank you for following along in this APL Quest. We hope you enjoyed exploring how to generate odd numbers and the nuances of APL's index management.

For more about the problem and solutions, check out the original [problem set](https://problems.tryapl.org/psets/2013.html?goto=P1_Seems_a_Bit_Odd_To_Me). Watch the [video](https://youtu.be/Mj4wyLKrBho) for further elaboration and access the [source code](https://github.com/abrudz/apl_quest/blob/main/2013/1.apl) for hands-on learning.
