/*:
# Error Handling : process of responding to and recovering from error conditions in program
* Swift provides first-class support for throwing, catching, propagating, and manipulating recoverable errors at runtime
* Some functions and methods can’t be guaranteed to always complete execution or produce useful output
* Optionals are used to represent absence of value, but when function fails, useful to understand what caused failure
* In Swift, these are called throwing functions and throwing methods.
* consider task of reading and processing data from file on disk
* There are number of ways this task can fail, including file not exist at specified path, file not having read permissions, or file not being encoded in compatible format
* different situations allows program to resolve and recover from error, and—if necessary—communicate it to user
* Error handling interoperates with error handling patterns that use NSError

# Representing Errors
* errors are represented by values of types conforming to ErrorType protocol.
* Swift enumerations are particularly well-suited to modeling group of related error conditions, with associated values allowing for additional information about nature of error to be communicated
* Swift enumerations that adopt ErrorType automatically have implementation of their conformance synthesized by compiler
* here how might represent error conditions of operating vending machine */
enum VendingMachineError: ErrorType {
    case InvalidSelection
    case InsufficientFunds(required: Double)
    case OutOfStock
}
/*:
* vending machine can fail for following reasons:
* requested item not valid selection, indicated by InvalidSelection
* requested item cost is greater than provided funds, indicated by InsufficientFunds
* associated Double value represents balance required to complete transaction
* request item is out of stock, indicated by OutOfStock */

//:# Throwing Errors
/*:
* To indicate that function or method can throw error, write throws keyword in its declaration, after its parameters
* If it specifies return type, write throws keyword before return arrow (->)
* function, method, or closure cannot throw an error unless explicitly indicated */
//   func canThrowErrors() throws -> String
//   func cannotThrowErrors() -> String
/*:
* At any point in body of throwing function, you can throw error with throw statement
* example below, vend(itemNamed:) function throws error if requested item is not available, is out of stock, or has a cost that exceeds the current deposited amount */
struct Item {
    var price: Double
    var count: Int
}
var inventory = [
    "Candy Bar": Item(price: 1.25, count: 7),
    "Chips": Item(price: 1.00, count: 4),
    "Pretzels": Item(price: 0.75, count: 11)
]
var amountDeposited = 1.00

func vend(itemNamed name: String) throws {
    guard var item = inventory[name] else {
        throw VendingMachineError.InvalidSelection
    }
    guard item.count > 0 else {
    throw VendingMachineError.OutOfStock }
    if amountDeposited >= item.price {
        amountDeposited -= item.price
        --item.count
        inventory[name] = item
    } else {
        let amountRequired = item.price - amountDeposited
        throw VendingMachineError.InsufficientFunds(required: amountRequired) }
}
/*:
* First, "guard" used to bind item constant and count variable to corresponding values in current inventory
* If item not in inventory, InvalidSelection error is thrown
* Next, availability of requested item is determined by checking its count
* If count is less than or equal to zero, OutOfStock error is thrown
* Finally, price of requested item is compared to current deposited amount
* If deposited amount can cover cost of item, price is deducted from deposited amount, count of stock of item is decremented in inventory, and function return requested item
* Otherwise, outstanding balance is calculated and used as associated value for thrown InsufficientFunds error
* Because throw statement immediately transfers program control, an item will be vended only if all of requirements for purchase stock selection with sufficient funds—are met.
* When call throwing function, write try in front of the call
* This keyword calls out fact that function can throw error and that lines of code after try might not be run */
let favoriteSnacks = ["Alice": "Chips", "Bob": "Licorice", "Eve": "Pretzels", ]
func buyFavoriteSnack(person: String) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vend(itemNamed: snackName)
}
//:* buyFavoriteSnack(_:) looks up given person favorite snack and tries to buy it for them
//:* If don’t have favorite snack listed, tries to buy candy bar
//:* It calls vend function, which is throwing function, so function call is marked with try in front of it
//:* buyFavoriteSnack(_:) also throwing function, so any errors that vend function throws propagate up to point where  buyFavoriteSnack(_:) called.

//:# Catching and Handling Errors
//:* use "do-catch" to catch errors and handle them.
//:   do { try function that throws ; statements } catch pattern { statements }
//:* If error is thrown, that error is propagated to its outer scope until it is handled by catch clause
//:* catch clause consists of "catch" keyword, followed by pattern to match error against and set of statements to execute
//:* Like "switch", compiler attempts to infer whether catch clauses are exhaustive
//:* If such a determination can be made, error is considered handled
//:* Otherwise, containing scope must handle error, or containing function must be declared with throws
//:* To ensure that error is handled, use catch clause with pattern that matches all errors
//:* If catch clause not specify pattern, clause will match and bind any error to local constant named error
do {
    try vend(itemNamed: "Candy Bar") }
catch VendingMachineError.InvalidSelection { print("Invalid Selection.")}
catch VendingMachineError.OutOfStock { print("Out of Stock.")}
catch VendingMachineError.InsufficientFunds(let amountRequired) { print("Insufficient funds. Please insert an additional $\(amountRequired).")}
//:* In above example, vend(itemNamed:) called in try expression, because it can throw error
//:* If error is thrown, execution immediately transfers to catch clauses, which decide whether to allow propagation to continue. 
//:* If no error is thrown, the remaining statements in the do statement are executed.
//:* Error handling in Swift resembles exception handling in other languages, with use of try, catch and throw keywords
//:* Swift not involve unwinding call stack, which can be computationally expensive
//:* As such, performance characteristics of a throw statement are comparable to those of a return statement.


//:NEW!!!
//:# Converting Errors to Optional Values
//:* use try? to handle error by converting it to optional value
//:* If error is thrown while evaluating try? expression, value of expression is nil
//:* following code x and y have the same value and behavior

func someThrowingFunction() throws -> Int { return 5 }
let x = try? someThrowingFunction()

let y: Int?
do {
    y = try someThrowingFunction()
} catch {
    y = nil
}
//:* If someThrowingFunction() throws error, value of x and y is nil
//:* Otherwise, value of x and y is value that function returned
//:* Note that x and y are optional of whatever type someThrowingFunction() returns
//:* Here function returns integer, so x and y are optional integers.
//:* Using try? lets you write concise error handling code when you want to handle all errors in the same way
//:* following code uses several approaches to fetch data, or returns nil if all of the approaches fail.
/*
func fetchData() -> Data? {
    if let data = try? fetchDataFromDisk() { return data }
    if let data = try? fetchDataFromServer() { return data }
    return nil
}
*/


//:# Disabling Error Propagation
//*: There are some cases in which you know throwing function or method won’t, in fact, throw error at run time
//:* In these cases, can call throwing function or method in forced-try expression, written, try!, instead of regular try
//:* Calling throwing function or method with try! disables error propagation and wraps call in run-time assertion that no error will be thrown
//:* If error actually is thrown, you’ll get a runtime error.
/*
func willOnlyThrowIfTrue(value: Bool) throws {
    if value { throw someError }
}

do { try willOnlyThrowIfTrue(false) }
catch { }

try! willOnlyThrowIfTrue(false)
*/

//:# Specifying Clean-Up Actions
/*:
* use "defer" to execute set of statements just before code execution leaves current block of code
* lets you do any necessary cleanup that should be performed regardless of whether error occurred
* Examples include closing any open file descriptors and freeing any manually allocated memory.
* "defer" defers execution until current scope is exited
* It consists of "defer" keyword and statements to be executed later
* deferred statements may not contain any code that would transfer control out of statements, such as "break" or "return", or by throwing error
* Deferred actions are executed in reverse order of how they are specified—that is, code in first "defer" executes after code in second */
/*
func processFile(filename: String) throws {
    if exists(filename) {
        let file = open(filename)
        defer { close(file) }
        while let line = try file.readline() { }
    }
}
*/
//:* example uses "defer" to ensure that open(_:) has corresponding call to close(_:)
//:* This call is executed regardless of whether an error is thrown