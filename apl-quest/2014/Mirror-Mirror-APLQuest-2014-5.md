# [Mirror Mirror 2014-5](https://apl.quest/psets/2014.html?goto=P5_Mirror_Mirror)

**Problem:** A palindrome is a word or phrase whose letters read the same forwards and backwards. Write a dfn which returns a 1 if its character vector argument is a palindrome, 0 otherwise. For simplicity’s sake, you may assume that the vector is all one case.

**Video:** [https://www.youtube.com/watch?v=cPzQr2aJ7e4](https://www.youtube.com/watch?v=cPzQr2aJ7e4)

**Code:** [https://github.com/abrudz/apl_quest/blob/main/2014/5.apl](https://github.com/abrudz/apl_quest/blob/main/2014/5.apl)

Today's quest is the fifth problem from the 2014 round of the APL Problem Solving Competition. The task is to determine whether a given text is a palindrome. A slight complication is that we need to ignore case differences and punctuation.

### Test Data

To illustrate our solution, we can start with some test data. We need to ensure that case differences are removed so that, for example, the first 'A' and the last 'A' in "Panama" match each other. To achieve this, we can use the `quad c`, which is case fold.

Next, we will sort out the characters we need to compare and eliminate any that we do not wish to consider. Let's put this into a function to process the data. An example of such a function is:

```apl
A←{c←⎕C⍵ ⋄ l←c/⍨c∊⎕C⎕A ⋄ l≡⌽l}
```

Here, we apply the process to ensure we filter by characters that are members of the case-folded alphabet.

The last step is to see if the letters match themselves when reversed. For example, "A man, a plan, a canal: Panama" is a palindrome, whereas "Hello World" is not.

### Optimizing the Process

While our initial method works, we can simplify the process with a few key observations.

Firstly, filtering by membership is the same as performing an intersection. Therefore, instead of pre-processing both arguments with case folding, we can just case fold one—the alphabet.

This helps avoid unnecessary case folding on potentially large arguments. However, we must be cautious, as this means we only get lowercase letters; thus, we can supplement our alphabet with uppercase letters as well. This is a one-time operation when defining the function and helps us optimize the intersection. An example of this optimized approach is:

```apl
A←≡∘⌽⍨∩⍥⎕C∘⎕A      ⍝ tacit
B←≡∘⌽⍨∩∘(⎕A,⎕C⎕A)  ⍝ avoid case folding argument
```

### Exploring Ranges

Another approach we can take is to compare Unicode character ranges instead of calculating intersections. All uppercase letters in Unicode and ASCII are contiguous, as are lowercase letters. By examining the values at the beginning and end of both cases (65 to 90 for uppercase and 97 to 122 for lowercase), we can determine which characters fall within these intervals.

We'll use an interval index to filter characters, and we can simplify this by utilizing the properties of character ranges. For instance, we can express this as:

```apl
D←{≡∘⌽⍨32|u/⍨((65∘≤∧≤∘90)∨(97∘≤∧≤∘122))u←⎕UCS⍵}
```

Finally, we will proceed to test for palindromes as before, but with the added benefit of avoiding constant rechecking of case-folding characters.

### Performance Considerations

One important aspect to consider is the performance implications of our approach. By starting with raw code points, especially when all characters are ASCII, we can optimize our processing. We wouldn't need to check every character for case folding repeatedly, which can be expensive.

Using ranges, we can efficiently filter the characters we are interested in and conduct our palindrome checks on these values. For performance testing, we can create larger test data sets like:

```apl
t←(70↑⎕A,⎕C⎕A,',.!?')[?1e5⍴70]
```

### Creating Test Data

We need to create some test data similar to natural text, which might include uppercase and lowercase letters along with punctuation. For a palindrome, we can self-concatenate half of our data to create a valid example by reversing one half and attaching it to the other.

```apl
p←,∘⌽⍨(70↑⎕A,⎕C⎕A,',.!?')[?5e4⍴70]
```

And measure performance using:

```apl
cmpx 'ABCD',¨⊂' t'
cmpx 'ABCD',¨⊂' p'
```

### 

### Conclusion

Through this exploration, we learned various methods to detect palindromes, optimizing for performance and efficiency. By considering both case sensitivity and character ranges, we have developed a robust solution.

Thank you for reading!
