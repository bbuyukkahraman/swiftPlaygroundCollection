/*:
# Methods : functions that associated with particular type
* Class, struct, and enum can all define instance methods, which encapsulate specific tasks and functionality
* Class, struct, and enum can also define type methods, which associated with type itself
* you can choose to define class, struct, or enum, and still have flexibility to define methods on type you create.

## Instance Methods : functions that belong to instances of a particular class, struct, or enum.
* support functionality of those instances, either by providing ways to access and modify instance properties, or by providing functionality related to instance’s purpose
* Instance methods have exactly same syntax as functions, as described in Functions.
* instance method has implicit access to all other instance methods and properties of that type. 
* instance method can be called only on specific instance of type it belongs to
* not be called in isolation without an existing instance. */
class Counter {
    var count = 0
    func increment() { ++count }
    func incrementBy(amount: Int) { count += amount }
    func reset() {  count = 0 }
}
let counter = Counter()
counter.increment()
counter.incrementBy(5)
counter.reset()

/*:
## Local and External Parameter Names for Methods
* Function parameters can have both local name and external name, as described in Specifying External Parameter Names
* same is true for method parameters, because methods are just functions that are associated with a type.
* Swift gives first parameter name in method Local parameter name by default, and gives second and subsequent parameter names both local and external parameter names by default */
class MyCounter {
    var count: Int = 0
    func incrementBy(amount: Int, numberOfTimes: Int) {
        count += amount * numberOfTimes }}
//:* By default, Swift treats amount as local name only, but treats numberOfTimes as both Local and external name */
let mycounter = MyCounter()
mycounter.incrementBy(5, numberOfTimes: 3)

/*:
## Modifying External Parameter Name Behavior for Methods
* useful to provide external parameter name for method first parameter, even not default behavior
* To do so, you can add explicit external name yourself.
* if you not want to provide external name for second or subsequent parameter of method, override default behavior by using underscore character (_) as explicit external parameter name for that parameter.

## self Property
* Every instance of type has implicit property called self
* self is exactly equivalent to instance itself
* use self property to refer to current instance within its own instance methods. */
//    func increment() { self.count++ }

struct Point { var x = 0.0, y = 0.0
func isToTheRightOfX(x: Double) -> Bool { return self.x > x }
}
let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOfX(1.0) { print("This point is to the right of the line where x == 1.0") }
/*:
Without self prefix, Swift would assume that both uses of x referred to the method parameter called x.

## Modifying Value Types from Within Instance Methods
* Struct and enum value types. By default, properties of value type cannot be modified from within its instance methods.
* if need to modify properties of struct or enum within particular method, can opt in to mutating behavior for that method
* method can then mutate its properties from within method, and any changes that it makes are written back to original struct when method ends
* method can also assign completely new instance to its implicit self property, and this new instance will replace existing one when the method ends.
* can opt in to this behavior by placing mutating keyword before func keyword for that method: */
struct MyPoint { var x = 0.0, y = 0.0
mutating func moveByX(deltaX: Double, y deltaY: Double) {
    x += deltaX ; y += deltaY } }
var mysomePoint = MyPoint(x: 1.0, y: 1.0)
mysomePoint.moveByX(2.0, y: 3.0)
mysomePoint.x
mysomePoint.y

let fixedPoint = MyPoint(x: 3.0, y: 3.0)
//fixedPoint.moveByX(2.0, y: 3.0) //ERROR

//:## Assign to self Within a Mutating Method
//:* mutating methods can assign entirely new instance to implicit self property */
struct NewPoint {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        self = NewPoint(x: x + deltaX, y: y + deltaY)}}

enum TriStateSwitch {
case Off, Low, High
mutating func next() {
switch self {
case Off: self = Low
case Low: self = High
case High: self = Off } } }
var ovenLight = TriStateSwitch.Low
ovenLight.next()
ovenLight.next()

/*:
## Type Methods
* Instance methods, that are called on an instance of a particular type
* also define methods that are called on type itself
* You indicate type methods by writing keyword static before method func keyword
* Classes may also use class keyword to allow subclasses to override superclass implementation of that method.
* define type-level methods for all class, struct, and enum. 
* Each type method is explicitly scoped to type it supports.
* Type methods are called with dot syntax, like instance methods. 
* call type methods on type, not on instance of that type */
class SomeClass {
class func someTypeMethod() { } }
SomeClass.someTypeMethod()
/*:
* type method can call another type method with the other method’s name, without needing to prefix it with type name
* Similarly, type methods on structures and enumerations can access type properties by using the type property’s name without a type name prefix. */
struct LevelTracker {
static var highestUnlockedLevel = 1
static func unlockLevel(level: Int) {
if level > highestUnlockedLevel { highestUnlockedLevel = level } }
static func levelIsUnlocked(level: Int) -> Bool { return level <= highestUnlockedLevel }
var currentLevel = 1
mutating func advanceToLevel(level: Int) -> Bool {
if LevelTracker.levelIsUnlocked(level) { currentLevel = level
return true } else { return false } } }

class Player {
var tracker = LevelTracker()
let playerName: String
func completedLevel(level: Int) {
LevelTracker.unlockLevel(level + 1)
tracker.advanceToLevel(level + 1) }
init(name: String) { playerName = name } }

var player = Player(name: "Argyrios")
player.completedLevel(1)
LevelTracker.highestUnlockedLevel

player = Player(name: "Beto")
if player.tracker.advanceToLevel(6) { print("player is now on level 6")
} else { print("level 6 has not yet been unlocked")}