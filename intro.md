# Welcome to APL Quest

APL Quest is an annual programming challenge that focuses on Array Programming Language (APL). Since its inception in 2013, APL Quest has been offering a series of engaging and thought-provoking problems that challenge participants to think in terms of arrays and leverage the power of APL.

## What is APL?

APL (A Programming Language) is a high-level, array-oriented programming language developed by Kenneth E. Iverson in the 1960s. It's known for its concise syntax and powerful array operations, making it particularly well-suited for mathematical and statistical computations.

## About APL Quest

APL Quest presents a set of 10 problems each year, designed to:

1. Test your problem-solving skills
2. Encourage creative thinking in terms of array operations
3. Showcase the expressive power and conciseness of APL
4. Challenge both beginners and experienced APL programmers

The problems range from simple array manipulations to complex algorithmic challenges, all solvable with APL's unique approach to computation.

## Structure of This Book

This Jupyter Book is organized by year, from 2013 to 2023. Each year contains:

- An index page introducing that year's challenges
- Individual pages for each of the 10 problems

You can navigate through the problems chronologically or jump to specific years or problems that interest you.

# APL Data Parsing Techniques

## 1. Basic CSV Parsing

Let's start with a simple comma-separated file (1.txt):

```
12,1,14,7,16
2,2,5,11,14
...
```

To parse this, we use Dyalog APL's `⎕CSV` function:

```apl
⎕CSV'/d/1.txt'⍬4
```

The `⍬4` argument specifies automatic type inference, converting numeric-looking strings to numbers.

## 2. Single-Column Number List

For a file containing a single column of numbers (2.txt):

```
67
121
530
...
```

We can still use `⎕CSV`, but we need to ravel the result:

```apl
,⎕CSV'/d/2.txt'⍬4
```

## 3. Bitmap Parsing

For a bitmap represented as characters (3.txt):

```
11110111
01000010
...
```

We use the 'Widths' option of `⎕CSV`:

```apl
{⎕CSV⍠'Widths'(1⍨¨⊃⍵)⊢⍵⍬ 4}⊃⎕NGET'/d/3.txt'1
```

This automatically determines the number of columns and parses accordingly.

## 4. Custom-Format Parsing

For files with custom formats (4.txt):

```
IEH == K
CFO == Q
...
```

We can use 'Widths' again, but with specific column widths:

```apl
1 0 1/⎕CSV⍠'Widths'(3 4 1)⊢'/d/4.txt'
```

This extracts only the relevant columns.

## 5. Coordinate Parsing

For coordinate-like data (5.txt):

```
0;5 to 5;0
4;4 to 0;6
...
```

We use a combination of 'Widths' and partitioning:

```apl
1 0 1 0⊂⍤1⊢(7⍴1 0)/⎕CSV⍠'Widths'(1 1 1 4 1 1 1)⊢'/d/5.txt'⍬4
```

## 6. Space-Separated Words

For space-separated words (6.txt):

```
IBEI MEJADO AQUEF UNUYE
AEA PIGEIU EJO IQURI
...
```

We can use `⎕CSV` with a space separator:

```apl
⎕CSV⍠'Separator' ' '⊢'/d/6.txt'
```

## 7. Direction and Distance

For direction and distance data (7.txt):

```
North 4
South 17
...
```

We use the same space-separated technique:

```apl
⎕CSV⍠'Separator' ' '⊢'/d/7.txt'⍬4
```

## 8. Numeric Grids with Empty Lines

For numeric grids separated by empty lines (8.txt):

```
 4 53 58 39 86
51 31 89 94 18
              
68 27 82 15 17
...
```

We use a more complex approach:

```apl
↑↑((≢¨⊣/)⊆↓){⎕CSV⍠'Widths'(≢¨⊂⍨1@1∧⌿' '=↑⍵)⊢⍵⍬4}⊃⎕NGET'/d/8.txt' 1
```

This handles the empty lines and variable column widths.

## 9. Multiple Boards with Headers

For multiple boards with headers (9.txt):

```
## BOARD 14 ##
8,9
-7,-8
6,1

## BOARD 5 ##
-5,6
10,0
-1,4
...
```

We use a complex parsing strategy:

```apl
{(⌈⌿⊃⌽⎕VFI⊃⍵)(⎕CSV(1↓⍵)⍬4)}¨(×∘≢¨⊆⊢)⊃⎕NGET'/d/9.txt'1
```

This extracts the board numbers and parses the coordinate data separately.
