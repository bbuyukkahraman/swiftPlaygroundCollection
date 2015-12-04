/*:
# Automatic Reference Counting
* to track and manage app memory usage
* not need to think about memory management
* ARC automatically frees up memory used by class instances when those instances are no longer needed
* in few cases ARC requires more info about relationships between parts of code in order to manage memory
* Reference counting only applies to instances of classes
* Struct and enume are value types, not reference types, and not stored and passed by reference

## How ARC Works
* Every time create new class instance, ARC allocates chunk of memory to store info about instance
* This memory holds info about instance type, together with values of any stored properties associated with instance
* when instance is no longer needed, ARC frees up memory so that memory can be used for other purposes
* This ensures that class instances not take up space in memory when they no needed
* if ARC were to deallocate instance that was still in use, it would no longer be possible to access instance properties, or call instance methods
* if you tried to access instance, app would most likely crash
* To make sure instances don’t disappear while they are still needed, ARC tracks how many properties, constants, and variables are currently referring to each class instance
* ARC will not deallocate instance as long as at least one active reference to that instance still exists
* to make this possible, whenever assign class instance to property, constant, or variable, that property, constant, or variable makes strong reference to instance
* reference is called “strong“ reference because it keeps firm hold on that instance, and not allow it to be deallocated for as long as that strong reference remains.

## ARC in Action
* example starts with simple class called Person, which defines a stored constant property called name: */
class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized") }
    deinit { print("\(name) is being deinitialized") }
}
/*:
* class has initializer that sets instance name property and prints message to indicate that initialization is underway
* class also has deinitializer that prints message when instance of class is deallocated
* 3 variables of type Person?, which are used to set up multiple references to new Person instance in subsequent code snippets
* these variables are of optional type (Person?, not Person), they automatically initialized with value of nil, and not currently reference Person instance. */
var reference1: Person?
var reference2: Person?
var reference3: Person?
//:* now create new Person instance and assign it to one of these three variables: */
reference1 = Person(name: "John Appleseed")

/*:
* message "John Appleseed is being initialized" is printed at point that call Person class initializer
* This confirms that initialization has taken place.
* new Person instance has been assign to reference1 var, there is now strong reference from reference1 to new instance
* there is at least one strong reference, ARC makes sure that this Person is kept in memory and is not deallocated.
* If assign same Person instance to two more variables, two more strong references to that instance are established: */
reference2 = reference1
reference3 = reference1
//:* There are now 3 strong references to this single Person instance
//:* If break two of these strong references (including original reference) by assigning nil to two of variables, single strong reference remains, and Person instance not deallocated
reference1 = nil
reference2 = nil
//:* ARC not deallocate Person instance until 3rd and final strong reference is broken, at which point it is clear that you are no longer using Person instance
reference3 = nil
/*:
## Strong Reference Cycles Between Class Instances
* In examples above, ARC is able to track number of references to new Person instance create and to deallocate that Person instance when it is no longer needed
* possible to write code in which instance of class never gets to point where it has zero strong references
* This can happen if two class instances hold strong reference to each other, such that each instance keeps other alive
* This known as strong reference cycle
* resolve strong reference cycles by defining some relationships between classes as weak or unowned references instead of as strong references
* This process is described in Resolving Strong Reference Cycles Between Class Instances
* before learn how to resolve strong reference cycle, useful to understand how such cycle is caused
* example of how strong reference cycle can be created by accident
* example defines two classes called Person and Apartment, which model block of apartments and its residents */
class MyPerson {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    var tenant: Person?
    deinit { print("Apartment \(unit) is being deinitialized") }
}
/*:
* Every Person instance has name property of type String and optional apartment property that is initially nil
* apartment property optional, because person may not always have apartment
* every Apartment instance has unit property of type String and has optional tenant property that is initially nil
* tenant property is optional because apartment may not always have tenant
* Both of these classes also define deinitializer, which prints fact that instance of class is being deinitialized
* This enables to see whether instances of Person and Apartment are being deallocated as expected.
* next code defines two vars of optional type, which will be set to a specific Apartment and Person instance below
* both of these variables have initial value of nil, by virtue of being optional */
var john: MyPerson?
var unit4A: Apartment?
//:* now create specific Person instance and Apartment instance and assign these new instances to john and unit4A
john = MyPerson(name: "John Appleseed")
unit4A = Apartment(unit: "4A")
//:* how strong references look after creating and assign these two instances
//:* john has strong reference to new Person instance, and unit4A variable has strong reference to new Apartment instance
//:* link two instances together so person has apartment, and apartment has tenant
//:* (!) used to unwrap and access instances stored inside john and unit4A optional variables, properties of those instances can be set
john!.apartment = unit4A
//unit4A!.tenant = john
/*:
* how strong references look after link two instances together:
* linking two instances creates strong reference cycle between them
* Person instance has strong reference to Apartment instance & Apartment instance has strong reference to Person instance
* when break strong references held by john and unit4A variables, reference counts not drop to zero, and instances not deallocated by ARC */
john = nil
unit4A = nil
/*:
* neither deinitializer was called when set these two variables to nil
* strong reference cycle prevents Person and Apartment instances from ever being deallocated, causing memory leak in app
* how strong references look after you set john and unit4A variables to nil:
* strong references between Person instance and Apartment instance remain and cannot be broken.

## Resolving Strong Reference Cycles Between Class Instances
* 2 ways to resolve strong reference cycle when work with properties of class type: weak references and unowned references.
* Weak and unowned references enable one instance in reference cycle to refer to other instance without keeping strong hold on it
* instances can then refer to each other without creating strong reference cycle.
* Use weak reference whenever it is valid for that reference to become nil at some point during its lifetime
* use unowned reference when you know that the reference will never be nil once it has been set during initialization.

## Weak References : not keep strong hold on instance it refers to, and not stop ARC from disposing of referenced instance
* this prevents reference from becoming part of strong reference cycle
* indicate weak reference by placing weak keyword before property or variable declaration
* Use weak reference to avoid reference cycles whenever possible for that reference to have “no value” at some point in life
* If reference will always have value, use unowned reference
* In Apartment example above, appropriate for apartment to be able to have “no tenant” at some point in its lifetime, and so weak reference is appropriate way to break reference cycle in this case
* Weak references must be declared as variables, to indicate that their value can change at runtime
* weak reference cannot be declared as constant
* weak references are allowed to have “no value”, declare every weak reference as having optional type
* Optional types are preferred way to represent possibility for “no value”
* weak reference not keep strong hold on instance it refers to, possible for that instance to be deallocated while weak reference is still referring to it
* ARC automatically sets weak reference to nil when instance that it refers to is deallocated
* check for existence of value in weak reference, just like any other optional value, and you will never end up with reference to invalid instance that no longer exists
* example below is identical to Person and Apartment example from above, with one important difference
* This time around, Apartment type’s tenant property is declared as a weak reference: */
class NewPerson {
    let name: String
    init(name: String) { self.name = name }
    var apartment: NewApartment?
    deinit { print("\(name) is being deinitialized") }
}

class NewApartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    weak var tenant: NewPerson?
    deinit { print("Apartment \(unit) is being deinitialized") }
}
//:* strong references from two var (john and unit4A) and links between two instances are created as before
var john1: NewPerson?
var unit4A1: NewApartment?

john1 = NewPerson(name: "John Appleseed")
unit4A1 = NewApartment(unit: "4A")

john1!.apartment = unit4A1
unit4A1!.tenant = john1
/*:
* how references look now that you’ve linked two instances together:
* Person instance still has strong reference to Apartment instance
* Apartment instance now has weak reference to Person instance
* means that when break strong reference held by john variables, there are no more strong references to Person instance:
* there are no more strong references to Person instance, it is deallocated: */
john = nil
/*:
* only remaining strong reference to Apartment instance is from unit4A variable
* If break that strong reference, there are no more strong references to Apartment instance:
* Because there are no more strong references to Apartment instance, it too is deallocated: */
unit4A = nil
/*:
* final two code above show deinitializers for Person instance and Apartment instance print their “deinitialized” messages after john and unit4A variables are set to nil
* This proves that reference cycle has been broken.


## Unowned References: not keep strong hold on instance it refers to
* unowned reference is assumed to always have a value
* unowned reference is always defined as non-optional type
* indicate unowned reference by placing unowned keyword before property or variable declaration
* unowned reference is non-optional, don’t need to unwrap unowned reference each time it is used
* unowned reference can always be accessed directly
* ARC cannot set reference to nil when instance it refers to is deallocated, because variables of non-optional type not be set to nil
* If try to access unowned reference after instance that it references is deallocated, will trigger runtime error
* Use unowned references only when sure that reference will always refer to instance
* Swift guarantees app will crash if try to access unowned reference after instance it references is deallocated
* You will never encounter unexpected behavior in this situation
* app will always crash reliably, although you should, of course, prevent it from doing so.
* example defines two classes, Customer and CreditCard, which model bank customer and possible credit card for customer
* These two classes each store instance of other class as property
* This relationship has potential to create strong reference cycle
* relationship between Customer and CreditCard is slightly different from relationship between Apartment and Person seen in weak reference example above
* In this data model, customer may or may not have credit card, but credit card will always be associated with customer
* To represent this, Customer class has optional card property, but CreditCard class has non-optional customer property
* new CreditCard instance can only be created by passing number value and customer instance to custom CreditCard initializer
* This ensures that CreditCard instance always has customer instance associated with it when CreditCard instance is created
* Because credit card always have customer, define customer property as unowned reference, to avoid strong reference cycle*/
class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) { self.name = name }
    deinit { print("\(name) is being deinitialized") }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { print("Card #\(number) is being deinitialized") }
}
/*:
* number property of CreditCard class is defined with type of UInt64 rather than Int, to ensure that number property capacity is large enough to store 16-digit card number on both 32-bit and 64-bit systems
* next code defines optional Customer variable called john, which will be used to store reference to specific customer
* This variable has initial value of nil, by virtue of being optional */
var john2: Customer?
//:* create Customer instance, and use it to initialize and assign new CreditCard instance as customer card property
john2 = Customer(name: "John Appleseed")
john2!.card = CreditCard(number: 1234_5678_9012_3456, customer: john2!)
/*:
* how references look, now that you’ve linked two instances:
* Customer instance now has strong reference to CreditCard instance, and CreditCard instance has unowned reference to Customer instance.
* Because of unowned customer reference, when break strong reference held by john variable, there are no more strong references to Customer instance:
* Because there are no more strong references to Customer instance, it is deallocated
* After this happens, there are no more strong references to CreditCard instance, and it too is deallocated */
john2 = nil
/*:
* final code above shows that deinitializers for Customer instance and CreditCard instance both print their “deinitialized” messages after john variable is set to nil.

## Unowned References and Implicitly Unwrapped Optional Properties
* examples for weak and unowned references above cover two of more common scenarios in which it is necessary to break strong reference cycle
* Person and Apartment shows situation where two properties, both of which are allowed to be nil, have potential to cause strong reference cycle
* This scenario is best resolved with weak reference
* Customer and CreditCard example shows situation where one property that is allowed to be nil and another property that cannot be nil have potential to cause strong reference cycle
* This scenario is best resolved with an unowned reference.
* there is 3rd scenario, in which both properties should always have value, and neither property should ever be nil once initialization is complete
* In this scenario, useful to combine unowned property on one class with implicitly unwrapped optional property on other class.
* This enables both properties to be accessed directly (without optional unwrapping) once initialization is complete, while still avoiding reference cycle
* This section shows you how to set up such a relationship.
* example below defines two classes, Country and City, each of which stores instance of other class as property
* In this data model, every country must always have capital city, and every city must always belong to country
* To represent this, Country class has capitalCity property, and City class has country property */
class Country {
    let name: String
    var capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self) }
}

class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country }
}
/*:
* To set up interdependency between two classes, initializer for City takes Country instance, and stores this instance in its country property.
* initializer for City is called from within initializer for Country
* initializer for Country cannot pass self to City initializer until new Country instance is fully initialized
* declare capitalCity property of Country as implicitly unwrapped optional property, indicated by (!) at end of its type annotation (City!)
* This means that capitalCity property has default value of nil, like any other optional, but can be accessed without need to unwrap its value as described in Implicitly Unwrapped Optionals.
* capitalCity has default nil value, new Country instance is considered fully initialized as soon as Country instance sets its name property within its initializer
* Country initializer can start to reference and pass around implicit self property as soon as name property is set
* Country initializer can therefore pass self as one of parameters for City initializer when Country initializer is setting its own capitalCity property.
* All of this means that you can create Country and City instances in single statement, without creating strong reference cycle, and capitalCity property can be accessed directly, without needing to use (!) to unwrap its optional value */
var country = Country(name: "Canada", capitalName: "Ottawa")
print("\(country.name)'s capital city is called \(country.capitalCity.name)")
/*:
* example above, use of implicitly unwrapped optional means that all of two-phase class initializer requirement satisfied
* capitalCity property can be used and accessed like non-optional value once initialization is complete, while still avoiding a strong reference cycle

## Strong Reference Cycles for Closures
* above how strong reference cycle can be created when two class instance properties hold strong reference to each other
* You also saw how to use weak and unowned references to break these strong reference cycles.
* strong reference cycle can also occur if assign closure to property of class instance & closure body captures instance
* This capture might occur because closure body accesses property of instance, such as self.someProperty, or because closure calls method on instance, such as self.someMethod()
* In either case, these accesses cause closure to “capture” self, creating strong reference cycle.
* strong reference cycle occurs because closures, like classes, are reference types
* When assign closure to property, assigning a reference to that closure
* In essence, it’s same problem as above—two strong references are keeping each other alive. 
* rather than two class instances, this time it’s a class instance and a closure that are keeping each other alive.
* Swift provides elegant solution to problem, known as closure capture list
* before learn how to break strong reference cycle with closure capture list, useful to understand how such cycle can be caused.
* example below shows how can create strong reference cycle when using closure that references self
* example defines class called HTMLElement, which provides simple model for individual element within HTML document */
class HTMLElement {
    let name: String
    let text: String?
    lazy var asHTML: Void -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />" } }
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text }
    deinit { print("\(name) is being deinitialized") }
}
/*:
* HTMLElement class defines name property, which indicates name of element, such as "p" for paragraph element, or "br" for a line break element
* HTMLElement defines optional text property, which can set to string that represents text to be rendered within HTML element.
* HTMLElement defines lazy property called asHTML
* This property references closure that combines name and text into HTML string fragment
* asHTML property is of type () -> String, or “a function that takes no parameters, and returns a String value”.
* By default, asHTML property is assigned closure that return string representation of HTML tag
* This tag contains optional text value if exists, or no text content if does not exist
* For paragraph element, closure return "<p>some text</p>" or "<p />", depending on text property equals "some text" or nil.
* asHTML property is named and used somewhat like instance method
* asHTML is closure property rather than instance method, can replace default value of asHTML property with custom closure, if want to change HTML rendering for particular HTML element
* asHTML property declared as lazy property, because only needed if and when element actually needs to be rendered as string value for some HTML output target
* fact that asHTML is lazy property means that can refer to self within default closure, because lazy property not accessed until after initialization has been completed and self is known to exist.
* HTMLElement provides single initializer, takes name argument and (if desired) text argument to initialize new element
* class also defines deinitializer, which prints message to show when HTMLElement instance is deallocated
* Here how use HTMLElement class to create and print new instance */
var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())
/*:
* paragraph variable above is defined as optional HTMLElement, so that it can be set to nil below to demonstrate presence of a strong reference cycle.
* HTMLElement creates strong reference cycle between HTMLElement instance and closure used for its default asHTML value
* Here how cycle looks:
* instance asHTML property holds strong reference to its closure
* because closure refers to self within its body (as a way to reference self.name and self.text), closure captures self, which means that it holds strong reference back to HTMLElement instance
* strong reference cycle is created between two
* Even though closure refers to self multiple times, it only captures one strong reference to HTMLElement instance
* If set paragraph variable to nil and break its strong reference to HTMLElement instance, neither HTMLElement instance nor its closure are deallocated, because of strong reference cycle */
paragraph = nil
/*:
* message in HTMLElement deinitializer not printed, which shows that HTMLElement instance is not deallocated.

## Resolving Strong Reference Cycles for Closures
* resolve strong reference cycle between closure and class instance by defining capture list as part of closure definition
* capture list defines rules to use when capturing one or more reference types within closure body
* As with strong reference cycles between two class instances, declare each captured reference to be weak or unowned reference rather than strong reference
* appropriate choice of weak or unowned depends on relationships between different parts of code
* Swift requires to write self.someProperty or self.someMethod() whenever you refer to member of self within closure
* This helps remember that it’s possible to capture self by accident.

## Define Capture List
* Each item in capture list is pairing of weak or unowned keyword with reference to class instance (such as self) or a variable initialized with some value (such as delegate = self.delegate!)
* These pairings are written within pair of square braces, separated by commas
* Place capture list before closure parameter list and return type if they provided */
/*
lazy var someClosure: (Int, String) -> String = {  
[unowned self, weak delegate = self.delegate!] (index: Int, stringToProcess: String) -> String in
// closure body goes here
}
*/
//:* If closure not specify parameter list or return type because they can be inferred from context, place capture list at very start of closure, followed by in keyword
/*
lazy var someClosure: Void -> String = {
[unowned self, weak delegate = self.delegate!] in  // closure body goes here
}
*/

//: ## Weak and Unowned References
/*:
* Define capture in closure as unowned reference when closure and instance it captures will always refer to each other, and will always be deallocated at the same time.
* define capture as weak reference when captured reference may become nil at some point in future
* Weak references always of optional type, and automatically become nil when instance they reference is deallocated
* This enables you to check for their existence within closure body
* If captured reference never become nil, it should always be captured as unowned reference, rather than weak reference
* unowned reference is appropriate capture method to use to resolve strong reference cycle in HTMLElement example
* Here’s how you write HTMLElement class to avoid the cycle */

class HTMLElement1 {
    let name: String
    let text: String?
    lazy var asHTML: Void -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />" } }
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    deinit { print("\(name) is being deinitialized")}
}

/*:
* HTMLElement implementation identical previous implementation, apart from addition of capture list within asHTML closure.
* In this case, capture list is [unowned self], means “capture self as unowned reference rather than strong reference”
* can create and print HTMLElement instance as before */
//var paragraph: HTMLElement1? = HTMLElement1(name: "p", text: "hello, world")
//print(paragraph!.asHTML())
/*:
* Here how references look with capture list in place:
* This time, capture of self by closure is unowned reference, and not keep strong hold on HTMLElement instance it has captured
* If set strong reference from paragraph variable to nil, HTMLElement instance is deallocated, as can be seen from printing of its deinitializer message in example below */
paragraph = nil