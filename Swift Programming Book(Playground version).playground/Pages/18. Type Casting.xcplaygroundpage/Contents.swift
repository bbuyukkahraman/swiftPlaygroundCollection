/*:
# Type Casting : a way to check type of instance, and/or to treat that instance as if it is different superclass or subclass from somewhere else in its own class hierarchy.
* implemented with "is" and "as" operators
* "is" and "as" provide simple and expressive way to check type of value or cast value to different type.
* also use type casting to check whether type conforms to protocol

# Defining a Class Hierarchy for Type Casting
* use type casting with hierarchy of classes and subclasses to check type of particular class instance and to cast that instance to another class within same hierarchy
* 3 code below define class hierarchy and array contain instances of those classes, for use in example of type casting.
* 1st define new base class MediaItem
* class provides basic functionality for any kind of item that appears in a digital media library
* it declares name property of type String, and init name initializer. (assumed that all media items have name.) */
class MediaItem {
    var name: String
    init(name: String) { self.name = name }
}
//:* next code defines two subclasses of MediaItem
//:* 1st subclass, Movie, encapsulates additional information about movie or film
//:* It adds director property on top of base MediaItem class, with corresponding initializer
//:* 2nd subclass, Song, adds  artist property and initializer on top of base class
class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}
class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}
//:* final snippet creates constant array called library, which contain two Movie instances and three Song instances
//:* type of library array is inferred by initializing it with contents of array literal
//:* Swift type checker is able to deduce that Movie and Song have common superclass of MediaItem, and so it infers type of [MediaItem] for library array

let library = [
Movie(name: "Casablanca", director: "Michael Curtiz"),
Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
Movie(name: "Citizen Kane", director: "Orson Welles"),
Song(name: "The One And Only", artist: "Chesney Hawkes"),
Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]
//:* items stored in library are still Movie and Song instances behind scenes
//:* if iterate over contents of this array, items receive back are typed as MediaItem, and not as Movie or Song
//:* In order to work with them as their native type, need to check their type, or downcast them to different type

//:# Checking Type
//:* Use type check operator (is) to check whether instance is of certain subclass type
//:* type check operator returns true if instance is of that subclass type and false if it is not.
//:* example define 2 variable, movieCount and songCount, which count number of Movie and Song instances in library array
var movieCount = 0
var songCount = 0
for item in library { if item is Movie { ++movieCount } else if item is Song { ++songCount } }
print("Media library contains \(movieCount) movies and \(songCount) songs")
//:* example iterates through all items in library array
    //:* On each pass, for-in loop sets item constant to next MediaItem in array
//:* item is Movie returns true if current MediaItem is Movie instance and false if it is not
//:* item is Song checks whether item is Song instance
//:* end of for-in, values of movieCount and songCount contain count of how many MediaItem instances were found of each type

//:# Downcasting
/*:
* let or var of certain class type may actually refer to instance of subclass behind scenes
* Where believe this is case, try to downcast to subclass type with a type cast operator (as? or as!).
* Because downcasting can fail, type cast operator comes in two different forms
* conditional form, as?, returns optional value of type you are trying to downcast to
* forced form, as!, attempts downcast and force-unwraps result as a single compound action.
* Use conditional form of type cast operator (as?) when not sure if downcast will succeed
* This form of operator will always return optional value, and value will be nil if downcast was not possible
* This enables you to check for a successful downcast.
* Use forced form of type cast operator (as!) only when sure that downcast will always succeed
* This form of operator will trigger runtime error if you try to downcast to an incorrect class type.
* example below iterates over each MediaItem in library, and prints appropriate description for each item
* To do this, it needs to access each item as true Movie or Song, and not just as a MediaItem
* This is necessary in order for it to be able to access director or artist property of Movie or Song for use in description
* In this example, each item in array might be Movie, or it might be Song
* You don’t know in advance which actual class to use for each item, and so it is appropriate to use conditional form of type cast operator (as?) to check downcast each time through the loop */
for item in library { if let movie = item as? Movie { print("Movie: '\(movie.name)', dir. \(movie.director)")}
else if let song = item as? Song { print("Song: '\(song.name)', by \(song.artist)") } }
/*:
* example starts by trying to downcast current item as Movie
* Because item is MediaItem instance, it’s possible that it might be a Movie; equally, it’s also possible that it might be a Song, or even just a base MediaItem
* Because of this uncertainty, as? form of type cast operator return optional value when attempting to downcast to subclass type
* result of item as? Movie is of type Movie?, or “optional Movie”.
* Downcasting to Movie fails when applied to Song instances in library array
* example above uses optional binding to check whether optional Movie actually contain value (to find out whether the downcast succeeded.)
* This optional binding is written “if let movie = item as? Movie”, which can be read as:
* “Try to access item as Movie. If this is successful, set new temporary constant called movie to the value stored in the returned optional Movie.”
* If downcasting succeeds, properties of movie are then used to print description for that Movie instance, including name of its director
* similar principle is used to check for Song instances, and to print appropriate description (including artist name) whenever a Song is found in library.
* Casting not actually modify instance or change its values
* underlying instance remains same; it is simply treated and accessed as instance of type to which it has been cast */

//:# Type Casting for Any and AnyObject
/*:
* Swift provides two special type aliases for working with non-specific types:
* AnyObject can represent an instance of any class type.
* Any can represent an instance of any type at all, including function types.
* Use Any and AnyObject only when explicitly need behavior and capabilities they provide
* It is always better to be specific about types you expect to work with in your code */

//:# AnyObject
/*:
* When working with Cocoa APIs, it is common to receive array with type of [AnyObject], or “an array of values of any object type”
* Objective-C not have explicitly typed arrays
* often be confident about type of objects contained in such array just from info you know about API that provided array
* In these situations, use forced version of type cast operator (as) to downcast each item in array to more specific class type than AnyObject, without need for optional unwrapping.
* example below defines array of type [AnyObject] and populates this array with three instances of Movie class */
let someObjects: [AnyObject] = [
    Movie(name: "2001: A Space Odyssey", director: "Stanley Kubrick"),
    Movie(name: "Moon", director: "Duncan Jones"),
    Movie(name: "Alien", director: "Ridley Scott")
]
//:* Because this array is known to contain only Movie instances, can downcast and unwrap directly to non-optional Movie with forced version of type cast operator (as!)
for object in someObjects { let movie = object as! Movie
    print("Movie: '\(movie.name)', dir. \(movie.director)")
}
//:* For even shorter form of this loop, downcast someObjects array to type of [Movie] instead of downcasting each item
for movie in someObjects as! [Movie] {
    print("Movie: '\(movie.name)', dir. \(movie.director)")
}

//:# Any
//:* Here example of using Any to work with mix of different types, including function types and non-class types
//:* example creates an array called things, which can store values of type Any
var things = [Any]()
things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })
//:*  things array contains two Int values, two Double values, String value, tuple of type, movie “Ghostbusters”, and a closure expression that takes a String value and returns another String value.
//:* can "is" and "as" operators in "switch" cases to discover specific type of constant or variable that is known only to be of type Any or AnyObject
//:* example below iterates over items in things array and queries type of each item with "switch"
//:* Several of "switch" cases bind their matched value to constant of specified type to enable its value to be printed
for thing in things {
    switch thing {
    case 0 as Int: print("zero as an Int")
    case 0 as Double: print("zero as a Double")
    case let someInt as Int: print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0: print("a positive double value of \(someDouble)")
    case is Double: print("some other double value that I don't want to print")
    case let someString as String: print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double): print("an (x, y) point at \(x), \(y)")
    case let movie as Movie: print("a movie called '\(movie.name)', dir. \(movie.director)")
    case let stringConverter as String -> String: print(stringConverter("Michael"))
    default: print("something else")
    }
}
//:* cases of "switch" use forced version of type cast operator (as, not as?) to check and cast to a specific type
//:* This check is always safe within the context of a switch case statement