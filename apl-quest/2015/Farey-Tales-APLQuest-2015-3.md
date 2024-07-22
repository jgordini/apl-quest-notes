
# Welcome to the APL Quest

## Introduction
Welcome to the APL Quest CAPL! For more details, please refer to the wiki. Today, we're exploring the third quest from the 2015 round of the APL Problem Solving Competition. The task is to generate the Farey Sequence of order `n`.

## Farey Sequence
The Farey Sequence is defined as the sequence of fully reduced fractions from `0` to `1`, where both the numerators and denominators are integers between `0` and `n`. The fractions must be presented in ascending order based on their values.

### Example: n = 5
For `n = 5`, the sequence starts with:
- 0 (which is \( $\frac{0}{1}$ \))
- \( $\frac{1}{5}$ \)
- \( $\frac{1}{4}$ \)
- \( $\frac{1}{3}$ \)
- \( $\frac{2}{5}$ \) (as it is between \( $\frac{1}{3}$ \) and \( $\frac{1}{2}$ \))

Several methods exist to generate this sequence, and we will explore a few of them.

## Generating the Sequence
To generate the sequence, we can follow these steps:

1. **Generate All Possible Fractions**:
   Create all valid pairs of integers from `0` to `n`, including `0` but excluding pairs where the denominator is zero.

   You can use the following APL function to generate indices for an `n x n` matrix:

   ```apl
   Ii←{0 1,⍥⊆f[i][⍋q[i←(1∘≥∩⍥⍸≠)q←÷/¨f←,⍳⍵ ⍵]]}
   Ij←{0 1,⍥⊆f[i][⍋q[i←⍸(1∘≥∧≠)q←÷/¨f←,⍳⍵ ⍵]]}
```

2. **Remove Non-Reduced Fractions**:
   Identify and remove duplicates and fractions that are not fully reduced (fractions that can be simplified). The following APL example illustrates reducing the indices:

   ```apl
   Im←{0 1,⍥⊆(m/f)[⍋q/⍨m←(1∘≥∧≠)q←÷/¨f←,⍳⍵ ⍵]}
```

3. **Sort Valid Fractions**:
   Divide the numerator by the denominator to obtain a quotient and sort them to ensure they are in ascending order. The example below shows how to filter using the GCD:

   ```apl
   G←{0 1,⍥⊆f[⍋÷/¨f←⍸∘.(≤∧1=∨)⍨⍳⍵]}
   ```

4. **Filter Valid Fractions**:
   Keep only those fractions that are less than or equal to `1`. Compute the quotients as follows:

   ```apl
   Q←{(,÷∨)∘1¨{⍵[⍋⍵]}0,∪1⌊,∘.÷⍨⍳⍵}
   ```

5. **Add Zero**:
   Lastly, include `0` as the first element of the sequence.

### Step-by-step Implementation
1. **Initial Setup**:
   We create a matrix of fractions of shape `n x n`.

2. **Reduction and Validation**:
   We utilize a unique mask to track the first occurrence of reduced fractions. Use the greatest common divisor logic to ensure that fractions represent a number that is less than or equal to `1`.

3. **Index Selection**:
   Use the intersection of two boolean masks to ensure we have valid, unique fractions.

4. **Sorting**:
   Sort the remaining fractions based on their values.

5. **Insert Zero**:
   Finally, concatenate zero with the list of the sorted fractions.

## Performance Considerations
We can compare different implementations by measuring execution time and determining whether to use indices or boolean masks optimally.

```apl
cmpx'Ij 1000' 'Im 1000'
```

### Alternative Approaches
An alternative method involves treating the fractions as pairs \( (a, b) \) and filtering directly for coprimality, applying the greatest common divisor (gcd) to check if a fraction is fully reduced. 

- **Outer Product**: By generating an outer product of enumerators and denominators, we can efficiently filter valid fractions:

   ```apl
   G2←{0 1,⍥⊆f[⍋÷/¨f←⍸(∘.≤∧1=∘.∨)⍨⍳⍵]}
   ```

- **Quotients First**: Generate quotients directly and eliminate any that exceed `1`, keeping the process streamlined.

```apl
Qf←{↓(,⍤0÷⍤1 0∨)∘1{⍵[⍋⍵]}0,∪1⌊,∘.÷⍨⍳⍵}
```

## Final Thoughts
Ultimately, the goal is to generate the Farey Sequence efficiently. We will explore multiple approaches and compare their performance, focusing on how optimizations affect execution time.

```apl
cmpx'Im 100' 'G2 100' 'Qf 100'
```

Thank you for following this exploration into generating the Farey Sequence!
