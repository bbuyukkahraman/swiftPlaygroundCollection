/*:
# Optional Chaining : process for querying and calling properties, methods, and subscripts on optional that might currently be nil
* If optional contains value, property, method, or subscript call succeeds
* if optional nil, property, method, or subscript call returns nil
* Multiple queries can be chained together, and entire chain fails gracefully if any link in chain is nil.
* Optional chaining works for any type, and that can be checked for success or failure.

# Optional Chaining as an Alternative to Forced Unwrapping
* You specify optional chaining by placing (?) after optional value on which you wish to call property, method or subscript if optional is non-nil
* very similar to placing (!) after optional value to force unwrapping of its value
* main difference is optional chaining fails gracefully when optional nil, whereas forced unwrapping trigger runtime error when optional is nil.
* optional chaining can be called on nil value, result of optional chaining call is always optional value, even if property, method, or subscript you are querying return non-optional value
* use this optional return value to check whether optional chaining call was successful (returned optional contain value), or not succeed due to nil value in chain (returned optional value is nil).
* result of optional chaining call is of same type as expected return value, but wrapped in optional
* property that normally return Int will return Int? when accessed through optional chaining.
* next several code demonstrate how optional chaining differs from forced unwrapping and enables to check for success */
class Person {
    var residence: Residence?
}
class Residence {
    var numberOfRooms = 1
}
//:* If you create new Person instance, its residence property is default initialized to nil, by virtue of being optional
//:* In below, john has a residence property value of nil:
let john = Person()
//:* If try to access numberOfRooms property of this person residence, by placing (!) after residence to force unwrapping of its value, you trigger a runtime error, because there is no residence value to unwrap
//let roomCount = john.residence!.numberOfRooms    // this triggers a runtime error

//:* code succeeds when john.residence has non-nil and will set roomCount to Int value contain appropriate number of rooms
//:* code always trigger runtime error when residence is nil
//:* Optional chaining provides alternative way to access value of numberOfRooms
//:* To use optional chaining, use (?) in place of (!)
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
//:* tells to “chain” on optional residence property and to retrieve the value of numberOfRooms if residence exists.
//:* attempt to access numberOfRooms has potential to fail, optional chaining attempt return value of type Int?, or “optional Int”. When residence is nil, as in the example above, this optional Int will also be nil, to reflect the fact that it was not possible to access numberOfRooms.
//:* this is true even though numberOfRooms is non-optional Int
//:* fact that it is queried through optional chain means that call to numberOfRooms will always return Int? instead of Int
//:* can assign Residence instance to john.residence, so that it no longer has nil value
john.residence = Residence()
//:* john.residence now contain actual Residence instance, rather than nil
//:* If you try to access numberOfRooms with same optional chaining, return Int? that contain default numberOfRooms of 1
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
//:# Defining Model Classes for Optional Chaining
//:* use optional chaining with calls to properties, methods, and subscripts that more than one level deep
//:* This enables to drill down into subproperties within complex models of interrelated types, and to check whether it is possible to access properties, methods, and subscripts on those subproperties.
//:* code define 4 model classes for use in several subsequent examples, including examples of multilevel optional chaining. 
//:* These classes expand upon Person and Residence model from above by adding Room and Address class, with associated properties, methods, and subscripts.
class Person2 {
    var residence: Residence?
}
//:* Residence class is more complex than before
//:* Residence class defines a variable property called rooms, which is initialized with an empty array of type [Room]:
/*
class Residence2 {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get { return rooms[i] }
        set { rooms[i] = newValue }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}
*/
/*:
* this version of Residence stores array of Room instances, its numberOfRooms property is implemented as computed property, not stored property
* computed numberOfRooms property simply return value of count property from rooms array.
* As shortcut to access rooms array, this version of Residence provides read-write subscript that provides access to room at requested index in rooms array.
* Residence provides method called printNumberOfRooms, which simply prints number of rooms in residence.
* Residence defines optional property called address, with type of Address?
* Address class type for this property is defined below.
* Room class used for rooms array is simple class with one property called name, and initializer to set that property to suitable room name */

class Room {
    let name: String
    init(name: String) { self.name = name }
}
//:* final class called Address
//:* This class has three optional properties of type String?
//:* 1st 2 properties, buildingName and buildingNumber, alternative ways to identify particular building as address part
//:* 3rd property, street, is used to name street for that address
class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        } else if buildingNumber != nil && street != nil {
            return "\(buildingNumber) \(street)"
        } else { return nil } }
}
/*:
* Address class provides method called buildingIdentifier(), which has return type of String?
* This method checks properties of address and returns buildingName if it has value, or buildingNumber concatenated with street if both have values, or nil otherwise

# Access Properties Through Optional Chaining
* demonstrated in Optional Chaining as Alternative to Forced Unwrapping, can use optional chaining to access property on optional value, and to check if that property access is successful.
* Use classes defined above to create new Person instance, and try to access its numberOfRooms property as before */
/*
let john = Person()
if let roomCount = john.residence?.numberOfRooms {
print("John's residence has \(roomCount) room(s).")
} else {
print("Unable to retrieve the number of rooms.")
}
*/
//:* Because john.residence is nil, this optional chaining call fails in the same way as before.
//:* can attempt to set a property’s value through optional chaining:
let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
// john.residence?.address = someAddress
//:* example, attempt to set address property of john.residence will fail, because john.residence is currently nil.

//:# Calling Methods Through Optional Chaining
/*:
* use optional chaining to call method on optional value, and to check whether that method call is successful
* do this even if that method does not define a return value.
* printNumberOfRooms() method on Residence class prints current value of numberOfRooms
* Here’s how the method looks */
//func printNumberOfRooms() { print("The number of rooms is \(numberOfRooms)") }
//:* method not specify return type
//:* functions and methods with no return type have implicit return type of Void
//:* means that they return a value of (), or an empty tuple.
//:* If call this method on optional value with optional chaining, method return type will be Void?, not Void, because return values are always of optional type when called through optional chaining
//:* enables to use if statement to check whether it was possible to call printNumberOfRooms() method, even though method not itself define return value
//:* Compare return value from printNumberOfRooms call against nil to see if method call was successful
/*
if john.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
} else {
print("It was not possible to print the number of rooms.")
}
*/
//:*  same is true if you attempt to set a property through optional chaining. The example above in Accessing Properties Through Optional Chaining attempts to set an address value for john.residence, even though the residence property is nil. Any attempt to set a property through optional chaining returns a value of type Void?, which enables you to compare against nil to see if the property was set successfully:
/*
if (john.residence?.address = someAddress) != nil {
print("It was possible to set the address.")
} else {
print("It was not possible to set the address.")
}
*/

//:# Accessing Subscripts Through Optional Chaining
/*:
* can use optional chaining to try to retrieve and set value from subscript on optional value, and to check whether that subscript call is successful.
* When access subscript on optional value through optional chaining, place (?) before subscript brackets, not after
* optional chaining (?) always follows immediately after part of expression that is optional.
* example below tries to retrieve name of first room in rooms array of john.residence property using subscript defined on Residence class
* Because john.residence is currently nil, subscript call fails */
/*
if let firstRoomName = john.residence?[0].name {
print("The first room name is \(firstRoomName).")
} else {
print("Unable to retrieve the first room name.")
}
*/
//:* optional chaining (?) in this subscript call is placed immediately after john.residence, before subscript brackets, because john.residence is optional value on which optional chaining is being attempted.
//:* you can try to set new value through a subscript with optional chaining
// john.residence?[0] = Room(name: "Bathroom")
//:* This subscript setting attempt also fails, because residence is currently nil.
//:* If create and assign actual Residence instance to john.residence, with one or more Room instances in its rooms array, can use Residence subscript to access actual items in rooms array through optional chaining
/*
let johnsHouse = Residence()
johnsHouse.rooms.append(Room(name: "Living Room"))
johnsHouse.rooms.append(Room(name: "Kitchen"))
john.residence = johnsHouse

if let firstRoomName = john.residence?[0].name {
print("The first room name is \(firstRoomName).")}
else { print("Unable to retrieve the first room name.")}
*/
//:# Access Subscripts of Optional Type
//:* If subscript return value of optional type—such as key subscript of Swift’s Dictionary type—place (?) after subscript closing bracket to chain on its optional return value
var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0]++
testScores["Brian"]?[0] = 72
//:* example defines dictionary testScores, contains two key-value pairs that map a String key to an array of Int values. 
//:* example uses optional chaining to set first item in "Dave" array to 91; to increment first item in "Bev" array by 1; and to try to set first item in array for key of "Brian"
//:* first two calls succeed, because testScores dictionary contains keys for "Dave" and "Bev"
//:* third call fails, because testScores dictionary does not contain a key for "Brian".

//:# Linking Multiple Levels of Chaining
/*:
* link together multiple level of optional chaining to drill down to properties, methods, and subscripts deeper within model
* multiple levels of optional chaining do not add more levels of optionality to the returned value.
* To put it another way:
* If type trying to retrieve is not optional, it will become optional because of optional chaining.
* If type trying to retrieve is already optional, it will not become more optional because of the chaining.
* Therefore:
* If try to retrieve Int through optional chaining, Int? always return, no matter how many chaining level used
* if try to retrieve Int? through optional chaining, Int? always return, no matter how many chaining level used
* example tries to access street property of address property of residence property of john
* There are two levels of optional chaining in use here, to chain through residence and address properties, both of which are of optional type */
/*
if let johnsStreet = john.residence?.address?.street {
print("John's street name is \(johnsStreet).")}
else { print("Unable to retrieve the address.")}
*/
/*:
* value of john.residence currently contains valid Residence instance
* value of john.residence.address is currently nil
* call to john.residence?.address?.street fails.
* you are trying to retrieve value of street property
* type of this property is String?
* return value of john.residence?.address?.street is therefore also String?, even though two levels of optional chaining are applied in addition to underlying optional type of property.
* If set actual Address instance as value for john.residence.address, and set actual value for address street property, can access value of street property through multilevel optional chaining */
/*
let johnsAddress = Address()
johnsAddress.buildingName = "The Larches"
johnsAddress.street = "Laurel Street"
john.residence?.address = johnsAddress

if let johnsStreet = john.residence?.address?.street {
print("John's street name is \(johnsStreet).")
} else {
print("Unable to retrieve the address.")
}
*/
//:* In example, attempt to set address property of john.residence will succeed, because value of john.residence currently contains a valid Residence instance.

//:# Chaining on Methods with Optional Return Values
/*:
* previous example shows how to retrieve value of property of optional type through optional chaining
* can use optional chaining to call method that return value of optional type, and to chain on that method return value if needed.
* example below calls Address class buildingIdentifier() method through optional chaining
* This method returns value of type String?
* As described above, ultimate return type of this method call after optional chaining is also String? */
/*
if let buildingIdentifier = john.residence?.address?.buildingIdentifier() {
print("John's building identifier is \(buildingIdentifier).")
}
*/
//:* If want to perform further optional chaining on this method return value, place optional chaining (?) after method parentheses
/*
if let beginsWithThe =
john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
if beginsWithThe {
print("John's building identifier begins with \"The\".")
} else {
print("John's building identifier does not begin with \"The\".") }}
*/
//:* In example above, place optional chaining (?) after parentheses, because optional value chaining on is  buildingIdentifier() method’s return value, and not the buildingIdentifier() method itself