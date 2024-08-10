⍝ Write a function that:
  ⍝ takes a right argument that is a character vector or scalar representing a valid non-negative integer.
  ⍝ takes a left argument that is a character scalar "separator" character.
  ⍝ returns a character vector that is a representation of the right argument formatted such that the separator character is found between trailing groups of 3 digits.

10*0,⍳9
⍝ 1 10 100 1000 10000 100000 1000000 10000000 100000000 1000000000
⍕¨10*0,⍳9
⍝ ┌─┬──┬───┬────┬─────┬──────┬───────┬────────┬─────────┬──────────┐
⍝ │1│10│100│1000│10000│100000│1000000│10000000│100000000│1000000000│
⍝ └─┴──┴───┴────┴─────┴──────┴───────┴────────┴─────────┴──────────┘
t←⍕¨10*0,⍳9
s←','

s{⌽⍵}¨t
⍝ ┌─┬──┬───┬────┬─────┬──────┬───────┬────────┬─────────┬──────────┐
⍝ │1│01│001│0001│00001│000001│0000001│00000001│000000001│0000000001│
⍝ └─┴──┴───┴────┴─────┴──────┴───────┴────────┴─────────┴──────────┘
s{≢⍵}¨t
⍝ 1 2 3 4 5 6 7 8 9 10
s{1 0 0⍴⍨≢⍵}¨t
⍝ ┌─┬───┬─────┬───────┬─────────┬───────────┬─────────────┬───────────────┬─────────────────┬───────────────────┐
⍝ │1│1 0│1 0 0│1 0 0 1│1 0 0 1 0│1 0 0 1 0 0│1 0 0 1 0 0 1│1 0 0 1 0 0 1 0│1 0 0 1 0 0 1 0 0│1 0 0 1 0 0 1 0 0 1│
⍝ └─┴───┴─────┴───────┴─────────┴───────────┴─────────────┴───────────────┴─────────────────┴───────────────────┘
s{(1 0 0⍴⍨≢⍵)⊂⌽⍵}¨t
⍝ ┌───┬────┬─────┬───────┬────────┬─────────┬───────────┬────────────┬─────────────┬───────────────┐
⍝ │┌─┐│┌──┐│┌───┐│┌───┬─┐│┌───┬──┐│┌───┬───┐│┌───┬───┬─┐│┌───┬───┬──┐│┌───┬───┬───┐│┌───┬───┬───┬─┐│
⍝ ││1│││01│││001│││000│1│││000│01│││000│001│││000│000│1│││000│000│01│││000│000│001│││000│000│000│1││
⍝ │└─┘│└──┘│└───┘│└───┴─┘│└───┴──┘│└───┴───┘│└───┴───┴─┘│└───┴───┴──┘│└───┴───┴───┘│└───┴───┴───┴─┘│
⍝ └───┴────┴─────┴───────┴────────┴─────────┴───────────┴────────────┴─────────────┴───────────────┘
s{⍺,¨(1 0 0⍴⍨≢⍵)⊂⌽⍵}¨t
⍝ ┌────┬─────┬──────┬─────────┬──────────┬───────────┬──────────────┬───────────────┬────────────────┬───────────────────┐
⍝ │┌──┐│┌───┐│┌────┐│┌────┬──┐│┌────┬───┐│┌────┬────┐│┌────┬────┬──┐│┌────┬────┬───┐│┌────┬────┬────┐│┌────┬────┬────┬──┐│
⍝ ││,1│││,01│││,001│││,000│,1│││,000│,01│││,000│,001│││,000│,000│,1│││,000│,000│,01│││,000│,000│,001│││,000│,000│,000│,1││
⍝ │└──┘│└───┘│└────┘│└────┴──┘│└────┴───┘│└────┴────┘│└────┴────┴──┘│└────┴────┴───┘│└────┴────┴────┘│└────┴────┴────┴──┘│
⍝ └────┴─────┴──────┴─────────┴──────────┴───────────┴──────────────┴───────────────┴────────────────┴───────────────────┘
s{∊⍺,¨(1 0 0⍴⍨≢⍵)⊂⌽⍵}¨t
⍝ ┌──┬───┬────┬──────┬───────┬────────┬──────────┬───────────┬────────────┬──────────────┐
⍝ │,1│,01│,001│,000,1│,000,01│,000,001│,000,000,1│,000,000,01│,000,000,001│,000,000,000,1│
⍝ └──┴───┴────┴──────┴───────┴────────┴──────────┴───────────┴────────────┴──────────────┘
s{1↓∊⍺,¨(1 0 0⍴⍨≢⍵)⊂⌽⍵}¨t
⍝ ┌─┬──┬───┬─────┬──────┬───────┬─────────┬──────────┬───────────┬─────────────┐
⍝ │1│01│001│000,1│000,01│000,001│000,000,1│000,000,01│000,000,001│000,000,000,1│
⍝ └─┴──┴───┴─────┴──────┴───────┴─────────┴──────────┴───────────┴─────────────┘
s{⌽1↓∊⍺,¨(1 0 0⍴⍨≢⍵)⊂⌽⍵}¨t
⍝ ┌─┬──┬───┬─────┬──────┬───────┬─────────┬──────────┬───────────┬─────────────┐
⍝ │1│10│100│1,000│10,000│100,000│1,000,000│10,000,000│100,000,000│1,000,000,000│
⍝ └─┴──┴───┴─────┴──────┴───────┴─────────┴──────────┴───────────┴─────────────┘
F←{⌽1↓∊⍺,¨(1 0 0⍴⍨≢⍵)⊂⌽⍵}

s{'...(?!$)'⎕R'&'⍺⌽⍵}¨t
⍝ ┌─┬──┬───┬─────┬──────┬───────┬─────────┬──────────┬───────────┬─────────────┐
⍝ │1│01│001│000,1│000,01│000,001│000,000,1│000,000,01│000,000,001│000,000,000,1│
⍝ └─┴──┴───┴─────┴──────┴───────┴─────────┴──────────┴───────────┴─────────────┘
s{⌽'...(?!$)'⎕R'&'⍺⌽⍵}¨t
⍝ ┌─┬──┬───┬─────┬──────┬───────┬─────────┬──────────┬───────────┬─────────────┐
⍝ │1│10│100│1,000│10,000│100,000│1,000,000│10,000,000│100,000,000│1,000,000,000│
⍝ └─┴──┴───┴─────┴──────┴───────┴─────────┴──────────┴───────────┴─────────────┘
G←{⌽'...(?!$)'⎕R'&'⍺⌽⍵}

s{(⌈3÷⍨≢⍵)3⍴⌽⍵}¨t
⍝ ┌───┬───┬───┬───┬───┬───┬───┬───┬───┬───┐
⍝ │111│010│001│000│000│000│000│000│000│000│
⍝ │   │   │   │100│010│001│000│000│000│000│
⍝ │   │   │   │   │   │   │100│010│001│000│
⍝ │   │   │   │   │   │   │   │   │   │100│
⍝ └───┴───┴───┴───┴───┴───┴───┴───┴───┴───┘
s{⍺,⍨(⌈3÷⍨≢⍵)3⍴⌽⍵}¨t
⍝ ┌────┬────┬────┬────┬────┬────┬────┬────┬────┬────┐
⍝ │111,│010,│001,│000,│000,│000,│000,│000,│000,│000,│
⍝ │    │    │    │100,│010,│001,│000,│000,│000,│000,│
⍝ │    │    │    │    │    │    │100,│010,│001,│000,│
⍝ │    │    │    │    │    │    │    │    │    │100,│
⍝ └────┴────┴────┴────┴────┴────┴────┴────┴────┴────┘
s{,⍺,⍨(⌈3÷⍨≢⍵)3⍴⌽⍵}¨t
⍝ ┌────┬────┬────┬────────┬────────┬────────┬────────────┬────────────┬────────────┬────────────────┐
⍝ │111,│010,│001,│000,100,│000,010,│000,001,│000,000,100,│000,000,010,│000,000,001,│000,000,000,100,│
⍝ └────┴────┴────┴────────┴────────┴────────┴────────────┴────────────┴────────────┴────────────────┘
s{(≢⍵),,⍺,⍨(⌈3÷⍨≢⍵)3⍴⌽⍵}¨t
⍝ ┌──────┬──────┬──────┬──────────┬──────────┬──────────┬──────────────┬──────────────┬──────────────┬───────────────────┐
⍝ │1 111,│2 010,│3 001,│4 000,100,│5 000,010,│6 000,001,│7 000,000,100,│8 000,000,010,│9 000,000,001,│10 000,000,000,100,│
⍝ └──────┴──────┴──────┴──────────┴──────────┴──────────┴──────────────┴──────────────┴──────────────┴───────────────────┘
s{(3|≢⍵),,⍺,⍨(⌈3÷⍨≢⍵)3⍴⌽⍵}¨t
⍝ ┌──────┬──────┬──────┬──────────┬──────────┬──────────┬──────────────┬──────────────┬──────────────┬──────────────────┐
⍝ │1 111,│2 010,│0 001,│1 000,100,│2 000,010,│0 000,001,│1 000,000,100,│2 000,000,010,│0 000,000,001,│1 000,000,000,100,│
⍝ └──────┴──────┴──────┴──────────┴──────────┴──────────┴──────────────┴──────────────┴──────────────┴──────────────────┘
s{(3|-≢⍵),,⍺,⍨(⌈3÷⍨≢⍵)3⍴⌽⍵}¨t
⍝ ┌──────┬──────┬──────┬──────────┬──────────┬──────────┬──────────────┬──────────────┬──────────────┬──────────────────┐
⍝ │2 111,│1 010,│0 001,│2 000,100,│1 000,010,│0 000,001,│2 000,000,100,│1 000,000,010,│0 000,000,001,│2 000,000,000,100,│
⍝ └──────┴──────┴──────┴──────────┴──────────┴──────────┴──────────────┴──────────────┴──────────────┴──────────────────┘
s{(1+3|-≢⍵),,⍺,⍨(⌈3÷⍨≢⍵)3⍴⌽⍵}¨t
⍝ ┌──────┬──────┬──────┬──────────┬──────────┬──────────┬──────────────┬──────────────┬──────────────┬──────────────────┐
⍝ │3 111,│2 010,│1 001,│3 000,100,│2 000,010,│1 000,001,│3 000,000,100,│2 000,000,010,│1 000,000,001,│3 000,000,000,100,│
⍝ └──────┴──────┴──────┴──────────┴──────────┴──────────┴──────────────┴──────────────┴──────────────┴──────────────────┘
s{(¯1-3|-≢⍵)↓,⍺,⍨(⌈3÷⍨≢⍵)3⍴⌽⍵}¨t
⍝ ┌─┬──┬───┬─────┬──────┬───────┬─────────┬──────────┬───────────┬─────────────┐
⍝ │1│01│001│000,1│000,01│000,001│000,000,1│000,000,01│000,000,001│000,000,000,1│
⍝ └─┴──┴───┴─────┴──────┴───────┴─────────┴──────────┴───────────┴─────────────┘
s{⌽(¯1-3|-≢⍵)↓,⍺,⍨(⌈3÷⍨≢⍵)3⍴⌽⍵}¨t
⍝ ┌─┬──┬───┬─────┬──────┬───────┬─────────┬──────────┬───────────┬─────────────┐
⍝ │1│10│100│1,000│10,000│100,000│1,000,000│10,000,000│100,000,000│1,000,000,000│
⍝ └─┴──┴───┴─────┴──────┴───────┴─────────┴──────────┴───────────┴─────────────┘
H←{⌽(¯1-3|-≢⍵)↓,⍺,⍨(⌈3÷⍨≢⍵)3⍴⌽⍵}

'cmpx'⎕CY'dfns'
10↑n←1e6⍴⎕D
⍝ 0123456789
cmpx's F n' 's G n' 's H n'
⍝   s F n → 4.3E¯2 |    0% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕                       
⍝   s G n → 1.0E¯1 | +141% ⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕⎕
⍝   s H n → 2.6E¯3 |  -95% ⎕                                       