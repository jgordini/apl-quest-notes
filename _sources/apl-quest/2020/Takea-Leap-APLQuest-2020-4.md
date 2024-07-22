# Understanding Leap Years: A Guide

In this article, we will explore how to determine which years are leap years using a set of rules and how to implement this in a programming context.

## Leap Year Rules

The rules for determining leap years are a bit involved:

1. Every fourth year is a leap year, **except**:
2. Every 100th year is **not** a leap year, even if it is divisible by four.
3. However, every 400th year **is** a leap year, redeeming it from the previous rule.

Thus, the general rules can be summarized as follows:
- A year is a leap year if it is divisible by 4.
- It is **not** a leap year if it is divisible by 100 unless it is also divisible by 400.

### Examples
- **Year 2000:** Divisible by 400; it **is** a leap year.
  ```apl
  400 100 4 | 2000  ⍝ Result: 0 0 0 (0 indicates non-leap year)
  ```

- **Year 1900:** Divisible by 100; it is **not** a leap year despite being divisible by 4.
  ```apl
  400 100 4 | 1900  ⍝ Result: 300 0 0 (0 indicates non-leap year)
  ```

- **Year 1904:** Divisible by 4 and not restricted by the other rules; it **is** a leap year.
  ```apl
  400 100 4 | 1904  ⍝ Result: 304 4 0 (4 indicates leap year)
  ```

- **Year 1905:** Not divisible by 4; it is **not** a leap year.
  ```apl
  400 100 4 | 1905  ⍝ Result: 305 5 1 (1 indicates leap year but prev checks)
  ```

## Approach to Implementation

In APL, we don't have a direct "is divisible by" function but we can use the division remainder function. If the remainder is zero, then it's divisible.

### Logic for Leap Year Calculation

To determine whether a year is a leap year:
- We check the divisibility of the year by 4, 100, and 400.
- We'll represent the results of these divisions and compare them with zero. A zero remainder implies divisibility.

### Handling Arrays

To handle any array of years, we'll implement the logic with matrix operations, specifically using an outer product to create a three-dimensional array that evaluates the leap year conditions for each year in the input array.

```apl
400 100 4 ∘ . |  2 2⍴ 1900 1904 1905 2000
```
This results in:
```
300 304
305   0
```

### XOR Reduction for Exception Handling

We will utilize an XOR operation to incorporate the leap year exceptions neatly. This allows us to express conditions like:
- A year is a leap year if:
  - It is divisible by 4 XOR (not divisible by 100 and divisible by 400).

## Converting to Function

To create a practical function in APL, we can encapsulate our logic into a reusable function. By doing a reduction on our leap year evaluation matrix, we can determine the leap year status for an entire array of years efficiently.

### Using Built-in Functions

APL provides a built-in function called `quad DT` for date time validation. By converting a year to a date format and checking its validity, we can determine if February 29 exists in that year, giving us the information needed to confirm if it's a leap year.

### Example Implementation

Here's a simple function to check leap years from an array of years:

```apl
checkLeapYears ← {
    years ← ⍵
    validDates ← (years, 2, 29)  ⍝ Concatenate February 29 to each year
    leapYearCheck ← 0 = quad DT '0' validDates  ⍝ Validate dates
    leapYearCheck
}
```

We can also run a matrix operation for a set of years:
```apl
(≠⌿0 = 400 100 4∘.|⊢)  2 2⍴ 1900 1904 1905 2000
```
This will yield:
```
0 1
0 1
```

## Conclusion

We have gone through the logic and rules for identifying leap years and how to implement this in APL effectively. With this understanding, you can apply leap year logic to any set of years, ensuring accurate results. Thank you for reading!
