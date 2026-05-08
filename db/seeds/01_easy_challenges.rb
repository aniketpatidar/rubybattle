# frozen_string_literal: true

puts "Creating easy challenges"

create_challenge(
  name: "Not even odd",
  difficulty: :easy,
  description: "Write a method taking a number as an argument.\n  The method should return \"even steven\" if the number is even and \"that was odd...\" if the number is odd.",
  language: "Ruby",
  tests: [
      {
        "input": "not_even_odd(4)",
        "expected_output": "even steven"
      },
      {
        "input": "not_even_odd(5)",
        "expected_output": "that was odd..."
      }
    ],
  method_template: "def not_even_odd(number)\\n  \\nend"
)

create_challenge(
  name: "Array Array Array",
  difficulty: :easy,
  description: "You are given an initial 2-value array. You will use this to calculate a score.\n  If both values in the array are numbers, the score is the sum of the two.\n  If only one is a number, the score is that number.\n  If neither is a number, return \"Void!\".\n  Once you have your score, you must return an array of arrays.\n  Each sub array will be the same as the original array and the number of sub arrays should be equal to the score.\n\n  For example:\n    if (array) == [\"a\", 3] you should return [[\"a\", 3], [\"a\", 3], [\"a\", 3]].",
  language: "Ruby",
  tests: [
      {
        "input": "array_array_array([\"a\", 3])",
        "expected_output": [
          [
            "a",
            3
          ],
          [
            "a",
            3
          ],
          [
            "a",
            3
          ]
        ]
      },
      {
        "input": "array_array_array([2, 4])",
        "expected_output": [
          [
            2,
            4
          ],
          [
            2,
            4
          ],
          [
            2,
            4
          ],
          [
            2,
            4
          ],
          [
            2,
            4
          ],
          [
            2,
            4
          ]
        ]
      }
    ],
  method_template: "def array_array_array(array)\\n  \\nend"
)

create_challenge(
  name: "Printed errors",
  difficulty: :easy,
  description: "In a factory a printer prints labels for boxes. For one kind of boxes the printer has to use colors which, are named with letters from a to m.\n  The colors used by the printer are recorded in a control string.\n  For example a \"good\" control string would be aaabbbbhaijjjm meaning that the printer used color a three times, color b four times, color h once, then once again color a...\n\n  Sometimes there are problems: lack of colors, technical malfunctions, and a \"bad\" control string is produced.\n\n  For example:\n    aaaxbbbbyyhwawiwjjjwwm which includes letters outside of a-m.\n\n  You have to write a method which given a string will return the error rate of the printer as a string with a numerator showing the number of errors, and a denominator showing the length of the control string.\n\n  For example:\n    \"1/15\" (1 error, 15 control string length) Do not reduce this fraction to a simpler expression.",
  language: "Ruby",
  tests: [
      {
        "input": "printer_error(\"aaabbbbhaijjjm\")",
        "expected_output": "0/14"
      },
      {
        "input": "printer_error(\"aaaxbbbbyyhwawiwjjjwwm\")",
        "expected_output": "8/22"
      }
    ],
  method_template: "def printer_error(string)\\n  \\nend"
)

create_challenge(
  name: "Arrays",
  difficulty: :easy,
  description: "You are given an array (which will have a length of at least 3, but could be very large) containing integers.\n  The array is either entirely comprised of odd integers or entirely comprised of even integers except for a single integer N.\n  Write a method that takes the array as an argument and returns this \"outlier\" N.\n\n  Examples:\n    [2, 4, 0, 100, 4, 11, 2602, 36]\n    Should return: 11 (the only odd number)\n\n    [160, 3, 1719, 19, 11, 13, -21]\n    Should return: 160 (the only even number)",
  language: "Ruby",
  tests: [
      {
        "input": "find_the_outlier([2, 4, 0, 100, 4, 11, 2602, 36])",
        "expected_output": 11
      },
      {
        "input": "find_the_outlier([160, 3, 1719, 19, 11, 13, -21])",
        "expected_output": 160
      }
    ],
  method_template: "def find_the_outlier(array)\\n  \\nend"
)

create_challenge(
  name: "Sort numbers",
  difficulty: :easy,
  description: "You are given an array of integers.\n  Your task is to sort odd numbers within the array in ascending order, and even numbers in descending order.\n  Note that zero is an even number. If you have an empty array, you need to return it.\n\n  For example:\n  [5, 3, 2, 8, 1, 4]  -->  [1, 3, 5, 8, 4, 2]",
  language: "Ruby",
  tests: [
      {
        "input": "up_and_down([5, 3, 2, 8, 1, 4])",
        "expected_output": [
          1,
          3,
          5,
          8,
          4,
          2
        ]
      },
      {
        "input": "up_and_down([21, 7, 35, 1, 8, 12, 2, 0])",
        "expected_output": [
          1,
          7,
          21,
          35,
          12,
          8,
          2,
          0
        ]
      }
    ],
  method_template: "def up_and_down(array)\\n  \\nend"
)

create_challenge(
  name: "Descending order",
  difficulty: :easy,
  description: "Your task is to make a method that can take any non-negative integer as an argument and return it with its digits in descending order.\n\n  Examples:\n    Input: 42145 Output: 54421\n    Input: 145263 Output: 654321\n    Input: 123456789 Output: 987654321",
  language: "Ruby",
  tests: [
      {
        "input": "descending_order(42145)",
        "expected_output": 54421
      },
      {
        "input": "descending_order(145263)",
        "expected_output": 654321
      },
      {
        "input": "descending_order(123456789)",
        "expected_output": 987654321
      }
    ],
  method_template: "def descending_order(number)\\n  \\nend"
)

create_challenge(
  name: "Numbers Greater Than Five",
  difficulty: :easy,
  description: "Given an array of numbers, count how many items are greater than 5.\n  The method should return an integer.\n\n  For example:\n    [1, 4, 2, 70, 45, -2] --> 2",
  language: "Ruby",
  tests: [
      {
        "input": "numbers_greater_than_five([1, 48, 32, 6, 90, 2, 3])",
        "expected_output": 4
      },
      {
        "input": "numbers_greater_than_five([32, 3, 1, 8, 5, 4])",
        "expected_output": 2
      }
    ],
  method_template: "def numbers_greater_than_five(array)\\n  \\nend"
)

create_challenge(
  name: "Prime Number Algorith",
  difficulty: :easy,
  description: "Given an array of numbers, count how many items are prime numbers.\n  The method should return an integer.\n\n  For example:\n    [15, 53, 117, 487, 1212, 1213] --> 3",
  language: "Ruby",
  tests: [
      {
        "input": "prime_number_algorithm([1303, 41, 86, 997, 100])",
        "expected_output": 3
      },
      {
        "input": "prime_number_algorithm([120, 2, 1, 60, -1, 80])",
        "expected_output": 1
      }
    ],
  method_template: "def prime_number_algorithm(array)\\n  \\nend"
)

create_challenge(
  name: "Sum of Prime Numbers",
  difficulty: :easy,
  description: "Given an array of numbers, calculate the sum of the prime numbers.\n  The method should return an integer.\n\n  For example:\n    [15, 53, 117, 487, 1212, 1213] --> 1753",
  language: "Ruby",
  tests: [
      {
        "input": "sum_of_prime_numbers([1303, 41, 86, 997, 100])",
        "expected_output": 2341
      },
      {
        "input": "sum_of_prime_numbers([120, 2, 1, 60, -1, 80])",
        "expected_output": 2
      }
    ],
  method_template: "def sum_of_prime_numbers(array)\\n  \\nend"
)

create_challenge(
  name: "Factorial Numbers",
  difficulty: :easy,
  description: "Given an integer, calculate its factorial.\n  The method should return an integer.\n\n  The factorial of a number is the product of all the positive integers that are less than or equal to the number in question.\n\n  For example:\n    6 --> 720\n    (1 x 2 x 3 x 4 x 5 x 6 = 720",
  language: "Ruby",
  tests: [
      {
        "input": "factorial_numbers(8)",
        "expected_output": 40320
      },
      {
        "input": "factorial_numbers(2)",
        "expected_output": 2
      },
      {
        "input": "factorial_numbers(4)",
        "expected_output": 24
      }
    ],
  method_template: "def factorial_numbers(number)\\n  \\nend"
)

create_challenge(
  name: "Repeated Digit Checker",
  difficulty: :easy,
  description: "Given an integer, check to see if it has repeated digits in it.\n  The method should return a boolean.\n\n  For example:\n    554 -> true\n    1085 -> false\n    888888 -> true",
  language: "Ruby",
  tests: [
      {
        "input": "repeated_digit_checker(1103)",
        "expected_output": true
      },
      {
        "input": "repeated_digit_checker(4230)",
        "expected_output": false
      },
      {
        "input": "repeated_digit_checker(666)",
        "expected_output": true
      }
    ],
  method_template: "def repeated_digit_checker(integer)\\n  \\nend"
)

create_challenge(
  name: "FibonacciAlgorithm",
  difficulty: :easy,
  description: "Given an integer (n), give the (n)th number of the fibonacci sequence.\n  The method should return an integer.\n\n  The sequence will start at 0, and the first few numbers are 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144.\n\n  For example:\n    1 --> 0\n    5 --> 3\n    20 --> 4181",
  language: "Ruby",
  tests: [
      {
        "input": "fibonacci_algorithm(10)",
        "expected_output": 34
      },
      {
        "input": "fibonacci_algorithm(2)",
        "expected_output": 1
      },
      {
        "input": "fibonacci_algorithm(14)",
        "expected_output": 233
      }
    ],
  method_template: "def fibonacci_algorithm(integer)\\n  \\nend"
)

create_challenge(
  name: "Missing Number Game",
  difficulty: :easy,
  description: "Given an array of numbers 1 - 10 that is missing one number, find the missing number.\n  The method should return an integer.\n\n  For example:\n    [2, 1, 5, 4, 6, 9, 7, 8, 10] --> 3",
  language: "Ruby",
  tests: [
      {
        "input": "missing_number_game([2, 1, 3, 4, 6, 7, 9, 8, 10])",
        "expected_output": 5
      },
      {
        "input": "missing_number_game([1, 9, 4, 10, 2, 3, 8, 5, 7])",
        "expected_output": 6
      },
      {
        "input": "missing_number_game([9, 3, 2, 4, 7, 10, 5, 6, 1])",
        "expected_output": 8
      }
    ],
  method_template: "def missing_number_game(array)\\n  \\nend"
)

create_challenge(
  name: "Four Passengers And Driver",
  difficulty: :easy,
  description: "Given a number of people, calculate how many cars are needed to seat everyone comfortably.\n  A typical car can hold four passengers and one driver, allowing five people to travel around.\n  The method should return an integer.\n\n  For example:\n    5 --> 1\n    11 --> 3",
  language: "Ruby",
  tests: [
      {
        "input": "four_passengers_and_driver(0)",
        "expected_output": 0
      },
      {
        "input": "four_passengers_and_driver(21)",
        "expected_output": 5
      },
      {
        "input": "four_passengers_and_driver(30)",
        "expected_output": 6
      }
    ],
  method_template: "def four_passengers_and_driver(integer)\\n  \\nend"
)

create_challenge(
  name: "Multiply Numbers in a String",
  difficulty: :easy,
  description: "Given a string which contains some numbers, return the product of all the numbers.\n  The method should return an integer.\n\n  For example:\n    \"1 l1v3 l1f3 2 th3 full!\" --> 54\n    \"I need to buy 4 oranges and 3 tomatoes\" --> 12",
  language: "Ruby",
  tests: [
      {
        "input": "multiply_numbers_in_a_string(\"123456helloeveryone!\")",
        "expected_output": 720
      },
      {
        "input": "multiply_numbers_in_a_string(\"h3k h3p .;/#';\")",
        "expected_output": 9
      },
      {
        "input": "multiply_numbers_in_a_string(\"1\")",
        "expected_output": 1
      }
    ],
  method_template: "def multiply_numbers_in_a_string(string)\\n  \\nend"
)

create_challenge(
  name: "Last Letter Sort",
  difficulty: :easy,
  description: "Given a string of words, sort it alphabetically by the last character of each word.\n  If two words have the same last character, sort by the order they originally appeared.\n  The method should return an string of words.\n\n  For example:\n    \"herb camera dynamic\" --> \"camera herb dynamic\"\n    \"brick moral institution loud talk resign worth\" --> \"loud worth brick talk moral institution resign\"",
  language: "Ruby",
  tests: [
      {
        "input": "last_letter_sort(\"stab traction artist approach\")",
        "expected_output": "stab approach traction artist"
      },
      {
        "input": "last_letter_sort(\"sample partner autonomy swallow trend\")",
        "expected_output": "trend sample partner swallow autonomy"
      },
      {
        "input": "last_letter_sort(\"introduce fashionable cause sacrifice reality\")",
        "expected_output": "introduce fashionable cause sacrifice reality"
      }
    ],
  method_template: "def last_letter_sort(string)\\n  \\nend"
)

create_challenge(
  name: "Largest Number",
  difficulty: :easy,
  description: "Write a method that takes an array of numbers and returns the largest number in the array.\n\n  For example:\n  Input: [3, 6, 1, 9, 4]\n  Output: 9\n\n  Input: [10, 20, 5, 15]\n  Output: 20\n\n  Input: [-5, -10, -2, -8]\n  Output: -2",
  language: "Ruby",
  tests: [
      {
        "input": "largest_number([3, 6, 1, 9, 4])",
        "expected_output": 9
      },
      {
        "input": "largest_number([10, 20, 5, 15])",
        "expected_output": 20
      },
      {
        "input": "largest_number([-5, -10, -2, -8])",
        "expected_output": -2
      }
    ],
  method_template: "def largest_number(array)\\n  \\nend"
)

create_challenge(
  name: "Reverse String",
  difficulty: :easy,
  description: "Write a method that takes a string as an argument and returns the string reversed.\n\n  For example:\n  Input: \"hello\"\n  Output: \"olleh\"\n\n  Input: \"racecar\"\n  Output: \"racecar\"\n\n  Input: \"12345\"\n  Output: \"54321\"",
  language: "Ruby",
  tests: [
      {
        "input": "reverse_string(\"hello\")",
        "expected_output": "olleh"
      },
      {
        "input": "reverse_string(\"racecar\")",
        "expected_output": "racecar"
      },
      {
        "input": "reverse_string(\"12345\")",
        "expected_output": "54321"
      }
    ],
  method_template: "def reverse_string(str)\\n  \\nend"
)

create_challenge(
  name: "Prime Number",
  difficulty: :easy,
  description: "Write a method that takes a number as an argument and returns true if the number is prime, false otherwise.\n\n  For example:\n  Input: 7\n  Output: true\n\n  Input: 10\n  Output: false\n\n  Input: 23\n  Output: true\n\n  Input: 4\n  Output: false",
  language: "Ruby",
  tests: [
      {
        "input": "prime_number?(7)",
        "expected_output": true
      },
      {
        "input": "prime_number?(10)",
        "expected_output": false
      },
      {
        "input": "prime_number?(23)",
        "expected_output": true
      },
      {
        "input": "prime_number?(4)",
        "expected_output": false
      }
    ],
  method_template: "def prime_number?(number)\\n  \\nend"
)

create_challenge(
  name: "Factorial",
  difficulty: :easy,
  description: "Write a method that takes a positive integer as an argument and returns its factorial.\n\n  For example:\n  Input: 5\n  Output: 120\n\n  Input: 3\n  Output: 6\n\n  Input: 0\n  Output: 1",
  language: "Ruby",
  tests: [
      {
        "input": "factorial(5)",
        "expected_output": 120
      },
      {
        "input": "factorial(3)",
        "expected_output": 6
      },
      {
        "input": "factorial(0)",
        "expected_output": 1
      }
    ],
  method_template: "def factorial(n)\\n  \\nend"
)

create_challenge(
  name: "Sum of Array",
  difficulty: :easy,
  description: "Write a method that takes an array of numbers as an argument and returns the sum of all elements.\n\n  For example:\n  Input: [1, 2, 3, 4, 5]\n  Output: 15\n\n  Input: [10, -3, 8, 1]\n  Output: 16\n\n  Input: [0, 0, 0]\n  Output: 0",
  language: "Ruby",
  tests: [
      {
        "input": "sum_of_array([1, 2, 3, 4, 5])",
        "expected_output": 15
      },
      {
        "input": "sum_of_array([10, -3, 8, 1])",
        "expected_output": 16
      },
      {
        "input": "sum_of_array([0, 0, 0])",
        "expected_output": 0
      }
    ],
  method_template: "def sum_of_array(array)\\n  \\nend"
)

create_challenge(
  name: "Palindrome Check",
  difficulty: :easy,
  description: "Write a method that takes a string as an argument and returns true if it is a palindrome, false otherwise.\n\n  For example:\n  Input: \"racecar\"\n  Output: true\n\n  Input: \"hello\"\n  Output: false\n\n  Input: \"level\"\n  Output: true\n\n  Input: \"abcde\"\n  Output: false",
  language: "Ruby",
  tests: [
      {
        "input": "palindrome?(\"racecar\")",
        "expected_output": true
      },
      {
        "input": "palindrome?(\"hello\")",
        "expected_output": false
      },
      {
        "input": "palindrome?(\"level\")",
        "expected_output": true
      },
      {
        "input": "palindrome?(\"abcde\")",
        "expected_output": false
      }
    ],
  method_template: "def palindrome?(str)\\n  \\nend"
)

create_challenge(
  name: "Minimum Number",
  difficulty: :easy,
  description: "Write a method that takes an array of numbers and returns the minimum number in the array.\n\n  For example:\n  Input: [3, 6, 1, 9, 4]\n  Output: 1\n\n  Input: [10, 20, 5, 15]\n  Output: 5\n\n  Input: [-5, -10, -2, -8]\n  Output: -10",
  language: "Ruby",
  tests: [
      {
        "input": "minimum_number([3, 6, 1, 9, 4])",
        "expected_output": 1
      },
      {
        "input": "minimum_number([10, 20, 5, 15])",
        "expected_output": 5
      },
      {
        "input": "minimum_number([-5, -10, -2, -8])",
        "expected_output": -10
      }
    ],
  method_template: "def minimum_number(array)\\n  \\nend"
)

create_challenge(
  name: "Remove Duplicates",
  difficulty: :easy,
  description: "Write a method that takes an array of numbers and returns a new array with duplicates removed.\n\n  For example:\n  Input: [1, 2, 2, 3, 3, 4, 4, 5]\n  Output: [1, 2, 3, 4, 5]\n\n  Input: [10, 10, 20, 30, 20]\n  Output: [10, 20, 30]\n\n  Input: []\n  Output: []",
  language: "Ruby",
  tests: [
      {
        "input": "remove_duplicates([1, 2, 2, 3, 3, 4, 4, 5])",
        "expected_output": [
          1,
          2,
          3,
          4,
          5
        ]
      },
      {
        "input": "remove_duplicates([10, 10, 20, 30, 20])",
        "expected_output": [
          10,
          20,
          30
        ]
      },
      {
        "input": "remove_duplicates([])",
        "expected_output": []
      }
    ],
  method_template: "def remove_duplicates(array)\\n  \\nend"
)

create_challenge(
  name: "Average of Array",
  difficulty: :easy,
  description: "Write a method that takes an array of numbers and returns the average of all elements.\n\n  For example:\n  Input: [1, 2, 3, 4, 5]\n  Output: 3.0\n\n  Input: [10, -3, 8, 1]\n  Output: 4.0\n\n  Input: [0, 0, 0]\n  Output: 0.0",
  language: "Ruby",
  tests: [
      {
        "input": "average_of_array([1, 2, 3, 4, 5])",
        "expected_output": 3.0
      },
      {
        "input": "average_of_array([10, -3, 8, 1])",
        "expected_output": 4.0
      },
      {
        "input": "average_of_array([0, 0, 0])",
        "expected_output": 0.0
      }
    ],
  method_template: "def average_of_array(array)\\n  \\nend"
)

create_challenge(
  name: "Middle Element",
  difficulty: :easy,
  description: "Write a method that takes an array of numbers and returns the middle element. If the array has an even number of elements, return the second middle element.\n\n  For example:\n  Input: [1, 2, 3, 4, 5]\n  Output: 3\n\n  Input: [10, -3, 8, 1]\n  Output: -3\n\n  Input: [1, 2, 3, 4]\n  Output: 3\n\n  Input: [0, 0, 0, 0]\n  Output: 0",
  language: "Ruby",
  tests: [
      {
        "input": "middle_element([1, 2, 3, 4, 5])",
        "expected_output": 3
      },
      {
        "input": "middle_element([10, -3, 8, 1])",
        "expected_output": -3
      },
      {
        "input": "middle_element([1, 2, 3, 4])",
        "expected_output": 3
      },
      {
        "input": "middle_element([0, 0, 0, 0])",
        "expected_output": 0
      }
    ],
  method_template: "def middle_element(array)\\n  \\nend"
)

create_challenge(
  name: "Word Count",
  difficulty: :easy,
  description: "Write a method that takes a string representing a sentence and returns the number of words in the sentence.\n\n  For example:\n  Input: \"This is a sample sentence.\"\n  Output: 5\n\n  Input: \"Hello, how are you?\"\n  Output: 4\n\n  Input: \"One word.\"\n  Output: 2",
  language: "Ruby",
  tests: [
      {
        "input": "word_count(\"This is a sample sentence.\")",
        "expected_output": 5
      },
      {
        "input": "word_count(\"Hello, how are you?\")",
        "expected_output": 4
      },
      {
        "input": "word_count(\"One word.\")",
        "expected_output": 2
      }
    ],
  method_template: "def word_count(sentence)\\n  \\nend"
)

create_challenge(
  name: "Multiply Array",
  difficulty: :easy,
  description: "Write a method that takes an array of numbers as an argument and returns the product of all elements.\n\n  For example:\n  Input: [1, 2, 3, 4, 5]\n  Output: 120\n\n  Input: [10, -3, 8, 1]\n  Output: -240\n\n  Input: [1, 1, 1, 1, 1]\n  Output: 1",
  language: "Ruby",
  tests: [
      {
        "input": "multiply_array([1, 2, 3, 4, 5])",
        "expected_output": 120
      },
      {
        "input": "multiply_array([10, -3, 8, 1])",
        "expected_output": -240
      },
      {
        "input": "multiply_array([1, 1, 1, 1, 1])",
        "expected_output": 1
      }
    ],
  method_template: "def multiply_array(array)\\n  \\nend"
)

create_challenge(
  name: "Even Number Check",
  difficulty: :easy,
  description: "Write a method that takes a number as an argument and returns true if the number is even, false otherwise.\n\n  For example:\n  Input: 4\n  Output: true\n\n  Input: 7\n  Output: false\n\n  Input: -10\n  Output: true\n\n  Input: 0\n  Output: true",
  language: "Ruby",
  tests: [
      {
        "input": "even_number?(4)",
        "expected_output": true
      },
      {
        "input": "even_number?(7)",
        "expected_output": false
      },
      {
        "input": "even_number?(-10)",
        "expected_output": true
      },
      {
        "input": "even_number?(0)",
        "expected_output": true
      }
    ],
  method_template: "def even_number?(number)\\n  \\nend"
)

create_challenge(
  name: "Numbers Greater Than Five",
  difficulty: :easy,
  description: "Given an array of numbers, count how many items are greater than 5.\n  The method should return an integer.\n\n  For example:\n    [1, 4, 2, 70, 45, -2] --> 2",
  language: "Ruby",
  tests: [
      {
        "input": "numbers_greater_than_five([1, 48, 32, 6, 90, 2, 3])",
        "expected_output": 4
      },
      {
        "input": "numbers_greater_than_five([32, 3, 1, 8, 5, 4])",
        "expected_output": 2
      }
    ],
  method_template: "def numbers_greater_than_five(array)\\n  \\nend"
)

puts "Finished creating"
