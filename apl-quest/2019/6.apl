⍝ Write an APL function that takes a character vector right argument that consists of digits and uppercase letters and returns an integer vector of the corresponding digits on the phone keypad.
t←↑¨⍕¨¨4 3⍴(''1)('ABC'2)('DEF'3)('GHI'4)('JKL'5)('MNO'6)('PQRS'7)('TUV '8)('WXYZ'9)('' '*')(''0)('' '#')
⊃¨t
⍝  AD
⍝ GJM
⍝ PTW
⍝    
,⊃¨t
⍝  ADGJMPTW   
⎕A∩,⊃¨t
⍝ ADGJMPTW
c←⎕A∩,⊃¨t
c⍸⎕A
⍝ 1 1 1 2 2 2 3 3 3 4 4 4 5 5 5 6 6 6 6 7 7 7 8 8 8 8
'@ADGJMPTW'⍸⎕A
⍝ 2 2 2 3 3 3 4 4 4 5 5 5 6 6 6 7 7 7 7 8 8 8 9 9 9 9
⎕D
⍝ 0123456789
⎕D⍸⎕D
⍝ 1 2 3 4 5 6 7 8 9 10
⎕D⍸' '
⍝ 0
(1↓⎕D)
⍝ 123456789
(1↓⎕D)⍸⎕D
⍝ 0 1 2 3 4 5 6 7 8 9
(1↓⎕D,'@ADGJMPTW')
⍝ 123456789@ADGJMPTW
(1↓⎕D,'@@ADGJMPTW')⍸⎕D
⍝ 0 1 2 3 4 5 6 7 8 9
(1↓⎕D,'@@ADGJMPTW')⍸⎕A
⍝ 12 12 12 13 13 13 14 14 14 15 15 15 16 16 16 17 17 17 17 18 18 18
 19 19 19 19
10|(1↓⎕D,'@@ADGJMPTW')⍸⎕A
⍝ 2 2 2 3 3 3 4 4 4 5 5 5 6 6 6 7 7 7 7 8 8 8 9 9 9 9
10|(1↓⎕D,'@@ADGJMPTW')⍸⎕D
⍝ 0 1 2 3 4 5 6 7 8 9
F←10|(1↓⎕D,'@@ADGJMPTW')∘⍸
F 'ABC'
⍝ 2 2 2
F 'DEF'
⍝ 3 3 3
F '123'
⍝ 1 2 3
F 'UR2CUTE'
⍝ 8 7 2 2 8 8 3
F¨⎕D,⎕A
⍝ 0 1 2 3 4 5 6 7 8 9 2 2 2 3 3 3 4 4 4 5 5 5 6 6 6 7 7 7 7 8 8 8 9
 9 9 9
n←F¨⎕D,⎕A
G←{n[(⎕D,⎕A)⍳⍵]}
G 'UR2CUTE'
⍝ 8 7 2 2 8 8 3
G←{0 1 2 3 4 5 6 7 8 9 2 2 2 3 3 3 4 4 4 5 5 5 6 6 6 7 7 7 7 8 8 8 9 9 9 9[(⎕D,⎕A)⍳⍵]}
G 'UR2CUTE'
⍝ 8 7 2 2 8 8 3
