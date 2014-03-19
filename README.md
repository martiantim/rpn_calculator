Implement a RPN evaluator in Ruby. It should be able to evaluate the following strings and answer with the corresponding numbers:

    “1 2 +” = 3

    “4 2 /” = 2

    “2 3 4 + *” = 14

    “3 4 + 5 6 + *” = 77

    “13 4 -” = 9

And should provide an error message for the following types of errors

    “1 +” (not enough arguments)
    “a b +” (invalid number)

We should be able to evaluate a string from the command line in the following way:

$ ruby rpn.rb "1 2 +"

3



In addition, implement your own string to number conversion function like the one discussed during the phone screening
interview. Do not use the following: send, eval, to_i, to_f, Integer(str), Float(str), or any similar method to
convert your strings to numbers.

Feel free to search the internet for basic ruby syntax and usage questions. Do not use the internet for algorithm
implementations.