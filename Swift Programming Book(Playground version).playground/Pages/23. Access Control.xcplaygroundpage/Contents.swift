/*:
# Access Control : restricts access to parts of code from code in other source files and modules
* enables to hide implementation details and to specify preferred interface through which that code can be accessed and used
* assign specific access levels to individual types (Class/Struct/Enum), to properties, methods, initializers, and subscripts
* Protocols can be restricted to certain context, as can global constants, variables, and functions
* Swift reduces need to specify explicit access control levels by providing default access levels for typical scenarios.
* if you writing single-target app, not need to specify explicit access control levels at all.
* various aspects of code that can have access control applied to them (properties, types, functions, and so on) are referred to as “entities”


## Modules and Source Files : access control model is based on concept of modules and source files.
* module is single unit of code distribution—a framework or application that is built and shipped as single unit and can be imported by import keyword
* Each build target (app bundle or framework) in Xcode is treated as separate module
* If you group together aspects of app code as stand-alone framework then everything you define within framework will be part of separate module when it is imported and used within app, or when it is used within another framework
* "source file" is single source code file within module (single file within app or framework).
* common to define individual types in separate source files, single source file can contain definitions for multiple types, functions, and so on.


## Access Levels : 3 access levels for entities
* access levels are relative to source file in which entity is defined, and also relative to module that source file belongs to.
* [1] Public : enables entities to be used within any source file from their defining module, and also in source file from another module that imports defining module.
* use public access when specifying public interface to framework
* [2] Internal : enables entities to be used within any source file from their defining module, but not in any source file outside of that module
* use internal access when defining app or framework internal structure
* [3] Private : restricts use of entity to its own defining source file
* Use private access to hide implementation details of specific piece of functionality.
* Public is highest (least restrictive) access level and private is lowest (or most restrictive) access level.
* Private scoped to enclosing source file rather than to enclosing declaration.
* Type can access any private entities that are defined in same source file as itself, but extension not access that type private members if it’s defined in separate source file.


## Access Level: Guiding Principle
* No entity can be defined in terms of another entity that has lower (more restrictive) access level
* public variable not defined as having internal or private type, type might not be available everywhere that public variable is used
* function not have higher access level than its parameter and return type, function used in its constituent types are not available to surrounding code

## Access Level: Default
* All entities in code have default access level of internal if not specify explicit access level yourself.
* in many cases not need to specify explicit access level in code.

## Access Level : Single-Target Apps
* When write simple single-target app, code in app typically self-contained within app and not need to be made available outside of app module
* default access level of internal already matches this requirement
* not need to specify custom access level
* want to mark some parts of code as private to hide implementation details from other code within app module.

## Access Level : Frameworks
* mark public-facing interface to framework as public, it can be viewed and accessed by other modules, such as app imports the framework.
* public-facing interface is application programming interface (or API) for framework
* Any internal implementation details of framework can still use default access level of internal, or marked as private if want to hide them from other parts of framework internal code.
* need to mark entity as public only if want it to become part of framework API.

## Access Levels : Unit Test Targets
* When write app with unit test target, code in app needs to be made available to that module in order to be tested.
* By default, only entities marked as public are accessible to other modules
* unit test target can access any internal entity, if mark import declaration for product module with @testable attribute and compile that product module with testing enabled.

## Access Control Syntax
* Define access level for entity by placing public, internal, or private modifiers before entity introducer */
public   class SomePublicClass   {}
internal class SomeInternalClass {}
private  class SomePrivateClass  {}
public   var  somePublicVariable = 0
internal let  someInternalConstant = 0
private  func somePrivateFunction() {}

//:* Unless otherwise specified, default access level is internal
//:* SomeInternalClass and someInternalConstant can written without explicit access level modifier, and still have internal access level
class MySomeInternalClass {}              // implicitly internal
var mySomeInternalConstant = 0            // implicitly internal
/*:
## Custom Types
* if want to specify explicit access level for custom type, do so at point that define type
* new type can then be used wherever its access level permits
* if define private class, class can only used as type of property, or as function parameter or return type, in source file in private class is defined
* access control level of type affects default access level of that type members (properties, methods, initializers, and subscripts)
* If define type access level as private, default access level of members will also be private
* If define type access level as internal or public, default access level of type members will be internal
* public type defaults to having internal members, not public members.
* If want type member to be public, you must explicitly mark it as such.
* This ensures that public-facing API for type is something to publishing, and avoids presenting internal workings of type as public API by mistake */
public class NewSomePublicClass {
    public var newSomePublicProperty = 0
    var newSomeInternalProperty = 0         // implicitly internal class member
    private func newSomePrivateMethod() {}
}
class NewSomeInternalClass {
    var newSomeInternalProperty = 0
    private func newSomePrivateMethod() {}
}
private class NewSomePrivateClass {
    var newSomePrivateProperty = 0          // implicitly private class member
    func newSomePrivateMethod() {}          // implicitly private class member
}

/*:
## Tuple Types
* access level for tuple type is most restrictive access level of all types used in that tuple
* if compose tuple from two different types, one with internal access and private access, access level for that compound tuple type will be private
* Tuple types not have standalone definition in way that class, struct, enum and functions do
* tuple type access level is deduced automatically when tuple type is used, and not be specified explicitly

## Function Types
* access level for function type is calculated as most restrictive access level of function parameter types and return type
* specify access level explicitly as part of function definition if function calculated access level not match contextual default
* example defines global function called someFunction, without providing specific access level modifier for function itself
* You might expect this function to have default access level of “internal”, but not case
* In fact, someFunction not compile as written below */
// func someFunction() -> (NewSomeInternalClass, NewSomePrivateClass) {// function implementation goes here }

/*:
* function return type is tuple type composed from two of custom classes defined above in Custom Types
* One of these classes was defined as “internal”, and other was defined as “private”
* overall access level of compound tuple type is “private” (minimum access level of tuple constituent types)
* function return type is private, must mark function overall access level with private modifier for function declaration to be valid */
// private func someFunction() -> (SomeInternalClass, SomePrivateClass) { /*function implementation goes here*/ }
/*:
* It not valid to mark definition of someFunction with public or internal modifiers, or to use default setting of internal, because public or internal users of function might not have appropriate access to private class used in function return type.

## Enumeration Types
* individual cases of enum automatically receive same access level as enum they belong to
* not specify different access level for individual enum cases
* CompassPoint enum has explicit access level of “public”.
* enum cases North, South, East, and West also have access level of “public” */
class Deneme {
    private enum CompassPoint {
        case North
        case South
        case East
        case West
    }
}
/*:
## Raw Values and Associated Values
* types used for any raw values or associated values in enum definition must have access level at least as high as enum access level.
* cannot use private type as raw-value type of enum with internal access level

## Nested Types
* defined within private type have automatic access level of private
* defined within public type or internal type have automatic access level of internal.
* If want nested type within public type to be publicly available, must explicitly declare nested type as public

## Subclassing
* can subclass any class that can be accessed in current access context
* subclass cannot have higher access level than its superclass, cannot write public subclass of internal superclass
* can override any class member (method, property, initializer, or subscript) that is visible in certain access context
* override can make inherited class member more accessible than its superclass version
* Class A is public class with private method called someMethod()
* Class B is subclass of A, with reduced access level of “internal”
* Class B provides override of someMethod() with access level of “internal”, which higher than original implementation of someMethod() */
// public class A { private func someMethod() {} }
// internal class B: A { override internal func someMethod() {} }
/*:
* It is valid for subclass member to call superclass member that has lower access permissions than subclass member
* call to superclass member takes place within allowed access level context
* within same source file as superclass for private member call, or within same module as superclass for internal member call */
// public class A { private func someMethod() {} }
// internal class B: A { override internal func someMethod() { super.someMethod() } }
/*:
* superclass A and subclass B defined in same source file, it is valid for B implementation of someMethod() to call super.someMethod().

## Constants, Variables, Properties, and Subscripts :
* constant, variable, or property cannot be more public than its type
* not valid to write public property with private type
* subscript cannot be more public than either its index type or return type
* If constant, variable, property, or subscript makes use of private type, must also be marked as private */
// private var privateInstance = SomePrivateClass()

/*:
## Getters and Setters
* Getters and setters for constants, variables, properties, and subscripts automatically receive same access level
* can give setter lower access level than its corresponding getter, to restrict read-write scope of that variable, property, or subscript.
* assign lower access level by writing private(set) or internal(set) before var or subscript introducer
* rule applies to stored properties as well as computed properties
* for not write explicit getter and setter for stored property, Swift still synthesizes implicit getter and setter to provide access to stored property backing storage.
* Use private(set) and internal(set) to change access level of synthesized setter in exactly same way as for explicit setter in computed property
* example defines TrackedString struct, which keeps track of number of times string property is modified */
struct TrackedString {
    private(set) var numberOfEdits = 0
    var value: String = "" {
        didSet { numberOfEdits++ }
    }
}
/*:
* TrackedString struct and value property not provide explicit access level modifier, they both receive default access level of internal
* numberOfEdits access level marked with private(set) modifier to indicate that property should be settable only from within same source file
* property getter still has default access level of internal, but its setter is now private to source file in which TrackedString is defined
* enables TrackedString to modify numberOfEdits property internally, but to present property as read-only property when used by other source files within same module.
* If create TrackedString instance and modify string value few times, can see numberOfEdits property value update to match number of modifications */
var stringToEdit = TrackedString()
stringToEdit.value = "This string will be tracked."
stringToEdit.value += " This edit will increment numberOfEdits."
stringToEdit.value += " So will this one."
stringToEdit.numberOfEdits

/*:
* can query current value of numberOfEdits from within another source file, cannot modify property from another source file
* restriction protect implementation details of TrackedString edit-tracking functionality, while still providing convenient access to aspect of that functionality
* can assign explicit access level for both getter and setter if required
* example shows version of TrackedString struct in which struct defined with explicit access level of public
* struct members (including numberOfEdits property) therefore have internal access level by default
* can make struct numberOfEdits property getter public, and its property setter private, by combining public and private(set)modifiers */
/*
public struct TrackedString {
    public private(set) var numberOfEdits = 0
    public var value: String = "" { didSet { numberOfEdits++ }}
    public init() {}
}
*/
/*:
## Initializers
* Custom initializers can be assigned access level less than or equal to type that they initialize
* only exception is for required initializers
* required initializer must have same access level as class it belongs to
* As with function and method parameters, types of initializer parameters cannot be more private than initializer own access level

## Default Initializers
* Swift automatically provides default initializer without any arguments for any struct or base class that provides default values for all of its properties and does not provide at least one initializer itself
* default initializer has same access level as type it initializes, unless that type is defined as public
* For type that defined as public, default initializer is considered internal
* If want public type to be initializable with no-argument initializer when used in another module, explicitly provide public no-argument initializer yourself as part of type definition.

## Default Memberwise Initializers for Struct Types
* is considered private if any of struct stored properties are private
* initializer has access level of internal
* if want public struct type to be initializable with memberwise initializer when used in another module, provide public memberwise initializer yourself as part of type definition.

## Protocols
* If want to assign explicit access level to protocol type, do so at point that define protocol
* enables to create protocols that can only be adopted within certain access context
* access level of each requirement within protocol definition is automatically set to same access level as protocol
* cannot set protocol requirement to different access level than protocol it supports
* ensures that all protocol requirements will be visible on any type that adopts protocol
* If define public protocol, protocol requirements require public access level for those requirements when they implemented
* This is different from other types, where public type definition implies access level of internal for type members.

## Protocol Inheritance
* If define new protocol inherits from existing protocol, new protocol can have at most same access level as protocol it inherits from.
* cannot write public protocol that inherits from internal protocol */

/*:
## Protocol Conformance
* type can conform to protocol with lower access level than type itself
* can define public type that can be used in other modules, but whose conformance to internal protocol can only be used within internal protocol defining module.
* context in which type conforms to particular protocol is minimum of type access level and protocol access level
* If type is public, but protocol it conforms to is internal, type conformance to that protocol is also internal
* When write or extend type to conform to protocol ensure that type implementation of each protocol requirement has at least same access level as type conformance to that protocol
* if public type conforms to internal protocol, type implementation of each protocol requirement must be at least "internal"
* protocol conformance is global—it is not possible for type to conform to protocol in two different ways within the same program */

/*:
## Extensions
* can extend class, struct, or enum in any access context in which class, struct, or enum is available
* Any type members added in extension have same default access level as type members declared in original type being extended
* If extend public or internal type, any new type members you add will have default access level of internal
* If extend private type, any new type members add will have default access level of private
* can mark extension with explicit access level modifier to set new default access level for all members defined within extension
* new default can still be overridden within extension for individual type members.

## Adding Protocol Conformance with an Extension
* cannot provide explicit access level modifier for extension if using that extension to add protocol conformance
* protocol own access level is used to provide default access level for each protocol requirement implementation within extension

## Generics
* access level for generic type or generic function is minimum of access level of generic type or function itself and access level of any type constraints on its type parameters

## Type Aliases
* Any type aliases you define treated as distinct types for purposes of access control
* type alias can have access level less than or equal to access level of type it aliases
* private type alias can alias private, internal, or public type, but public type alias not alias internal or private type
* This rule also applies to type aliases for associated types used to satisfy protocol conformances 
*/
