/*:
# Inheritance
* class can inherit methods, properties, and other characteristics from another class
* When one class inherits from another, inheriting class is known as subclass, and class it inherits from is superclass
* Inheritance is fundamental behavior that differentiates classes from other types
* Class can call and access methods, properties, and subscripts belonging to their superclass and can provide their own overriding versions of those methods, properties, and subscripts to refine or modify their behavior
* Swift helps to ensure overrides are correct by checking that override definition has matching superclass definition
* Class can also add property observers to inherited properties in order to be notified when value of property changes
* Property observers can be added to any property, regardless of whether it was originally defined as stored or computed.

## Defining Base Class
* Any class that does not inherit from another class is known as base class
* class not inherit from universal base class.
* Class you define without specifying superclass automatically become base classes for you to build upon */
class Vehicle {
    var currentSpeed = 0.0
    var description: String { return "traveling at \(currentSpeed) miles per hour" }
    func makeNoise() {}
}
//:* create new instance
let someVehicle = Vehicle()
//: access description property
someVehicle.description

//: ## Subclassing : act of basing new class on existing class
//:* subclass inherits characteristics from existing class, which you can then refine.
//:* also add new characteristics to subclass.
//:* indicate that subclass has superclass, write subclass name before superclass name, separated by colon
class Bicycle: Vehicle {
    var hasBasket = false
}
let bicycle = Bicycle()
bicycle.hasBasket = true

bicycle.currentSpeed = 15.0
bicycle.description

class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}

let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
tandem.description

/*:
## Overriding
* subclass can provide its own custom implementation of instance method, type method, instance property, type property, or subscript that it would otherwise inherit from superclass. This is known as overriding.
* To override characteristic that would otherwise be inherited, you prefix your overriding definition with override keyword
* Doing so clarifies that you intend to provide override and have not provided matching definition by mistake
* Overriding by accident can cause unexpected behavior, and any overrides without override keyword are diagnosed as error when code compiled.
* override keyword also prompts compiler to check that overriding class superclass has declaration that matches one you provided for override
* This check ensures that your overriding definition is correct.

## Accessing Superclass Methods, Properties, and Subscripts
* When you provide method, property, or subscript override for subclass, it is sometimes useful to use existing superclass implementation as part of your override
* you can refine behavior of that existing implementation, or store modified value in existing inherited variable.
* Where this is appropriate, you access superclass version of method, property, or subscript by using super prefix:
* overridden method named someMethod() can call superclass version of someMethod() by calling super.someMethod() within overriding method implementation
* overridden property called someProperty can access superclass version of someProperty as super.someProperty within overriding getter or setter implementation.
* overridden subscript for someIndex can access superclass version of same subscript as super[someIndex] from within overriding subscript implementation

## Overriding Methods
* override inherited instance or type method to provide tailored or alternative implementation of method within subclass */
class Train: Vehicle {
    override func makeNoise() { print("Choo Choo")}
}

let train = Train()
train.makeNoise()

/*:
## Overriding Properties
* override inherited instance or type property to provide own custom getter and setter for that property, or to add property observers to enable overriding property to observe when the underlying property value changes.

## Overriding Property Getters and Setters
* provide custom getter (and setter, if appropriate) to override any inherited property, regardless of whether inherited property is implemented as stored or computed property at source
* stored or computed nature of inherited property is not known by subclass—it only knows that inherited property has certain name and type
* always state both name and type of property you are overriding, to enable compiler to check that override match superclass property with same name and type.
* present inherited read-only property as read-write property by providing both getter and setter in subclass property override
* You cannot, however, present an inherited read-write property as a read-only property.
* If provide setter as part of property override, must also provide getter for that override
* If don’t want to modify inherited property value within overriding getter, can simply pass through inherited value by returning super.someProperty from getter, where someProperty is name of property you are overriding */
class Car: Vehicle {
    var gear = 1
    override var description: String { return super.description + " in gear \(gear)" }
}
//: override of description property starts by calling super.description, which return Vehicle class description property

let car = Car()
car.currentSpeed = 25.0
car.gear = 3
car.description

/*:
## Overriding Property Observers
* use property overriding to add property observers to inherited property
* enables to be notified when value of inherited property changes, regardless of how property was originally implemented
* cannot add property observers to inherited constant stored properties or inherited read-only computed properties
* value of these properties cannot be set, and so it is not appropriate to provide willSet or didSet implementation as part of an override.
* cannot provide both overriding setter and overriding property observer for same property
* to observe changes to property value, and already providing custom setter for that property, simply observe any value changes from within custom setter.*/
class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet { gear = Int(currentSpeed / 10.0) + 1}
    }
}
//:Whenever you set currentSpeed property of AutomaticCar instance, didSet observer sets instance’s gear property to appropriate choice of gear for new speed
let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
automatic.description

/*:
## Preventing Overrides
* prevent method, property, or subscript from being overridden by marking it as final
* Do this by writing final modifier before method, property, or subscript’s introducer keyword
* such as final var, final func, final class func, and final subscript
* Any attempt to override final method, property, or subscript in subclass is reported as compile-time error
* Methods, properties, or subscripts that you add to a class in an extension can also be marked as final
* mark entire class as final by writing final modifier before class keyword in its class definition (final class)
* Any attempt to subclass a final class is reported as a compile-time error. */