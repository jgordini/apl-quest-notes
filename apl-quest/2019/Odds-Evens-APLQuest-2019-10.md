
# Splitting a List of Words by Length

In this article, we will explore how to split a list of words into two categories: words with an even number of letters and words with an odd number of letters. The order of the words is important; we want the odd-lettered words to appear first, followed by the even-lettered words. 

## Introduction

We will examine three different approaches to solving this problem. Each method provides a unique way of tackling the same issue, and there are many other strategies that could also be employed.

### Test Data

Let’s start with some test data that includes both even and odd length words:

- **Test Data in APL:**  
```apl
t ← 'only' 'even' 'all' 'odd' 'the' 'plan' 'is' 'great'
```

- **Odd Words:** "cat", "dog", "horse"
- **Even Words:** "fish", "seal", "turtle"
- A mixture of both: "cat", "fish", "dog", "seal", "horse", "turtle"

We will start our analysis by counting the number of letters in each word. However, we are primarily interested in determining whether each word has an odd or even number of letters. 

To achieve this, we can inspect the remainder of the length of each word when divided by two. If the remainder is zero, the number of letters is even; if it is one, the number of letters is odd.

```apl
≢¨ t  ⍝ Count the number of letters in each word
```

This will return:
```
4 4 3 3 3 4 2 5
```

## Method 1: Using Lambda Functions

1. **Creating a Lambda Function:**  
   We will create a Lambda function that takes an argument and refers to it as `ω`.
   
2. **Generating Masks:**  
   We need two masks: one for odd-numbered words and another for even-numbered words. The mask for even numbers is simply the Boolean negation of the odd mask.

```apl
2|≢¨t  ⍝ This gives a mask for even (0) and odd (1)
```

This returns:
```
0 0 1 1 1 0 0 1
```

3. **Applying the Masks:**  
   We apply both masks to the list of words. The application of each mask will yield the respective even and odd categorized words.

```apl
{2|≢¨⍵} t  ⍝ Mask for odd words
{~2|≢¨⍵} t  ⍝ Mask for even words
```

4. **Final Concatenation:**  
   After applying the masks, we will concatenate the results, ensuring that odd-numbered words appear first.

```python
# Example in Python-like pseudocode
words = ["cat", "fish", "dog", "seal", "horse", "turtle"]
odd_mask = lambda x: len(x) % 2 != 0
even_mask = lambda x: len(x) % 2 == 0

odd_words = [word for word in words if odd_mask(word)]
even_words = [word for word in words if even_mask(word)]
result = odd_words + even_words
```

## Method 2: Using the Key Operator

The problem specification suggests using a key operator. This method groups words based on their characteristic (odd or even length), but we encounter an issue with the order since the first group ends up being even if the first word is even.

### Solution to Ordering

To maintain the desired order, we can prepend words of the appropriate lengths, remove them from the incoming data, and then regroup.

```apl
((2|≢¨)⊂⍤⊢⌸⊢) t  ⍝ Key-based approach maintaining order
```

### Another Approach

```apl
(2|≢¨)⊂⍤⊢⌸⊢ t  ⍝ Grouping based on the key, shows odd/even categorization
```

## Method 3: Sorting by Length

Another straightforward method is to sort the list of words based on their length. By sorting first and then splitting the results, we can ensure that all odd-length words come before even-length words. 

1. **Sort Words by Length:**  
   Using a descending sort based on whether the length is odd or even will arrange the words correctly.

```apl
{n←2|≢¨⍵ ⋄ ⍵[⍒n]} t  ⍝ Sort based on length even/odd
```

2. **Counting Odd Words:**  
   We can count how many odd words are present and then split the list at that point.

```apl
{n←2|≢¨⍵ ⋄ c←+/n ⋄ c↑s} t  ⍝ Count odd length words, split result
```

## Conclusion

In this article, we demonstrated three distinct methods for splitting a list of words into odd and even categories based on the number of letters. 

- The first method utilized Lambda functions.
- The second method involved the key operator with additional manipulation to maintain order.
- The third method relied on sorting the words based on their length.

Each approach shows the flexibility of programming techniques in addressing the same problem in various ways. Thank you for reading!
