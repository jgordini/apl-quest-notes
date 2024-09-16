# Finding the Longest Run of Ones in a Boolean Vector

In this article, we will explore how to find the longest run of ones in a Boolean vector. The goal is to efficiently compute the length of the longest contiguous sequence of 1s in the vector. Let's start by considering some sample data.

## Sample Data
In our sample data, we have runs of varying lengths:
- A run of length 3
- A run of length 2
- A run of length 4

We can represent this sample data as follows:

```apl
s ← 1 1 1 0 0 1 1 0 1 1 1 1 0
```

To deduce the lengths of the runs of ones, we can use the following APL expression:

```apl
{⍵⊆⍵} s
```

This results in the following partitions:

```
┌─────┬───┬───────┐
│1 1 1│1 1│1 1 1 1│
└─────┴───┴───────┘
```

By counting the lengths of each partition, we can use the expression:

```apl
{≢¨⍵⊆⍵} s
```

This gives us the lengths:

```
3 2 4
```

Thus, the answer to our problem will be the length of the longest run, which in this case is **4**.

## Defining the Function
To start, we will define an anonymous lambda function that we can later name. This function will take a Boolean vector `s` as its argument, which we will refer to as `Omega`.

The following code snippet defines our function to find the maximum length of runs of 1's:

```apl
F ← {⌈/0,≢¨⊆⍨⍵}
```

Next, we can use a partition function that takes a mask on the left and some data on the right, as shown below:

### Using Commutative Operators
We can simplify our argument handling by using a "selfie" operator or commutative function, deriving a new function that only requires one argument while applying it to both instances.

## Finding the Maximum Length
After counting the lengths, we will find the maximum. If there are no runs of ones, the length list may be empty. Thus, the maximum function should provide the identity element for an empty list, which is the minimum representable value (or a very large negative value for numerical contexts).

### Handling Empty Lists
To avoid issues with empty lists, we can ensure that there is always at least one value by injecting a zero at the beginning of our list of lengths. However, it's important to note that injecting a value can impact performance. For instance, when no runs of 1's exist, we will get:

```apl
{⌈/0,≢¨⊆⍨⍵} 0 0 0
```

The output will be:

```
¯1.797693135E308
```

By ensuring that we use zero injections, we can handle scenarios with no runs of ones gracefully:

```apl
{⌈/0,≢¨⊆⍨⍵} 0 0 0
```

This gives us an output of:

```
0
```

## Importing Required Libraries
We'll now import the necessary libraries for testing and performance comparison. Generating Boolean test data will help us evaluate the effectiveness of our approach. We'll create a vector with 10 million random elements, representing our Boolean values.

## Improving Performance
The initial method may involve significant memory overhead due to copying elements when inserting a zero. To optimize this, we can use a conditional maximum that compares the result of our maximum reduction against zero. This way, if the maximum is a large negative value, we replace it with zero. If it is positive, it remains unchanged.

### Performance Results
We will compare the execution times of two functions, `F` and `G`, that implement our strategies to see which one performs better. The code for evaluating speed and comparing performance is below:

```apl
b ← 1 = ? 1e7 ⍴ 2
G ← {0⌈⌈/≢¨⊆⍨⍵}
```

The benchmark comparison can be executed with:

```apl
cmpx 'F b' 'G b'
```

We expect this optimization to make a considerable difference, nearly doubling the speed for large datasets.

## Avoiding Unnecessary Computation
As we analyze our function further, we realize there are ways to compute the lengths of runs without generating unnecessary nested arrays. Instead of dividing the data into pieces, we can directly locate the beginnings and ends of runs of ones.

### Identifying Runs
To identify the beginnings of runs, we will compare adjacent elements. If the left element is less than the right element in a binary domain (0s and 1s), we have discovered the start of a new run. Here are some APL expressions to illustrate this:

```apl
{2</⍵} s  ⍝ Counts segments where 1's run ends.
```

This gives:

```
0 0 0 0 1 0 0 1 0 0 0 0
```

Similarly, we will find the ends of runs and ensure we account for cases where a zero does not naturally exist at the end of the vector.

## Final Implementation Strategy
With our beginnings and ends identified, we can convert these Boolean masks into indices. Upon subtracting the indices of the beginnings from the corresponding ends, we will have the lengths of the runs.

We will utilize functions like these for our final implementation:

```apl
{(⍸2</0,⍵,0)-(⍸2>/0,⍵,0)} s  ⍝ Finds length gaps.
```

This yields:

```
3 2 4
```

### Using Forks for Efficiency
Given the nature of our operations, we can apply a "fork" construct to more efficiently process our shared inputs. We will handle both comparisons (less than and greater than) and will finalize our approach by ensuring we also manage the potential for a zero output cleanly.

## Comparing Approaches
Finally, we will compare our original algorithm (using `G`) with our optimized approach (using `H`) to see the performance discrepancies, as shown below:

```apl
H ← {0⌈⌈/2(>/-⍥⍸</)0,⍵,0}
cmpx 'G b' 'H b'
```

This comparison will highlight the benefits of our improvements, confirming the enhanced efficiency of the direct computation method over the earlier, more complex methods.

## Conclusion
By implementing these strategies, we can efficiently determine the longest run of ones in a Boolean vector with improved performance and reduced computational overhead. This exploration demonstrates the importance of optimizing algorithms for large datasets and the usefulness of various techniques in achieving our goal.