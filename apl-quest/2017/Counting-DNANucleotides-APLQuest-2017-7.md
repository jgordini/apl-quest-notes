
# Counting Letters in a String: A Guide

In this article, we will explore how to count the occurrences of a given set of letters in a string. Let’s start with some sample data and walk through the process of computing the counts for each letter.

## Sample Data Analysis

Given the string data, we can identify the counts of specific letters:

- **A's**: 3
- **C's**: 2
- **G's**: 0
- **T's**: 2

Our goal is to compute these counts and ensure we maintain the order of the letters: first A's, then C's, then G's, and finally T's.

## Outer Product Concept

To achieve this, we can utilize an **outer product**. An outer product compares and combines each element from one array with each element from another array using a specified function. In this case, we will use equality.

The syntax in APL (A Programming Language) allows us to express this as follows: 

```apl
result ← leftArray ⊗ rightArray
```

In our case, we will specifically compare the letters 'A', 'C', 'G', and 'T' against the string 'ATTACCA':

```apl
'ACGT' ∘.= 'ATTACCA'  ⍝ outer "product"
```

This expression yields a table where the rows represent our letters (A, C, G, T) and the columns represent the letters of the test string. A true comparison yields 1 (or true) in APL.

### Example of Outer Product Result

Here’s a simple illustration:

- **Rows**: A, C, G, T
- **Columns**: A, T, T, A, C, C, A

The outcome is a table showing which letters match. By counting the number of ones (true values) in each row, we can determine the letter counts.

For our specific example, we can compute the outer product, resulting in:

```apl
⍝ 1 0 0 1 0 0 1
⍝ 0 0 0 0 1 1 0
⍝ 0 0 0 0 0 0 0
⍝ 0 1 1 0 0 0 0
```

## Summation and Reduction

To count the occurrences, we can apply the **reduction** operator (often noted as `+/`). This operation sums the rows, giving us the precise counts of each letter:

```apl
+/ 'ACGT' ∘.= 'ATTACCA'  ⍝ summation expression
```

Example output:
- 3 A's
- 2 C's
- 0 G's
- 2 T's

## Creating a Function

Next, we aim to encapsulate this logic within a function. One straightforward approach is to replace a placeholder (often denoted as *Omega*) with the specific string input and define a function:

```apl
F←{+/ 'ACGT' ∘.= ⍵}  ⍝ as a function
F 'ATTACCA'
```

This leads us to the counts of letters as:

```apl
⍝ 3 2 0 2
```

### Point-Free Function

Since we're only referencing the argument once, we can transform this into a **point-free function**. This type of function does not explicitly mention its argument.

By removing the argument and braces, we can derive a new function that represents an outer product equality.

### Using Density Function 

To avoid ambiguity with derived functions lacking an argument, we can introduce a **density function** applied to our input argument. This enables us to format function applications properly without needing to specify each argument explicitly.

## Function Composition

Additionally, we can demonstrate function grouping using parentheses, which can visually indicate how our summation and outer product work together to form the solution.

Here’s how we can group them together:

```apl
H←'ACGT' (+/∘.=) ⊢  ⍝ grouping together the computational parts
```

By combining both functionalities, we create a derived function that accepts letters as one argument and applies the identity function to the main data input.

## Binding Arguments

Another method to develop our function is through **argument binding** using the bind operator, which employs the same symbol as the outer product. This allows us to set a left argument for a general function representing the sum of equality tables:

```apl
G←+/ 'ACGT' ∘.= ⊢   ⍝ tacit
```

## Creating a General Purpose Function

Finally, we can define a general-purpose function called `Counts`, encompassing the core functionality without additional complexities. This flexible function takes vocabulary as its left argument and the main data as its right argument, making it reusable for various contexts:

```apl
Counts←+/∘.=     ⍝ general-purpose function
J←'ACGT'∘Counts  ⍝ deriving specific-use function from the general one
```

## Conclusion

With this method, we can efficiently count the occurrences of specific letters in a given string while maintaining the order of the letters. We can then apply the `Counts` function to analyze other datasets as needed.

Thank you for your attention!
