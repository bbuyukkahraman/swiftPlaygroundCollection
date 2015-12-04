/*:
# Generics : enables to write flexible, reusable functions and types can work with any type.
* write code that avoids duplication and expresses
* Array and Dictionary types are both generic collections
* create array holds Int, String, or any other type
* create dictionary to store values of any specified type, and no limitations on what type can be

## What Generics Solves?
* Standard, non-generic function swapTwoInts(_:_:), swaps two Int */
func swapTwoInts(inout a: Int, inout _ b: Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
//:* want to swap two String, or two Double
//:* have to write more functions, swapTwoStrings(_:_:) and swapTwoDoubles(_:_:)
func swapTwoStrings(inout a: String, inout _ b: String) {
    let temporaryA = a
    a = b
    b = temporaryA
}
func swapTwoDoubles(inout a: Double, inout _ b: Double) {
    let temporaryA = a
    a = b
    b = temporaryA
}
/*:
* function body identical only difference is value type they accept (Int, String, and Double)
* write single function that could swap two values of any type
* Generic enables to write such function
* Important that types of a and b are defined to be same as each other
* If a and b not same type, not possible to swap values

## Generic Functions : can work with any type
* generic version of swapTwoValues(_:_:) */
func swapTwoValues<T>(inout a: T, inout _ b: T) {
    let temporaryA = a
    a = b
    b = temporaryA
}
//:* Compare first lines
func swapTwoInts1     (inout a: Int, inout _ b: Int){}
func swapTwoValues1<T>(inout a: T, inout _ b: T){}
/*:
* generic function uses placeholder type name (T) 
* placeholder type name not say anything about T must be, it says a and b must be same type T
* actual type to use in place of T will be determined each time swapTwoValues(_:_:) function called
* generic function name (swapTwoValues(_:_:)) followed by placeholder type name (T) inside angle brackets (<T>)
* <> tells "T" is placeholder type name */
var mySomeInt = 3
var myAnotherInt = 107
func swapTwoValues2<T>(inout a: T, inout _ b: T) {
    let temporaryA = a
    a = b
    b = temporaryA
}
swapTwoValues2(&mySomeInt, &myAnotherInt)
mySomeInt
myAnotherInt

var someString = "hello"
var anotherString = "world"
func swapTwoValues3<T>(inout a: T, inout _ b: T) {
    let temporaryA = a
    a = b
    b = temporaryA
}
swapTwoValues3(&someString, &anotherString)
someString
anotherString

//:* swapTwoValues(_:_:) generic function called swap, which is part of Swift standard library
//:* can use Swift existing swap(_:_:) rather than providing own implementation

/*:
//:## Type Parameters
* placeholder type T is type parameter
* Type parameters specify and name placeholder type, and written immediately after function name
* specify type parameter, use to define type of function parameters (a and b in swapTwoValues(_:_:)), or function return type, or as type annotation within body of function
* type parameter replaced with actual type whenever function called
* T replaced with Int first time function was called, and replaced with String second time it was called
*  provide more type parameter by writing multiple type parameter names within angle brackets, separated by commas.

## Naming Type Parameters
* mostly type parameter have descriptive names, such as in Dictionary<Key, Value> and in Array<Element>
* tells reader about relationship between type parameter and generic type or function it’s used in.
* when no meaningful relationship between them, use single letters T, U, and V
* give type parameters upper camel case names (MyTypeParameter) to indicate that placeholder for a type, not value

## Generic Types
* Swift enables to define your own generic types
* These are custom class, struct and enum can work with any type, in similar way to Array and Dictionary
* how to write generic collection type called Stack
* stack is ordered set of values, similar to array, but more restricted set of operations than Array type
* Array allows new items to be inserted and removed
* stack allows new items to be appended only to end of collection (pushing new value on to stack)
* stack allows items to be removed only from end of collection (popping value off stack)
* stack used by UINavigationController class to model view controllers in navigation hierarchy
* call UINavigationController class pushViewController(_:animated:) to add a view controller on to navigation stack
* call popViewControllerAnimated(_:) to remove view controller from navigation stack.
* stack is useful collection model whenever need strict “last in, first out” approach to managing collection
* how to write non-generic version of stack, for stack of Int values */
struct IntStack {
    var items = [Int]()
    mutating func push(item: Int) { items.append(item)        }
    mutating func pop() -> Int    { return items.removeLast() }
}
/*:
* InStack use Array property called items to store values in stack
* Stack provides two methods, push and pop, to push and pop values on and off stack
* methods marked as mutating, they need to modify struct items array
* IntStack can only be used with Int values
* useful to define generic Stack class, that can manage stack of any value type
* generic version of code */
struct Stack<Element> {
    var items = [Element]()
    mutating func push(item: Element) { items.append(item)        }
    mutating func pop() -> Element    { return items.removeLast() }
}
//:* create new Stack instance by writing type to be stored in stack within <>
//:* to create new stack of strings, write Stack<String>()
var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")
let fromTheTop = stackOfStrings.pop()

//:## Extending Generic Type
//:* When extend generic type, not provide type parameter list as part of extension definition
//:* type parameter list from original type definition is available within body of extension
//:* original type parameter names used to refer to type parameters from original definition.
//:* example adds read-only computed property "topItem", which return top item on stack without popping from stack
extension Stack {
    var topItem: Element? { return items.isEmpty ? nil : items[items.count - 1] }
}
//:* extension not define type parameter list
//:* existing type parameter name, Element, used within extension to indicate optional type of topItem property
//:* topItem can now be used with any Stack instance to access and query its top item without removing
if let topItem = stackOfStrings.topItem { print("The top item on the stack is \(topItem).") }

/*:
## Type Constraints
* swapTwoValues(_:_:) and Stack type can work with any type
* sometimes useful to enforce certain type constraints on types that can be used with generic functions and generic types 
* Type constraints specify that type parameter must inherit from specific class, or conform to particular protocol or protocol composition
* Dictionary type places limitation on types that can be used as keys for dictionary
* type of dictionary keys must be hashable
* it must provide way to make itself uniquely representable
* Dictionary needs its keys to be hashable so that it can check whether it already contains value for particular key 
* Without this requirement, Dictionary not tell whether it should insert or replace value for particular key, nor would it be able to find value for given key that is already in dictionary
* This requirement is enforced by type constraint on key type for Dictionary, which specifies that key type must conform to Hashable protocol
* All basic types (String, Int, Double, and Bool) are hashable by default
* define own type constraints when creating custom generic types, and constraints provide power of generic programming 
* Abstract concepts (Hashable) characterize types in terms of conceptual characteristics, rather than explicit type.

## Type Constraint Syntax
* write type constraints by placing single class or protocol constraint after type parameter name, separated by colon, as part of type parameter list
* basic syntax for type constraints on generic function is shown below */
class SomeClass {}
protocol SomeProtocol {}
func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {}

//:* function has two type parameters
//:* first type parameter, T, has type constraint that requires T to be a subclass of SomeClass
//:* second type parameter, U, has type constraint that requires U to conform to protocol SomeProtocol

//:## Type Constraints in Action
//:* non-generic findStringIndex, which is given String value to find and String array within which to find it
//:* function return optional Int, which index of first matching string in array if found, or nil if not found
func findStringIndex(array: [String], _ valueToFind: String) -> Int? {
    for (index, value) in array.enumerate() {
        if value == valueToFind { return index }
    }
    return nil
}
//:* findStringIndex(_:_:) can be used to find string value in an array of strings

let strings = ["cat", "dog", "lama", "parakeet", "terrapin"]
if let foundIndex = findStringIndex(strings, "lama") {
    print("The index of lama is \(foundIndex)")
}
/*:
* principle of finding index of value in array not useful only for strings
* can write same functionality as generic function findIndex, by replacing strings with values of some type T
* generic version of findStringIndex, called findIndex, to be written
* return type of function still Int?, because function return optional index number, not optional value from array
* Be warned, though—this function does not compile, for reasons explained after example */
/*
func findIndex<T>(array: [T], _ valueToFind: T) -> Int? {
    for (index, value) in array.enumerate() {
        if value == valueToFind { return index }
    }
    return nil
}
*/
/*:
* function not compile, problem lies with equality check, “if value == valueToFind”
* Not every type in Swift can be compared with equal to operator (==)
* If create own class or struct to represent complex data model, then meaning of “equal to” for that class or struct not something that Swift can guess for you
* not possible to guarantee that  code will work for every possible type T, and appropriate error is reported
* Swift standard library defines protocol called Equatable, which requires any conforming type to implement equal to operator (==) and not equal to operator (!=) to compare any two values of that type
* All Swift standard types automatically support Equatable protocol.
* Any type that is Equatable can be used safely with findIndex(_:_:), it guaranteed to support equal to operator
* write type constraint of Equatable as part of type parameter definition when define function */

func findIndex<T: Equatable>(array: [T], _ valueToFind: T) -> Int? {
    for (index, value) in array.enumerate() {
        if value == valueToFind { return index }
    }
    return nil
}
//:* single type parameter for findIndex written as T: Equatable, means “any type T conforms to Equatable protocol.”
//:* findIndex(_:_:)now compiles successfully and can used with any type that is Equatable, such as Double or String
let doubleIndex = findIndex([3.14159, 0.1, 0.25], 9.3)
let stringIndex = findIndex(["Mike", "Malcolm", "Andrea"], "Andrea")

/*:
# Associated Types
* When defining protocol, sometimes useful to declare one or more associated types as part of protocol definition
* associated type gives placeholder name (alias) to type that is used as part of protocol
* actual type to use for that associated type not specified until protocol is adopted
* Associated types are specified with "typealias" keyword.

# Associated Types in Action
* example of protocol Container, declares associated type ItemType */
protocol Container {
    typealias ItemType
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}

/*:
* Container protocol defines three required capabilities that any container must provide:
* It must be possible to add new item to  container with append(_:)
* It must be possible to access count of items in container through count property returns Int value
* It must be possible to retrieve each item in container with subscript that takes Int index value
* not specify how items in container be stored or what type they are allowed to be
* only specifies three bits of functionality that any type must provide in order to be considered Container
* conforming type can provide additional functionality, as long as it satisfies these three requirements.
* Any type that conforms to Container protocol must be able to specify type of values it stores
* it must ensure that only items of right type are added to container, and it must be clear about type of items returned by its subscript.
* To define these requirements, Container needs way to refer to type of elements that container will hold, without knowing what type is for specific container
* Container protocol needs to specify any value passed to append(_:) must have same type as container element type
* and that value returned by container subscript will be of same type as container element type
* Container protocol declares associated type called ItemType, written as typealias ItemType
* protocol not define what ItemType is alias for—that info is left for any conforming type to provide
* ItemType alias provides way to refer to type of items in Container, and to define type for use with append(_:) and subscript, to ensure that expected behavior of any Container is enforced.
* non-generic IntStack type from earlier, adapted to conform to Container protocol */

struct IntStack1 {
    var items = [Int]()
    mutating func push(item: Int) { items.append(item)        }
    mutating func pop() -> Int    { return items.removeLast() }
}

protocol Container1 {
    typealias ItemType
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}

struct IntStack2: Container1 {
    // original IntStack implementation
    var items = [Int]()
    mutating func push(item: Int) { items.append(item) }
    mutating func pop() -> Int { return items.removeLast() }

    // conformance to Container protocol
    typealias ItemType = Int
    mutating func append(item: Int) { self.push(item) }
    var count: Int { return items.count }
    subscript(i: Int) -> Int { return items[i] }
}
/*:
* IntStack type implements all three of Container protocol requirements, and in each case wraps part of IntStack type existing functionality to satisfy these requirements.
* IntStack specifies that for this implementation of Container, appropriate ItemType to use is type of Int
* definition of typealias ItemType = Int turns abstract type of ItemType into concrete type of Int for this implementation of Container protocol
* with type inference, not need to declare concrete ItemType of Int as part of definition of IntStack
* IntStack conforms to all of requirements of Container protocol, Swift can infer appropriate ItemType to use, simply by looking at type of append(_:) item parameter and return type of subscript
* if delete typealias ItemType = Int, everything still works, because it is clear what type should be used for ItemType
* can also make generic Stack type conform to Container protocol */

struct Stack1<Element> {
    var items = [Element]()
    mutating func push(item: Element) { items.append(item)        }
    mutating func pop() -> Element    { return items.removeLast() }
}

protocol Container2 {
    typealias ItemType
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}

struct Stack2<Element>: Container2 {
    // original Stack<Element> implementation
    var items = [Element]()
    mutating func push(item: Element) { items.append(item) }
    mutating func pop() -> Element { return items.removeLast() }
    
    // conformance to the Container protocol
    mutating func append(item: Element) { self.push(item) }
    var count: Int { return items.count }
    subscript(i: Int) -> Element { return items[i] }
}
//:* type parameter Element used as type of append(_:) item parameter and return type of subscript
//:* Swift can infer Element is appropriate type to use as ItemType for this particular container

/*:
//:# Extending an Existing Type to Specify an Associated Type
* can extend existing type to add conformance to protocol
* This includes a protocol with an associated type.
* Array type already provides append(_:), count property, and subscript with Int index to retrieve its elements
* These three capabilities match requirements of Container protocol
* can extend Array to conform to Container protocol simply by declaring that Array adopts protocol
* do this with empty extension */
protocol Container3 {
    typealias ItemType
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}
extension Array: Container3 {}
//:* Array existing append(_:) and subscript enable Swift to infer appropriate type to use for ItemType, just as for generic Stack type above
//:* After defining this extension, you can use any Array as Container

/*:
//:# Where Clauses
* Type constraints enable to define requirements on type parameters associated with generic function or type.
* can also useful to define requirements for associated types
* do this by defining where clauses as part of type parameter list
* where clause enables to require that associated type conforms to certain protocol, and/or certain type parameters and associated types be same
* write where clause by placing "where" keyword immediately after list of type parameters, followed by one or more constraints for associated types, and/or one or more equality relationships between types and associated types
* example defines generic allItemsMatch(), checks to see if two Container instances contain same items in same order
* function returns Boolean value of true if all items match and value of false if they do not.
* two containers to be checked do not have to be same type of container, but they do have to hold same type of items
* This requirement is expressed through a combination of type constraints and where clauses */
func allItemsMatch<C1: Container, C2: Container  where C1.ItemType == C2.ItemType, C1.ItemType: Equatable>
    (someContainer: C1, _ anotherContainer: C2) -> Bool {
        // check that both containers contain the same number of items
        if someContainer.count != anotherContainer.count { return false }
        
        // check each pair of items to see if they are equivalent
        for i in 0..<someContainer.count {
            if someContainer[i] != anotherContainer[i] { return false }
        }
        // all items match, so return true
        return true
}
/*:
* This function takes two arguments called someContainer and anotherContainer
* someContainer argument is of type C1, and anotherContainer argument is of type C2
* Both C1 and C2 are type parameters for two container types to be determined when the function is called.
* function’s type parameter list places following requirements on two type parameters:
* C1 must conform to Container protocol (written as C1: Container).
* C2 must also conform to Container protocol (written as C2: Container).
* ItemType for C1 must be same as ItemType for C2 (written as C1.ItemType == C2.ItemType).
* ItemType for C1 must conform to Equatable protocol (written as C1.ItemType: Equatable).
* 3rd and 4th requirements defined as part of where clause, and written after "where" as part of function type parameter list
* These requirements mean:
* someContainer is container of type C1.
* anotherContainer is container of type C2.
* someContainer and anotherContainer contain same type of items.
* items in someContainer can be checked with not equal operator (!=) to see if they are different from each other
* 3rd and 4th requirements combine to mean that items in anotherContainer can also be checked with != operator, because they are exactly same type as items in someContainer
* These requirements enable allItemsMatch(_:_:) to compare two containers, even if they are of different container type
* allItemsMatch(_:_:) starts by checking that both containers contain same number of items
* If they contain different number of items, no way that they can match, and function returns false
* After check, function iterates over all of items in someContainer with for-in loop and half-open range operator (..<)
* For each item, function checks whether item from someContainer is not equal to corresponding item in anotherContainer
* If two items not equal, then two containers not match, and function returns false
* If loop finishes without finding mismatch, two containers match, and function return true
* Here’s how  allItemsMatch(_:_:) looks in action */
/*
var stackOfStrings3 = Stack<String>()
stackOfStrings3.push("uno")
stackOfStrings3.push("dos")
stackOfStrings3.push("tres")
var arrayOfStrings3 = ["uno", "dos", "tres"]
if allItemsMatch(stackOfStrings3, arrayOfStrings3) { print("All items match.")
} else { print("Not all items match.")}
*/
/*:
* example creates Stack instance to store String values, and pushes three strings onto stack
* example also creates Array instance initialized with array literal containing same three strings as stack
* Even though stack and array are of different type, they both conform to Container protocol, and both contain same type of values
* call allItemsMatch(_:_:) with these two containers as its arguments
* In example above, allItemsMatch(_:_:) correctly reports that all of items in two containers match. */