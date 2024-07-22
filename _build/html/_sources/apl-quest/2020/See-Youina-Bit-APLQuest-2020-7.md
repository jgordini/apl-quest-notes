# Checking Bit States in APL

In this article, we will explore how to check if a particular set of bits is set in a given state of bits. Although this seems trivial, the challenge arises from the fact that we are dealing with integers representing our query bits and state bits, necessitating some conversion.

## Example

Let’s consider the bits we are querying as `3` and the state bits as `10`. This choice of numbers will clarify our process as we proceed.

## Converting to Binary

Both numbers are encoded as standard integers, but we need to ascertain the individual bits in their binary representation. Since `10` has a greater width than `3`, we need to convert these numbers together to align their bit patterns.

### Concatenation and Conversion

We can concatenate these two numbers and convert them into binary. An effective approach is to allow APL to determine the necessary bit width by using a function to convert the bit patterns back into numbers and running it in reverse, effectively applying the negative power operator. 

We can apply this function directly:

```apl
3 (,) 10
```

This allows us to parse the inputs as a vector, resulting in:

```
3 10
```

Next, we apply the inverse base evaluation function to convert this vector to base 2.

### Binary Representation

- **3 in binary**: This can be calculated as \(1 \times 1 + 1 \times 2 = 3\).
- **10 in binary**: This can be calculated as \(0 \times 1 + 1 \times 2 + 0 \times 4 + 1 \times 8 = 10\).

Now, we see all possible combinations represented side by side:

| Left Bit | Right Bit |
|----------|-----------|
| 0        | 0         |
| 0        | 1         |
| 1        | 0         |
| 1        | 1         |

## Checking Bit Conditions

We are not interested in all the bits on the right; our concern lies only with the bits that are set (i.e., `1`) on the left. In this context, it is required that for every `1` on the left, there must also be a `1` on the right. Thus, we analyze each combination:

- **Left: 0, Right: 0** → OK
- **Left: 0, Right: 1** → OK
- **Left: 1, Right: 1** → OK
- **Left: 1, Right: 0** → Not OK (Query bit is set, but state bit is not)

From this evaluation, we can conclude that the conditions for our requirements are **not met**.

## Processing the Matrix

To simplify the reasoning, let’s examine the case where our requirements are not met. The problematic case arises when the left side exceeds the right side.

In the binary context, this means that we need to evaluate the comparison between the left and right bits:

- **Condition to check**: Left should not be greater than right (in relation to boolean values).

## Reducing Over Rows

To validate this condition, we can insert a "less than or equal to" comparison between the elements of each row. Employing a last-axis reduction will confirm whether our condition holds across all cases.

### Verification of Conditions

Performing the "less than or equal to" reduction shows that the conditions are indeed met for the first few bits, but they fail subsequently. We can test this in APL:

```apl
3 (≤/2⊥⍣¯1,) 10
```

This checks the conditions across the bits, yielding the following result:

```
1 1 1 0
```

Consequently, we use a logical AND reduction to assess if all conditions are satisfied:

```apl
3 ((∧/≤/)2⊥⍣¯1,) 10
```

This concludes whether every query bit is matched in the state bits. The output reveals:

```
0
```

indicating that our conditions are not fully satisfied.

## Conclusion and Testing

Our solution concludes with the following APL function to check if our conditions hold:

```apl
F←(∧/≤/)2⊥⍣¯1,
```

Now, we can test our function with input values:

```apl
3 F 11
```

This returns `1`, signifying that `11` has all the required bits set. Conversely, testing with:

```apl
4 F 11
```

yields `0`, as there are mismatches in the required bits.

Thank you for watching!