⍝ Write a function that will return the first n odd natural numbers.
{⍳⍵}5
⍝ 1 2 3 4 5
{2×⍳⍵}5
⍝ 2 4 6 8 10
{¯1+2×⍳⍵}5
⍝ 1 3 5 7 9
(¯1+2×⍳)5
⍝ 1 3 5 7 9
¯1+2×⍳5
⍝ 1 3 5 7 9
Odd←¯1+2×⍳
Odd 5
⍝ 1 3 5 7 9
