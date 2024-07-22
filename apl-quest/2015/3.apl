⍝ Write a function that takes an integer right argument and returns a vector of the terms in the Farey sequence of that order. Each element in the returned vector is itself a 2-element vector of numerator and denominator for the corresponding term.
⍝ Generate all indices in n×n matrix
Ii←{0 1,⍥⊆f[i][⍋q[i←(1∘≥∩⍥⍸≠)q←÷/¨f←,⍳⍵ ⍵]]}
Ij←{0 1,⍥⊆f[i][⍋q[i←⍸(1∘≥∧≠)q←÷/¨f←,⍳⍵ ⍵]]}

'cmpx'⎕'dfns'
cmpx'Ii 1000' 'Ij 1000'
⍝  Ii 1000 → 3.3E0  |   0% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕
⍝  Ij 1000 → 1.4E0  | -56% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕                      

⍝ Eliminate one more use of indices
Im←{0 1,⍥⊆(m/f)[⍋q/⍨m←(1∘≥∧≠)q←÷/¨f←,⍳⍵ ⍵]}
cmpx'Ij 1000' 'Im 1000'
⍝  Ij 1000 → 1.4E0  |  0% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕
⍝  Im 1000 → 1.3E0  | -1% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕

⍝ Use Greatest Common Divisor
G←{0 1,⍥⊆f[⍋÷/¨f←⍸∘.(≤∧1=∨)⍨⍳⍵]}
G2←{0 1,⍥⊆f[⍋÷/¨f←⍸(∘.≤∧1=∘.∨)⍨⍳⍵]}
cmpx'G 1000' 'G2 1000'
⍝  G 1000  → 4.2E¯1 |   0% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕
⍝  G2 1000 → 1.6E¯1 | -63% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕                         

⍝ Compute quotients from the outset
Q←{(,÷∨)∘1¨{⍵[⍋⍵]}0,∪1⌊,∘.÷⍨⍳⍵}
Qf←{↓(,⍤0÷⍤1 0∨)∘1{⍵[⍋⍵]}0,∪1⌊,∘.÷⍨⍳⍵}
cmpx'Q 1000' 'Qf 1000'
⍝  Q 1000  → 2.0E¯1 |   0% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕
⍝  Qf 1000 → 8.1E¯2 | -59% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕                       

⍝ Use Power operator to generate sequence
P← {⍵{(a b)(c d)←¯2↑⍵ ⋄ ⍵,⊂a b-⍨c d×⌊d÷⍨⍺+b}⍣{≥/⊃⌽⍺}⍣(1<⍵)⊢(0 1)(1 ⍵)↑⍨2⌊1+⍵}
Pf←{↓⍵{(a b c d)←,¯2↑⍵ ⋄ ⍵⍪a b-⍨c d×⌊d÷⍨⍺+b}⍣{≥/⊢⌿⍺}⍣(1<⍵)⊢0 1 1 ⍵⍴⍨(2⌊1+⍵)2}
cmpx'P 100' 'Pf 100'
⍝  P 100  → 5.0E¯2 |   0% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕
⍝  Pf 100 → 8.1E¯3 | -84% ⎕⎕⎕⎕⎕⎕⎕                                 

cmpx'Im 100' 'G2 100' 'Qf 100' 'Pf 100'
⍝  Im 100 → 9.3E¯3 |   0% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕
⍝  G2 100 → 1.4E¯3 | -86% ⎕⎕⎕⎕⎕⎕                                  
⍝  Qf 100 → 8.0E¯4 | -92% ⎕⎕⎕                                     
⍝  Pf 100 → 8.1E¯3 | -14% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕     
