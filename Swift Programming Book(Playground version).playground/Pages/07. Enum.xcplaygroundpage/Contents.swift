//:# Enum : Common Type for related value group
//:- Enables work with values in type-safe way
//:- Not have to provide value
//:- If value (“raw”) provided, it can be string, character, Int or Float type
//:- Define common set of related members as part of one enum
//:- enum is first-class type. (It has own right)
//:- enum adopt many class features:
//:- + Computed properties  : additional info about enum current value
//:- + Instance methods     : functionality related to values
//:- + Initializers         : initial member value */

//:## Syntax
enum CompassPoint {
    case North
    case South
    case East
    case West     }
//: North, South, East, West : enum member values
//: North, South, East, West : NOT implicitly equal 0, 1, 2 and 3
enum Planet { case Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune }
//:* enum defines new type and names start with capital letter: (CompassPoint)
//:* Give singular names
var directionToHead = CompassPoint.West
directionToHead = .East

//:## Match enum Values with Switch
directionToHead = .South
switch directionToHead {
case .North : print("Lots of planets have a north")
case .South : print("Watch out for penguins")
case .East  : print("Where the sun rises")
case .West  : print("Where the skies are blue") }
//: provide default case to cover any members that are not addressed explicitly
let somePlanet = Planet.Earth
switch somePlanet {
case .Earth: print("Mostly harmless")
default: print("Not a safe place for humans") }

//:# Associated Values
//:set constant or variable to Planet.Earth, and check for this value later.
//:useful to be able to store associated values of other types alongside these member values.
//:enables to store additional custom info along with member value, and permits this info to vary each time you use that member in your code.
//:Can define enum to store associated values of any given type, and value types can be different for each member of enum if needed.
//:Example: Inventory tracking system needs to track products by two different types of barcode.
//:Some products labeled with 1D barcode in UPC-A format, uses numbers 0 to 9.
//:Each barcode has “number system” digit, followed by 5 “manufacturer code” digits and 5 “product code” digits.
//:These are followed by “check” digit to verify that code been scanned correctly
//:Other products labeled with 2D barcodes in QR code format, which can use any ISO 8859-1 character and can encode string up to 2,953 characters.
//:system  able to store UPC-A barcodes as tuple of four integers, and QR code barcodes as string of any length.
//:enum to define product barcodes of either type */
enum Barcode {
    case UPCA(Int, Int, Int, Int)
    case QRCode(String) }
/*:
* definition not provide any actual Int or String values.
* just defines type of associated values that Barcode constants and variables can store when they are equal to Barcode.UPCA or Barcode.QRCode.
* New barcodes can then be created using either type: */
var productBarcode = Barcode.UPCA(8, 85909, 51226, 3)
//:* Example creates new variable called productBarcode and assign value of Barcode.UPCA with an associated tuple value of (8, 85909, 51226, 3).
//:* Same product can assign different type of barcode */
productBarcode = .QRCode("ABCDEFGHIJKLMNOP")
//:Original Barcode.UPCA and its integer values are replaced by new Barcode.QRCode and its string value.
//:Constants and variables of type Barcode can store either .UPCA or .QRCode
//:They can only store one of them at any given time.
//:Different barcode types can be checked using switch statement.
//:associated values can be extracted as part of switch statement.
//:extract each associated value as constant (let) or variable (var) for use within switch case’s body: */
switch productBarcode {
case .UPCA(let numberSystem, let manufacturer, let product, let check): print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
case .QRCode(let productCode): print("QR code: \(productCode).") }
//: If all associated values for enum member are extracted as constants, all extracted as variables, you can place single var or let annotation before member name. */
switch productBarcode {
case let .UPCA(numberSystem, manufacturer, product, check): print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
case let .QRCode(productCode): print("QR code: \(productCode).") }

//:# Raw Values
//:example in Associated Values shows how enum members declare that they store associated values of different types.
//:As alternative to associated values, enum members can come prepopulated with default values (raw values), which are all of same type.
//:Example that stores raw ASCII values alongside named enumeration members */
enum ASCIIControlCharacter: Character {
case Tab = "\t"
case LineFeed = "\n"
case CarriageReturn = "\r" }
/*:
* raw values for enum defined to be of type Character, and set to some of more common ASCII control characters. 
* Raw values can be string, character, integer or floating-point number types.
* Each raw value must be unique within its enum declaration.
* Raw values are not same as associated values. 
* Raw values are set to prepopulated values when you first define enum, like 3 ASCII codes above.
* Raw value for particular enum member is always same.
* Associated values are set when you create new constant or variable based on one of enum members, and can be different each time you do so.

## Implicitly Assigned Raw Values
* When working with enum that store integer or string raw values, don’t have to explicitly assign raw value for each member.
* Swift automatically assign values for you.
* When integers are used for raw values, implicit value for each member is one more than previous member.
* If first member not have value set, it’s value is 0. */
enum MyPlanet: Int { case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune }
//: MyPlanet.Mercury has explicit raw value of 1, MyPlanet.Venus has implicit raw value of 2, and so on.
enum MyCompassPoint: String { case North, South, East, West }
//: MyCompassPoint.South has implicit raw value of "South", and so on.
//: access raw value of enum member with its rawValue property */
let earthsOrder = MyPlanet.Earth.rawValue
let sunsetDirection = MyCompassPoint.West.rawValue

//:## Initializing from Raw Value
//:If define enum with raw-value type, enum automatic receives initializer that takes value of raw value’s type (as parameter called rawValue) and returns either enum member or nil.
//:Can use this initializer to try to create a new instance of enum.
//:example identifies Uranus from its raw value of 7: */
let possiblePlanet = MyPlanet(rawValue: 7)
/*:
* Not all possible Int values will find matching planet, however. 
* Because of this, raw value initializer always returns optional enum member. 
* In example above, possiblePlanet is of type MyPlanet?, or “optional MyPlanet.”
* raw value initializer is failable initializer, because not every raw value will return enum member.
* try find planet with position of 9, optional MyPlanet value returned by raw value initializer will be nil */
let positionToFind = 9
if let somePlanet = MyPlanet(rawValue: positionToFind) {
switch somePlanet {
case .Earth: print("Mostly harmless")
default: print("Not a safe place for humans") }
} else { print("There isn't a planet at position \(positionToFind)")}
//:example uses optional binding to try to access planet with raw value of 9.
//:statement if let somePlanet = MyPlanet(rawValue: 9) creates optional MyPlanet, and sets somePlanet to value of that optional MyPlanet if it can be retrieved.
//:In this case, it is not possible to retrieve planet with position of 9, and so else branch is executed instead.

//:# Recursive Enumerations
//:Enum work well for modeling data when there is fixed number of possibilities that need to be considered, such as operations used for doing simple integer arithmetic.
//:These operations let you combine simple arithmetic expressions that are made up of integers such as 5 into more complex ones such as 5 + 4.
//:One important characteristic of arithmetic expressions is that they can be nested.
//:expression (5 + 4) * 2 has number on right hand side of multiplication and another expression on left hand side of multiplication.
//:Because data is nested, enum used to store data also needs to support nesting—this means enum needs to be recursive.
//:recursive enum is enum that has another instance of enum as associated value for one or more of enum members.
//:compiler has to insert layer of indirection when it works with recursive enum.
//: You indicate that enum member is recursive by writing indirect before it.
//: here is enum that stores simple arithmetic expressions. */
enum ArithmeticExpression {
    case Number(Int)
    indirect case Addition(ArithmeticExpression, ArithmeticExpression)
    indirect case Multiplication(ArithmeticExpression, ArithmeticExpression) }
//:can write indirect before beginning of enum, to enable indirection for all enum members that need it
indirect enum MyArithmeticExpression {
    case Number(Int)
    case Addition(MyArithmeticExpression, MyArithmeticExpression)
    case Multiplication(MyArithmeticExpression, MyArithmeticExpression) }
//:This enumn can store 3 kinds of arithmetic expressions: [1]plain number, [2] addition of two expressions, [3] multiplication of two expressions.
//:Addition and Multiplication members have associated values that are also arithmetic expressions.
//:these associated values make it possible to nest expressions.
//:recursive function is a straightforward way to work with data that has recursive structure.
//:here a function that evaluates an arithmetic expression: */
func evaluate(expression: ArithmeticExpression) -> Int {
    switch expression {
    case .Number(let value): return value
    case .Addition(let left, let right): return evaluate(left) + evaluate(right)
    case .Multiplication(let left, let right): return evaluate(left) * evaluate(right) } } // evaluate (5 + 4) * 2
let five = ArithmeticExpression.Number(5)
let four = ArithmeticExpression.Number(4)
let sum = ArithmeticExpression.Addition(five, four)
let product = ArithmeticExpression.Multiplication(sum, ArithmeticExpression.Number(2))
print(evaluate(product)) // prints "18"
//:* This function evaluates a plain number by simply returning associated value.
//:* It evaluates addition or multiplication by evaluating expression on left hand side, evaluating expression on right hand side, and then adding them or multiplying them
