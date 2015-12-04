//:## Operator : special symbol or phrase, use to check, change, or combine values

//:# Operators
//: Unary       : operate on 1 target  ( -a , !b (prefix) , i++ (postfix) )
//: Binary      : operate on 2 targets ( 2 + 3)
//: Ternary     : operate on 3 targets ( a ? b : c)

//:# Assignment Operator : ( = )
let b = 10
var a = 5
a = b

//: Assign multiple values with tuple
let (nameX, surnameX, ageX) = ("Barrack" , "Obama", 52)
nameX
surnameX
ageX

//:# Arithmetic Operators : ( + , - , * , / )
5 + 8 - 4
4 * 3 / 2
//: arithmetic operators not allow values to overflow by default
//: to value overflow behavior use overflow operators (a &+ b)
//ERROR: 5 + Int8.max
5 &+ Int8.max

//: "+" also support String concatenation
"hello, " + "world"

//:# Remainder Operator
9 % 4
-9 % 4

//:# Floating-Point Remainder
8 % 2.5

//:## Increment and Decrement Operators
var i = 0
++i
--i
var height = 2.2
++height
--height

var score = 0
score
var newScore = score++      //: If operator written after variable, increments variable after return value
score
newScore

var myScore = 0
myScore
var myNewScore = ++myScore  //RECOMMENDED!: If operator written before variable, increments variable before return value
myScore
myNewScore


//:# Unary Minus Operator
//: sign of numeric value can be toggled using prefixed - (known as unary minus)
let three = 3
let minusThree = -three
let plusThree = -minusThree
//: "-" prepended directly before value it operates on without any white space

//:# Compound Assignment Operators (+= , -=, *=, /*)
var a2 = 1
a2 += 2

//:# Comparison Operators : return Bool to indicate whether or not statement true
1 == 1      //Equal to      (a == b)
2 != 1      //Not equal to  (a != b)
2 > 1       //Greater than  (a > b)
1 < 2       //Less than     (a < b)
1 >= 1      //Greater than or equal to (a >= b)
2 <= 1      //Less than or equal to (a <= b)
//: identity operators (=== and !==) to test whether two object references both refer to same object instance

//:Comparison operators often used in conditional statements
let name = "world"
if name == "world" { print("hello, world")} else { print("I'm sorry \(name)") }


//:# Ternary Conditional Operator : question ? answer1 : answer2
//: If question true, evaluates answer1 and return its value
//: otherwise, it evaluates answer2 and return its value
//: shorthand of: "if question { answer1 } else { answer2 }"
let contentHeight = 40
let hasHeader = true
let rowHeight = contentHeight + (hasHeader ? 50 : 20)

let mycontentHeight = 40
let myhasHeader = true
var myrowHeight = mycontentHeight
if myhasHeader { myrowHeight = myrowHeight + 50} else { myrowHeight = myrowHeight + 20 }


//:# Nil Coalescing Operator : (a ?? b) unwraps optional a if it contains value, or return default value b if a is nil
//: a always optional type and b must match type that is stored inside a
//: shorthand of :  a != nil ? a! : b
let defaultColorName = "red"
var userDefinedColorName: String?
var colorNameToUse = userDefinedColorName ?? defaultColorName   //return red
userDefinedColorName = "green"
colorNameToUse = userDefinedColorName ?? defaultColorName       //return green


//:# Range Operator : Closed (a...b) | half-open (a..<b)
for index in 1...5 { print("\(index) times 5 is \(index * 5)") }

let names = ["Anna", "Alex", "Brian", "Jack"]
for i in 0..<names.count { print("Person \(i + 1) is called \(names[i])") }


//:# Logical Operators: Logical NOT (!a) | Logical AND (a && b) | Logical OR (a || b)

//:# Logical NOT : (!a) | inverts Boolean value | true becomes false, and false becomes true
let allowedEntry = false
if !allowedEntry { print("ACCESS DENIED") }

//:# Logical AND : (a && b)  |  (true && true) = true
let enteredDoorCode = true
let passedRetinaScan = false
if enteredDoorCode && passedRetinaScan { print("Welcome!") } else { print("ACCESS DENIED") }

//:# Logical OR :  (a || b)  |  (true || any ) = true
let hasDoorKey = false
let knowsOverridePassword = true
if hasDoorKey || knowsOverridePassword { print("Welcome!") } else { print("ACCESS DENIED") }


//:# Combining Logical Operators
if enteredDoorCode && passedRetinaScan || hasDoorKey || knowsOverridePassword {
print("Welcome!")} else {print("ACCESS DENIED")}
//: If entered correct door code and passed retina scan, or if have valid door key, or if know emergency override password, allow access
//: "&&" and "||" are left-associative : evaluate leftmost subexpression first

//:# Explicit Parentheses : useful to add () around first part of compound expression to make its intent explicit
if (enteredDoorCode && passedRetinaScan) || hasDoorKey || knowsOverridePassword { print("Welcome!") } else { print("ACCESS DENIED") }
//: "( )" make it clear that first two values are considered as part of separate possible state