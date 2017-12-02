// Playground - noun: a place where people can play

import Cocoa

var stringOne = "Hello"

for char in stringOne {
    print(char)
}

stringOne.map{
    print($0)
}

var multiLine = """
This is a multiline string
literal.  This shows how we can create
a string over multiple lines.
Jon says "multiline string literals are cool"
"""
print(multiLine)

