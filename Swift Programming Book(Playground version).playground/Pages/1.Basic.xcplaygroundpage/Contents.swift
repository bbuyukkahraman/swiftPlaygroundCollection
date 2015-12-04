//:## VALUE TYPE
var valueType = [
    "Fundamental": ["Int", "Double", "Float", "Bool", "String"],
    "Collection" : ["Array", "Dictionary", "Set"],
    "Advanced"   : ["Tuple", "Optional"]]


//:## Value Declaration : "var" (variable) | "let" (constant)
var currentLoginAttempt = 0
var x = 0.0, y = 0.0, z = 0.0 //Multiple declaration

let maximumNumberOfLoginAttempts = 10
let languageName = "Swift"
//languageName = "Swift++" //ERROR : let can not changed (BUG FREE!!)

let π = 3.14159
let 你好 = "你好世界"
let 🐶🐮 = "dogcow"
var friendlyWelcome = "Hello!"
friendlyWelcome = "Bonjour!"


//:## Value Type Annotation
var welcomeMessage: String
welcomeMessage = "Hello"
var blue: Double

//:## String Interpolation
print("FriendlyWelcome is \(friendlyWelcome)")

//:* print(_:separator:terminator:) is global function
//:* separator and terminator have default values
//:* By default terminates line by adding line break
//:* To print without line break pass " " as terminator
print("FriendlyWelcome is \(friendlyWelcome)", terminator: "")


//:## String Concatenation
print(friendlyWelcome + " World")
print("list:\n1\tApple\n2\tBananas\n6\tOranges\n", terminator: "\n") // \n newline \t tab


//:## INTEGER : signed (+, 0, -) or unsigned (+, 0)
//: 8, 16, 32, 64 bit forms (UInt8: 8-bit unsigned integer, Int32: 32-bit signed integer)

//:## Integer Bounds
let minValue = UInt8.min
let maxValue = UInt8.max

//## Int (32-bit platform, Int = Int32 ; 64-bit platform, Int = Int64)
Int.max  // This system is 64 bit
Int64.max
Int64.min

//## UInt (32-bit platform, UInt = UInt32 ; 64-bit platform, UInt = UInt64)
UInt.max
UInt64.max
UInt64.min


//:## FLOATING-POINT (Double: 64-bit (15 decimal digit) ; Float: 32-bit  (6 decimal digit))

//:# Type Inference
//: If don’t specify value type, Swift use type inference with initial value
let meaningOfLife   = 42            //Int
let pi              = 3.14159       //Double

//:# Type Safety
//: If Int and floating-point literals in expression, Double inferred
let anotherPi = 3 + 0.14159

//:# Integer literal
let decimalInteger      = 17        //dec(no prefix)
let binaryInteger       = 0b10001   //bin(0b prefix)
let octalInteger        = 0o21      //oct(0o prefix)
let hexadecimalInteger  = 0x11      //hex(0x prefix)

//:# Floating-point literal
let decimalDouble       = 12.1875   //dec(no prefix)
let hexadecimalDouble   = 0xC.3p0   //hex(0x prefix)
let exponentDouble      = 1.25e2    // 1.25 * (10 uzeri 2)  = 125.0
let exponentDouble2     = 1.25e-2   // 1.25 * (10 uzeri -2) = 0.0125
let hexaExponentDouble  = 0xFp2     // 15 * (2 uzeri 2)     = 60.0
let hexaExponentDouble2 = 0xFp-2    // 15 * (2 uzeri -2)    = 3.75

//:# Padding for readability
let paddedDouble        = 000123.456            //with extra zeroes
let oneMillion          = 1_000_000             //with ( _ )
let justOverOneMillion  = 1_000_000.000_000_1   //with ( _ )

//:# Integer Conversion
Int8.max        //: Int8  : numbers between -128 and 127
Int8.min
UInt8.max       //: UInt8 : numbers between 0 and 255
UInt8.min

let twoThousand : UInt16    = 2_000
let one         : UInt8     = 1
let twoThousandAndOne = twoThousand + UInt16(one)

//:# Integer and Floating-Point Conversion
let three = 3
let pointOneFourOneFiveNine = 0.14159
let newPi       = Double(three) + pointOneFourOneFiveNine
let integerPi   = Int(pi)

//:# Type Aliases : alternative name for existing type
typealias AudioSample = UInt16
var maxAmplitudeFound = AudioSample.min


//:## Booleans
let orangesAreOrange    = true
let turnipsAreDelicious = false
if turnipsAreDelicious { print("tasty!") } else { print("horrible")}
let i = 1
if i == 1 {print("Right")}


//:# Tuples : Compound value for multiple-values
//: for complex data structures use class or struct
let http404Error = (404, "Not Found")
let (statusCode, statusMessage) = http404Error
statusCode
statusMessage

//: Ignore not need values with (_)
let (justTheStatusCode, _) = http404Error
justTheStatusCode

//: Access element with index number
http404Error.0
http404Error.1

//: Define name for each element
let http200Status = (statusCode: 200, description: "OK")
http200Status.statusCode
http200Status.description


//:# OPTIONAL : define value or no-value status
let possibleNumber      = "123"
let convertedNumber     = Int(possibleNumber)
let myPossibleNumber    = "Two"
let myConvertedNumber   = Int(myPossibleNumber)  //nil

//: set optional variable to valueless state by assign it value nil
var serverResponseCode: Int? = 404
serverResponseCode = nil

var serverResponseCode2 = 404
// ERROR: serverResponseCode2 = nil

//: If optional no default value, automatically set to nil
var surveyAnswer: String?   //nil

var str: String = "Hi there"
str.uppercaseString

var optionalString : String?
optionalString = "Hello"
optionalString?.uppercaseString  //NULL CHECK

var implicitString1 : String!
//implicitString1.uppercaseString  // ERROR


//:# If & Forced Unwrap
if convertedNumber != nil { print("contains value")}

//: if optional has value, can access its value by adding (!) to end of name
//: ! means, “I know optional has value; please use it.” (forced unwrap)
if convertedNumber != nil { print("value is \(convertedNumber)")}
if convertedNumber != nil { print("value is \(convertedNumber!)")}


//:# Optional Binding
//: to find optional has value, to make value available as temporary let or var
//: used with if and while to check optional value, and extract to let or var
if let actualNumber = Int(possibleNumber) { print("\'\(possibleNumber)\' has an integer value of \(actualNumber)")}
else { print("\'\(possibleNumber)\' could not be converted to an integer")}

//: Single "if" and use (,) separated list of assignment expression
let someOptional        :String?    = "Hi"
let someOtherOptional   :Int?       = 5
if let constantName = someOptional, anotherConstantName = someOtherOptional { print("\(constantName) , \(anotherConstantName)")}

//: Single "if" and use "where" clause to check for Boolean condition
if let firstNum = Int("4"), secondNumber = Int("42") where firstNum < secondNumber { print("\(firstNum) < \(secondNumber)")}


//:# Implicitly Unwrapped Optionals
//: give permission for optional to be unwrapped automatically whenever used
//: put ! after optional’s type when declare it
//: not use when there is possibility of variable becoming nil at later
//: use normal optional type if need to check for nil value during lifetime of var
let possibleString  : String?   = "An optional string."
let forcedString    : String    = possibleString!   //requires an exclamation mark
let assumedString   : String!   = "An implicitly unwrapped optional string."
let implicitString  : String    = assumedString     //no need for an exclamation mark
if assumedString != nil { print(assumedString) }
//: use with optional binding, to check and unwrap its value in single statement
if let definiteString = assumedString { print(definiteString)}


//:# ⭐ Error Handling
//: to respond to error conditions during execution
//: can use presence or absence or value to communicate success or failure of function
//: allows to determine underlying cause of failure
//: if necessary, propagate error to another part of code
//: When function encounters error condition, it throws (atmak) error
//: function’s caller catch error and respond appropriately
func canThrowAnError() throws { /* function may or may not throw an error */}
//: function can throw error by including throws keyword
//: When call function that can throw error, you prepend try keyword to expression
//: Swift propagates errors out of their current scope until they are handled by catch clause
do { try canThrowAnError() /*no error was thrown*/ } catch { /*error was thrown*/ }
//: "do" creates new containing scope, which allows errors to be propagated to one or more catch clause

func makeASandwich  () throws {}
func eatASandwich   () {}
func washDishes     () {}
func buyGroceries   () {}
enum Error {
    case OutOfCleanDishes
    case MissingIngredients
}
do { try makeASandwich();   eatASandwich() }
catch Error.OutOfCleanDishes { washDishes() }
catch Error.MissingIngredients(let ingredients ) { buyGroceries(ingredients) }
//: makeASandwich() throw error if no clean dishes are available or if any ingredients are missing
//: Because makeASandwich() throws, function call is wrapped in try expression
//: By wrapping function call in "do", any errors that are thrown will be propagated to provided catch clauses
//: If no error is thrown, eatASandwich() function is called
//: If error is thrown and match Error.OutOfCleanDishes, washDishes() will called
//: If error is thrown and match Error.MissingIngredientse, buyGroceries(_:) called with associated [String] value captured by catch pattern


//:# Assertions
//: If not possible to continue execution if particular condition not satisfied
//: trigger assertion to end code execution and provide opportunity to debug cause of absent or invalid value

//:# Debugging with Assertions
//: assertion is runtime check that logical condition definitely evaluates to true
//: Literally put, assertion “asserts” that condition is true
//: Use assertion to make sure that essential condition is satisfied before executing any further code
//: If condition true, execution continues
//: If condition false, execution ends, and app terminated
//: If code trigger assertion while running in debug environment, see where invalid state occurred and query state of app at time that assertion was triggered
//: assertion provide suitable debug message as to nature of assert

let age = 3  //Change to -3
assert(age >= 0, "A person's age cannot be less than zero") // assertion triggered, age not >= 0
//: execution continue only if age >= 0 evaluate true
//: If value of age is negative, age >= 0 evaluates to false, and assertion is triggered, terminating application
//: assertion message can be omitted if desired, as in following example
assert(age >= 0)
//: Assertions are disabled when code is compiled with optimizations

//:# When Use Assertions
//: condition has potential to be false, but must definitely be true in order for continue execution
//: Suitable scenarios for assertion check include :
//: integer subscript index passed to custom subscript implementation, but subscript index value be too low or too high
//: value passed to function, but invalid value means that function cannot fulfill its task
//: optional value currently nil, but non-nil value is essential for subsequent code to execute successfully