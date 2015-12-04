/*:

2015-09-09
* @autoclosure attribute—including its @autoclosure(escaping) form—to the Autoclosures section.
* multiple optional bindings example with a where clause to the Optional Binding section.
* String Literals section about how concatenating string literals using + operator happens at compile time.
* Added info to Metatype Type section about comparing metatype values and using them to construct instances with initializer expressions.
* Added note to the Debugging with Assertions section about when user-defined assertions are disabled.

2015-08-24
* new try? keyword to Converting Errors to Optional Values section.
* new Swift standard library print(_:separator:terminator) function to the Printing Constants and Variables section.
* @NSManaged attribute in Declaration Attributes section, that attribute can be applied to certain instances methods.
* Variadic Parameter: variadic parameters can be declared in any position in a function’s parameter list.

2015-08-06
Updated the Representing and Throwing Errors section, now that all types can conform to the ErrorType protocol.
Added information to the Overriding a Failable Initializer section about how a nonfailable initializer can delegate up to a failable initializer by force-unwrapping the result of the superclass’s initializer.
Added information about using enumeration cases as functions to the Enumerations with Cases of Any Type section.
Added information about explicitly referencing an initializer to the Initializer Expression section.
Added information about build configuration and line control statements to the Compiler Control Statements section.
Added a note to the Metatype Type section about constructing class instances from metatype values.
Added a note to the Weak References section about weak references being unsuitable for caching.
Updated a note in the Type Properties section to mention that stored type properties are lazily initialized.

2015-07-21
Added information about recursive enumerations to the Recursive Enumerations section of the Enumerations chapter and the Enumerations with Cases of Any Type section of the Declarations chapter.
Added information about the behavior of enumeration cases with String raw values to the Implicitly Assigned Raw Values section of the Enumerations chapter and the Enumerations with Cases of a Raw-Value Type section of the Declarations chapter.
Updated the Capturing Values section to clarify how variables and constants are captured in closures.
Updated the Declaration Attributes section to describe when you can apply the @objc attribute to classes.
Added a note to the Handling Errors section about the performance of executing a throw statement. Added similar information about the do statement in the Do Statement section.
*/

//: [Next](@next)


//:# Metatype Type : refers to type of any type, including class, struc, enum, and protocol types.
//:* metatype of class, struct, or enum type is name of that type followed by .Type. Metatype of protocol type—not concrete type that conforms to protocol at runtime—is name of that protocol followed by .Protocol.
//:* metatype of class type SomeClass is SomeClass.Type and metatype of protocol SomeProtocol is SomeProtocol.Protocol.

//:* use postfix self expression to access type as value. 
//:* SomeClass.self returns SomeClass itself, not instance of SomeClass
//:* SomeProtocol.self returns SomeProtocol itself, not instance of type that conforms to SomeProtocol at runtime
//:* can use dynamicType expression with instance of type to access that instance’s dynamic, runtime type as a value, as the following example shows
class SomeBaseClass {
    class func printClassName() { print("SomeBaseClass")}
}
class SomeSubClass: SomeBaseClass {
    override class func printClassName() { print("SomeSubClass") }
}
let someInstance: SomeBaseClass = SomeSubClass()
// The compile-time type of someInstance is SomeBaseClass,
// and the runtime type of someInstance is SomeBaseClass
someInstance.dynamicType.printClassName()

//:* Use identity operators (=== and !==) to test whether instance runtime type is same as its compile-time type

if someInstance.dynamicType === someInstance.self { print("The dynamic type of someInstance is SomeBaseCass")
} else { print("The dynamic type of someInstance isn't SomeBaseClass")}

//:* Use an initializer expression to construct an instance of a type from that type’s metatype value. For class instances, the initializer that’s called must be marked with the required keyword or the entire class marked with the final keyword.
class AnotherSubClass: SomeBaseClass {
    let string: String
    required init(string: String) { self.string = string   }
    override class func printClassName() {  print("AnotherSubClass") }
}
let metatype: AnotherSubClass.Type = AnotherSubClass.self
let anotherInstance = metatype.init(string: "some string")
//:* GRAMMAR OF A METATYPE TYPE
//: metatype-type → type­.­Type­  type­.­Protocol­
