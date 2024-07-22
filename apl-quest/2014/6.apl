⍝ Write a dfn that takes an integer vector representing the sides of a number of dice and returns a 2 column matrix of the number of ways each possible total of the dice can be rolled.
I←{,∘≢⌸,+/¨⍳⍵}
I 16⍴2 ⍝ fails with LIMIT ERROR
E←{,∘≢⌸+⌿1+⍵⊤⍥,¯1+⍳×/⍵}
E 16⍴2 ⍝ works

'cmpx'⎕CY'dfns'
⊃,/{,⍳⍵⍴3}¨0,⍳3
≢t←⊃,/{,⍳⍵⍴9}¨0,⍳4
cmpx'I¨t' 'E¨t'
⍝  I¨t → 3.6E¯1 |   0% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕
⍝  E¨t → 2.5E¯1 | -32% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕             

Ed←{{⍺,≢⍵}⌸+⌿1+⍵⊤⍥,¯1+⍳×/⍵}
cmpx'E¨t' 'Ed¨t'
⍝  E¨t  → 2.4E¯1 |   0% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕
⍝  Ed¨t → 1.0E¯1 | -58% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕                       
