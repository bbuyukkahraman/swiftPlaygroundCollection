/*:
# Closure : self-contained blocks of functionality
* can pass around and used in code
* can capture and store references to any let and var from their defined context
* known as closing over those let and var
* Global and nested functions are actually special cases of closures

* 3 Closure form:
* Global function : have name and not capture any values
* Nested function : have name and can capture values from their enclosing function
* Closure expression : unnamed closures, that can capture values from their surrounding context; have clean, clear style, with optimizations that encourage brief, clutter-free syntax in common scenarios
* Optimizations include:
* Inferring parameter and return value types from context
* Implicit returns from single-expression closures
* Shorthand argument names
* Trailing closure syntax



## Closure Expression
* Nested functions means of naming and defining self-contained blocks of code as part of larger function
* useful to write shorter versions of function-like constructs without full declaration and name
* particularly true when work with functions that take other functions as one or more of their arguments
* Closure expression are a way to write inline closures in brief, focused syntax
* provide several syntax optimization for writing closures in short form without loss of clarity or intent

## Sort Function
* which sort array of values of known type, based on output of a sorting closure that you provide
* sort(_:) return new array of same type and size as old one, with its elements in correct sorted order
* original array is not modified by sort(_:)
* closure expression below use sort(_:) to sort array of String values in reverse alphabetical order */
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
func backwards(s1: String, s2: String) -> Bool { return s1 > s2 }
var reversed = names.sort(backwards)

/*:
## Closure Expression Syntax
* { (parameters) -> return type in statements }
* Closure expression syntax can use let, var, and inout parameters
* Default values cannot be provided
* Variadic parameters can be used if you variadic parameter and place it last in  parameter list
* example shows closure expression version of backwards(_:_:) function from earlier */
reversed = names.sort({ (s1: String, s2: String) -> Bool in
    return s1 > s2 })
/*:
* for inline closure expression, parameters and return type written inside {}
* start of closure body is introduced by in keyword
* "in" indicates closure parameter and return type definition finished, and closure body begin
* Because body of closure is so short, it can even be written on single line */
reversed = names.sort( { (s1: String, s2: String) -> Bool in return s1 > s2 } )

/*:
## Inferring Type From Context
* sort closure passed as argument to function, Swift infer parameters type and type of value it return from type of sort(_:) 2nd parameter
* This parameter is expecting function of type (String, String) -> Bool
* This means that (String, String) and Bool types not need to written
* Because all of types can be inferred, return arrow (->) and () names of parameters can also be omitted */
reversed = names.sort( { s1, s2 in return s1 > s2 } )
/*:
* possible to infer parameter types and return type when passing closure to function as inline closure expression
* no need to write inline closure in its fullest form when closure is used as function argument
* still make types explicit if you wish, and doing so is encouraged if it avoids ambiguity for readers of code
* purpose of closure is clear from fact that sorting is taking place, and it is safe for reader to assume that closure is likely to be working with String values, because it is assisting with sorting of string array

## Implicit Returns from Single-Expression Closures
* Single-expression closure implicitly return result of expression by omitting return keyword from declaration */
reversed = names.sort( { s1, s2 in s1 > s2 } )
/*:
* function type of sort(_:) 2nd argument makes it clear that Bool value must be returned
* closure body contains single expression (s1 > s2) that return Bool value
* return keyword can be omitted

## Shorthand Argument Names
* Swift provides shorthand argument names to inline closures, can used to refer to values of closure arguments by names $0, $1, $2, and so on.
* If use these shorthand argument names within closure expression, can omit closure argument list, and number and type of shorthand argument names will be inferred from expected function type
* "in" keyword also be omitted, because closure expression is made up its body 
* $0 and $1 refer to closure 1st and 2nd String arguments. */
reversed = names.sort( { $0 > $1 } )

/*:
## Operator Functions
* Swift String type defines its string-specific implementation of (>) as function that has 2 parameters of type String, and return value of type Bool
* This exactly match function type needed for sort(_:) 2nd parameter
* simply pass in (>), and Swift infer that you want to use its string-specific implementation */
reversed = names.sort(>)
reversed = names.sort(<)

/*:
## Trailing Closures
* If need to pass closure expression to function as function final argument and closure expression is long, useful to write it as trailing closure instead
* trailing closure is closure expression that written after () of function call it supports */
func someFunctionThatTakesAClosure(closure: () -> Void) {}
//: call function without trailing closure:
someFunctionThatTakesAClosure({})
//: call function with trailing closure
someFunctionThatTakesAClosure() {}
/*:
* If closure expression is only argument and provide that expression as trailing closure, not need to write () func name when call func */
reversed = names.sort() { $0 > $1 }

/*:
* useful when closure is sufficiently long that it is not possible to write it inline on a single line
* Array map(_:) method which takes closure expression as its single argument
* closure is called once for each item in array, and return alternative mapped value for that item
* nature of mapping and type of return value is left up to closure to specify
* map(_:) return new array containing all of new mapped values, in same order as their corresponding values in  original array
* use map(_:) with trailing closure to convert array of Int to array of String */
let digitNames = [ 0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine" ]
let numbers = [16, 58, 510]
/*:
* creates dictionary of mappings between integer digits and their English names
* also defines array of integers, ready to be converted into strings.
* use numbers array to create array of String, by passing closure to map(_:) method
* call to numbers.map not need to include any () after map, because map(_:) has only one parameter, and that parameter is provided as trailing closure */
let strings = numbers.map { (var number) -> String in
var output = ""
while number > 0 { output = digitNames[number % 10]! + output
number /= 10 }
return output}



/*:
## Capturing Values
* closure can capture constants and variables from surrounding context in which it is defined
* closure can then refer to and modify values of those constants and variables from within its body, even if original scope that defined let and var no longer exists.
* simplest form of a closure that can capture values is a nested function, written within body of another function
* nested function can capture any of its outer function’s arguments and can also capture any constants and variables defined within the outer function.
* nested incrementer() function captures two values, runningTotal and amount, from its surrounding context
* After capturing these values, incrementer is returned by makeIncrementer as a closure that increments runningTotal by amount each time it is called */
func makeIncrementer(forIncrement amount: Int) -> Void -> Int { var runningTotal = 0
    func incrementer() -> Int { runningTotal += amount ; return runningTotal }
return incrementer }
/*:
* return type of makeIncrementer is Void -> Int
* it return function, rather than simple value
* returned function has no parameters, and returns Int value each time it is called
* makeIncrementer(forIncrement:) defines integer variable called runningTotal, to store current running total of incrementer that will be returned
* This variable is initialized with value of 0
* makeIncrementer(forIncrement:) has single Int parameter with external name of forIncrement, and a local name of amount
* argument value passed to this parameter specifies how much runningTotal should be incremented by each time returned incrementer function is called.
* makeIncrementer define nested function called incrementer, which perform actual incrementing
* This function simply adds amount to runningTotal, and return result
* When considered in isolation, nested incrementer() might seem unusual */
//func incrementer() -> Int { runningTotal += amount ; return runningTotal }

/*:
* incrementer() no any parameters, and yet it refers to runningTotal and amount from within its function body
* It does this by capturing reference to runningTotal and amount from surrounding function and using them within its own function body
* Capturing by reference ensures that runningTotal and amount do not disappear when call to makeIncrementer ends, and also ensures that runningTotal is available next time  incrementer is called
* Swift may instead capture and store copy of value if value not mutated by or outside closure
* Swift handles all memory management involved in disposing of variables when they are no longer needed.
* Here example of makeIncrementer in action */
let incrementByTen = makeIncrementer(forIncrement: 10)
/*:
* example set constant called incrementByTen to refer to incrementer function that adds 10 to its runningTotal variable each time it is called
* Calling function multiple times shows this behavior in action */
incrementByTen()
incrementByTen()
incrementByTen()
//:If create second incrementer, it will have its own stored reference to a new, separate runningTotal variable
let incrementBySeven = makeIncrementer(forIncrement: 7)
incrementBySeven()
//:Calling original incrementer (incrementByTen) again continues to increment its own runningTotal variable, and not affect variable captured by incrementBySeven
incrementByTen()
/*:
* If assign closure to property of class instance, and closure captures that instance by referring to instance or its members, you will create strong reference cycle between closure and instance
* Swift uses capture lists to break these strong reference cycles

## Closures Are Reference Types
* incrementBySeven and incrementByTen are constants, but closures these constants refer to are still able to increment runningTotal variables that they have captured
* This is because functions and closures are reference types.
* When assign function or closure to constant or variable, you actually setting that constant or variable to be a reference to function or closure
* it is choice of closure that incrementByTen refers to that is constant, and not contents of closure itself
* if assign closure to two different constants or variables, both of those constants or variables will refer to same closure */
let alsoIncrementByTen = incrementByTen
alsoIncrementByTen()


//:# NEW!!!
//:# Autoclosures : is automatically created to wrap expression that being passed as argument to function
/*:
* not take any arguments, and when called, return value of expression that wrapped inside of it
    * lets delay evaluation, code inside isn’t run until you call closure
* useful for code that has side effects or is computationally expensive, it lets control when code evaluated
* code shows how closure delays evaluation. */

var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
let nextCustomer = { customersInLine.removeAtIndex(0) }
print(customersInLine.count)
print("Now serving \(nextCustomer())!")
print(customersInLine.count)

/*:
* Even though first element of customersInLine array is removed as part of closure, that operation isn’t carried out until closure is actually called
* If closure never called, expression inside closure is never evaluated
* type of nextCustomer is not String but () -> String , function that takes no arguments and returns string
* You get same behavior when you do this in function */

customersInLine
func serveNextCustomer(customer: () -> String) { print("Now serving \(customer())!") }
serveNextCustomer( { customersInLine.removeAtIndex(0) } )

/*:
* serveNextCustomer(_:) below performs same operation but, instead of using explicit closure, it uses autoclosure by marking its parameter with @autoclosure attribute
* can call function as if it took String argument instead of closure */

customersInLine
func serveNextCustomer(@autoclosure customer: () -> String) { print("Now serving \(customer())!")}
serveNextCustomer(customersInLine.removeAtIndex(0))

/*:
* Overusing autoclosures can make your code hard to understand
* context and function name should make it clear that evaluation is being deferred.
* @autoclosure attribute implies  @noescape attribute, which indicates closure is used only within function
* closure isn’t allowed to be stored in way that would let it “escape” scope of function and be executed after function return
* If want autoclosure that is allowed to escape, use  @autoclosure(escaping) form of attribute */

customersInLine
var customerClosures: [() -> String] = []
func collectCustomerClosures(@autoclosure(escaping) customer: () -> String) { customerClosures.append(customer) }
collectCustomerClosures(customersInLine.removeAtIndex(0))
collectCustomerClosures(customersInLine.removeAtIndex(0))
print("Collected \(customerClosures.count) closures.")
for customerClosure in customerClosures {  print("Now serving \(customerClosure())!") }

//:* In code above, instead of calling closure passed to it as its customer argument, collectCustomerClosures(_:) append closure to customerClosures array
//:* array is declared outside scope of function, which means closures in array can be executed after function returns
//:* value of customer argument must be allowed to escape function’s scope.
//:* more info about @autoclosure and @noescape attributes, see Declaration Attributes.


///:======================

let weight1 = Array(20...80)
weight1[2]

//: Long Form
let weight2 = Array(20...80).map ({ (intVal : Int ) -> Double in return  Double(intVal) * 0.5 })

//: Short Form
let weight3 = Array(20...80).map( { Double($0) * 0.5 } )

let height3 = Array(140...220).map( {Double($0) * 0.01} )