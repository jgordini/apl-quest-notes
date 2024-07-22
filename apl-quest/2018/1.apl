⍝ Write an APL expression that, given a scalar or vector of skyscraper heights from closest to furthest, will return an integer representing the number of skyscrapers that can be seen.
t←5 5 2 10 3 15 10
{⌈\⍵}t
⍝ 5 5 5 10 10 15 15
{∪⌈\⍵}t
⍝ 5 10 15
{≢∪⌈\⍵}t
⍝ 3
F←{≢∪⌈\⍵}

{⌈\⍵}t
⍝ 5 5 5 10 10 15 15
{2</⌈\⍵}t
⍝ 0 0 1 0 1 0
{0,⍵}t
⍝ 0 5 5 2 10 3 15 10
{2</⌈\0,⍵}t
⍝ 1 0 0 1 0 1 0
{+/2</⌈\0,⍵}t
⍝ 3
G←{+/2</⌈\0,⍵}

⍝ Avoid expensive 0,
H←{⍬≡⍵:0 ⋄ 1++/2</⌈\⍵}

'cmpx'⎕CY'dfns'
s←?⍳1000
cmpx 'F s' 'G s' 'H s'
⍝   F s → 6.3E¯6 |   0% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕
⍝   G s → 2.7E¯6 | -58% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕     
⍝   H s → 2.1E¯6 | -68% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕   
