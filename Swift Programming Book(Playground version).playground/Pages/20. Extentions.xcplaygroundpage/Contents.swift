/*:
# Extensions : add new functionality to existing class, struct, enum, or protocol type
* This includes ability to extend types for which not have access to original source code (known as retroactive modeling)
* Extensions in Swift can:
* Add computed properties and computed type properties
* Define instance methods and type methods
* Provide new initializers
* Define subscripts
* Define and use new nested types
* Make an existing type conform to a protocol
* you can even extend protocol to provide implementations of its requirements or add additional functionality that conforming types can take advantage of
* Extensions can add new functionality to a type, but they cannot override existing functionality.

# Syntax
* Declare extensions with "extension"
* extension SomeType { // new functionality to add to SomeType goes here }
* extension can extend existing type to make it adopt one or more protocols
* Where this is case, protocol names are written in exactly same way as for a class or structure
* extension SomeType: SomeProtocol, AnotherProtocol { // implementation of protocol requirements goes here }
* If you define extension to add new functionality to an existing type, new functionality will be available on all existing instances of that type, even if they were created before extension was defined.

# Computed Properties
* Extensions can add computed instance properties and computed type properties to existing types
* example adds five computed instance properties to Swift’s built-in Double type, to provide basic support for working with distance units */
extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}
let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")
let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")
/*:
* These computed properties express that Double value should be considered as a certain unit of length
* Although they are implemented as computed properties, names of these properties can be appended to floating-point literal value with dot syntax, as way to use that literal value to perform distance conversions.
* In this example, Double value of 1.0 is considered to represent “one meter”
* This is why m computed property returns self—the expression 1.m is considered to calculate a Double value of 1.0.
* Other units require some conversion to be expressed as a value measured in meters
* One kilometer is same as 1,000 meters, km computed property multiplies value by 1_000.00 to convert into number expressed in meters
* Similarly, there are 3.28024 feet in a meter, and so the ft computed property divides the underlying Double value by 3.28024, to convert it from feet to meters.
* These properties are read-only computed properties, and so they are expressed without get keyword, for brevity
* Their return value is of type Double, and can be used within mathematical calculations wherever a Double is accepted */
let aMarathon = 42.km + 195.m
print("A marathon is \(aMarathon) meters long")
//:* Extensions can add new computed properties, but not add stored properties, or add property observers to existing properties

//:# Initializers
/*:
* Extensions can add new initializers to existing types
* This enables to extend other types to accept your own custom types as initializer parameters, or to provide additional initialization options that were not included as part of the type’s original implementation.
* Extensions can add new convenience initializers to a class, but they cannot add new designated initializers or deinitializers to a class. Designated initializers and deinitializers must always be provided by the original class implementation.
* If use extension to add initializer to value type that provides default values for all its stored properties and not define custom initializer, can call default initializer and memberwise initializer for that value type from within your extension’s initializer.
* This would not be the case if you had written the initializer as part of the value type’s original implementation
* example below defines custom Rect structure to represent a geometric rectangle
* example define 2 struct called Size and Point, both of which provide default values of 0.0 for all of their properties*/
struct Size { var width = 0.0, height = 0.0 }
struct Point { var x = 0.0, y = 0.0 }
struct Rect {
    var origin = Point()
    var size = Size()
}
//:* Because Rect struct provides default values for all its properties, it receives default initializer and a memberwise initializer automatically, as described in Default Initializers
//:* These initializers can be used to create new Rect instances
let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
size: Size(width: 5.0, height: 5.0))
//:* can extend Rect struct to provide additional initializer that takes a specific center point and size
extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}
//:* This new initializer starts by calculating appropriate origin point based on provided center point and size value
//:* initializer calls structure’s automatic memberwise initializer init(origin:size:), which stores new origin and size values in  appropriate properties
let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
size: Size(width: 3.0, height: 3.0))
//:* If you provide new initializer with extension, still responsible for making sure that each instance is fully initialized once initializer completes

//:# Methods
//:* Extensions can add new instance methods and type methods to existing types
//:* following example adds new instance method called repetitions to Int type
extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self { task() }
    }
}
//:* repetitions(_:) takes single argument of type () -> Void, which indicates function that has no parameters and not return value
//:* After define extension, can call repetitions(_:) on any integer number to perform a task that many number of times
3.repetitions({ print("Hello!")})
//:* Use trailing closure syntax to make the call more succinct
3.repetitions { print("Goodbye!") }

//:# Mutating Instance Methods
//:* Instance methods added with extension can also modify (or mutate) instance itself
//:* Struct and enum methods that modify self or its properties must mark instance method as mutating, just like mutating methods from original implementation.
//:* example below adds new mutating method called square to Swift’s Int type, which squares the original value
extension Int { mutating func square() { self = self * self } }
var someInt = 3
someInt.square()

//:# Subscripts
//:* Extensions can add new subscripts to an existing type
//:* example adds integer subscript to Int type
//:* subscript [n] returns the decimal digit n places in from the right of the number
// 123456789[0]
// 123456789[1]
extension Int {
    subscript(var digitIndex: Int) -> Int {
        var decimalBase = 1
        while digitIndex > 0 {
            decimalBase *= 10
            --digitIndex
        }
        return (self / decimalBase) % 10
    }
}
746381295[0]
746381295[1]
746381295[2]
746381295[8]
//:* If Int value not have enough digits for requested index, subscript implementation returns 0, as if number had been padded with zeroes to  left
746381295[9]
0746381295[9]

//:# Nested Types
//:* Extensions can add new nested types to existing classes, structures and enumerations
extension Int {
    enum Kind { case Negative, Zero, Positive }
    var kind: Kind {
        switch self {
        case 0: return .Zero
        case let x where x > 0: return .Positive
        default: return .Negative } } }
//:* example adds new nested enumeration to Int
//:* enum, called Kind, expresses kind of number that particular integer represents
//:* Specifically, it expresses whether number is negative, zero, or positive
//:* example also adds new computed instance property to Int, called kind, which return appropriate Kind enum member for that integer
//:* nested enum can now be used with any Int value
func printIntegerKinds(numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .Negative: print("- ", terminator: "")
        case .Zero: print("0 ", terminator: "")
        case .Positive: print("+ ", terminator: "") } }
    print("")
}
printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
// prints "+ + - 0 - 0 +"
//:* This function, printIntegerKinds, takes input array of Int values and iterates over those values in turn
//:* For each integer in array, function considers kind computed property for that integer, and prints an appropriate description.
//:* number.kind is already known to be of type Int.Kind
//:* Because of this, all of Int.Kind member values can be written in shorthand form inside the switch statement, such as .Negative rather than Int.Kind.Negative