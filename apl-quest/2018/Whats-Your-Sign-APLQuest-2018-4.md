
# Converting Gregorian Year Numbers to Chinese Zodiac Animals

In this article, we will cover the process of converting a Gregorian year number to the closest matching Chinese zodiac animal. It is essential to note that the proleptic Gregorian calendar does not have a year zero, which adds complexity to our task.

## Data Preparation

There are various methods to scrape data from a website. For our purposes, I've defined a matrix that corresponds to a table on a website. This matrix is a bit "dirty," so the first thing we need to do is clean it up.

We do not require all the columns, so we will index into this data and select columns one and four for the year numbers. Additionally, we will select the animal names from columns two and five, skipping the empty column four, which was merely for spacing.

As we examine the data, we can see that there are trailing spaces at the end of both the animal names and the year numbers. We can clean this up by applying a set difference function to remove the spaces, as there are no internal spaces to worry about.

Here’s how we can prepare the data using APL:

```apl
r[;1 4 2 5]
```

## Reshaping the Data

Next, we can transpose the cleaned data to improve the reading order. However, we still have two rows for each item. We only want two rows in total: one for the years and one for the animal names. We can reshape our data to achieve this, resulting in a clearer table.

Since the data is now in reverse order, we will mirror it. Finally, we want to split our matrix into two lists, resulting in vectors for the years and the zodiac sign names. The years are not numeric, but this is not a significant concern for our immediate task.

To generate the year numbers, we can create a sequence starting from 2006. Here’s an example of reshaping data in APL:

```apl
2 12⍴⍉r[;1 4 2 5]~¨' '
```

## Working with the Zodiac Cycle

We are going to work with a 12-year cycle. To identify the origin point for our zodiac signs, we can calculate the remainder of the year after dividing by 12. We can find exactly one year that is evenly divisible by 12 and obtain its index (which is 10). Starting from year 2007, we want to rotate our animal names by nine steps.

### Mapping Years to Zodiac Animals

Now, let’s clarify how the zodiac assignments work. If the result of the division of the year by 12 is zero, then the zodiac is the Monkey. If there is a remainder of one, the zodiac is the Rooster, and so on, up to eleven, which corresponds to the Pig.

To streamline the process, we can transform our processing logic into an APL expression. A special user command will help us with this, but we can also combine all the characters into a single character vector. 

An example to illustrate this mapping is shown below:

```apl
y s ← ↓⌽2 12⍴⍉r[;1 4 2 5]~¨' '
```

### Character Vector Membership

We make use of a special system variable called `Quade`, which provides the alphabet. By checking membership against this, we can ensure that we keep track of the leading uppercase letters in our animal names.

Next, we can create a function that references the arguments in terms of function application to partition the list based on the membership we derived from our earlier checks. 

## Addressing Year Zero

One significant challenge arises when dealing with years one and negative one. Since the Gregorian calendar lacks a year zero, a negative input year number must be adjusted by adding one.

Here’s how the APL adjustment looks for handling the year zero issue:

```apl
F ← ⊃('MonkeyRoosterDogPigRatOxTigerRabbitDragonSnakeHorseGoat'(∊⊂⊣)⎕A)⌽⍨⊢+0∘>
```

We need to account for this adjustment in our calculations by using a greater-than function to determine whether the year number is positive or negative. By implementing this logic, we can effectively adjust our year numbers before rotations.

## Final Function Implementation

Now that we have a method to calculate the year number while compensating for the absence of a year zero, we can create our complete function. With this in place, we can easily retrieve the zodiac sign for any given year, including negative years.

Here’s a brief example for the years:

- For the year 2018, we find that the corresponding zodiac animal is the Dog. 
- For 2007, it's the Pig, and for -1, we should arrive at the Monkey.

### Examples of Function Calls

To illustrate how this can be done in APL:

```apl
F 2018
```
This will yield:
```
Dog
```

```apl
F 1
```
This will yield:
```
Rooster
```

```apl
F ¯1
```
This will yield:
```
Monkey
```

### Conclusion

This approach robustly combines data cleaning, reshaping, and numeric adjustments to ensure accurate outputs for the Chinese zodiac corresponding to any Gregorian year. 

For improved efficiency and readability, it is advised to save the list of zodiac signs as a constant, allowing for cleaner function definitions and better reusability without altering the logic fundamentally.

Thank you for reading!