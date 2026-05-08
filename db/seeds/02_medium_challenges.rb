# frozen_string_literal: true

puts "Creating medium challenges"

create_challenge(
  name: "Type of Triangle",
  difficulty: :medium,
  description: "Given an array of the side lengths of a triangle, determine its type.\n\n  No sides equal: \"scalene\"\n  Two sides equal: \"isosceles\"\n  All sides equal: \"equilateral\"\n  Less or more than 3 sides given: \"not a triangle\"\n\n  The method should return a string.\n\n  For example:\n  [2, 6, 5] --> \"scalene\"\n  [4, 4, 7] --> \"isosceles\"\n  [3, 5, 5, 2] --> \"not a triangle\"",
  language: "Ruby",
  tests: [
      {
        "input": "type_of_triangle([2, 3, 4])",
        "expected_output": "scalene"
      },
      {
        "input": "type_of_triangle([4, 4, 7])",
        "expected_output": "isosceles"
      },
      {
        "input": "type_of_triangle([8, 8, 8])",
        "expected_output": "equilateral"
      },
      {
        "input": "type_of_triangle([10])",
        "expected_output": "not a triangle"
      }
    ],
  method_template: "def type_of_triangle(integer)\\n  \\nend"
)

create_challenge(
  name: "Position in Alphabet",
  difficulty: :medium,
  description: "Given a number between 1-26, return what letter is at that position in the alphabet. Return \"invalid\" if the number given is not within that range, or isn't an integer.\n\n  For example:\n  1 --> \"a\"\n  26.0 --> \"z\"\n  0 --> \"invalid\"",
  language: "Ruby",
  tests: [
      {
        "input": "position_in_alphabet(4)",
        "expected_output": "d"
      },
      {
        "input": "position_in_alphabet(9)",
        "expected_output": "i"
      },
      {
        "input": "position_in_alphabet(-1)",
        "expected_output": "invalid"
      },
      {
        "input": "position_in_alphabet(4.5)",
        "expected_output": "invalid"
      },
      {
        "input": "position_in_alphabet(21.0)",
        "expected_output": "u"
      }
    ],
  method_template: "def position_in_alphabet(integer)\\n  \\nend"
)

create_challenge(
  name: "Find Bob",
  difficulty: :medium,
  description: "Given an array of names, find Bob.\n  Return his location in the array, or -1 if Bob is not there. This method returns an integer\n\n  For example:\n  [\"Will\", \"Nicola\", \"Bob\"] --> 2\n  [\"Bob\", \"Nicola\", \"Aaron\", \"Dareos\"] --> 0\n  [\"Will\", \"Nicola\", \"Aaron\"] --> -1",
  language: "Ruby",
  tests: [
      {
        "input": "find_bob([\"Jimmy\", \"Layla\", \"Mandy\"])",
        "expected_output": -1
      },
      {
        "input": "find_bob([\"Bob\", \"Nathan\", \"Hayden\"])",
        "expected_output": 0
      },
      {
        "input": "find_bob([\"Paul\", \"Layla\", \"Bob\"])",
        "expected_output": 2
      },
      {
        "input": "find_bob([\"Garry\", \"Maria\", \"Bethany\", \"Bob\", \"Pauline\"])",
        "expected_output": 3
      }
    ],
  method_template: "def find_bob(array)\\n  \\nend"
)

create_challenge(
  name: "Letter increment",
  difficulty: :medium,
  description: "Given a one word string, write a method that changes every letter to the next letter. Ignore any punctuation.\n  This method returns a string.\n\n  For example:\n  \"a\" --> \"b\"\n  \"bye!\" --> \"czf!\"\n  \"Welcome\" --> \"Xfmdpnf\"",
  language: "Ruby",
  tests: [
      {
        "input": "letter_increment(\"Hello\")",
        "expected_output": "Ifmmp"
      },
      {
        "input": "letter_increment(\"lol!?\")",
        "expected_output": "mpm!?"
      },
      {
        "input": "letter_increment(\"bye\")",
        "expected_output": "czf"
      }
    ],
  method_template: "def letter_increment(string)\\n  \\nend"
)

create_challenge(
  name: "Decimator",
  difficulty: :medium,
  description: "Write a DECIMATOR method which takes a string and decimates it (i.e. it removes the last 1/10 of the characters).\n  Always round up: if the string has 21 characters, 1/10 of the characters would be 2.1 characters, hence the DECIMATOR removes 3 characters. The DECIMATOR shows no mercy!\n\n  For example:\n  \"1234567890\" --> \"123456789\"\n  # 10 characters, removed 1.\n\n  \"123\" --> \"12\"\n  # 3 characters, removed 1\n\n  \"ABCDEFGHIJKLMNOPQRSTUVWXYZ\" --> \"ABCDEFGHIJKLMNOPQRSTUVW\"\n  # 26 characters, removed 3.",
  language: "Ruby",
  tests: [
      {
        "input": "decimator(\"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz\")",
        "expected_output": "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrst"
      },
      {
        "input": "decimator(\"A\")",
        "expected_output": ""
      },
      {
        "input": "decimator(\"1234567890AB\")",
        "expected_output": "1234567890"
      },
      {
        "input": "decimator(\"\")",
        "expected_output": ""
      }
    ],
  method_template: "def decimator(string)\\n  \\nend"
)

create_challenge(
  name: "Binary Zeroes",
  difficulty: :medium,
  description: "Given a binary string, write a method that returns the longest sequence of consecutive zeroes in a binary string.\n  If no zeroes exist in the input, return an empty string.\n  This method returns a string.\n\n  For example:\n  \"01100001011000\" --> \"0000\"\n  \"100100100\" --> \"00\"\n  \"11111\" --> \"\"",
  language: "Ruby",
  tests: [
      {
        "input": "binary_zeroes(\"1000000000011101\")",
        "expected_output": "0000000000"
      },
      {
        "input": "binary_zeroes(\"100001110000100000\")",
        "expected_output": "00000"
      },
      {
        "input": "binary_zeroes(\"101010101\")",
        "expected_output": "0"
      },
      {
        "input": "binary_zeroes(\"111111\")",
        "expected_output": ""
      }
    ],
  method_template: "def binary_zeroes(string)\\n  \\nend"
)

create_challenge(
  name: "Squares and Cubes",
  difficulty: :medium,
  description: "Given an array of two numbers, check if the square root of the first number is equal to the cube root of the second number.\n  This method returns a boolean.\n\n  For example:\n  [4, 8] --> true\n  [16, 48] --> false\n  [9, 27] --> true",
  language: "Ruby",
  tests: [
      {
        "input": "squares_and_cubes([5, 12])",
        "expected_output": false
      },
      {
        "input": "squares_and_cubes([25, 125])",
        "expected_output": true
      },
      {
        "input": "squares_and_cubes([1, 1])",
        "expected_output": true
      },
      {
        "input": "squares_and_cubes([36, 217])",
        "expected_output": false
      },
      {
        "input": "squares_and_cubes([9, 27])",
        "expected_output": true
      }
    ],
  method_template: "def squares_and_cubes(array)\\n  \\nend"
)

create_challenge(
  name: "Find Odd Integer",
  difficulty: :medium,
  description: "Create a method that takes an array and finds the integer which appears an odd number of times.\n  This method returns an integer.\n\n  For example:\n  [1, 1, 2, -2, 5, 2, 4, 4, -1, -2, 5] --> -1\n  [20, 1, 1, 2, 2, 3, 3, 5, 5, 4, 20, 4, 5] --> 5\n  [10] --> 10",
  language: "Ruby",
  tests: [
      {
        "input": "find_odd_integer([20, 1, -1, 2, -2, 3, 3, 5, 5, 1, 2, 4, 20, 4, -1, -2, 5])",
        "expected_output": 5
      },
      {
        "input": "find_odd_integer([1, 1, 1, 1, 1, 1, 10, 1, 1, 1, 1])",
        "expected_output": 10
      },
      {
        "input": "find_odd_integer([20, 1, 1, 2, 2, 3, 3, 5, 5, 4, 20, 4, 5])",
        "expected_output": 5
      },
      {
        "input": "find_odd_integer([10])",
        "expected_output": 10
      }
    ],
  method_template: "def find_odd_integer(array)\\n  \\nend"
)

create_challenge(
  name: "No Yelling",
  difficulty: :medium,
  description: "Create a method that transforms sentences ending with multiple question marks ? or exclamation marks ! into a sentence only ending with one without changing punctuation in the middle of the sentences.\n  This method returns a string.\n\n  For example:\n  \"What went wrong?????????\" --> \"What went wrong?\"\n  \"Oh my goodness!!!\" --> \"Oh my goodness!\"\n  \"I just can't believe!!!!!!! it.\" --> \"I just can't believe!!!!!!! it.\"",
  language: "Ruby",
  tests: [
      {
        "input": "no_yelling(\"What went wrong?????????\")",
        "expected_output": "What went wrong?"
      },
      {
        "input": "no_yelling(\"Oh my goodness!!!\")",
        "expected_output": "Oh my goodness!"
      },
      {
        "input": "no_yelling(\"WHAT!\")",
        "expected_output": "WHAT!"
      },
      {
        "input": "no_yelling(\"That's a ton!! of cheese!!!!!!!!\")",
        "expected_output": "That's a ton!! of cheese!"
      }
    ],
  method_template: "def no_yelling(string)\\n  \\nend"
)

create_challenge(
  name: "Reverse Words",
  difficulty: :medium,
  description: "Write a method that takes a string as an argument and returns the string with each word reversed.\n  Words are separated by a single space. The order of words should remain the same.\n\n  For example:\n  Input: \"Hello World\"\n  Output: \"olleH dlroW\"\n\n  Input: \"Ruby is fun\"\n  Output: \"ybuR si nuf\"\n\n  Input: \"123 456 789\"\n  Output: \"321 654 987\"",
  language: "Ruby",
  tests: [
      {
        "input": "reverse_words(\"Hello World\")",
        "expected_output": "olleH dlroW"
      },
      {
        "input": "reverse_words(\"Ruby is fun\")",
        "expected_output": "ybuR si nuf"
      },
      {
        "input": "reverse_words(\"123 456 789\")",
        "expected_output": "321 654 987"
      }
    ],
  method_template: "def reverse_words(string)\\n  \\nend"
)

create_challenge(
  name: "Sum of Squares",
  difficulty: :medium,
  description: "Write a method that takes an array of numbers and returns the sum of the squares of all elements.\n\n  For example:\n  Input: [1, 2, 3, 4, 5]\n  Output: 55\n\n  Input: [10, -3, 8, 1]\n  Output: 130\n\n  Input: [0, 0, 0]\n  Output: 0",
  language: "Ruby",
  tests: [
      {
        "input": "sum_of_squares([1, 2, 3, 4, 5])",
        "expected_output": 55
      },
      {
        "input": "sum_of_squares([10, -3, 8, 1])",
        "expected_output": 130
      },
      {
        "input": "sum_of_squares([0, 0, 0])",
        "expected_output": 0
      }
    ],
  method_template: "def sum_of_squares(array)\\n  \\nend"
)

create_challenge(
  name: "Pangram Check",
  difficulty: :medium,
  description: "A pangram is a sentence that contains every letter of the alphabet at least once.\n  Write a method that takes a string as an argument and returns true if it is a pangram, false otherwise.\n\n  For example:\n  Input: \"The quick brown fox jumps over the lazy dog\"\n  Output: true\n\n  Input: \"Hello World\"\n  Output: false\n\n  Input: \"Pack my box with five dozen liquor jugs\"\n  Output: true",
  language: "Ruby",
  tests: [
      {
        "input": "pangram?(\"The quick brown fox jumps over the lazy dog\")",
        "expected_output": true
      },
      {
        "input": "pangram?(\"Hello World\")",
        "expected_output": false
      },
      {
        "input": "pangram?(\"Pack my box with five dozen liquor jugs\")",
        "expected_output": true
      }
    ],
  method_template: "def pangram?(sentence)\\n  \\nend"
)

create_challenge(
  name: "Fibonacci Sequence",
  difficulty: :medium,
  description: "Write a method that takes an integer n and returns the nth number in the Fibonacci sequence.\n  The Fibonacci sequence starts with 0 and 1, and each subsequent number is the sum of the two preceding ones.\n  Assume n is non-negative.\n\n  For example:\n  Input: 0\n  Output: 0\n\n  Input: 1\n  Output: 1\n\n  Input: 5\n  Output: 5\n\n  Input: 10\n  Output: 55",
  language: "Ruby",
  tests: [
      {
        "input": "fibonacci(0)",
        "expected_output": 0
      },
      {
        "input": "fibonacci(1)",
        "expected_output": 1
      },
      {
        "input": "fibonacci(5)",
        "expected_output": 5
      },
      {
        "input": "fibonacci(10)",
        "expected_output": 55
      }
    ],
  method_template: "def fibonacci(n)\\n  \\nend"
)

create_challenge(
  name: "Unique Characters",
  difficulty: :medium,
  description: "Write a method that takes a string as an argument and returns true if all characters in the string are unique, false otherwise.\n\n  For example:\n  Input: \"abcdefg\"\n  Output: true\n\n  Input: \"hello\"\n  Output: false\n\n  Input: \"123456789\"\n  Output: true",
  language: "Ruby",
  tests: [
      {
        "input": "unique_characters?(\"abcdefg\")",
        "expected_output": true
      },
      {
        "input": "unique_characters?(\"hello\")",
        "expected_output": false
      },
      {
        "input": "unique_characters?(\"123456789\")",
        "expected_output": true
      }
    ],
  method_template: "def unique_characters?(str)\\n  \\nend"
)

create_challenge(
  name: "Power of Two",
  difficulty: :medium,
  description: "Write a method that takes an integer n as an argument and returns true if n is a power of 2, false otherwise.\n\n  For example:\n  Input: 1\n  Output: true\n\n  Input: 4\n  Output: true\n\n  Input: 10\n  Output: false\n\n  Input: 64\n  Output: true",
  language: "Ruby",
  tests: [
      {
        "input": "power_of_two?(1)",
        "expected_output": true
      },
      {
        "input": "power_of_two?(4)",
        "expected_output": true
      },
      {
        "input": "power_of_two?(10)",
        "expected_output": false
      },
      {
        "input": "power_of_two?(64)",
        "expected_output": true
      }
    ],
  method_template: "def power_of_two?(n)\\n  \\nend"
)

create_challenge(
  name: "Palindrome Integer",
  difficulty: :medium,
  description: "Write a method that takes an integer as an argument and returns true if it is a palindrome (reads the same backward as forward), false otherwise.\n\n  For example:\n  Input: 121\n  Output: true\n\n  Input: 12321\n  Output: true\n\n  Input: 12345\n  Output: false",
  language: "Ruby",
  tests: [
      {
        "input": "palindrome_integer?(121)",
        "expected_output": true
      },
      {
        "input": "palindrome_integer?(12321)",
        "expected_output": true
      },
      {
        "input": "palindrome_integer?(12345)",
        "expected_output": false
      }
    ],
  method_template: "def palindrome_integer?(num)\\n  \\nend"
)

create_challenge(
  name: "Reverse Odd Length Words",
  difficulty: :medium,
  description: "Given a string, reverse all the words which have odd length. The even length words are not changed.\n\n  For example:\n  \"Bananas\" --> \"sananaB\"\n  \"One two three four\" --> \"enO owt eerht four\"\n  \"Make sure uoy only esrever sdrow of ddo length\" --> \"Make sure you only reverse words of odd length\"",
  language: "Ruby",
  tests: [
      {
        "input": "reverse_odd_length_words(\"Even even even even even even even even even\")",
        "expected_output": "Even even even even even even even even even"
      },
      {
        "input": "reverse_odd_length_words(\"Odd Odd odd\")",
        "expected_output": "ddO ddO ddo"
      },
      {
        "input": "reverse_odd_length_words(\"Make sure you only reverse words of odd length\")",
        "expected_output": "Make sure uoy only esrever sdrow of ddo length"
      }
    ],
  method_template: "def reverse_odd_length_words(string)\\n  \\nend"
)

create_challenge(
  name: "Largest Palindrome",
  difficulty: :medium,
  description: "Write a method that takes a string as an argument and returns the largest palindrome substring within that string.\n  If there are multiple palindromes of the same length, return the first one found.\n\n  For example:\n  \"racecar\" --> \"racecar\"\n  \"hello\" --> \"ll\"\n  \"abbacc\" --> \"abba\"",
  language: "Ruby",
  tests: [
      {
        "input": "largest_palindrome(\"racecar\")",
        "expected_output": "racecar"
      },
      {
        "input": "largest_palindrome(\"hello\")",
        "expected_output": "ll"
      },
      {
        "input": "largest_palindrome(\"abbacc\")",
        "expected_output": "abba"
      }
    ],
  method_template: "def largest_palindrome(str)\\n  \\nend"
)

create_challenge(
  name: "String Compression",
  difficulty: :medium,
  description: "Write a method that takes a string as an argument and returns a compressed version of the string.\n  The compression should replace repeated characters with the character followed by the number of occurrences.\n\n  For example:\n  Input: \"aaabbbbcc\"\n  Output: \"a3b4c2\"\n\n  Input: \"hello\"\n  Output: \"hel2o\"\n\n  Input: \"abcd\"\n  Output: \"abcd\"",
  language: "Ruby",
  tests: [
      {
        "input": "string_compression(\"aaabbbbcc\")",
        "expected_output": "a3b4c2"
      },
      {
        "input": "string_compression(\"hello\")",
        "expected_output": "hel2o"
      },
      {
        "input": "string_compression(\"abcd\")",
        "expected_output": "abcd"
      }
    ],
  method_template: "def string_compression(str)\\n  \\nend"
)

create_challenge(
  name: "Sum of Digits",
  difficulty: :medium,
  description: "Write a method that takes an integer as an argument and returns the sum of its digits.\n\n  For example:\n  Input: 123\n  Output: 6\n\n  Input: 456\n  Output: 15\n\n  Input: 98765\n  Output: 35",
  language: "Ruby",
  tests: [
      {
        "input": "sum_of_digits(123)",
        "expected_output": 6
      },
      {
        "input": "sum_of_digits(456)",
        "expected_output": 15
      },
      {
        "input": "sum_of_digits(98765)",
        "expected_output": 35
      }
    ],
  method_template: "def sum_of_digits(n)\\n  \\nend"
)

create_challenge(
  name: "Common Prefix",
  difficulty: :medium,
  description: "Write a method that takes an array of strings as an argument and returns the longest common prefix among the strings.\n  If there is no common prefix, return an empty string.\n\n  For example:\n  Input: [\"flower\", \"flow\", \"flight\"]\n  Output: \"fl\"\n\n  Input: [\"dog\", \"race\", \"car\"]\n  Output: \"\"",
  language: "Ruby",
  tests: [
      {
        "input": "common_prefix([\"flower\", \"flow\", \"flight\"])",
        "expected_output": "fl"
      },
      {
        "input": "common_prefix([\"dog\", \"race\", \"car\"])",
        "expected_output": ""
      }
    ],
  method_template: "def common_prefix(strings)\\n  \\nend"
)

create_challenge(
  name: "Roman to Integer",
  difficulty: :medium,
  description: "Write a method that takes a string representing a Roman numeral and returns the corresponding integer value.\n  Roman numerals are represented by the following symbols: I, V, X, L, C, D, M.\n\n  For example:\n  Input: \"III\"\n  Output: 3\n\n  Input: \"IV\"\n  Output: 4\n\n  Input: \"IX\"\n  Output: 9\n\n  Input: \"LVIII\"\n  Output: 58",
  language: "Ruby",
  tests: [
      {
        "input": "roman_to_integer(\"III\")",
        "expected_output": 3
      },
      {
        "input": "roman_to_integer(\"IV\")",
        "expected_output": 4
      },
      {
        "input": "roman_to_integer(\"IX\")",
        "expected_output": 9
      },
      {
        "input": "roman_to_integer(\"LVIII\")",
        "expected_output": 58
      }
    ],
  method_template: "def roman_to_integer(roman)\\n  \\nend"
)

create_challenge(
  name: "Square Root",
  difficulty: :medium,
  description: "Write a method that takes a non-negative integer x and returns its square root as an integer.\n  You may assume that the input will be a valid non-negative integer.\n\n  For example:\n  Input: 4\n  Output: 2\n\n  Input: 9\n  Output: 3\n\n  Input: 16\n  Output: 4",
  language: "Ruby",
  tests: [
      {
        "input": "square_root(4)",
        "expected_output": 2
      },
      {
        "input": "square_root(9)",
        "expected_output": 3
      },
      {
        "input": "square_root(16)",
        "expected_output": 4
      }
    ],
  method_template: "def square_root(x)\\n  \\nend"
)

create_challenge(
  name: "Majority Element",
  difficulty: :medium,
  description: "Write a method that takes an array of numbers and returns the majority element (element that appears more than n/2 times, where n is the length of the array).\n  Assume there is always a majority element.\n\n  For example:\n  Input: [3, 2, 3]\n  Output: 3\n\n  Input: [2, 2, 1, 1, 1, 2, 2]\n  Output: 2\n\n  Input: [1]\n  Output: 1",
  language: "Ruby",
  tests: [
      {
        "input": "majority_element([3, 2, 3])",
        "expected_output": 3
      },
      {
        "input": "majority_element([2, 2, 1, 1, 1, 2, 2])",
        "expected_output": 2
      },
      {
        "input": "majority_element([1])",
        "expected_output": 1
      }
    ],
  method_template: "def majority_element(arr)\\n  \\nend"
)

create_challenge(
  name: "Count Primes",
  difficulty: :medium,
  description: "Write a method that takes an integer n as an argument and returns the number of prime numbers less than n.\n  Assume n is a positive integer greater than 1.\n\n  For example:\n  Input: 10\n  Output: 4 (Primes less than 10 are 2, 3, 5, 7)\n\n  Input: 20\n  Output: 8 (Primes less than 20 are 2, 3, 5, 7, 11, 13, 17, 19)\n\n  Input: 30\n  Output: 10 (Primes less than 30 are 2, 3, 5, 7, 11, 13, 17, 19, 23, 29)",
  language: "Ruby",
  tests: [
      {
        "input": "count_primes(10)",
        "expected_output": 4
      },
      {
        "input": "count_primes(20)",
        "expected_output": 8
      },
      {
        "input": "count_primes(30)",
        "expected_output": 10
      }
    ],
  method_template: "def count_primes(n)\\n  \\nend"
)

create_challenge(
  name: "Reverse Words in a String",
  difficulty: :medium,
  description: "Write a method that takes a string as an argument and returns the string with the order of the words reversed.\n  Words in the input string are separated by one or more spaces.\n  Remove leading and trailing spaces from the resulting string.\n\n  For example:\n  Input: \"hello world\"\n  Output: \"world hello\"\n\n  Input: \"  The sky is blue   \"\n  Output: \"blue is sky The\"",
  language: "Ruby",
  tests: [
      {
        "input": "reverse_words(\"hello world\")",
        "expected_output": "world hello"
      },
      {
        "input": "reverse_words(\"  The sky is blue   \")",
        "expected_output": "blue is sky The"
      }
    ],
  method_template: "def reverse_words(str)\\n  \\nend"
)

puts "Finished creating"
