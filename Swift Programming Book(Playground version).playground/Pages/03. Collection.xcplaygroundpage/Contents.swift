//:# Collection Types
//: Array       : ordered collections of values
//: Set         : unordered collections of unique values
//: Dictionary  : unordered collections of key-value associations

//:# ARRAY : stores values of same type in ordered list
//:# Syntax
var cars1 = Array<String>() //Long Syntax
var cars2 = [String]()      //Short Syntax

//:# Empty Array
var someInts = [Int]()
someInts.count
someInts.append(3)
someInts = []

//:# Array with Default Value
var threeDoubles = [Double](count: 3, repeatedValue: 0)

//:# Add Two Arrays Together
var anotherThreeDoubles = [Double](count: 3, repeatedValue: 2.5)
var sixDoubles = threeDoubles + anotherThreeDoubles

//:# Array Literal
var shoppingList: [String] = ["Eggs", "Milk"]
var newshoppingList = ["Eggs", "Milk"]

//:# isEmpty for checking count == 0
if shoppingList.isEmpty { print("empty")} else { print("not empty") }

//:# append() for add item to end of array
shoppingList.append("Flour")

//:# append array items with (+=)
shoppingList += ["Baking Powder"]
shoppingList += ["Chocolate Spread", "Cheese", "Butter"]

//:# Retrieve/Change value with subscript syntax
var firstItem = shoppingList[0]
shoppingList[0] = "Six eggs"
shoppingList
shoppingList[2...2] = ["Bananas", "Apples", "Orange"]
shoppingList
//:# insert(_:atIndex:) for insert item to array at specified index
shoppingList.insert("Maple Syrup", atIndex: 1)

//:# removeAtIndex(_:) for remove item from array and return removed item
let mapleSyrup = shoppingList.removeAtIndex(0)

//:# removeLast() for remove final item from array
let apples = shoppingList.removeLast()


//:# Array Iteration
for item in shoppingList { print(item) }

//:enumarate() : If need each item integer index value
for (index, value) in shoppingList.enumerate() { print("Item \(index + 1): \(value)")}

//:============================================
//:# Value vs. Reference
//:# [1] Value Type
var array1 = [1, 2, 3] //Elementler Int yani struct (value type)
var arrayCopy1 = array1

array1[0] = 100
array1
arrayCopy1 //degismedi!

//:# [2] Reference Type
class ExampleClass { var value = 10 }
var array2 = [ExampleClass(), ExampleClass()] //Elementler class instance (reference type)
var arrayCopy2 = array2
arrayCopy2[0].value
array2[0].value

array2[0].value = 100
array2[0].value

arrayCopy2[0].value //bu da degisti..

//: # Growth and Capacity
//:* reserveCapacity(_:) : If know how many elements you will need to store
//:* capacity and count : determine how many more elements array can store
import Foundation
var ar01 = [Int]()
ar01.capacity
ar01.reserveCapacity(10)
ar01.capacity
for number in 5...12 { ar01.append(number)}
ar01.count
ar01.capacity
for _ in 1...5 { ar01.append(Int(arc4random_uniform(100))) }
ar01


//:# Array and NSArray Bridging
//:* Bridge between Array and NSArray using as operator
//:* Bridging from NSArray to Array first calls copyWithZone: method
//:# NSMutableArray Class
import Foundation
var ar03 = NSMutableArray()
ar03.count
ar03.addObject("IST")
for number in 1...10 { ar03.addObject(number)}
ar03.insertObject("ANK", atIndex: 4)

var ar03a = NSMutableArray()
ar03a.addObjectsFromArray(ar03 as [AnyObject])
ar03a.removeAllObjects()
ar03a.addObject("ANT")
ar03a.replaceObjectAtIndex(0, withObject: "BRS")
ar03a.addObjectsFromArray(ar03 as [AnyObject])
ar03a.insertObject("IZM", atIndex: 3)
ar03a.removeLastObject()
ar03a.removeObject(7)
ar03a.removeObjectAtIndex(2)
ar03a.removeObjectsInArray(ar03 as [AnyObject])
ar03a.exchangeObjectAtIndex(1, withObjectAtIndex: 0)
ar03a.addObjectsFromArray(ar03 as [AnyObject])
var ar03b = (ar03a as Array)
ar03b.count

/*:
# Associated Types
* SubSlice : sub-range of Array.
* typealias SubSlice = ArraySlice<Element>
* Sliceable */

var ar04a = [Int]()
for _ in 1...5 { ar04a.append(Int(arc4random_uniform(100)))}
ar04a
ar04a.sortInPlace()

var ar04b = Array<Int>(arrayLiteral: 10)
var ar04c = Array<Int>(count: 5, repeatedValue: 6)
var ar04d = Array<Int>(count: Int(arc4random_uniform(10)), repeatedValue: 8)

var ar04e = [Int]()
for var number = 3 ; number < 40 ; number = number + 3 { ar04e.append(number)}
ar04e
ar04e.capacity
ar04e.count
ar04e.endIndex
ar04e.startIndex
ar04e.appendContentsOf(ar04a)
ar04e.insert(18, atIndex: 2)
ar04e.removeLast()
ar04e
ar04e.removeAtIndex(5)
ar04e
ar04e.removeRange(4...8)
ar04e.capacity
ar04e.removeAll(keepCapacity: true)
ar04e.capacity
ar04e

var ar04f = [Int]()
for var i = 5 ; i < 40 ; i = i + 5 { ar04f.append(i)}
ar04f
ar04f.insertContentsOf([3,6], at: 4)


/*:
# Define & Initialization () */
var myArrayv3 : Array<String> = Array<String>()
var myArrayv2 = Array<String>()
var myArray = [String]()

myArray.count
myArray.capacity
myArray.append("IST")
myArray.count
myArray.capacity
myArray.append("ANK")
myArray.count
myArray.capacity
myArray.append("IZM")
myArray.count
myArray.capacity
myArray.append("BRS")
myArray.count
myArray.capacity
myArray.append("ADN")
myArray.count
myArray.capacity
myArray[0] //First Item
myArray[Int(myArray.count - 1)]  //Last Item


var randomArray = [Int]()
for _ in 1...10 {
randomArray.append(Int(arc4random_uniform(100)))}
randomArray

var numberArray = [Int]()
for number in 1...10 { numberArray.append(number)}
numberArray
numberArray.count
numberArray.capacity


//:# Casting
var array4 = [Int]()
for number in 16...20 { array4.append(number)}
array4
(array4 as NSArray).containsObject(18)


//:# Algorithms
var arrayS = [3, 2, 5, 1, 4]
var ar500 = arrayS.sort { $0 < $1 }
ar500
var ar600 = arrayS.sort { $1 < $0 }
ar600

let arrayF = [0, 1, 2, 3, 4, 5, 6, 7]
let filteredArrayF = arrayF.filter { $0 % 2 == 0 }
filteredArrayF

let arrayF1 = [0, 1, 2, 3, 4, 5, 6, 7]
let filteredArrayF1 = arrayF1.filter { $0 % 2 != 0 }
filteredArrayF1

let arrayM = [0, 1, 2, 3]
let multipliedArrayM = arrayM.map { $0 * 2 }
multipliedArrayM

let describedArrayM = arrayM.map { "Number: \($0)" }
describedArrayM

let arrayRe = [1, 2, 3, 4, 5]
let addResult = arrayRe.reduce(0) { $0 + $1 }
addResult

let multiplyResultRe = arrayRe.reduce(1) { $0 * $1 } // multiplyResult is 120
multiplyResultRe

var y = [String](count: 2, repeatedValue: "red")
y.count     //How many elements stores
y.capacity  //How many elements Array can store without reallocation
y.isEmpty   //`true` if and only if `Array` is empty
y.first     //first element, or `nil` if the array is empty
y.last      //last element, or `nil` if the array is empty
y.reserveCapacity(30) // Reserve enough space to store minimumCapacity elements.
y.capacity
y.append("blue")     // Append newElement to the Array
y.removeLast()   // Remove an element from the end of the Array in O(1).
y.insert("orange", atIndex: 2) // Insert `newElement` at index `i`.
y.removeAtIndex(0) // Remove and return the element at index `i`
y.removeAll(keepCapacity: true)     // Remove all elements.
y.count
y.capacity
y = [String](count: 2, repeatedValue: "red")
y.appendContentsOf(["blue", "white"])


/*:
=============
## Set : stores distinct values of same type in collection with no ordering
* alternative to arrays when order of items is not important
* or need to ensure that an item only appears once

### Hash Values for Set Types
* type must be hashable in order to be stored
* type must provide way to compute hash value for itself
* hash value is Int value that is same for all objects that compare equally
* if a == b, it follows that a.hashValue == b.hashValue
* String, Int, Double, and Bool are hashable by default
* Enum member values without associated values are also hashable by default.
* use custom types as set value types or dictionary key types by making conform to Hashable protocol
* Types conform to Hashable protocol must provide gettable Int property called hashValue
* Hashable protocol conforms to Equatable, conforming types must provide implementation of “is equal” operator (==)
* Equatable protocol requires any conforming implementation of == to be equivalence relation
* implementation of == must satisfy following 3 conditions
* a == a (Reflexivity)
* a == b implies b == a (Symmetry)
* a == b && b == c implies a == c (Transitivity)

### Syntax : Set<Element> ; noshorthand form */

//:### Empty Set
var letters = Set<Character>()
print("letters is of type Set<Character> with \(letters.count) items.")
//:if context provides type info, create empty set with empty array literal
letters.insert("a")
letters = []

//:### Create Set with Array Literal
var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
//:set type cannot be inferred from array literal alone, set must be explicitly declared
//:don’t write set type if initialize with array literal containing values of same type
var myfavoriteGenres: Set = ["Rock", "Classical", "Hip hop"]

//:### Access/Modify Set

//:isEmpty property as shortcut for checking whether count == 0
if favoriteGenres.isEmpty { print("As far as music goes, I'm not picky.") }
else { print("I have particular music preferences.")}

//:insert(_:)  add new item
favoriteGenres.insert("Jazz")

//: remove items in set
if let removedGenre = favoriteGenres.remove("Rock") { print("\(removedGenre)? I'm over it.")} else { print("I never much cared for that.") }

//: contains(_:) : check set contains particular item
if favoriteGenres.contains("Funk") { print("I get up on the good foot.") }
else { print("It's too funky in here.")}


//:### Iteration Over Set
for genre in favoriteGenres { print("\(genre)")}

//:Set type not have defined ordering
//:iterate set in specific order, use sort()
for genre in favoriteGenres.sort() { print("\(genre)")}


//:### Fundamental Set Operations
//:* intersect(_:) to create new set with only values common to both sets.
//:* exclusiveOr(_:) to create new set with values in either set, but not both.
//:* union(_:) to create new set with all of values in both sets.
//:* subtract(_:) to create new set with values not in specified set
let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

oddDigits.union(evenDigits).sort()
oddDigits.intersect(evenDigits).sort()
oddDigits.subtract(singleDigitPrimeNumbers).sort()
oddDigits.exclusiveOr(singleDigitPrimeNumbers).sort()

//:### Set Membership and Equality
//:(==) to determine whether two sets contain all of same values
//:isSubsetOf(_:) to determine whether all of values of set are contained in specified set
//:isSupersetOf(_:) to determine whether set contains all of values in specified set
//:isStrictSubsetOf(_:) or isStrictSupersetOf(_:) to determine set is subset or superset, but not equal specified set
//:isDisjointWith(_:) to determine whether two sets have any values in common
let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]
houseAnimals.isSubsetOf(farmAnimals)
farmAnimals.isSupersetOf(houseAnimals)
farmAnimals.isDisjointWith(cityAnimals)


/*:
==========================
# Dictionaries
* stores associations between keys of same type and values of same type in  collection with no defined ordering
* Each value is associated with unique key, which acts as identifier
* not have specified order */

//:### Syntax
var myDictionary: Dictionary<Int, String> = Dictionary<Int, String> ()
var myDictionary2 = [Int: String]()

//:### Empty Dictionary
var namesOfIntegers = [Int: String]()
//:If context provides type info, create with empty dictionary literal as [:]
namesOfIntegers[16] = "sixteen"
namesOfIntegers
namesOfIntegers = [:]

//:### Create Dictionary with Dictionary Literal
//:* dictionary literal is shorthand way to write one or more key-value pairs as Dictionary
var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
var myairports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

//:### Access/Modify Dictionary
//: isEmpty property as shortcut for checking whether count == 0
if airports.isEmpty { print("The airports dictionary is empty.") } else {
print("The airports dictionary is not empty.")}

//:add new item to dictionary with subscript syntax
airports["LHR"] = "London"
airports

//: use subscript syntax to change value associated with particular key
airports["LHR"] = "London Heathrow"
airports
/*:
* updateValue(_:forKey:) alternatively to set or update value for key
* sets value for key if none exists, or updates value if key exists
* returns old value after performing update
* enables to check whether or not an update took place
* return optional value of dictionary’s value type
* For dictionary that stores String values, return String?, or “optional String”
* optional value contains old value for that key if one existed before update, or nil if no value existed */
if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") { print("The old value for DUB was \(oldValue).")}
/*:
* use subscript syntax to retrieve value from dictionary for particular key
* it is possible to request key for which no value exists
* dictionary’s subscript return optional value of dictionary’s value type
* If dictionary contains value for requested key, subscript return optional value containing existing value for that key. Otherwise, subscript returns nil */
if let airportName = airports["DUB"] { print("The name of the airport is \(airportName).")
} else { print("That airport is not in the airports dictionary.")}

//: use subscript syntax to remove key-value pair from dictionary by assign nil value
airports["APL"] = "Apple International"
airports["APL"] = nil

//:removeValueForKey(_:) remove key-value pair from dictionary
//:removes key-value pair if it exists and return removed value, or nil if no value existed
if let removedValue = airports.removeValueForKey("DUB") { print("The removed airport's name is \(removedValue).") } else { print("The airports dictionary does not contain a value for DUB.") }

//:### Iteration Over Dictionary
for (airportCode, airportName) in airports {print("\(airportCode): \(airportName)")}

//: retrieve iterable collection of dictionary keys or values by access keys and values
for airportCode in airports.keys { print("Airport code: \(airportCode)")}
for airportName in airports.values { print("Airport name: \(airportName)") }

//:If need use dictionary keys or values with API that takes Array instance, initialize new array with keys or values
let airportCodes = [String](airports.keys)
let airportNames = [String](airports.values)
//:Dictionary type does not have defined ordering
//:To iterate over keys or values of dictionary in specific order, use sort() on its keys or values property
