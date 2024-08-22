# Welcome to APL Quest

APL Quest is an annual programming challenge that focuses on Array Programming Language (APL). Since its inception in 2013, APL Quest has been offering a series of engaging and thought-provoking problems that challenge participants to think in terms of arrays and leverage the power of APL. 

No copyright intended all credit to [abrudz](https://github.com/abrudz/apl_quest) These notes are to improve my APL knowledge not intended as documentation. 

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

**Video:** [https://www.youtube.com/watch?v=AHoiROI15BA](https://www.youtube.com/watch?v=AHoiROI15BA)

## 1. Basic [CSV Parsing](https://help.dyalog.com/latest/Content/Language/System%20Functions/csv.htm)

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



# Justifying Text in APL

APL provides powerful array-oriented capabilities that make text justification concise and efficient. Let's explore how to implement text justification using APL.

## Basic Approach

The core idea is to create an integer matrix representing how many copies of each character we want in the final justified text. For example:

```apl
chars ← 'the question: whether ''tis    '
ints  ← 1 1 1 3 1 1 1 1 1 1 1 1 1 2 1 1 1 1 1 1 1 2 1 1 1 1 0 0 0 0
```

Here, `3` and `2` indicate expanded spaces, while `0` removes trailing spaces.

## Key Steps

1. Identify spaces and trailing spaces:
```apl
spaces ← ' '=text
trailing ← ⌽∧\⌽spaces
```

2. Determine characters to keep:
```apl
keep ← ~trailing
```

3. Find inner spaces to expand:
```apl
inner ← keep∧spaces
```

4. Calculate space distribution:
```apl
trail ← +/~keep        ⍝ Trailing spaces per line
spaces ← +/inner       ⍝ Inner spaces per line
add ← inner(×⍤1 0)⌊trail÷spaces
```

5. Handle extra spaces:
```apl
extra ← inner × (+\inner)(≤⍤1 0)spaces|trail
```

6. Combine and apply:
```apl
result ← (⍴text)⍴(,keep+add+extra)/,text
```

## Complete Function

Here's a concise APL function that justifies text:

```apl
Just ← {
    keep ← ~⌽∧\⌽' '=⍵
    inner ← keep∧' '=⍵
    trail ← +/~keep
    spaces ← +/inner
    add ← inner(×⍤1 0)⌊trail÷spaces
    extra ← inner×(+\inner)(≤⍤1 0)spaces|trail
    (⍴⍵)⍴(,keep+add+extra)/,⍵
}
```

## Handling Edge Cases

To handle blank lines and short lines, we can create a more robust function:

```apl
BetterJust ← {
    s ← ' '=⍵
    t ← ⌽∧\⌽s
    fewWs ← 0=+/s-t
    shortL ← (+/t)>0.25×⊃⌽⍴⍵
    use ← ~fewWs∨shortL
    result ← ⍵
    (use⌿result) ← Just use⌿⍵
    result
}
```

This function ignores blank lines, lines with only one word, and lines that are too short (less than 75% filled).

## Example Usage

```apl
text ← ↑'HAMLET' '' 'To APL, or not to APL, that is' 'the question: whether ''tis' 'nobler in the mind to suffer' 'the slings and arrows of the' 'outrageous fortune...'

BetterJust text
⍝ Result:
⍝ HAMLET                        
⍝                               
⍝ To APL, or not to APL, that is
⍝ the   question:  whether  'tis
⍝ nobler  in  the mind to suffer
⍝ the  slings  and arrows of the
⍝ outrageous fortune...         
```

This APL implementation demonstrates the language's power in handling complex text operations with concise, array-oriented code. The `BetterJust` function efficiently justifies text while intelligently handling various edge cases.

## Common Use Cases

**Using first and reduction:**

```
∧/⊣=⊢
```

This checks if all elements are equal to the first element.

**Using unique and tally:**

```
1≥≢∪
```

This checks if the count of unique elements is 1 or less.

**Using 2-wise reduction:**

```
∧/2=⍨
```

This checks if each pair of adjacent elements is equal.

**Using min and max:**

```
⌊/=⌈/
```

This checks if the minimum and maximum elements are equal.

**Using key:**

```
1≥≢⊣⌸
```

This uses the key operator to get unique elements and checks their count.

# APL Idioms Categorized

## Array Operations

- Fast: Y sorted into ascending order: `{(⊂⍋⍵)⌷⍵}Y`
- Fast: Y sorted into descending order: `{(⊂⍒⍵)⌷⍵}Y`
- Fast: The subset of Yv in the index positions defined by M: `M⊃¨⊂Yv`
- Fast: The positions in Yv corresponding to the 1s in Av: `Av/⍳⍴Yv`
- Fast: A nested vector comprising vectors that each correspond to a position in the original vectors of Yv: `↓⍉↑Yv`
- Fast: 'name' redefined to be its value with Y catenated along its last axis: `name,←Y`
- Fast: 'name' redefined to be its value with Y catenated along its first axis: `name⍪←Y`
- Fast: 'name' redefined to be its value without the -Js trailing major cells (only fast when Js is negative): `name↓⍨←Js`

## Numeric Operations

- Fast: Round to nearest integer: `⌊0.5+N`
- Golden ratio (direct formula): `2÷¯1+5*÷2`
- Arithmetic precision of the system (in decimals): `17×2-645=⎕FR`
- Negative "infinity" (the smallest representable value): `⌈/⍬`
- Positive "infinity" (the largest representable value): `⌊/⍬`

## Boolean Operations

- Fast: The number of leading 1s in each row of B: `+/∧\B`
- Fast: A Boolean mask indicating the leading blank spaces in each row of D: `∧\' '=D`

## Shape/Structure Testing

- Fast: Is Y a Scalar?: `0=⍴⍴Y`
- Fast: Is Y a Simple Array?: `1=≡,Y`
- Fast: Does Y have an empty first dimension?: `0=⊃⍴Y`
- Fast: Is Y non-empty?: `~0∊⍴Y`
- Fast: Is Y a Simple Scalar?: `0=≡Y`
- Fast: Is Y a Simple Non-scalar?: `1=≡Y`

## Indexing/Selection

- Fast: The item in the top right of Y: `⊃⌽Y`
- Fast: The item in the bottom right of Y: `⊃⌽,Y`
- Fast: The subset of ⍳Ns corresponding to the 1s in Bv: `Bv/⍳Ns`
- Fast: The rank of Y as a scalar: `≢⍴Y`
- Fast: The rank of Y as a 1-element vector: `⍴⍴Y`

## Date/Time

- Packing current date (YYMMDD): `100⊥100|3↑⎕TS`
- Current UNIX time: `20⎕DT'Z'`
- Current UTC date and time: `¯1⎕DT'Z'`
- Current ISO timestamp: `'%ISO%'(1200⌶)1⎕DT'J'`
- Current ISO day-of-year: `2⊃⊃¯10⎕DT'J'`
- Current ISO week number: `2⊃⊃¯11⎕DT'J'`

## System Information

- Is this Dyalog APL Unicode?: `80=⎕DR''`
- Is this Dyalog APL Classic?: `82=⎕DR''`
- Current directory: `⊃1⎕NPARTS''`
- Report interpreter version: `#⎕WG'APLVersion'`
- Is interpreter a runtime?: `'R'∊4⊃#⎕WG'APLVersion'`
- Current real screen resolution before scaling: `(⊃÷100÷⊢/)⎕WG'DevCaps'`
- Report Operating System: `'-64'~⍨⊃#⎕WG'APLVersion'`
- Report Interpreter bit-width: `32×1+'4'∊⊃#⎕WG'APLVersion'`
- Report the command line that Dyalog was started with: `⊢2⎕NQ#'GetCommandLineArgs'`
- Report current IP address (first if multiple): `⊢2⎕NQ#'TCPGetHostID'`

## Function/Operator Behavior

- Called Monadically? (tradfns/tradops only): `900⌶⍬`
- Called Dyadically? (tradfns/tradops only): `~900⌶⍬`
- Number of arguments used in call (tradfns/tradops only): `2-900⌶⍬`
- Called Monadically? (dfns/dops only): `0=40⎕ATX'⍺'`
- Called Dyadically? (dfns/dops only): `0≠40⎕ATX'⍺'`

## Mathematical Constants

- Euler's idiom (accurate when N is a multiple of 0J0.5): `*○N`
- tau (2 pi): `○2`

## Workspace Management

- Clear active workspace: `)CLEAR`
- Save active workspace as CONTINUE and terminate session: `)CONTINUE`
- Terminate the session: `)OFF`
- Load workspace ws without executing ⎕LX: `)XLOAD {ws}`
- Replace active workspace with workspace ws: `)LOAD {ws}`
- Set or report the name of the active workspace: `)WSID {ws}`

## Error Handling

- Re-signal last caught error to caller (works with any ⎕IO and ⎕ML): `⎕SIGNAL⊂⎕DMX.(('EN'EN)('EM'EM)('Message'(OSError{⍵,2⌽(×≢⊃⍬⍴2⌽⍺,⊂'')/'"") (""',⊃⍬⍴2⌽⍺}Message)))`
- Construct first line of printed error message (works with any ⎕IO and ⎕ML): `⎕DMX.(OSError{⍵,2⌽(×≢⊃⍬⍴2⌽⍺,⊂'')/'"") (""',⊃⍬⍴2⌽⊆⍺}Message{⍵,⍺,⍨': '/⍨×≢⍺}⊃⍬⍴DM,⊂'')`

## Input/Output

- Output x to the session via stdout (with trailing line break): `⎕←x`
- Evaluate user input (from stdin) and return result: `x←⎕`
- Output x to session without trailing newline via stderr (without trailing line break): `⍞←x`
- Return one line of user input from stdin: `charvec←⍞`
- Assignment of character vector without needing to double quotes: `name←⍞`
- Prompt and response on same line: `⍞↓⍨≢⍞←'What? '`

## Random Number Generation

- Randomising random numbers: `⎕RL←⍬`
- Generate random ULID: `(⎕D,⎕A~'ILOU')[(1+(10⍴32)⊤12⎕DT'Z'),?16⍴32]`
- Generate random UUIDv4: `'-'@(4+5×⍳4)⊢(⎕D,⎕C⎕A)[4(9+|)@20⊢5@15?36⍴16]`
- Generate random UUIDv7: `{⎕IO←0 ⋄ (,~⊃)'  ----  ',8 4⍴(⎕D,⎕C⎕A)[((12⍴16)⊤12⎕DT'Z'),7,4(8+|)@3?19⍴16]}`

## Miscellaneous

- Meaning of life (short): `≢⍕!⍋⎕D`
- Meaning of life (traditional): `⍎⊖⍕⊃⊂|⌊-*+○⌈×÷!⌽⍉⌹~⍴⍋⍒,⍟?⍳0`
- An expression giving itself: `"1⌽,⍨9⍴'''1⌽,⍨9⍴'''"`
- Quote character: `''''`
- System setting for exact integer arithmetic up to 34 digits: `(⎕FR⎕PP)←1287 34`
- Conditional Abort (cut stack back one frame if Bs): `⍎Bs⍴'→'`
- Enable SALT when not in session file: `(⎕NS⍬).(_←enableSALT⊣⎕CY'salt')`
- Import dfns workspace into a namespace called dfns so dfn can be called using dfns.name: `{(⍎⍵⎕NS⍬).⎕CY ⍵}'dfns'`
- Call function "name" from the dfns workspace without polluting the current workspace: `({⍵⊣⍵.⎕CY'dfns'}⎕NS⍬).name`
- Delete all loaded TypeLibs: `{2⎕NQ#'DeleteTypeLib'⍵}∘⊃¨2⎕NQ#'ListTypeLibs'`
- Initialise session (Dyalog.Utils, Link, SALT, user commands, etc.) in runtime or shell script: `⎕SE.(⍎⊃2⎕FIX'/StartupSession.aplf',⍨2⎕NQ#'GetEnvironment' 'DYALOG')`
