/*:
# Class and Struct : general-purpose, flexible constructs that become building blocks of code.
* Define properties and methods to add functionality
* Define class or struct in single file
* external interface to that class or struct is automatically made available for other code to use.
* Instance of class known as object. 
* In Swift instance is class or struct type.

## Compare Class and Struct
* Both define properties to store values
* Both define methods to provide functionality
* Both define subscripts to provide access to values using subscript syntax
* Both define initializers to set up initial state
* Be extended to expand their functionality beyond default implementation
* Conform to protocols to provide standard functionality of certain kind

* Class have additional capabilities that struct do not:
* Inheritance enables one class to inherit characteristics of another.
* Type casting enables to check and interpret type of class instance at runtime.
* Deinitializers enable instance of class to free up any resources it has assigned.
* Reference counting allows more than one reference to class instance.
* Struct always copied when passed around in code, and not use reference counting.

## Syntax
* When define new class or struct, you define new type.
* Give types UpperCamelCase names to match capitalization of standard types (String, Int,  Bool).
* give properties and methods lowerCamelCase names to differentiate them from type names. */
struct Resolution { var width = 0 ; var height = 0 }
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String? }
/*:
## Class and Struct Instances
* Resolution struct and VideoMode class only describe what Resolution or VideoMode will look like.
* They not describe specific resolution or video mode. 
* To do that, to create instance of struct or class.*/
let someResolution = Resolution()
let someVideoMode = VideoMode()
/*:
* simplest form of initializer syntax uses type name of class or struct followed by ()
* This creates new instance of class or struct, with any properties initialized to their default values. 

## Access Properties
* can access properties of instance using dot syntax.
* In dot syntax, you write property name immediately after instance name, separated by (.) */
someResolution.width
someVideoMode.resolution.width
someVideoMode.resolution.width = 1280
someVideoMode.resolution.width

/*:
## Memberwise Initializers for Struct
* All struct have automatically-generated memberwise initializer.
* class not receive default memberwise initializer.
* use to initialize member properties of new structure instances.
* Initial values for properties of new instance can be passed to memberwise initializer by name */
let vga = Resolution(width: 640, height: 480)

/*:
## Struct and Enum Are Value Types
* value type measn value copied when it assign to var or let, or when it is passed to function.
* Int, Double, Bool, Array, Dictionary are value types, and implemented as struct.
* All struct and enum are value types. */
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
cinema.width = 2048
cinema.width
hd.width
//:* Same behavior applies to enum
enum CompassPoint { case North, South, East, West }
var currentDirection = CompassPoint.West
let rememberedDirection = currentDirection
currentDirection = .East
if rememberedDirection == .West {print("The remembered direction is still .West") }

//:## Class Are Reference Types
//:* reference types not copied when assign to var or let, or passed to function.
//:* reference to same existing instance is used instead
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0
let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
tenEighty.frameRate

/*:
## Identity Operators
* In class, possible for multiple constants and var to refer to same single instance of class behind scenes.
* same not true for struct and enum
* sometimes useful to find out if two constants or variables refer to exactly same instance
* To enable there is two identity operators: * Identical to (===) ; * Not identical to (!==)
* Use these operators to check whether two constants or variables refer to same single instance */
tenEighty === alsoTenEighty

/*:
## Choosing Between Class and Struct
* can use class or struct to define custom data types to use as building blocks
* struct instances passed by value, class instances passed by reference.
* they are suited to different kinds of tasks.
* consider struct when one or more of these conditions apply:
* struct primary purpose is to encapsulate few relatively simple data values.
* - encapsulated values will be copied rather than referenced when assign or pass around instance of struct.
* - properties stored by struct are value types, expected to be copied rather than referenced.
* - not need to inherit properties or behavior from another existing type.
* - struct examples: size of geometric shape, refer to ranges within series, point in 3D coordinate system

## Assignment and Copy Behavior for Strings, Arrays, and Dictionaries
* String, Array, and Dictionary types are implemented as struct.
* They are copied when assign to new let or var, or passed to unction or method.
* This is different from NSString, NSArray, and NSDictionary, which implemented as class.
* these instances always assign and passed around as reference to existing instance
* behavior you see in your code will always be as if copy took place.
* Swift only performs actual copy behind scenes when it is absolutely necessary to do so.
* Swift manages all value copying to ensure optimal performance */