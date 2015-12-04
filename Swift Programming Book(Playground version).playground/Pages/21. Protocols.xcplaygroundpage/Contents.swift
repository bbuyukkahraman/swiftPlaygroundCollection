/*:
# Protocol : blueprint for method/property that suit particular task
* adopted by class/struct/enum


## Syntax */
protocol SomeProtocol { }
protocol AnotherProtocol { }
struct SomeStructure: SomeProtocol, AnotherProtocol {}
class SomeSuperclass {}
class SomeClass: SomeSuperclass, SomeProtocol, AnotherProtocol {}
/*:

=====================================
## Protocol Property
* protocol provide instance property or type property
* protocol not specify property should be stored property or computed property
* protocol specify for each property gettable or gettable and settable
* Property declared as variable properties, with var keyword */
protocol SomeProtocol1 {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}
//: for prefix type property use static keyword
//: type property can be prefixed with class or static keyword when implemented by class
protocol AnotherProtocol1 {
    static var someTypeProperty: Int { get set }
}
//: protocol with single instance property
protocol FullyNamed {
    var fullName: String { get }
}

//: struct adopts and conforms to FullyNamed protocol
struct Person: FullyNamed {
    var fullName: String
}
let john = Person(fullName: "John Appleseed")
john.fullName

//:* Swift reports error at compile-time if protocol requirement is not fulfilled
//: complex class, which adopts and conform (uymak) to FullyNamed protocol
class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String { return (prefix != nil ? prefix! + " " : "") + name }
}
var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
ncc1701.fullName

/*:
=====================================
## Method
* Protocol can require instance method and type method
* methods written as part of protocol, but without {} or method body
* always prefix type method requirements with static keyword when they are defined in protocol
* even though type method requirements are prefixed with class or static keyword when implemented by class */

protocol SomeProtocol2 {
    static func someTypeMethod()
}

//: protocol with single instance method requirement
protocol RandomNumberGenerator {
    func random() -> Double
}
//:* protocol not make any assumptions about how each random number will be generated
//:* simply provide standard way to generate new random number
class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double { lastRandom = ((lastRandom * a + c) % m) ;  return lastRandom / m }
}
let generator = LinearCongruentialGenerator()
generator.random()
generator.random()

/*:
## Mutating Method
* methods on value types (struct and enum) place mutating keyword before method func keyword to indicate that method is allowed to modify instance it belongs to and/or any properties of that instance
* mutating enables struct and enum to adopt protocol and satisfy that method requirement
* not need to write mutating keyword when writing implementation of that method for class
* mutating keyword is only used by struct and enum */
protocol Togglable {
    mutating func toggle()
}
//:* struct/enum can conform protocol by providing implementation toggle() method that is marked as mutating.
enum OnOffSwitch: Togglable {
    case Off, On
    mutating func toggle() {
        switch self {
        case Off:  self = On
        case On:   self = Off
        }
    }
}
var lightSwitch = OnOffSwitch.Off
lightSwitch.toggle()
lightSwitch

/*:
## Initializer
* Protocols can require specific initializers to be implemented by conforming types
* write initializers same way as for normal initializers, but without {} or initializer body */
protocol SomeProtocol3 {
    init(someParameter: Int)
}

/*:
## Class Implementations of Protocol Initializer
* conforming class as either designated initializer or convenience initializer
* mark initializer implementation with required modifier */

class SomeClass3: SomeProtocol3 {
     required init(someParameter: Int) { /*initializer implementation*/ }
}

/*:
* required modifier ensures that provide explicit or inherited implementation of initializer requirement on all subclasses of conforming class, such that they also conform to protocol
* not need to mark protocol initializer implementations with required modifier on classes that are marked with final modifier, because final classes cannot be subclassed
* If subclass overrides designated initializer from superclass, and also implements matching initializer requirement from protocol, mark initializer implementation with both required and override modifiers */
protocol SomeProtocol4 { init() }
class SomeSuperClass {
    init() { /* initializer implementation*/ }
}
class SomeSubClass: SomeSuperClass, SomeProtocol {
    /*"required" from SomeProtocol conformance; "override" from SomeSuperClass*/
    required override init() { /*initializer implementation*/ }
}

/*:
## Failable Initializer Requirements
* failable initializer requirement can be satisfied by failable or nonfailable initializer on a conforming type
* nonfailable initializer requirement can be satisfied by nonfailable initializer or implicitly unwrapped failable initializer


## Protocols as Types
* Protocols not implement any functionality themselves
* any protocol you create will become fully-fledged type for use in code
* it is a type, can use protocol in many places where other types are allowed, including:
* As parameter type or return type in function, method, or initializer
* As type of constant, variable, or property
* As type of items in array, dictionary, or other container
* Because protocols are types, begin their names with capital letter to match names of other types
* example of protocol used as type */
class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int { return Int(generator.random() * Double(sides)) + 1 }
}
/*:
* example define new class called Dice, which represents n-sided dice for use in board game
* Dice instances have integer property called sides, which represents how many sides they have
* and property called generator, which provides random number generator from which to create dice roll values
* generator property is of type RandomNumberGenerator
* Therefore, you can set it to instance of any type that adopts RandomNumberGenerator protocol
* Nothing else is required of instance you assign to this property, except that instance must adopt RandomNumberGenerator protocol
* Dice also has initializer, to set up its initial state
* This initializer has parameter called generator, which is also of type RandomNumberGenerator
* You can pass value of any conforming type in to this parameter when initializing new Dice instance
* Dice provides one instance method, roll, which returns integer value between 1 and number of sides on dice
* This method calls generator random() method to create new random number between 0.0 and 1.0
* and uses this random number to create a dice roll value within correct range
* Because generator is known to adopt RandomNumberGenerator, it is guaranteed to have random() method to call.
* Here how Dice class can be used to create 6-sided dice with LinearCongruentialGenerator instance as its random number generator */
var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}

/*:
# Delegation: design pattern 
* enables class or struct to hand off (or delegate) some of its responsibilities to instance of another type
* implemented by defining protocol that encapsulates delegated responsibilities
* conforming type (known as delegate) is guaranteed to provide functionality that has been delegated
* used to respond to particular action, or retrieve data from external source without needing to know underlying type of that source */
protocol DiceGame {
    var dice: Dice { get }
    func play()
}
protocol DiceGameDelegate {
    func gameDidStart(game: DiceGame)
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(game: DiceGame)
}
/*:
* can be adopted by any game that involves dice
* DiceGameDelegate protocol can be adopted by any type to track progress of DiceGame
* version of Snakes and Ladders game originally introduced in Control Flow
* adapted to use Dice instance for its dice-rolls;
* to adopt DiceGame protocol; and to notify DiceGameDelegate about its progress */
class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init() {
        board = [Int](count: finalSquare + 1, repeatedValue: 0)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare: break gameLoop
            case let newSquare where newSquare > finalSquare: continue gameLoop
            default: square += diceRoll
            square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}
/*:
* This version of game is wrapped up as class called SnakesAndLadders, which adopts DiceGame protocol
* It provides gettable dice property and play() method in order to conform to protocol
* dice property is declared as constant property because it does not need to change after initialization, and protocol only requires that it is gettable
* game board setup takes place within class init() initializer
* All game logic is moved into protocol play method, which uses protocol’s required dice property to provide its dice roll values
* delegate property is defined as optional DiceGameDelegate, delegate isn’t required in order to play game
* Because it is of optional type, delegate property is automatically set to initial value of nil
* Thereafter, game instantiator has option to set property to suitable delegate
* DiceGameDelegate provides 3 methods for tracking progress of game
* These 3 methods have been incorporated into game logic within play() method, and are called when new game starts, new turn begins, or game ends
* Because delegate property is optional DiceGameDelegate, play() method uses optional chaining each time it calls a method on delegate
* If delegate property nil, these delegate calls fail gracefully and without error
* If delegate property non-nil, delegate methods are called, and passed SnakesAndLadders instance as parameter
* next example shows a class called DiceGameTracker, which adopts DiceGameDelegate protocol */
class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        ++numberOfTurns
        print("Rolled a \(diceRoll)")
    }
    func gameDidEnd(game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}
/*:
* DiceGameTracker implements all 3 methods required by DiceGameDelegate
* It uses these methods to keep track of number of turns game has taken
* It resets numberOfTurns property to zero when game starts
* increments it each time new turn begins
* prints out total number of turns once the game has ended
* implementation of gameDidStart uses game parameter to print some introductory information about game that is about to be played
* game parameter has type of DiceGame, not SnakesAndLadders, and so gameDidStart can access and use only methods and properties that are implemented as part of DiceGame protocol
* However, method is still able to use type casting to query type of underlying instance
* In this example, it checks whether game is actually instance of SnakesAndLadders behind scenes, and prints appropriate message if so
* gameDidStart also accesses dice property of passed game parameter
* Because game is known to conform to DiceGame protocol, it is guaranteed to have dice property, and so gameDidStart(_:) method is able to access and print dice sides property, regardless of what kind of game is being played
* Here how DiceGameTracker looks in action */
let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()

/*:
## Add Protocol Conformance with Extension
* can extend existing type to adopt and conform to new protocol, even if do not have access to source code
* can add new property/method/subscript to existing type, and able to add requirement that protocol may demand
* Existing instances of type automatically adopt and conform to protocol when that conformance is added to instance’s type in an extension
* this protocol can be implemented by any type that has way to be represented as text
* This might be a description of itself, or a text version of its current state */

protocol TextRepresentable { func asText() -> String }
//: Dice class from earlier can be extended to adopt and conform to TextRepresentable:
extension Dice: TextRepresentable { func asText() -> String { return "A \(sides)-sided dice" }}
/*:
* adopts new protocol in exactly same way as if Dice had provided it in its original implementation
* protocol name is provided after type name, separated by (:), and implementation of all requirements of protocol is provided within extension’s curly braces.
* Any Dice instance can now be treated as TextRepresentable */
let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
print(d12.asText())
//:SnakesAndLadders game class can be extended to adopt and conform to TextRepresentable protocol
extension SnakesAndLadders: TextRepresentable {
    func asText() -> String { return "A game of Snakes and Ladders with \(finalSquare) squares" }
}
game.asText()

/*:
## Declaring Protocol Adoption with an Extension
* If type already conforms to all of requirements of protocol, but has not yet stated that it adopts that protocol, you can make it adopt protocol with empty extension */
struct Hamster {
    var name: String
    func asText() -> String { return "A hamster named \(name)" }
}
extension Hamster: TextRepresentable {}
//:Instances of Hamster can now be used wherever TextRepresentable is required type
let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
somethingTextRepresentable.asText()
//: Types do not automatically adopt protocol just by satisfying its requirements
//: They must always explicitly declare their adoption of protocol.

/*:
## Collections of Protocol Types
* protocol can used as type to stored in collection such as array/dictionary, as mentioned in Protocols as Types
* example creates array of TextRepresentable things:*/
let things: [TextRepresentable] = [game, d12, simonTheHamster]
//: now possible to iterate over items in array, and print each item’s textual representation
for thing in things { print(thing.asText()) }

//:* thing constant is of type TextRepresentable.
//:* not of type Dice, or DiceGame, or Hamster, even if actual instance behind scenes is of one of those types
//:* Nonetheless, because it is of type TextRepresentable, and anything that is TextRepresentable is known to have an asText() method, it is safe to call thing.asText each time through loop

//:## Protocol Inheritance
//: protocol can inherit one or more other protocols and can add further requirements on top of requirements it inherits
//: protocol inheritance syntax similar class inheritance, but with option to list multiple inherited protocols, separated by (,)
protocol InheritingProtocol: SomeProtocol, AnotherProtocol { /*protocol definition here*/}
//: example of a protocol that inherits the TextRepresentable protocol from above:
protocol PrettyTextRepresentable: TextRepresentable { func asPrettyText() -> String }

/*:
* example define new protocol, which inherits from TextRepresentable
* Anything that adopts PrettyTextRepresentable must satisfy all of requirements enforced by TextRepresentable, plus additional requirements enforced by PrettyTextRepresentable. 
* PrettyTextRepresentable adds single requirement to provide an instance method called asPrettyText that returns a String.
* SnakesAndLadders class can be extended to adopt and conform to PrettyTextRepresentable */
extension SnakesAndLadders: PrettyTextRepresentable {
    func asPrettyText() -> String {
        var output = asText() + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0: output += "▲ "
            case let snake where snake < 0: output += "▼ "
            default: output += "○ "
            }
        }
        return output
    }
}
/*:
* extension states that it adopts PrettyTextRepresentable protocol and provides implementation of asPrettyText() method for SnakesAndLadders type
* Anything that is PrettyTextRepresentable must also be TextRepresentable, and so asPrettyText implementation starts by calling asText() method from TextRepresentable protocol to begin an output string. 
* It appends colon and line break, and uses this as start of its pretty text representation
* It then iterates through array of board squares, and appends geometric shape to represent contents of each square
* If square value is greater than 0, it is base of a ladder, and is represented by ▲
* If square value is less than 0, it is head of a snake, and is represented by ▼
* Otherwise, square’s value is 0, and it is a “free” square, represented by ○
* method implementation can now be used to print a pretty text description of any SnakesAndLadders instance */
game.asPrettyText()

/*:
## Class-Only Protocols
* You can limit protocol adoption to class types (not struct or enum) by adding class keyword to a protocol’s inheritance list.
* class keyword must always appear first in a protocol’s inheritance list, before any inherited protocols */
//protocol SomeClassOnlyProtocol: class, SomeInheritedProtocol { /*class-only protocol definition*/}

/*:
* In example above, SomeClassOnlyProtocol can only be adopted by class types
* It is compile-time error to write struct or enum definition that tries to adopt SomeClassOnlyProtocol
* Use class-only protocol when behavior defined by that protocol’s requirements assumes or requires that a conforming type has reference semantics rather than value semantics

## Protocol Composition
* It can be useful to require a type to conform to multiple protocols at once. 
* You can combine multiple protocols into a single requirement with a protocol composition. 
* Protocol compositions have form protocol<SomeProtocol, AnotherProtocol>.
* You can list as many protocols within pair of angle brackets (<>) as you need, separated by (,)
* Here example that combines two protocols called Named and Aged into a single protocol composition requirement on a function parameter */
/*
protocol Named { var name: String { get } }
protocol Aged { var age: Int { get } }
struct Person: Named, Aged {
    var name: String
    var age: Int
}
func wishHappyBirthday(celebrator: protocol<Named, Aged>) {
    print("Happy birthday \(celebrator.name) - you're \(celebrator.age)!")
}
let birthdayPerson = Person(name: "Malcolm", age: 21)
wishHappyBirthday(birthdayPerson)
*/
/*:
* example defines a protocol called Named, with a single requirement for a gettable String property called name.
* It also defines a protocol called Aged, with a single requirement for a gettable Int property called age. 
* Both of these protocols are adopted by a structure called Person.
* example also defines a function called wishHappyBirthday, which takes a single parameter called celebrator. 
* type of this parameter is protocol<Named, Aged>, which means “any type that conforms to both Named and Aged protocols.” 
* It doesn’t matter what specific type is passed to the function, as long as it conforms to both of required protocols.
* example then creates new Person instance called birthdayPerson and passes this new instance to  wishHappyBirthday(_:) function. 
* Because Person conforms to both protocols, this is a valid call, and the wishHappyBirthday(_:) function is able to print its birthday greeting.
* Protocol compositions do not define new, permanent protocol type. 
* Rather, they define a temporary local protocol that has the combined requirements of all protocols in composition.

## Checking for Protocol Conformance
* can use "is" and "as" operators described in Type Casting to check for protocol conformance, and to cast to a specific protocol
* Checking for and casting to protocol follows exactly same syntax as checking for and casting to type
* "is" operator returns true if instance conforms to a protocol and returns false if it does not.
* "as?" version of downcast operator returns optional value of protocol’s type, and this value is nil if instance does not conform to that protocol.
* "as!" version of downcast operator forces downcast to protocol type and triggers runtime error if downcast does not succeed.
* example defines protocol called HasArea, with single property requirement of gettable Double property called area */
protocol HasArea { var area: Double { get } }
//: Here are two classes, Circle and Country, both of which conform to the HasArea protocol
class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) { self.radius = radius }
}
class Country: HasArea {
    var area: Double
    init(area: Double) { self.area = area }
}
//: Circle class implements area property requirement as computed property, based on stored radius property
//: Country class implements area requirement directly as stored property
//: Both classes correctly conform to HasArea protocol
//: Here class called Animal, which does not conform to the HasArea protocol */
class Animal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}
//: Circle, Country and Animal classes not have shared base class
//: they are all classes, and so instances of all three types can be used to initialize an array that stores values of type AnyObject
let objects: [AnyObject] = [ Circle(radius: 2.0), Country(area: 243_610), Animal(legs: 4) ]
/*:
* objects array is initialized with array literal containing Circle instance with radius of 2 units; Country instance initialized with surface area of UK in square km; and Animal instance with 4legs
* objects array can now be iterated, and each object in array can be checked to see if it conforms to HasArea protocol */
for object in objects {
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    } else {
        print("Something that doesn't have an area")
    }
}
/*:
* Whenever object in array conforms to HasArea protocol, optional value returned by "as?" operator is unwrapped with optional binding into a constant called objectWithArea.
* objectWithArea constant is known to be of type HasArea, and so its area property can be accessed and printed in a type-safe way.
* underlying objects are not changed by the casting process.
* They continue to be a Circle, a Country and an Animal. 
* However, at point that they are stored in objectWithArea constant, they are only known to be of type HasArea, and so only their area property can be accessed */

/*:
## Optional Protocol Requirements
* You can define optional requirements for protocols, These requirements do not have to be implemented by types that conform to the protocol. 
* Optional requirements are prefixed by the optional modifier as part of the protocol’s definition.
* An optional protocol requirement can be called with optional chaining, to account for the possibility that the requirement was not implemented by a type that conforms to the protocol. 
* You check for an implementation of an optional requirement by writing a question mark after the name of the requirement when it is called, such as someOptionalMethod?(someArgument). 
* Optional property requirements, and optional method requirements that return a value, will always return an optional value of the appropriate type when they are accessed or called, to reflect the fact that the optional requirement may not have been implemented.
* Optional protocol requirements can only be specified if your protocol is marked with the @objc attribute.
* This attribute indicates that the protocol should be exposed to Objective-C code and is described in Using Swift with Cocoa and Objective-C. 
* Even if you are not interoperating with Objective-C, you need to mark your protocols with the @objc attribute if you want to specify optional requirements.
* @objc protocols can be adopted only by classes that inherit from Objective-C classes or other @objc classes. 
* They can’t be adopted by structures or enumerations.
* following example defines an integer-counting class called Counter, which uses an external data source to provide its increment amount
* This data source is defined by the CounterDataSource protocol, which has two optional requirements*/
/*
@objc protocol CounterDataSource {
    optional func incrementForCount(count: Int) -> Int
    optional var fixedIncrement: Int { get }
}
*/
/*:
* CounterDataSource protocol defines an optional method requirement called incrementForCount and an optional property requirement called fixedIncrement. 
*These requirements define two different ways for data sources to provide an appropriate increment amount for a Counter instance.
* Strictly speaking, you can write a custom class that conforms to CounterDataSource without implementing either protocol requirement. 
* They are both optional, after all. 
* Although technically allowed, this wouldn’t make for a very good data source.
* Counter class, defined below, has an optional dataSource property of type CounterDataSource?: */
/*
class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.incrementForCount?(count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}
*/
/*:
* Counter class stores its current value in a variable property called count
* Counter class also defines a method called increment, which increments count property every time method is called.
* increment() method first tries to retrieve an increment amount by looking for an implementation of incrementForCount(_:) method on its data source. 
* increment() method uses optional chaining to try to call incrementForCount(_:), and passes the current count value as the method’s single argument.
* Note two levels of optional chaining at play here. 
* Firstly, it is possible that dataSource may be nil, and so dataSource has a question mark after its name to indicate that incrementForCount should only be called if dataSource is non-nil.
* Secondly, even if dataSource does exist, there is no guarantee that it implements incrementForCount, because it is an optional requirement. 
* This is why incrementForCount is also written with a question mark after its name.
* Because call to incrementForCount can fail for either of these two reasons, the call returns an optional Int value. 
* This is true even though incrementForCount is defined as returning a non-optional Int value in the definition of CounterDataSource.
* After calling incrementForCount, the optional Int that it returns is unwrapped into a constant called amount, using optional binding. 
* If optional Int does contain a value—that is, if the delegate and method both exist, and the method returned a value—the unwrapped amount is added onto the stored count property, and incrementation is complete.
* If it is not possible to retrieve a value from the incrementForCount(_:) method—either because dataSource is nil, or because the data source does not implement incrementForCount—then the increment() method tries to retrieve a value from the data source’s fixedIncrement property instead. 
* fixedIncrement property is also an optional requirement, and so its name is also written using optional chaining with a question mark on the end, to indicate that the attempt to access the property’s value can fail. 
* As before, returned value is an optional Int value, even though fixedIncrement is defined as a non-optional Int property as part of CounterDataSource protocol definition.
* Here’s a simple CounterDataSource implementation where the data source returns a constant value of 3 every time it is queried
* It does this by implementing the optional fixedIncrement property requirement:
class ThreeSource: NSObject, CounterDataSource { let fixedIncrement = 3 }
You can use an instance of ThreeSource as the data source for a new Counter instance: */
/*
var counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1...4 { counter.increment()
    print(counter.count)
}
*/
/*:
* code above creates a new Counter instance; sets its data source to be a new ThreeSource instance; and calls counter’s increment() method four times. 
* As expected, the counter’s count property increases by three each time increment() is called.
* Here’s a more complex data source called TowardsZeroSource, which makes a Counter instance count up or down towards zero from its current count value */
/*
@objc class TowardsZeroSource: NSObject, CounterDataSource {
func incrementForCount(count: Int) -> Int {
    if count == 0 {return 0 } else if count < 0 { return 1} else { return -1}}
}
*/
/*:
* TowardsZeroSource class implements optional incrementForCount(_:) method from CounterDataSource protocol and uses count argument value to work out which direction to count in.
* If count is already zero, method returns 0 to indicate that no further counting should take place.
* You can use an instance of TowardsZeroSource with existing Counter instance to count from -4 to zero. 
* Once counter reaches zero, no more counting takes place: */
/*
counter.count = -4
counter.dataSource = TowardsZeroSource()
for _ in 1...5 { counter.increment()
print(counter.count) }
*/
/*:
## Protocol Extensions
* Protocols can be extended to provide method and property implementations to conforming types. 
* This allows you to define behavior on protocols themselves, rather than in each type’s individual conformance or in a global function.
* For example, the RandomNumberGenerator protocol can be extended to provide a randomBool() method, which uses  result of the required random() method to return a random Bool value */
extension RandomNumberGenerator { func randomBool() -> Bool { return random() > 0.5 } }
//: By creating extension on protocol, all conforming types automatically gain this method implementation without any additional modification.
/*
let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
print("And here's a random Boolean: \(generator.randomBool())")
*/
/*:
## Providing Default Implementations
* use protocol extensions to provide default implementation to any method or property requirement of that protocol
* If conforming type provides its own implementation of required method or property, that implementation will be used instead of one provided by extension
* Protocol requirements with default implementations provided by extensions are distinct from optional protocol requirements. 
* Although conforming types don’t have to provide own implementation of either, requirements with default implementations can be called without optional chaining.
* PrettyTextRepresentable protocol, inherits TextRepresentable protocol can provide default implementation of its required asPrettyText() method to simply return the result of the asText() method */
extension PrettyTextRepresentable  {
    func asPrettyText() -> String {return asText() } }
/*:
## Adding Constraints to Protocol Extensions
* When you define protocol extension, you can specify constraints that conforming types must satisfy before  methods and properties of extension are available.
* You write these constraints after name of the protocol you’re extending using a where clause, as described in Where Clauses.
* you can define an extension to the CollectionType protocol that applies to any collection whose elements conform to the TextRepresentable protocol from example above. */
/*
extension CollectionType where Generator.Element : TextRepresentable {
    func asList() -> String { let itemsAsText = self.map {$0.asText()}
return "(" + ", ".join(itemsAsText) + ")" } }
*/
//: asList() takes textual representation of each element in the collection and concatenates them into a comma-separated list.
//: Consider Hamster structure from before, which conforms to the TextRepresentable protocol, and an array of Hamster values:
let murrayTheHamster = Hamster(name: "Murray")
let morganTheHamster = Hamster(name: "Morgan")
let mauriceTheHamster = Hamster(name: "Maurice")
let hamsters = [murrayTheHamster, morganTheHamster, mauriceTheHamster]
//: Because Array conforms to CollectionType, and the array’s elements conform to the TextRepresentable protocol, the array can use the asList() method to get a textual representation of its contents:

//print(hamsters.asList())

//: If a conforming type satisfies the requirements for multiple constrained extensions that provide implementations for the same method or property, Swift will use implementation corresponding to the most specialized constraints