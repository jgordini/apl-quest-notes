
# APL Quest

Welcome to the APL Quest!

Today's quest is the second from the 2015 round of the APL Problem Solving Competition. We're given some numbers and we need to determine the longest run of intervals where the intervals are all increasing in volume.

## Understanding the Problem

To solve this, we can start by examining some test data. Our goal is to identify intervals — the spaces between numbers — that are increasing.

One approach is to subtract any number from the number before it. This is known as an end-wise reduce. Because we want the rightmost element minus the leftmost element, we can use a negated window length to clip the subsequence backward before we apply the reduction. For example, given a numeric vector:

```apl
n ← 1 5 3 4 2 6 7 8
```

### Example Catch

There's a catch: if the input is a scalar, the end-wise reduction will fail. However, this can be remedied by simply reveling the argument.

```apl
{⌈/≢¨⊆⍨0<¯2-/⍵}42   ⍝ fails on scalar
{⌈/≢¨⊆⍨0<¯2-/,⍵}42  ⍝ fix
```

## Analyzing Sample Data

So, going back to our sample data, we will calculate the differences and find out where those differences are strictly positive (i.e., greater than zero). This gives us a boolean mask indicating which intervals are growing.

Next, we can use partitioning on any data, conveniently using it on the same data. When the left argument is a boolean, any runs of ones become segments, while any elements that are zero get dropped out, marking the beginning of a new segment.

This allows us to visualize groups: the run of ones followed by a zero indicates a segment of growth.

Now, having obtained the segment lengths, we can simply take the length of each segment. Using the maximum function on those lengths gives us our result, which in this case is three. The intuitive solution can be implemented as follows:

```apl
A ← {0⌈⌈/≢¨⊆⍨2</,⍵}
A n
```

## Function Implementation

Let’s encapsulate this logic into a function. While there are tricks to make this shorter, we must also remember our goal: identifying whether we are growing rather than calculating differences explicitly.

Instead of comparing sizes, we can directly ask if the left element is less than the right element in this two-element sequence. This yields a pairwise comparison that avoids some complexities.

### Matrix Considerations

Observing our vector of vectors, we can stack these vectors to create a matrix. The longest sub-vector will dictate the number of columns. If we transpose this, the number of rows represents the original width, which gives the length of the longest segment. An example of this matrix approach (though ineffcient) is:

```apl
B ← {≢⍉↑⊆⍨2</,⍵}
B n
```

Although this method works, it introduces inefficiencies, particularly concerning space usage. Instead of creating many vectors, we should focus solely on the lengths of these segments.

## Finding Lengths of Sequences

To find the length of sequences of ones, let’s normalize this by padding with zeros around it. By identifying switching points (from zero to one or vice versa), we can measure distances between occurrences.

```apl
2</,n
0,0,⍨2</,n
```

Using pairwise differences can help, but we must be careful about our approach.

### Correcting the Approach

To get the correct lengths of sequence runs, we can look at cases of non-growth. By taking the opposite of our growth boolean, we obtain a series of ones wherever we have a streak of zeros.

```apl
x ← 1 10 9 8 7 6 5 4 3 4
~0,0,⍨2</,x
```

When analyzing the indices, it’s important to remember that counting intervals (rather than elements) leads to overestimation by one. Adjusting for this can give us the right length of the runs:

```apl
{⌈/¯1+¯2-/⍸~0,0,⍨2</,⍵} x
```

## Simplifying the Problem

We can simplify some elements of this code. Instead of applying negations, we can compute values based on greater-than or equal conditions, allowing us to avoid false negatives. An example of a simplification might look like this:

```apl
C ← {¯1-⌊/2-/⍸1,1,⍨2≥/,⍵}
C n
```

### Performance Comparison

In terms of performance, we can generate some test data with a thousand integers in random permutations, checking for the longest streak of consecutive growth. We expect that the most intuitive computation method will perform better than a solution that generates matrices.

```apl
t ← ?⍨1000
'cmpx' ⎕CY 'dfns'
cmpx 'A t' 'B t' 'C t'
```

In conclusion, the efficient solution is the one that computes directly without creating unnecessary partitions, making it ideally suited for performance.

Thank you for watching!
