⍝ Progressive dyadic iota is similar to ⍳ except that it returns the index of subsequent matches in the left argument until they are exhausted. Write a function that implements progressive dyadic iota.
a←'Landon' ⋄ b←'Finnegan'

{((⍴⍺)⍴⍋⍋⍺,⍵)⍳(⍴⍵)⍴⍋⍋⍵,⍺}
{((≢⍺)⍴⍋⍋⍺⍪⍵)⍳(≢⍵)⍴⍋⍋⍵⍪⍺}
F←{⍺(R⍨⍳R←≢⍤⊢⍴⍋⍤⍋⍤⍪⍨)⍵}

{((⍋⍺⍳⍺,⍵)⍳⍳⍴⍺)⍳(⍋⍺⍳⍵,⍺)⍳⍳⍴⍵}
{((⍋⍺⍳⍺⍪⍵)⍳⍳≢⍺)⍳(⍋⍺⍳⍵⍪⍺)⍳⍳≢⍵}
{⍺(R⍨⍳R←(⍋⍺⍳⍪⍨)⍳⍳⍤≢⍤⊢)⍵}
G←{⍺(R⍨⍳R←⍳⍤≢⍤⊢⍳⍨∘⍋⍺⍳⍪⍨)⍵}

x←⎕A[?1000⍴26]
y←⎕A[?1000⍴26]
'cmpx'⎕CY'dfns'
cmpx'x F y' 'x G y'
⍝  x F y → 2.8E¯5 |    0% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕                       
⍝  x G y → 6.6E¯5 | +133% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕

K{(1+≢⍺)@(0∘=){⍵[⍋⍵;2]}⊃⍪/{⊂⍵,⍪((≢⍵)↑⍸⍺)}⌸⍵≡⍤99 ¯1⍤¯1 99⊢⍺}

N←{{i⊣((i←(¯1↓a)⍳⍵)⌷a)←⎕NS ⍬}⍤¯1⊢⍵⊣a←⍺⍪'⍉'}

x←⎕A[?100⍴26]
y←⎕A[?100⍴26]
cmpx'x F y' 'x K y' 'x N y'
⍝  x F y → 1.4E¯5 |     0% ⎕⎕                                      
⍝  x K y → 9.8E¯5 |  +600% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕                             
⍝  x N y → 3.5E¯4 | +2414% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕
