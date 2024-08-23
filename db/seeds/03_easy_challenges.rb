# frozen_string_literal: true

create_challenge(
  name: 'Not even odd',
  difficulty: 1,
  description: 'Write a method taking a number as an argument.
  The method should return "even steven" if the number is even and "that was odd..." if the number is odd.',
  language: 'Ruby',
  tests: {
    'not_even_odd(4)' => 'even steven',
    'not_even_odd(5)' => 'that was odd...',
  },
  method_template: 'def not_even_odd(number)\n  \nend'
)

create_challenge(
  name: 'Printed errors',
  difficulty: 1,
  description: 'In a factory a printer prints labels for boxes. For one kind of boxes the printer has to use colors which, are named with letters from a to m.
  The colors used by the printer are recorded in a control string.
  For example a "good" control string would be aaabbbbhaijjjm meaning that the printer used color a three times, color b four times, color h once, then once again color a...

  Sometimes there are problems: lack of colors, technical malfunctions, and a "bad" control string is produced.

  For example:
    aaaxbbbbyyhwawiwjjjwwm which includes letters outside of a-m.

  You have to write a method which given a string will return the error rate of the printer as a string with a numerator showing the number of errors, and a denominator showing the length of the control string.

  For example:
    "1/15" (1 error, 15 control string length) Do not reduce this fraction to a simpler expression.',
  language: 'Ruby',
  tests: {
    'printer_error("aaabbbbhaijjjm")' => '0/14',
    'printer_error("aaaxbbbbyyhwawiwjjjwwm")' => '8/22',
  },
  method_template: 'def printer_error(string)\n  \nend'
)

create_challenge(
  name: 'Arrays',
  difficulty: 1,
  description: 'You are given an array (which will have a length of at least 3, but could be very large) containing integers.
  The array is either entirely comprised of odd integers or entirely comprised of even integers except for a single integer N.
  Write a method that takes the array as an argument and returns this "outlier" N.

  Examples:
    [2, 4, 0, 100, 4, 11, 2602, 36]
    Should return: 11 (the only odd number)

    [160, 3, 1719, 19, 11, 13, -21]
    Should return: 160 (the only even number)',
  language: 'Ruby',
  tests: {
    'find_the_outlier([2, 4, 0, 100, 4, 11, 2602, 36])' => 11,
    'find_the_outlier([160, 3, 1719, 19, 11, 13, -21])' => 160,
  },
  method_template: 'def find_the_outlier(array)\n  \nend'
)

create_challenge(
  name: 'Sort numbers',
  difficulty: 1,
  description: 'You are given an array of integers.
  Your task is to sort odd numbers within the array in ascending order, and even numbers in descending order.
  Note that zero is an even number. If you have an empty array, you need to return it.

  For example:
  [5, 3, 2, 8, 1, 4]  -->  [1, 3, 5, 8, 4, 2]',
  language: 'Ruby',
  tests: {
    'up_and_down([5, 3, 2, 8, 1, 4])' => [1, 3, 5, 8, 4, 2],
    'up_and_down([21, 7, 35, 1, 8, 12, 2, 0])' => [1, 7, 21, 35, 12, 8, 2, 0],
  },
  method_template: 'def up_and_down(array)\n  \nend'
)

create_challenge(
  name: 'Descending order',
  difficulty: 1,
  description: 'Your task is to make a method that can take any non-negative integer as an argument and return it with its digits in descending order.

  Examples:
    Input: 42145 Output: 54421
    Input: 145263 Output: 654321
    Input: 123456789 Output: 987654321',
  language: 'Ruby',
  tests: {
    'descending_order(42_145)' => 54_421,
    'descending_order(145_263)' => 654_321,
    'descending_order(123_456_789)' => 987_654_321,
  },
  method_template: 'def descending_order(number)\n  \nend'
)

create_challenge(
  name: 'Numbers Greater Than Five',
  difficulty: 1,
  description: 'Given an array of numbers, count how many items are greater than 5.
  The method should return an integer.

  For example:
    [1, 4, 2, 70, 45, -2] --> 2',
  language: 'Ruby',
  tests: {
    'numbers_greater_than_five([1, 48, 32, 6, 90, 2, 3])' => 4,
    'numbers_greater_than_five([32, 3, 1, 8, 5, 4])' => 2,
  },
  method_template: 'def numbers_greater_than_five(array)\n  \nend'
)

create_challenge(
  name: 'Prime Number Algorithm',
  difficulty: 1,
  description: 'Given an array of numbers, count how many items are prime numbers.
  The method should return an integer.

  For example:
    [15, 53, 117, 487, 1212, 1213] --> 3',
  language: 'Ruby',
  tests: {
    'prime_number_algorithm([1303, 41, 86, 997, 100])' => 3,
    'prime_number_algorithm([120, 2, 1, 60, -1, 80])' => 1,
  },
  method_template: 'def prime_number_algorithm(array)\n  \nend'
)

create_challenge(
  name: 'Sum of Prime Numbers',
  difficulty: 1,
  description: 'Given an array of numbers, calculate the sum of the prime numbers.
  The method should return an integer.

  For example:
    [15, 53, 117, 487, 1212, 1213] --> 1753',
  language: 'Ruby',
  tests: {
    'sum_of_prime_numbers([1303, 41, 86, 997, 100])' => 2341,
    'sum_of_prime_numbers([120, 2, 1, 60, -1, 80])' => 2,
  },
  method_template: 'def sum_of_prime_numbers(array)\n  \nend'
)

create_challenge(
  name: 'Factorial Numbers',
  difficulty: 1,
  description: 'Given an integer, calculate its factorial.
  The method should return an integer.

  The factorial of a number is the product of all the positive integers that are less than or equal to the number in question.

  For example:
    6 --> 720
    (1 x 2 x 3 x 4 x 5 x 6 = 720',
  language: 'Ruby',
  tests: {
    'factorial(6)' => 720,
    'factorial(4)' => 24,
  },
  method_template: 'def factorial(number)\n  \nend'
)
