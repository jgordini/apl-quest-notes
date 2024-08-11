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

## Transcript

Hi, I'd like to show you how to use Dyalog APL to parse the contents of text files that contain data in unusual formats. First off, we're going to have a regular comma-separated file. Luckily, Dyalog APL has quad CSV, which can easily do this job. The first element of the argument is the file name or the content itself. Next is a specification of what type of content it is, but that can usually be inferred, so we can give it an empty vector. Finally, there's a code for conversion. This is because comma-separated files do not distinguish between numbers and text. However, code number four uses a heuristic: if something looks like a number, then we'll convert it to a number; otherwise, we'll just leave it as text. And here we go, here's our numeric matrix.

Next up is something that's a list of numbers, and you might not think of this as a comma-separated file, but you can actually parse it as such, and you will just have a single column. In order to get a vector that we can work with, we simply ravel it.

Next, we have a bit map or a matrix of bits represented as the characters zero and one, and this doesn't look like a comma-separated file at all either. There are no separators. However, quad CSV has a variant option where you can, instead of using a separator, use widths. And we have eight columns, each one has width one, and here's our boolean matrix.

Of course, it's not so much fun to have to count how many columns there are, so what we can do is we can use quad-n-get to read in the file first and do a little bit of analysis on it so we know how many columns there are. We ask for a vector of character vectors with this one flag. This gives us a nested result. Getting just the first one allows us to count how many there are. But since we want the width as a vector of ones, we can actually just do a one constant for each one. And now we can take this and use it as our widths, and then we just take the data as before, wrap the entire thing in the dyad variant on the widths, and now it's all automatic.

Next, we got something that decidedly doesn't look like a separator-separated file. However, we can notice that the labels on the left have a consistent width, and the single character on the right is also well, just a single character. So we could actually split this with width as well. First, we have three characters for this label, and then four characters for the space equal equal space, and then a single character. It doesn't actually matter to specify the conversion to numbers because there are no numbers here. Okay, this gives us an extra column in the middle that we don't want because we just want the labels and the characters, so we can start processing them. We can then use a horizontal compress to remove the middle column, and then we can take it from there.

We can do something very similar to this file even though it looks like there are multiple levels of nesting. We can start off with the width: one column for the single digit, one column for the semicolon separator, one column for the second digit that's there, then four columns for space two space, and then we have the same kind of pattern again. This is seven columns, and we only want every other one, so we do a cyclic reshape of one zero for our mask and do the horizontal compress, and there we go. If you want to make pairs 2 and 2, then we can use partition for this: begin a new partition, continue the same partition, begin a new partition, continue the same partition. Now we've got two matrices: the beginning points and the end points. We could also apply this rank one in order to get a matrix of beginning pairs and end pairs and take it from there.

This might not look like a data file at all, but if you count, you'll see that every row has exactly four words. And so, instead of being comma-separated, we can call this space-separated. So we set the separator to a space, and we got ourselves a matrix of words. Here are some keywords and values, again separated by a space. Because we have the four for the conversion code so that things that look like numbers are treated like numbers, this just works.

Okay, this one is a bit tougher because we want to separate out each table that are empty line separated. Let's start off by figuring out the width of the columns. So we could look at this as the first column has of numbers takes two characters and the following ones use three characters each: two followed by four that are three. Okay, now we can split it on rows that begin with empty character vectors. So how do we find the empty character vectors? Let's take the left column, and the tally of each: the numbers have tally one and the empty character vectors have tally zero. And then we can use this to partition the split because partition likes to take a vector, so we split the matrix into individual rows and then we partition like that. And here we have a vector of vectors of vectors. Mix that twice, and we've got a rank three array of numbers.

Another possibility is to compute the exact width. Here we were lucky that it was easy to spot where the column splits were, but they might have had different widths. So how can we detect where the columns' separations are? Let's begin by getting in the data, and we give a 1 to quad-n-get to say we want a vector of vectors. If we mix this, we get a character matrix. Now we can compare with space, and this gives us a boolean matrix marking where the spaces are. And reduction will tell us columns that are entirely made of spaces. These are the beginning points for every column then when we're going to cut it up, except the first column doesn't begin with a space, so we'll change the into a 1 at position 1. These are our beginning marks. The only thing we want to know is how wide are these columns, so we can use this to self-partition and then get the length of each. There we go, and then we proceed like we did before to split it in by the lines that begin with an empty vector. Oops, that should have been a split. And finally, the mix.

Okay, this is a tough one because not only do we have the separations with empty spaces, we also have these headings, and we want to extract the number from the headings. What we're going to do is we're going to start by getting in the content of the file as vector of vectors. Now we're going to split it on empties. So we can get the length of each, and we can get whether or not the length is non-zero by taking the sign of that. We can use this to partition what we've got. So now we have each board with its heading in its separate element. This means we can write a little utility function and apply to each to process it. For each board and its heading, we want to separate it into two elements: one is the heading itself, and one is the data from the board. So the heading is the first element, and the board are the remaining elements.

Now we just need to parse each part. Well, the board content itself, that is exactly the content of a comma-separated file, so we can use quad CSV on that. And then we need to gather out the number from the board heading, and for that we have verify and fix input. It gives us a two-element result: the first one is a check for each token in that character vector, did it form a correctly formed number or not, and the second element are the values with zeros put in at places where we could not evaluate to a number. All this is safe; we're not executing anything. Now we know there's only one number, so we don't need to actually check. We can just take the second element, and since we know that there will only be one number and the rest are zeros, we can just take the largest one from that, and we're done. If you want, we can stack these on top of each other.

I'll take all the codes and put them into the description of this video. Thank you for watching.
