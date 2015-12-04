/*:
# ADVANCED OPERATOR : perform complex value manipulation

## [1] BITWISE Operator : to manipulate raw data bits
* used in low-level programming (graphics, device driver creation)
* useful when work raw data from external source (encode/decode data over custom protocol) */

//:## Bitwise NOT (~) : inverts all bits | prefix operator
let initialBits: UInt8 = 0b00001111
let invertedBits = ~initialBits  //11110000 equal to 240

//:## Bitwise AND (&) : (1 & 1 = 1) (1 & 0 = 0)
let firstSixBits: UInt8 = 0b11111100
let lastSixBits: UInt8  = 0b00111111
let middleFourBits = firstSixBits & lastSixBits  // equals 00111100

//:## Bitwise OR (|) : (1 | x = 1) (0 | 0 = 0)
let someBits: UInt8 = 0b10110010
let moreBits: UInt8 = 0b01011110
let combinedbits = someBits | moreBits  // equals 11111110

//:## Bitwise XOR (^) : "exclusive OR" (1 ^ 0 = 1) (1 ^ 1 = 0 ) (0 ^ 0 = 0)
let firstBits: UInt8 = 0b00010100
let otherBits: UInt8 = 0b00000101
let outputBits = firstBits ^ otherBits  // equals 00010001

//:## Bitwise Left Shift (<<) : move bits to left | multiply integer by factor 2 (doubles value)
let shiftBits: UInt8 = 4   // 00000100 in binary
shiftBits << 1             // 00001000
shiftBits << 2             // 00010000
shiftBits << 5             // 10000000
shiftBits << 6             // 00000000

//:## Bitwise Right Shift (>>) : move bits to right | dividing integer by factor 2 (halves value)
let shiftBits2: UInt8 = 4   // 00000100 in binary
shiftBits >> 2             // 00000001

//:## Unsigned Integer Shifting : Logical Shifting
//:* bits moved to left or right by requested number of places
//:* Any bits that moved beyond bounds of integer storage discarded
//:* "0" inserted in spaces left behind after original bits are moved to left or right

//:* use bit shifting to encode/decode values within other data types
let pink: UInt32 = 0xCC6699
let redComponent = (pink & 0xFF0000) >> 16    // redComponent is 0xCC
let greenComponent = (pink & 0x00FF00) >> 8   // greenComponent is 0x66
let blueComponent = pink & 0x0000FF           // blueComponent is 0x99

//:## Signed Integers Shifting
//:* Signed integers use first bit (sign bit) to indicate positive or negative
//:* sign bit 0 means positive, and sign bit 1 means negative
//:* Positive numbers are stored in exactly same way as for unsigned integers, counting upwards from 0.
//:* When shift signed integers to right, fill any empty bits on left with sign bit


//:=======================
//:## [2] OVERFLOW Operator :  begin with (&)
//:* arithmetic operators not overflow by default & trap and report as error
//:* use second set of arithmetic operators for overflow behavior, such as overflow addition operator (&+)
//:* * insert number into integer "let" or "var" that not hold value, reports error (extra safety)
var potentialOverflow = Int16.max
// potentialOverflow += 1   //ERRORR!!
//:* want overflow to truncate number of available bits use overflow operator: (&+) , (&-), (&*)

//:*## Value Overflow : Numbers can overflow in positive and negative direction
var unsignedOverflow = UInt8.max
unsignedOverflow = unsignedOverflow &+ 1

var newUnsignedOverflow = UInt8.min
newUnsignedOverflow = newUnsignedOverflow &- 1

var signedOverflow = Int8.min
signedOverflow = signedOverflow &- 1 // now equal to 127

//:## Precedence and Associativity
//:* precedence gives higher priority than others; these operators applied first
//:* associativity define how "same precedence operators" grouped : grouped from left, or grouped from right
2 + 3 * 4 % 5
//:* strictly from left to right
//:* Higher-precedence operators are evaluated before: (*) and (%) higher precedence than (+)
//:* (*) and (%) have same precedence
//:* (*) and (%) associate with expression to their left
2 + ((3 * 4) % 5)
2 + (12 % 5)
2 + 2


//:=====================
//:## [3] Operator Functions (Tailored Operator)
//:* define own infix, prefix, postfix assignment operators, with custom precedence and associativity values
//:* Class/Struct can provide own implementations of existing operators (overloading existing operators)
struct Vector2D { var x = 0.0, y = 0.0 }
func + (left: Vector2D, right: Vector2D) -> Vector2D {return Vector2D(x: left.x + right.x, y: left.y + right.y) }
//:* operator function defined as global function with name that matches operator to be overloaded (+)
//:* function defined globally, rather than method on Vector2D struct, it can be used as infix operator
let vector = Vector2D(x: 3.0, y: 1.0)
let anotherVector = Vector2D(x: 2.0, y: 4.0)
let combinedVector = vector + anotherVector


//:## Prefix and Postfix Operators
//:* Class/Struct can provide implementation of standard unary operators that operate on single target
//:* prefix (-a) and postfix (i++)
//:* implement unary operator by writing prefix or postfix modifier before func keyword
prefix func - (vector: Vector2D) -> Vector2D { return Vector2D(x: -vector.x, y: -vector.y) }
let positive = Vector2D(x: 3.0, y: 4.0)
let negative = -positive
let alsoPositive = -negative


//:## Compound Assignment Operators : (=) with another operation | (+=)
//:* mark compound assignment operator left input parameter as inout
//:* parameter value will be modified directly from within operator function.
func += (inout left: Vector2D, right: Vector2D) { left = left + right }
var original = Vector2D(x: 1.0, y: 2.0)
let vectorToAdd = Vector2D(x: 3.0, y: 4.0)
original += vectorToAdd

prefix func ++ (inout vector: Vector2D) -> Vector2D { vector += Vector2D(x: 1.0, y: 1.0) ; return vector }
var toIncrement = Vector2D(x: 3.0, y: 4.0)
let afterIncrement = ++toIncrement
//:* not possible to overload assignment operator (=) and ternary conditional operator (a ? b : c)


//:## Equivalence Operators (==)  or (!=)
//:* Custom Class/Struct not receive default implementation "equal to" (==) and "not equal to" (!=)
//:* To use equivalence operators, provide implementation of operators in same way as for other infix operator
func == (left: Vector2D, right: Vector2D) -> Bool { return (left.x == right.x) && (left.y == right.y) }
func != (left: Vector2D, right: Vector2D) -> Bool { return !(left == right) }

let twoThree = Vector2D(x: 2.0, y: 3.0)
let anotherTwoThree = Vector2D(x: 2.0, y: 3.0)
if twoThree == anotherTwoThree { print("These two vectors are equivalent.") }


//:## Custom Operators
//:* New operators declared at global level using "operator" and marked with prefix, infix or postfix
prefix operator +++ {}
//:* +++ doubles x and y of Vector2D instance, by adding vector to itself with addition assignment
prefix func +++ (inout vector: Vector2D) -> Vector2D { vector += vector ; return vector }
//:* +++ implementation similar to ++ implementation, except that this adds vector to itself
var toBeDoubled = Vector2D(x: 1.0, y: 4.0)
let afterDoubling = +++toBeDoubled


//:## Precedence and Associativity for Custom Infix Operators
//:* Custom infix operators can specify precedence and associativity
//:* possible values for associativity are left, right, and none.
//:* Left-associative: associate to left if written next to other left-associative of same precedence.
//:* Right-associative : associate to right if written next to other right-associative of same precedence
//:* Non-associative: cannot be written next to other operators with same precedence
//:* associativity value defaults to none if not specified
//:* precedence value defaults to 100 if not specified
infix operator +- { associativity left precedence 140 }
func +- (left: Vector2D, right: Vector2D) -> Vector2D { return Vector2D(x: left.x + right.x, y: left.y - right.y) }
let firstVector = Vector2D(x: 1.0, y: 2.0)
let secondVector = Vector2D(x: 3.0, y: 4.0)
let plusMinusVector = firstVector +- secondVector
//:* not specify precedence when defining prefix or postfix operator
//:* if apply both prefix and postfix operator to same operand, postfix operator is applied first