/*:
# Initialization : process of preparing instance of class, struct or enumeration for use
* involves setting initial value for each stored property on that instance and performing any other setup or initialization that is required before new instance is ready for use.
* implement initialization by defining initializers, like special methods that can be called to create new instance of particular type
* initializers do not return value
* primary role is to ensure that new instances of type correctly initialized before they are used for first time
* class instances also implement deinitializer, which performs any custom cleanup just before class instance deallocated

## Setting Initial Values for Stored Properties
* Class and struct must set all of stored properties to appropriate initial value by time instance of that class or structure is created
* Stored properties cannot be left in indeterminate state
* set initial value for stored property within initializer, or by assign default property value as part of property definition
* When assign default value to stored property, or set its initial value within initializer, value of that property is set directly, without calling any property observers.

## Initializers
* called to create new instance of particular type
* In its simplest form, initializer is like instance method with no parameters, written using init keyword: */
struct Fahrenheit {
    var temperature: Double
    init() { temperature = 32.0 }
}
var f = Fahrenheit()
f.temperature

/*:
## Default Property Values
* can set initial value of stored property from within initializer, as shown above
* Alternatively, specify default property value as part of property declaration
* specify default property value by assigning initial value to property when defined
* If property always takes same initial value, provide default value rather than setting value within initializer
* end result is same, but default value ties property initialization more closely to its declaration
* It makes for shorter, cleaner initializers and enables to infer type of property from its default value
* default value also makes it easier to take advantage of default initializers and initializer inheritance */
struct NewFahrenheit { var temperature = 32.0 }
/*:
## Customizing Initialization
* customize initialization process with input parameters and optional property types, or by assigning constant properties during initialization.

## Initialization Parameters
* provide initialization parameters as part of initializer definition, to define types and names of values that customize initialization process
* Initialization parameters have same capabilities and syntax as function and method parameters */
struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {temperatureInCelsius = (fahrenheit - 32.0) / 1.8 }
    init(fromKelvin kelvin: Double) { temperatureInCelsius = kelvin - 273.15 } }
let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
/*:
* first initializer has single initialization parameter with external name of fromFahrenheit and local name of fahrenheit
* second initializer has single initialization parameter with external name of fromKelvin and local name of kelvin
* Both initializers convert their single argument into value in Celsius scale and store value in property called temperatureInCelsius.

## Local and External Parameter Names
* As with function and method parameters, initialization parameters can have both local name for use within initializer body and external name for use when calling the initializer.
* initializers not have identifying function name before their parentheses in way that functions and methods do
* names and types of initializer parameters play particularly important role in identify which initializer should called
* Swift provides automatic external name for every parameter in initializer if don’t provide external name yourself */
struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    init(white: Double) {
        red   = white
        green = white
        blue  = white }
}
//: Both initializers can used to create new Color instance, by providing named values for each initializer parameter
let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)
/*:
* not possible to call these initializers without using external parameter names
* External names must always be used in initializer if they defined, and omitting them is compile-time error
//let veryGreen = Color(0.0, 1.0, 0.0) //ERROR!

## Initializer Parameters Without External Names
* If not want use external name for initializer parameter, write underscore (_) instead of explicit external name for that parameter to override default behavior */
struct MyCelsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) { temperatureInCelsius = (fahrenheit - 32.0) / 1.8 }
    init(fromKelvin kelvin: Double) {temperatureInCelsius = kelvin - 273.15 }
    init(_ celsius: Double) {temperatureInCelsius = celsius }
}
let bodyTemperature = MyCelsius(37.0)

/*:
## Optional Property Types
* If custom type has stored property that logically allowed to have “no value” declare property with optional type
* Properties of optional type are automatically initialized with value of nil, indicating that property is deliberately intended to have “no value yet” during initialization */
class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String) { self.text = text }
    func ask() {print(text)}
}
let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
cheeseQuestion.response = "Yes, I do like cheese."
/*:
* response to survey question not known until it is asked, and so response property is declared with type of String?, or “optional String”. 
* It automatically assign default value of nil, meaning “no string yet”, when new instance of SurveyQuestion initialized

## Assigning Constant Properties During Initialization
* assign value to constant property at any point during initialization, as long as it is set to definite value by time initialization finishes
* Once constant property is assign value, it can’t be further modified.
* For class instances, constant property can only be modified during initialization by class that introduces it
* It cannot be modified by a subclass. */
class MySurveyQuestion {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
func ask() {
print(text) } }
let beetsQuestion = MySurveyQuestion(text: "How about beets?")
beetsQuestion.ask()
beetsQuestion.response = "I also like beets. (But not with cheese.)"
/*:
## Default Initializers
* Swift provides default initializer for any struct or class that provides default values for all of its properties and does not provide at least one initializer itself
* default initializer simply creates new instance with all of its properties set to their default values */
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()
/*:
* all properties of ShoppingListItem class have default values, and it is base class with no superclass, ShoppingListItem automatically gains default initializer implementation that creates new instance with all of its properties set to their default values
* example uses default initializer for ShoppingListItem class to create new instance of class with initializer syntax, written as ShoppingListItem(), and assign new instance to a variable called item.

## Memberwise Initializers for Structure Types
* Struct automatically receive memberwise initializer if not define any custom initializers
* Unlike default initializer, struct receives memberwise initializer even if it has stored properties not default values
* memberwise initializer is shorthand way to initialize member properties of new struct instances
* Initial values for properties of new instance can be passed to memberwise initializer by name */
struct Size { var width = 0.0, height = 0.0 }
let twoByTwo = Size(width: 2.0, height: 2.0)
/*:
## Initializer Delegation for Value Types
* Initializers can call other initializers to perform part of instance initialization
* This known as initializer delegation, avoids duplicating code across multiple initializers
* rules for how initializer delegation works, and for what forms of delegation are allowed, are different for value types and class types. 
* Value types (struct and enum) not support inheritance, and so their initializer delegation process is relatively simple, because they can only delegate to another initializer that they provide themselves. 
* Class can inherit from other class
* This means that class have additional responsibilities for ensuring that all stored properties they inherit are assigned a suitable value during initialization
* For value types, use self.init to refer to other initializers from same value type when writing custom initializers
* can only call self.init from within an initializer.
* if define custom initializer for value type, you will no longer have access to default initializer for that type
* This constraint prevents situation in which additional essential setup provided in more complex initializer is circumvented by someone accidentally using one of automatic initializers instead
* If want custom value type to be initializable with default initializer and memberwise initializer, and also with custom initializers, write custom initializers in extension rather than as part of value type original implementation */
struct MySize { var width = 0.0, height = 0.0 }
struct MyPoint { var x = 0.0, y = 0.0 }
//:* can initialize Rect struct below in one of three ways—by using its default zero-initialized origin and size property values, by providing a specific origin point and size, or by providing a specific center point and size
//:* These initialization options are represented by three custom initializers that are part of Rect struct definition: */
struct Rect {
    var origin = MyPoint()
    var size = MySize()
    init() {}
    init(origin: MyPoint, size: MySize) {
        self.origin = origin
        self.size = size
    }
    init(center: MyPoint, size: MySize) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: MyPoint(x: originX, y: originY), size: size) }
}
/*:
* init(), is functionally same as default initializer that struct would have received if it did not have its own custom initializers.
* This initializer has empty body, represented by empty pair of curly braces {}, and not perform any initialization
* Calling initializer return Rect instance whose origin and size properties are both initialized with default values of Point(x: 0.0, y: 0.0) and Size(width: 0.0, height: 0.0) from their property definitions: */
let basicRect = Rect()
/*:
* init(origin:size:), is functionally same as memberwise initializer that struct would have received if did not have own custom initializers
* simply assign origin and size argument values to appropriate stored properties */
let originRect = Rect(origin: MyPoint(x: 2.0, y: 2.0),
size: MySize(width: 5.0, height: 5.0))
/*:
* init(center:size:), is slightly more complex
* It starts by calculating appropriate origin point based on center point and size value
* call (delegate) to init(origin:size:) initializer, which stores new origin and size values in appropriate properties */
let centerRect = Rect(center: MyPoint(x: 4.0, y: 4.0),
size: MySize(width: 3.0, height: 3.0))
/*:
* init(center:size:) could have assign new values of origin and size to appropriate properties itself
* more convenient (and clearer in intent) for init(center:size:) initializer to take advantage of existing initializer that already provides exactly that functionality.
* alternativly to write without defining the init() and init(origin:size:) initializers yourself.

## Class Inheritance and Initialization
* All class’s stored properties—including any properties class inherits from its superclass—must be assigned an initial value during initialization.
* Swift defines two kinds of initializers for class types to help ensure all stored properties receive initial value.
* known as designated initializers and convenience initializers.

## Designated Initializers and Convenience Initializers
* Designated initializers are primary initializers for class
* fully initializes all properties introduced by that class and calls appropriate superclass initializer to continue initialization process up superclass chain
* Class tend to have very few designated initializers, and it is quite common for class to have only one
* Designated initializers are “funnel” points through which initialization takes place, and through which initialization process continues up superclass chain.
* Every class must have at least one designated initializer. 
* In some cases, this requirement is satisfied by inheriting one or more designated initializers from a superclass
* Convenience initializers are secondary, supporting initializers for class
* You can define convenience initializer to call designated initializer from same class as convenience initializer with some of designated initializer parameters set to default values
* also define convenience initializer to create instance of that class for specific use case or input value type
* not have to provide convenience initializers if your class not require them
* Create convenience initializers whenever shortcut to common initialization pattern will save time or make initialization of the class clearer in intent.

## Syntax for Designated and Convenience Initializers
* Designated initializers for classes are written in the same way as simple initializers for value types
* init(parameters) { statements }
* Convenience initializers written in same style, but with convenience modifier placed before init keyword
* convenience init(parameters) { statements}

## Initializer Delegation for Class Types
* simplify relationships between designated and convenience initializers, Swift applies following three rules for delegation calls between initializers:
* [1] designated initializer must call designated initializer from its immediate superclass
* [2] convenience initializer must call another initializer from same class
* [3] convenience initializer must ultimately call designated initializer

* simple way to remember this is:
* Designated initializers must always delegate up.
* Convenience initializers must always delegate across.

* superclass has single designated initializer and two convenience initializers. 
* One convenience initializer calls another convenience initializer, which in turn calls single designated initializer
* This satisfies rules 2 and 3 from above
* superclass not itself have further superclass, and so rule 1 does not apply
* subclass has two designated initializers and one convenience initializer
* convenience initializer must call one of two designated initializers, because it can only call another initializer from  same class
* This satisfies rules 2 and 3
* Both designated initializers must call single designated initializer from superclass, to satisfy rule 1
* rules don’t affect how users of your classes create instances of each class
* Any initializer can be used to create fully-initialized instance of class they belong to
* rules only affect how write class’s implementation

## Two-Phase Initialization
* Class initialization in Swift is a two-phase process
* first phase, each stored property is assigned initial value by class that introduced it. 
* Once initial state for every stored property has been determined, second phase begins, and each class is given opportunity to customize its stored properties further before new instance is considered ready for use
* use of two-phase initialization process makes initialization safe, while still giving complete flexibility to each class in class hierarchy
* Two-phase initialization prevents property values from being accessed before they are initialized, and prevents property values from being set to different value by another initializer unexpectedly.
* Swift’s initialization flow is more flexible in that it lets you set custom initial values, and can cope with types for which 0 or nil is not a valid default value
* Swift’s compiler performs 4 safety-checks to make sure that two-phase initialization is completed without error:

* Safety check 1 : designated initializer must ensure that all of properties introduced by its class are initialized before it delegates up to a superclass initializer. Memory for object is only considered fully initialized once initial state of all of its stored properties is known. In order for this rule to be satisfied, designated initializer must make sure that all its own properties are initialized before it hands off up the chain.
* Safety check 2 : designated initializer must delegate up to a superclass initializer before assigning a value to an inherited property. If it doesn’t, new value designated initializer assigns will be overwritten by the superclass as part of its own initialization.
* Safety check 3 : convenience initializer must delegate to another initializer before assign value to any property. If it doesn’t, new value convenience initializer assign will be overwritten by its own class’s designated initializer.
* Safety check 4 : initializer cannot call any instance methods, read values of any instance properties, or refer to self as a value until after first phase of initialization is complete. class instance is not fully valid until the first phase ends. Properties can only be accessed, and methods can only be called, once the class instance is known to be valid at the end of the first phase.
* here’s how two-phase initialization plays out, based on the four safety checks above:

* Phase 1 : designated or convenience initializer is called on class. Memory for a new instance of that class is allocated. The memory is not yet initialized. Designated initializer for that class confirms that all stored properties introduced by that class have a value. Memory for these stored properties is now initialized. Designated initializer hands off to a superclass initializer to perform same task for its own stored properties. This continues up the class inheritance chain until top of chain is reached. Once top of chain is reached, and final class in chain has ensured that all of its stored properties have a value, instance’s memory is considered to be fully initialized, and phase 1 is complete.

* Phase 2 : Working back down from top of chain, each designated initializer in chain has option to customize instance further. Initializers are now able to access self and can modify its properties, call its instance methods, and so on. Finally, any convenience initializers in chain have option to customize instance and to work with self. 

* In example, initialization begins with a call to a convenience initializer on the subclass. This convenience initializer cannot yet modify any properties. It delegates across to a designated initializer from the same class.
* designated initializer makes sure that all of the subclass’s properties have a value, as per safety check 1. It then calls a designated initializer on its superclass to continue the initialization up the chain.
* superclass’s designated initializer makes sure that all of the superclass properties have a value. There are no further superclasses to initialize, and so no further delegation is needed.
As soon as all properties of the superclass have an initial value, its memory is considered fully initialized, and Phase 1 is complete.

* superclass’s designated initializer now has an opportunity to customize the instance further.
* Once superclass designated initializer is finished, subclass designated initializer can perform additional customization.
* Finally, once subclass designated initializer is finished, convenience initializer that was originally called can perform additional customization.

## Initializer Inheritance and Overriding
* Swift subclasses not inherit their superclass initializers by default
* Swift approach prevents situation in which simple initializer from superclass is inherited by more specialized subclass and is used to create a new instance of the subclass that is not fully or correctly initialized.
* Superclass initializers are inherited in certain circumstances, but only when it is safe and appropriate to do so
* If you want custom subclass to present one or more of same initializers as its superclass, you can provide custom implementation of those initializers within subclass
* When you write subclass initializer that matches superclass designated initializer, you are effectively providing override of that designated initializer
* you must write override modifier before subclass initializer definition
* This is true even if you are overriding automatically provided default initializer
* As with overridden property, method or subscript, presence of override modifier prompts Swift to check that superclass has matching designated initializer to be overridden, and validates that parameters for overriding initializer have been specified as intended.
* You always write override modifier when overriding superclass designated initializer, even if subclass implementation of  initializer is convenience initializer
* Conversely, if you write subclass initializer that matches superclass convenience initializer, that superclass convenience initializer can never be called directly by your subclass, as per rules described above in Initializer Delegation for Class Types
* your subclass is not providing override of superclass initializer
* you not write override modifier when providing matching implementation of superclass convenience initializer */
class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)" } }
//:* Vehicle class provides default value for only stored property, and not provide any custom initializers itself
//:* it automatically receives default initializer
//:* default initializer is always a designated initializer for class, and can be used to create new Vehicle instance with numberOfWheels of 0: */
let vehicle = Vehicle()
vehicle.description

class Bicycle: Vehicle {
override init() {
super.init()
numberOfWheels = 2 } }
/*:
* Bicycle subclass defines custom designated initializer, init()
* This designated initializer matches designated initializer from superclass of Bicycle, and so Bicycle version of this initializer is marked with override modifier
* init() initializer for Bicycle starts by calling super.init(), which calls default initializer for Bicycle class superclass, Vehicle. 
* ensures numberOfWheels inherited property is initialized by Vehicle before Bicycle has opportunity to modify property. 
* After calling super.init(), the original value of numberOfWheels is replaced with a new value of 2.
* If you create instance of Bicycle, you can call its inherited description computed property to see how its numberOfWheels property has been updated: */
let bicycle = Bicycle()
bicycle.description
//:Subclasses can modify inherited variable properties during initialization, but not modify inherited constant properties.

/*:
## Automatic Initializer Inheritance
* subclass not inherit superclass initializer by default
* superclass initializer automatically inherited in certain conditions
* not need to write initializer override, and inherit superclass initializers with minimal effort
* Assume that you provide default values for any new properties you introduce in subclass, following two rules apply:
* [1] If subclass not define any designated initializer, it automatically inherit all superclass designated initializer
* [2] If subclass provides implementation of all superclass designated initializers it automatically inherits all  superclass convenience initializers.
* These rules apply even if your subclass adds further convenience initializers.
* subclass can implement superclass designated initializer as subclass convenience initializer as part of satisfy rule 2.

## Designated and Convenience Initializers in Action
* example shows designated initializers, convenience initializers, and automatic initializer inheritance in action
* example define hierarchy of 3 class called Food, RecipeIngredient, and ShoppingListItem, and demonstrates how their initializers interact.
* base class in hierarchy called Food, which is simple class to encapsulate name of foodstuff
* Food class introduces single String property called name and provides two initializers for creating Food instances: */
class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}
//: Class not have default memberwise initializer, and so Food class provides designated initializer that takes single argument called name
//: This initializer can be used to create new Food instance with specific name
let namedMeat = Food(name: "Bacon")
/*:
* init(name: String) provided as designated initializer, it ensures all stored properties of new Food instance are fully initialized
* Food class not have superclass, and so init(name: String) not need to call super.init() to complete its initialization.
* Food class provides convenience initializer, init(), with no arguments
* init() provides default placeholder name for new food by delegating across to Food class init(name: String) with name value of [Unnamed]: */
let mysteryMeat = Food()
//:* RecipeIngredient class models ingredient in cooking recipe
//:* It introduces Int property called quantity and defines two initializers for creating RecipeIngredient instances
class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name) }
    override convenience init(name: String) { self.init(name: name, quantity: 1) }
}
/*:
* init(name: String, quantity: Int) is designated initializer, used to populate new RecipeIngredient instance properties
* This initializer starts by assign passed quantity argument to quantity property, which is only new property introduced by RecipeIngredient
* initializer delegates up to init(name: String) initializer of Food class
* This process satisfies safety check 1 from Two-Phase Initialization above.
* init(name: String) is convenience initializer, used to create RecipeIngredient instance by name alone
* This assumes a quantity of 1 for any RecipeIngredient instance that is created without an explicit quantity
* definition of this convenience initializer makes RecipeIngredient instances quicker and more convenient to create, and avoids code duplication when creating several single-quantity RecipeIngredient instances
* This initializer simply delegates across to class designated initializer, passing in a quantity value of 1.
* init(name: String) convenience initializer provided by RecipeIngredient takes same parameters as init(name: String) designated initializer from Food. 
* this initializer overrides designated initializer from its superclass, it must be marked with override modifier
* Even though RecipeIngredient provides init(name: String) initializer as convenience initializer, RecipeIngredient has nonetheless provided implementation of all of its superclass’s designated initializers
* RecipeIngredient automatically inherits all of its superclass’s convenience initializers too.
* superclass for RecipeIngredient is Food, which has a single convenience initializer called init()
* This initializer is therefore inherited by RecipeIngredient
* inherited version of init() functions in exactly same way as Food version, except that it delegates to RecipeIngredient version of init(name: String) rather than Food version.
* All three of these initializers can be used to create new RecipeIngredient instances: */
let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)
//:* ShoppingListItem class models a recipe ingredient as it appears in a shopping list.
//:* Every item in shopping list starts out as “unpurchased”
//:* To represent this fact, ShoppingListItem introduces Boolean property called purchased, with a default value of false
//:* ShoppingListItem also adds computed description property, which provides textual description of ShoppingListItem instance
class MyShoppingListItem: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output }
}
//:* ShoppingListItem not define initializer to provide initial value for purchased, because items in shopping list always start out unpurchased
//:* it provides default value for all of properties it introduces and does not define any initializers itself, ShoppingListItem automatically inherits all of designated and convenience initializers from its superclass
var breakfastList = [
    MyShoppingListItem(),
    MyShoppingListItem(name: "Bacon"),
    MyShoppingListItem(name: "Eggs", quantity: 6),
]
breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
print(item.description) }
/*:
* Here, new array called breakfastList is created
* type of array is inferred to be [ShoppingListItem]
* After array is created, name of ShoppingListItem at start of array is changed from "[Unnamed]" to "Orange juice" and it is marked as having been purchased. 
* Printing description of each item in the array shows that their default states have been set as expected.

## Failable Initializers
* sometimes useful to define class, struct, or enum for which initialization can fail
* failure might be triggered by invalid initialization parameter values, absence of required external resource, or some other condition that prevents initialization from succeeding
* To cope with initialization conditions can fail, define failable initializers as part of class, struct, or enum
* write failable initializer by placing ? after init (init?)
* not define failable and nonfailable initializer with same parameter types and names
* failable initializer creates optional value of type it initializes
* write return nil within failable init to indicate point at which init failure can be triggered
* Strictly speaking, init not return value
* their role is to ensure self is fully and correctly initialized by time that init ends
* write return nil to trigger init failure, not use return to indicate init success
* example define struct Animal, with constant String property called species
* Animal defines failable init with single parameter called species
* This initializer checks if species value passed to init is empty string
* If empty string found, init failure triggered
* Otherwise, species property value is set, and initialization succeeds:  */
struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty { return nil }
        self.species = species }
}
//:* use failable init to try to initialize new Animal instance and check if initialization succeeded
let someCreature = Animal(species: "Giraffe")
if let giraffe = someCreature { print("An animal was initialized with a species of \(giraffe.species)") }
//:* If pass empty string to failable init species parameter, initializer triggers init failure
let anonymousCreature = Animal(species: "")

if anonymousCreature == nil { print("The anonymous creature could not be initialized") }
/*:
* Check for empty string is not same as checking for nil to indicate absence of optional String value
* In example above, empty string ("") is valid, non-optional String
* it is not appropriate for animal to have empty string as value of its species property
* To model restriction, failable init triggers initialization failure if an empty string is found.

## Failable Initializers for Enumerations
* use failable initr to select appropriate enumeration member based on one or more parameters
* initializer can then fail if provided parameters not match appropriate enumeration member
* example below defines enum TemperatureUnit, with three possible states (Kelvin, Celsius, and Fahrenheit)
* failable init used to find appropriate enum member for Character value representing a temperature symbol: */
enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K": self = .Kelvin
        case "C": self = .Celsius
        case "F": self = .Fahrenheit
        default: return nil } }
}
//:* use failable init to choose appropriate enum member for 3 possible states and to cause initialization to fail if  parameter not match one of these states
let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil { print("This is a defined temperature unit, so initialization succeeded.")}
let unknownUnit = TemperatureUnit(symbol: "X")
if unknownUnit == nil { print("This is not a defined temperature unit, so initialization failed.") }

//:## Failable Init for Enum with Raw Values
//:* Enum with raw values automatically receive failable initializer, init?(rawValue:), that takes parameter called rawValue of  appropriate raw-value type and selects matching enum member if one is found, or triggers init failure if no match
//:* rewrite TemperatureUnit to use raw values of type Character and take advantage of init?(rawValue:) initializer
enum MyTemperatureUnit: Character { case Kelvin = "K", Celsius = "C", Fahrenheit = "F" }
let myfahrenheitUnit = MyTemperatureUnit(rawValue: "F")
if fahrenheitUnit != nil { print("This is a defined temperature unit, so initialization succeeded.") }
let myunknownUnit = MyTemperatureUnit(rawValue: "X")
if myunknownUnit == nil { print("This is not a defined temperature unit, so initialization failed.") }

/*:
## Failable Init for Classes
* failable init for value type (struct or enum) can trigger init failure at any point within its initializer implementation
* Animal struct example, init triggers init failure at very start of its implementation, before species property set
* For classes, failable init can trigger init failure only after all stored properties introduced by class have been set to initial value and any initializer delegation has taken place.
* example shows how use implicitly unwrapped optional property to satisfy this requirement within failable class init */
class Product {
    let name: String!
    init?(name: String) {
        self.name = name
        if name.isEmpty { return nil } }
}
/*:
* Product class very similar to Animal struct
* Product class has constant name property that must not be allowed to take empty string value
* To enforce requirement, Product class uses failable init to ensure property value is non-empty before allowing initialization to succeed.
* Product is class, not struct
* unlike Animal, any failable init for Product must provide initial value for name property before trigger init failure
* name property of Product defined as having implicitly unwrapped optional string type (String!)
* means that name property has default value of nil before it is assigned specific value during initialization
* default value of nil in turn means that all of properties introduced by Product have valid initial value
* failable init for Product can trigger init failure at start of initializer if it is passed empty string, before assign specific value to name property within initializer
* name property is constant, it will always contain non-nil if initialization succeeds
* it is defined with implicitly unwrapped optional type, can always access implicitly unwrapped value with confidence, without needing to check for value of nil */
if let bowTie = Product(name: "bow tie") { print("The product's name is \(bowTie.name)") }

/*:
## Propagation of Init Failure
* failable init of class, struct, or enum can delegate across to another failable init from same class, struct, or enum
* subclass failable init can delegate up to superclass failable init
* if delegate to another init that causes initialization to fail, entire init process fails immediately, and no further initialization code is executed.
* failable init can delegate to nonfailable initializer
* Use this approach if need to add potential failure state to existing init process that not otherwise fail
* example defines subclass of Product called CartItem
* CartItem models item in online shopping cart
* CartItem introduces stored constant property called quantity and ensures this property always has value of at least 1 */
class CartItem: Product {
    let quantity: Int!
    init?(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
        if quantity < 1 { return nil } }
}
/*:
* quantity property has implicitly unwrapped integer type (Int!)
* As with name property of Product class, means that quantity property has default value of nil before it is assigned a specific value during initialization.
* failable init for CartItem starts by delegating up to init(name:) initializer from its superclass, Product
* This satisfy requirement that failable init must always perform init delegation before triggering init failure
* If superclass initialization fails because of empty name value, entire init process fails immediately and no further initialization code is executed
* If superclass initialization succeeds, CartItem initializer validates that it has received quantity value of 1 or more
* If create CartItem instance with non-empty name and quantity of 1 or more, initialization succeeds */
if let twoSocks = CartItem(name: "sock", quantity: 2) {
    print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)") }
//:* If try to create CartItem instance with quantity value of 0, CartItem initializer causes init to fail
if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
    print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")}
else { print("Unable to initialize zero shirts") }
//:* if try to create CartItem instance with empty name value, superclass Product initializer causes init to fail
if let oneUnnamed = CartItem(name: "", quantity: 1) {
    print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)") }
else { print("Unable to initialize one unnamed product") }
/*:
## Override Failable Init
* override superclass failable init in subclass, just like any other initializer
* can override superclass failable init with subclass non-failable initializer
* enables to define subclass for which init cannot fail, even though init of superclass is allowed to fail.
* if override failable superclass init with nonfailable subclass initializer, subclass initializer not delegate up to superclass initializer
* nonfailable initializer can never delegate to failable init
* can override failable init with nonfailable init but not other way around
* example defines class called Document
* class models document that can be initialized with name property that is either non-empty string value or nil, but not be  empty string: */
class Document {
    var name: String?
    init() {}
    init?(name: String) {
        self.name = name
        if name.isEmpty { return nil } }
}
/*:
* next example defines subclass of Document called AutomaticallyNamedDocument
* subclass overrides both of designated initializers introduced by Document
* These overrides ensure that AutomaticallyNamedDocument instance has initial name value of "[Untitled]" if instance is initialized without name, or if empty string is passed to init(name:) initializer */
class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]" }
    override init(name: String) {
        super.init()
        if name.isEmpty { self.name = "[Untitled]"
        }
        else { self.name = name } }
}
/*:
* AutomaticallyNamedDocument overrides superclass failable init?(name:) initializer with nonfailable init(name:) initializer
* AutomaticallyNamedDocument copes with empty string case in different way than its superclass, its initializer not need to fail, and so it provides a nonfailable version of the initializer instead.

## init! Failable Initializer
* typically define failable init that creates optional instance of appropriate type by (init?)
* can define failable init that creates implicitly unwrapped optional instance of appropriate type
* Do this by (init!) instead of a question mark.
* can delegate from init? to init! and vice versa, and can override init? with init! and vice versa
* can also delegate from init to init!, although doing so will trigger an assertion if init! initializer causes initialization to fail.

## Required Initializers
* Write required modifier before definition of class initializer to indicate that every subclass of class must implement that initializer */
class SomeClass {
    required init() { }
}
/*:
* must also write required before every subclass implementation of required initializer, to indicate that initializer requirement applies to further subclasses in chain
* not write override modifier when overriding a required designated initializer
* class SomeSubclass: SomeClass { required init() {}}
* not have to provide explicit implementation of required initializer if can satisfy requirement with inherited initializer

## Setting Default Property Value with a Closure or Function
* If stored property default value requires some customization or setup, use closure or global function to provide customized default value for that property
* Whenever new instance of type that property belongs to is initialized, closure or function is called, and its return value is assigned as property default value.
* These kinds of closures or functions typically create temporary value of same type as property, tailor that value to represent desired initial state, and return that temporary value to be used as property default value.
* skeleton outline of how a closure can be used to provide a default property value:
* class SomeClass1 { let someProperty: SomeType = { return someValue }() }
* closure end curly brace is followed by empty pair of parentheses
* This tells Swift to execute closure immediately
* If you omit these parentheses, you are trying to assign closure itself to property, and not return value of closure
* If use closure to initialize property, remember that rest of instance not yet initialized at point that closure executed
* This means that not access any other property values from within closure, even if properties have default values
* not use implicit self property, or call any of the instance’s methods.
* example defines struct called Checkerboard, which models board for  game of Checkers
* game of Checkers is played on a ten-by-ten board, with alternating black and white squares
* To represent game board, Checkerboard struct has single property called boardColors, which is array of 100 Bool values
* value of true in array represents black square and value of false represents white square
* first item in array represent top left square on board and last item in array represents bottom right square on board
* boardColors array is initialized with closure to set up its color values */
struct Checkerboard {
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...10 {
            for j in 1...10 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack }
            isBlack = !isBlack }
        return temporaryBoard }()
    func squareIsBlackAtRow(row: Int, column: Int) -> Bool {
        return boardColors[(row * 10) + column] }
}
//: Whenever new Checkerboard instance is created, closure is executed, and default value of boardColors is calculated and returned
//: closure in example calculates and sets appropriate color for each square on board in temporary array called temporaryBoard, and returns this temporary array as closure return value once its setup is complete
//: returned array value is stored in boardColors and can be queried with squareIsBlackAtRow utility function
let board = Checkerboard()
print(board.squareIsBlackAtRow(0, column: 1))
print(board.squareIsBlackAtRow(9, column: 9))