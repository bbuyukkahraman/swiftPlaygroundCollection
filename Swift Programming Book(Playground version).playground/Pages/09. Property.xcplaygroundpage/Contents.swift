/*:
# Properties : associate values with particular class, struct, or enum.
* Stored properties store let and var values as part of instance
* computed properties calculate value.
* Computed properties provided by class, struct and enum.
* Stored properties provided only by class and struct.
* Stored and computed properties usually associated with instance of particular type.
* properties can be associated with type itself.
* Such properties are known as type properties.
* define property observers to monitor changes in property, which respond to with custom actions.
* Property observers can be added to stored properties you define yourself, and also to properties that subclass inherits from its superclass.

## Stored Properties
* stored property is let or var that stored as part of instance of particular class or struct.
* can provide value for stored property as part of its definition, as described in Default Property Values.
* can also set and modify initial value for stored property during initialization.
* It is true even for let stored properties, as described in Assign Constant Properties During Initialization */
struct FixedLengthRange { var firstValue: Int ; let length: Int }
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
rangeOfThreeItems.firstValue = 6

//:## Stored Properties of Constant Structure Instances
//:* If you create instance of struct and assign instance to constant, cannot modify instance’s properties, even if they were declared as variable properties */
let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
//rangeOfFourItems.firstValue = 6  //ERROR!
/*:
* same is not true for class, which are reference types.
* If you assign instance of reference type to constant, you can still change that instance’s variable properties.

## Lazy Stored Properties : initial value not calculated until first use
* declare lazy property as variable
* useful when initial value for property is dependent on outside factors
* useful when initial value for property requires complex or computationally expensive setup */
class DataImporter {
    var fileName = "data.txt"
}
class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
}
let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
manager.importer.fileName

/*:
## Stored Properties and Instance Variables
* Swift property not have corresponding instance variable, and backing store for property not access directly.
* This avoids confusion about how value is accessed in different contexts and simplifies property’s declaration
* All info about property—including its name, type, and memory management characteristics—is defined in single location as part of type’s definition.

## Computed Properties
* class, struct, and enum can define computed properties, which not actually store value. 
* Instead, they provide getter and optional setter to retrieve and set other properties and values indirectly. */
struct Point { var x = 0.0, y = 0.0 }
struct Size { var width = 0.0, height = 0.0 }
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2) }}}
var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
square.origin.x
square.origin.y

//:## Shorthand Setter Declaration
//:* If computed property setter not define name for new value to be set, default name of newValue is used
//:* alternative version of Rect struct, which takes advantage of this shorthand notation */
struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2) }}}
/*:
## Read-Only Computed Properties
* computed property with getter but no setter known as a read-only computed property
* read-only computed property returns value, and accessed through dot syntax, but not set different value.
* declare computed properties—including read-only computed properties—as variable properties with var
* let used for constant properties, to indicate that values not changed once set as part instance initialization.
* simplify declaration of read-only computed property by removing get and its braces */
struct Cuboid {
var width = 0.0, height = 0.0, depth = 0.0
var volume: Double {
return width * height * depth } }
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
fourByFiveByTwo.volume

/*:
## Property Observers
* observe and respond changes in property’s value
* called every time property value is set, even if new value is same as current value.
* add property observers to any stored properties, apart from lazy stored properties.
* add property observers to any inherited property (whether stored or computed) by overriding property
* don’t need to define property observers for non-overridden computed properties
* You have option to define either or both of these observers on a property:
* willSet is called before value is stored.
* didSet is called after new value is stored.
* If implement willSet, it passed new value as constant parameter
* specify name for this parameter as part of your willSet implementation
* If choose not to write parameter name and parentheses in implementation, parameter will still be made available with default parameter name of newValue.
* if implement didSet, it passed constant parameter containing old property value
* name parameter if wish, or use default parameter name of oldValue.
* willSet and didSet of superclass properties are called when property set in subclass initializer.*/
class StepCounter {
var totalSteps: Int = 0 {
willSet(newTotalSteps) { print("About to set totalSteps to \(newTotalSteps)")}
didSet {if totalSteps > oldValue  {
print("Added \(totalSteps - oldValue) steps") } } } }
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
stepCounter.totalSteps = 360
stepCounter.totalSteps = 896

/*:
## Global and Local Variables
* Global variables are variables that are defined outside of any function, method, closure, or type context
* Local variables are variables that are defined within function, method, or closure context.
* global and local variables have all been stored variables
* Stored variables, like stored properties, provide storage for value of certain type and allow value to set and retrieved.
* also define computed variables and define observers for stored variables, in global or local scope
* Computed variables calculate rather than store value, and are written in same way as computed properties.
* Global constants and variables always computed lazily, in similar manner to Lazy Stored Properties
* global constants and variables not need to be marked with lazy modifier.
* Local constants and variables are never computed lazily.

## Type Properties
* Instance properties are properties that belong to instance of particular type. 
* new instance of that type, it has its own set of property values, separate from any other instance.
* also define properties that belong to type itself, not to any one instance of that type. 
* There will only ever be one copy of these properties, no matter how many instances of that type you create. 
* These kinds of properties are called type properties.
* Type properties useful for defining values that are universal to all instances of a particular type, such as a constant property that all instances can use, or variable property that stores value that is global to all instances of that type.
* Stored type properties can be variables or constants. 
* Computed type properties always declared as variable properties, in same way as computed instance properties.
* Unlike stored instance properties, always give stored type properties default value
* because type itself not have initializer that can assign value to stored type property at initialization time.

## Type Property Syntax
* In Swift, type properties written as part of type definition, within type outer curly braces, and each type property is explicitly scoped to type it supports.
* define type properties with static keyword
* For computed type properties for class types, use class keyword instead to allow subclasses to override */
struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {return 1 }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {return 6 }
}
class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {return 27 }
class var overrideableComputedTypeProperty: Int {return 107 }
}
//:## Querying and Setting Type Properties
//:* Type properties are queried and set with dot syntax, just like instance properties
//:* type properties are queried and set on type, not on instance of that type */
SomeStructure.storedTypeProperty
SomeStructure.storedTypeProperty = "Another value."
SomeStructure.storedTypeProperty
SomeEnumeration.computedTypeProperty
SomeClass.computedTypeProperty

struct AudioChannel {
static let thresholdLevel = 10
static var maxInputLevelForAllChannels = 0
var currentLevel: Int = 0 {
didSet { if currentLevel > AudioChannel.thresholdLevel {
currentLevel = AudioChannel.thresholdLevel }
if currentLevel > AudioChannel.maxInputLevelForAllChannels {
AudioChannel.maxInputLevelForAllChannels = currentLevel } } }}

var leftChannel = AudioChannel()
var rightChannel = AudioChannel()
leftChannel.currentLevel = 7
leftChannel.currentLevel
AudioChannel.maxInputLevelForAllChannels

rightChannel.currentLevel = 11
rightChannel.currentLevel
AudioChannel.maxInputLevelForAllChannels