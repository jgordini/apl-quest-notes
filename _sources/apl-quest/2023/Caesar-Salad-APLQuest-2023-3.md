# Implementing a Simple Caesar Cipher for Uppercase Characters and Spaces

In this article, we will implement a simple Caesar cipher that handles uppercase characters and spaces. The fundamental idea is to build upon the uppercase alphabet, also incorporating a space at the front. We will utilize a Lambda function to achieve this.

## The Concept

The cipher replaces each letter in the plaintext by a letter that is a fixed number of positions away in the alphabet, effectively "shifting" the alphabet. For our implementation, we will use `' ',⎕A` as the alphabet, where `⎕A` represents the uppercase letters A through Z:

```apl
⎕A
⍝ ABCDEFGHIJKLMNOPQRSTUVWXYZ
alphabet ← ' ',⎕A
```

Here, we place a space at the beginning of the string, making it easier to manage the indexing for both letters and spaces. When we aim to index the characters, we can check the index of any character in the alphabet. For example, to find the index of "H":

```apl
indexOfH ← (' ',⎕A)⍳'H'
⍝ 9
```

The position of "H" is 9 when accounting for the space at the start.

Additionally, we will introduce a left argument representing a rotation of the alphabet, allowing us to utilize the indexing capabilities of APL effectively.

## Implementing the Cipher

First, let's define our function. The function will take a rotation value (indicating how many positions to shift the alphabet) and a character vector representing the plaintext message:

```apl
F ← { (⍺⌽a)[⍵⍳⍨a←' ',⎕A] }
```

### Applying the Cipher

Once we define our function for the cipher, we can apply it easily in both directions—encoding and decoding. To encode a message, we use positive rotation values. For example, to encode "HELLO WORLDS" with a rotation of 4:

```apl
encodedMessage ← 4 F 'HELLO WORLDS'
⍝ LIPPSD SVPHW
```

For decoding, we simply apply a negative rotation. Here’s how it looks when we decode the same message with a rotation of -4:

```apl
decodedMessage ← ¯4 F 'LIPPSD SVPHW'
⍝ HELLO WORLDS
```

### Rotation

Let's say we want to rotate the alphabet. We can create the rotated version of the alphabet by shifting its elements:

```apl
rotatedAlphabet ← 4⌽' ',⎕A
⍝ DEFGHIJKLMNOPQRSTUVWXYZ ABC
```

This line defines a rotated alphabet, representing the new arrangement of letters after the shift.

## Code Clean-Up

Next, we'll improve the existing code to make it more efficient and readable. Our revised code looks like this:

```apl
alphabet ← ' ',⎕A
alpha ← (' ',⎕A)⍳'H'
rotatedAlphabet ← 4⌽' ',⎕A
```

In this version, we have streamlined our assignments without repeating code. 

## Reversing the Cipher

To decode the message, we simply reverse the process using the same function defined earlier but with a negative rotation:

```apl
originalMessage ← ¯4 F encodedMessage
```

This dual functionality demonstrates that our cipher can encode and decode messages using the same function, with the distinction that a negative value for the rotation indicates a reverse action.

## Conclusion

We successfully implemented a Caesar cipher capable of encoding and decoding uppercase messages and spaces. The clever use of indexing and rotation provides a simple yet effective means to achieve this. Thank you for following along, and happy coding!