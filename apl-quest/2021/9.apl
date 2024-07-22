⍝ Write a function that:
⍝    has a right argument that is a numeric vector of 2 or more elements representing daily prices of a stock.
⍝    returns an integer singleton that represents the highest number of consecutive days where the price increased, decreased, or remained the same, relative to the previous day.

p←1 2 3 5 5 5 6 4 3

⍝ Simple solution:
{⍵}p
⍝ 1 2 3 5 5 5 6 4 3
{2-/⍵}p
⍝ ¯1 ¯1 ¯2 0 0 ¯1 2 1
{×2-/⍵}p
⍝ ¯1 ¯1 ¯1 0 0 ¯1 1 1
{2≠/×2-/⍵}p
⍝ 0 0 1 0 1 1 0
{1,2≠/×2-/⍵}p
⍝ 1 0 0 1 0 1 1 0
{⊂⍨1,2≠/×2-/⍵}p
⍝ ┌─────┬───┬─┬───┐
⍝ │1 0 0│1 0│1│1 0│
⍝ └─────┴───┴─┴───┘
{≢¨⊂⍨1,2≠/×2-/⍵}p
⍝ 3 2 1 2
{⌈/≢¨⊂⍨1,2≠/×2-/⍵}p
⍝ 3
F←{⌈/≢¨⊂⍨1,2≠/×2-/⍵}

⍝ Keeping it flat:
{1,2≠/×2-/⍵}p
⍝ 1 0 0 1 0 1 1 0
{1,⍨1,2≠/×2-/⍵}p
⍝ 1 0 0 1 0 1 1 0 1
{⍸1,⍨1,2≠/×2-/⍵}p
⍝ 1 4 6 7 9
{2-/⍸1,⍨1,2≠/×2-/⍵}p
⍝ ¯3 ¯2 ¯1 ¯2
{¯2-/⍸1,⍨1,2≠/×2-/⍵}p
⍝ 3 2 1 2
{⌈/¯2-/⍸1,⍨1,2≠/×2-/⍵}p
⍝ 3
G←{⌈/¯2-/⍸1,⍨1,2≠/×2-/⍵}

⍝ Performance comparison:
10↑q←?1e6⍴10
⍝ 6 9 3 8 6 4 9 6 7 9
'cmpx'⎕CY'dfns'
cmpx'F q' 'G q'
⍝   F q → 3.1E¯2 |   0% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕
⍝   G q → 2.6E¯3 | -92% ⎕⎕⎕                                     
