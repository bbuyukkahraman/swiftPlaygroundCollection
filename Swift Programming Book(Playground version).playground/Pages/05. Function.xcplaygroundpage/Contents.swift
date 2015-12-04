/*:
# Function
* self-contained chunks of code that perform specific task
* Parameters provide default values to simplify function calls and passed as in-out parameters, which modify passed variable once function has completed its execution
* Every function has type, consisting of function parameter types and return type
* use this type like any other type, makes easy to pass function as parameters to other functions, and to return functions from functions

## Define/Call Function
* define one or more named, typed values that function takes as input (parameters)
* and type of value that function will pass back as output (return type)
* function arguments must always be provided in same order as function parameter list */
func sayHello(personName: String) -> String { let greeting = "Hello, " + personName + "!" ;
    return greeting }
print(sayHello("Anna"))
print(sayHello("Brian"))
//: simplify function body, combine message creation and return into one line
func sayHelloAgain(personName: String) -> String { return "Hello again, " + personName + "!"}
print(sayHelloAgain("Anna"))

//:### Multiple Input Parameters
//:* written within function (), separated by (,)
//:* takes start and end index for half-open range, and works out how many elements range contains
func halfOpenRangeLength(start start: Int, end: Int) -> Int { return end - start }
print(halfOpenRangeLength(start: 1, end: 10))

//:### Functions Without Parameters
func sayHelloWorld() -> String { return "hello, world" }
print(sayHelloWorld())  // prints "hello, world"

//:### Functions With Multiple Parameters
func sayHello(personName: String, alreadyGreeted: Bool) -> String {
if alreadyGreeted {return sayHelloAgain(personName) } else { return sayHello(personName)} }
print(sayHello("Tim", alreadyGreeted: true)) // prints "Hello again, Tim!"

//:### Functions Without Return Values
func sayGoodbye(personName: String) { print("Goodbye, \(personName)!")}
sayGoodbye("Dave")
/*:
* sayGoodbye(_:) function does still return value, even though no return value is defined
* Functions without defined return type return special value of type Void
* This is simply empty tuple, in effect tuple with zero elements, which can be written as ()
* return value of function can be ignored when it is called */

func printAndCount(stringToPrint: String) -> Int { print(stringToPrint)
return stringToPrint.characters.count }
func printWithoutCounting(stringToPrint: String) {printAndCount(stringToPrint)}
printAndCount("hello, world")
printWithoutCounting("hello, world")
/*:
* printAndCount(_:), prints string, and return its character count as Int
* printWithoutCounting, calls first function, but ignores its return value
* When 2nd function is called, message is still printed by first function, but returned value not used
* Return values can be ignored, but function that says it will return value must always do so
* function with defined return type cannot allow control to fall out of bottom of function without return  value, and attempting to do so will result in compile-time error

### Functions with Multiple Return Values
* use tuple as return type for function to return multiple values */
func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] { if value < currentMin { currentMin = value }
    else if value > currentMax {currentMax = value }}
    return (currentMin, currentMax)
}

let bounds = minMax([8, -6, 2, 109, 3, 71])
print("min is \(bounds.min) and max is \(bounds.max)")
/*: tuple members not need to be named at point that tuple is returned from function, because their names are already specified as part of function return type

### Optional Tuple Return Types
* use optional tuple return type to reflect fact that entire tuple can be nil
* write optional tuple return type by placing ? after tuple type closing parenthesis, such as (Int, Int)?
* (Int, Int)? is different from (Int?, Int?) */
func myminMax(array: [Int]) -> (min: Int, max: Int)? {
if array.isEmpty { return nil }
var currentMin = array[0]
var currentMax = array[0]
for value in array[1..<array.count] { if value < currentMin { currentMin = value }
else if value > currentMax { currentMax = value } }
return (currentMin, currentMax)}

//: use optional binding to check whether this version of myminMax(_:) return actual tuple value or nil
if let bounds = myminMax([8, -6, 2, 109, 3, 71]) { print("min is \(bounds.min) and max is \(bounds.max)")}

/*:
### Function Parameter Names
* have both external parameter name and local parameter name
* external parameter name is used to label arguments passed to function call
* local parameter name is used in implementation of function */
func someFunction(firstParameterName: Int, secondParameterName: Int) { }
someFunction(1, secondParameterName: 2)
/*:
* 1st parameter is external name, and 2nd parameters use their local name as their external name
* All parameters must have unique local names, but may share external parameter in common

### Specify External Parameter Names
* write external parameter name before local parameter name it supports, separated by space */
func someFunction(externalParameterName localParameterName: Int) { }

//:* If provide external parameter name, external name must always be used when you call function */
func sayHello(to person: String, and anotherPerson: String) -> String {
return "Hello \(person) and \(anotherPerson)!" }
print(sayHello(to: "Bill", and: "Ted")) // prints "Hello Bill and Ted!"

//: ### Omitting External Parameter Names
//:* not want to use external name for 2nd func parameter, write (_) instead of explicit external name*/
func someFunction(firstParameterName: Int, _ secondParameterName: Int) { }
someFunction(1, 2)
/*:
* 1st parameter omits external parameter name by default, explicitly writing underscore is extraneous

## Default Parameter Values
* define default value for any parameter by assigning value to parameter after that parameter type
* If default value is defined, you can omit that parameter when calling function */
func someFunction(parameterWithDefault: Int = 12) {}
someFunction(6)
someFunction()

/*:
### Variadic Parameters
* variadic parameter accepts zero or more values of specified type
* use variadic parameter to specify that parameter can be passed varying number of input values
* Write variadic parameters by inserting 3 period characters (...) after parameter type name
* values passed to variadic parameter are made available within function body as array */
func arithmeticMean(numbers: Double...) -> Double {
var total: Double = 0
for number in numbers { total += number }
return total / Double(numbers.count) }
arithmeticMean(1, 2, 3, 4, 5)
arithmeticMean(3, 8.25, 18.75)



/*:
### Constant and Variable Parameters
* Function parameters are constants by default
* to change value of function parameter from within body of that function results in compile-time error
* can’t change value of parameter by mistake
* sometimes useful for function to have variable copy of parameter value to work with
* avoid define new var yourself in function by specifying one or more parameters as variable parameters instead
* Variable parameters are available as variables rather than as constants, and give new modifiable copy of  parameter value for your function to work with */
func alignRight(var string: String, totalLength: Int, pad: Character) -> String {
let amountToPad = totalLength - string.characters.count
if amountToPad < 1 { return string }
let padString = String(pad)
for _ in 1...amountToPad { string = padString + string }
return string }
let originalString = "hello"
let paddedString = alignRight(originalString, totalLength: 10, pad: "-")

/*:
### In-Out Parameters
* Variable parameters can only be changed within function itself
* If you want function to modify parameter value, and you want those changes to persist after function call has ended, define that parameter as in-out parameter instead
* write in-out parameter by placing inout keyword at start of its parameter definition
* in-out parameter has value that is passed in to function, is modified by function, and is passed back out of function to replace original value
* You place ampersand (&) directly before variable name when you pass it as argument to inout parameter, to indicate that it can be modified by function
* In-out parameters cannot have default values, and variadic parameters cannot be marked as inout
* If you mark parameter as inout, it cannot also be marked as var or let */
func swapTwoInts(inout a: Int, inout _ b: Int) { let temporaryA = a ; a = b ; b = temporaryA }
var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
//:* In-out parameters are alternative way for function to have effect outside of scope of function body

//:### Function Types
//:* Every function has specific function type, made up of parameter types and return type of function
func addTwoInts(a: Int, _ b: Int) -> Int { return a + b }
func multiplyTwoInts(a: Int, _ b: Int) -> Int { return a * b }
//: Type of these functions is (Int, Int) -> Int

func printHelloWorld() { print("hello, world") }
//: Type of this function is () -> Void

//:### Using Function Types
//:* use function types just like any other types
//:* define constant or variable to be of function type and assign appropriate function to that variable
var mathFunction: (Int, Int) -> Int = addTwoInts
mathFunction(2, 3)
mathFunction = multiplyTwoInts
print("Result: \(mathFunction(2, 3))")
let anotherMathFunction = addTwoInts

//:### Function Types as Parameter Types
//:* use function type such as (Int, Int) -> Int as parameter type for another function
func printMathResult(mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {print("Result: \(mathFunction(a, b))")}
printMathResult(addTwoInts, 3, 5) // prints "Result: 8"

//:### Function Types as Return Types
//:* do this by writing complete function type immediately after return arrow (->) of return function
func stepForward(input: Int) -> Int { return input + 1 }
func stepBackward(input: Int) -> Int { return input - 1 }
func chooseStepFunction(backwards: Bool) -> (Int) -> Int { return backwards ? stepBackward : stepForward }
var currentValue = 3
let moveNearerToZero = chooseStepFunction(currentValue > 0)
print("Counting to zero:")
while currentValue != 0 { print("\(currentValue)... ")
currentValue = moveNearerToZero(currentValue)}
print("zero!")

//:### Nested Functions
//:* define functions inside bodies of other functions, known as nested functions
//:* Nested functions hidden from outside by default, but still be called and used by their enclosing function
//:* enclosing function also return its nested functions to allow nested function to be used in another scope
func chooseStepFunction1(backwards1: Bool) -> (Int) -> Int {
    func stepForward1(input: Int) -> Int { return input + 1 }
    func stepBackward1(input: Int) -> Int { return input - 1 }
    return backwards1 ? stepBackward1 : stepForward1
}
var currentValue1 = -4
let moveNearerToZero1 = chooseStepFunction1(currentValue1 > 0)
while currentValue1 != 0 { print("\(currentValue1)... ")
    currentValue1 = moveNearerToZero1(currentValue1) }
print("zero!")