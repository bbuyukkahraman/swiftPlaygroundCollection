//:# String : ordered collection of characters ("albatross")
//:# Strings Are Value Types : copied when pass or assign

//:# String Literal
let someString = "Some string literal value"

//:# Initialize Empty String
var emptyString = ""
var anotherEmptyString = String()
if emptyString.isEmpty { print("Nothing to see here")}

//:# String Mutability
var variableString = "Horse"
variableString += " and carriage"

//:# Characters : access character values by iterating over its characters property with for-in loop
for character in "Dog!🐶".characters { print(character) }
//: stand-alone Character by Character type annotation
let exclamationMark: Character = "!"

//: String Construction by passing [Character]
let catCharacters: [Character] = ["C", "a", "t", "!", "🐱"]
let catString = String(catCharacters)

//:# String Concatenation
let string1 = "hello"
let string2 = " there"
var welcome = string1 + string2

//: append String value to existing String variable with (+=)
var instruction = "look over"
instruction += string2

//: append Character to String with append()
let newexclamationMark: Character = "!"
welcome.append(newexclamationMark)

//:# String Interpolation : "\( )"
let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"

//:# Unicode : international standard for encoding, representing, and processing text
//: represent any character from any language

//:# Unicode Scalars : unique 21-bit number
//: U+0061 for LATIN SMALL LETTER A ("a")
//: U+1F425 for FRONT-FACING BABY CHICK ("🐥")
//: Unicode Scalars code range   : U+0000 to U+D7FF inclusive   |  U+E000 to U+10FFFF inclusive
//: Unicode surrogate pair code range : U+D800 to U+DFFF inclusive
//: not all 21-bit Unicode scalars are assigned to character
//: Scalars that have been assigned to character typically also have name
//: such as LATIN SMALL LETTER A and FRONT-FACING BABY CHICK in example

//:# Special Characters: \0 :null, \\ :(\) , \t :(tab) , \n :linefeed , \r :return , \" :(") , \' :(')
//: Arbitrary Unicode scalar, written as \u{n} , "n" is 1–8 digit hex number with value equal to valid Unicode
let wiseWords       = "\"Imagination is more important than knowledge\" - Einstein"
let dollarSign      = "\u{24}"          // $,  Unicode scalar U+0024
let blackHeart      = "\u{2665}"        // ♥,  Unicode scalar U+2665
let sparklingHeart  = "\u{1F496}"       // 💖, Unicode scalar U+1F496

//:# Extended Grapheme Clusters : sequence of one or more Unicode scalars that produce single human-readable character
//: each Character type represents single extended grapheme cluster
let eAcute          : Character = "\u{E9}"          //:single scalar    : (LATIN SMALL LETTER E WITH ACUTE, or U+00E9)
let combinedEAcute  : Character = "\u{65}\u{301}"   //:pair of scalars  : (LATIN SMALL LETTER E, U+0065) + ACUTE ACCENT scalar (U+0301)
let precomposed     : Character = "\u{D55C}"                    //한 ,      :Hangul syllables from Korean alphabet
let decomposed      : Character = "\u{1112}\u{1161}\u{11AB}"    //ᄒ, ᅡ, ᆫ  :Hangul syllables from Korean alphabet
let enclosedEAcute: Character = "\u{E9}\u{20DD}"    //:enable scalars for enclosing marks (COMBINING ENCLOSING CIRCLE, or U+20DD)
let regionalIndicatorForUS: Character = "\u{1F1FA}\u{1F1F8}" //:REGIONAL INDICATOR SYMBOL U (U+1F1FA) + REGIONAL INDICATOR SYMBOL S (U+1F1F8)

//:# Counting Characters
"Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪".characters.count

var word = "cafe"
word.characters.count
word += "\u{301}"    // COMBINING ACUTE ACCENT, U+0301
word.characters.count   //string concatenation and modification may not always affect string character count
//:different representations of same character—can require different amounts of memory to store


//:# Access/Modify String
//:# String Indices : Each String value has associated index type
//: String.Index, which corresponds to positions of each Character it contains.
//: Swift strings not be indexed by integer values
//: If String is empty, startIndex and endIndex are equal
let greeting = "Guten Tag!"
greeting.startIndex     //position of first Character of String
greeting.endIndex       //position after last character in String, not valid argument to string’s subscript
greeting[greeting.startIndex]
greeting[greeting.endIndex.predecessor()]
greeting[greeting.startIndex.successor()]
greeting[greeting.startIndex.advancedBy(7)]
//:Use indices property to create Range of all of indexes used to access individual characters in string
for index in greeting.characters.indices { print("\(greeting[index]) ", terminator: "")}

//:# Insert/Remove
var mywelcome = "hello"
mywelcome.insert("!", atIndex: mywelcome.endIndex)
mywelcome.insertContentsOf(" there".characters, at: mywelcome.endIndex.predecessor()) //insert another string at specified index
mywelcome.removeAtIndex(mywelcome.endIndex.predecessor())       //remove char from string at specified index
mywelcome
mywelcome.removeRange(mywelcome.endIndex.advancedBy(-6)..<mywelcome.endIndex ) //remove substring at specified range


//:# String and Character Equality : checked with (==) and (!=)
let quotation       = "Hello"
let sameQuotation   = "Hello"
if quotation == sameQuotation { print("equal") }

let eAcuteQuestion          = "Voulez-vous un caf\u{E9}?"
let combinedEAcuteQuestion  = "Voulez-vous un caf\u{65}\u{301}?"
if eAcuteQuestion == combinedEAcuteQuestion { print("equal")}

let latinCapitalLetterA     : Character = "\u{41}"
let cyrillicCapitalLetterA  : Character = "\u{0410}"    //:characters visually similar, but not same linguistic meaning
if latinCapitalLetterA != cyrillicCapitalLetterA { print("not equivalent") }

//:# Prefix and Suffix Equality : call hasPrefix(_:) and hasSuffix(_:)
let romeoAndJuliet = [
"Act 1 Scene 1: Verona, A public place",
"Act 1 Scene 2: Capulet's mansion",
"Act 1 Scene 3: A room in Capulet's mansion",
"Act 1 Scene 4: A street outside Capulet's mansion",
"Act 1 Scene 5: The Great Hall in Capulet's mansion",
"Act 2 Scene 1: Outside Capulet's mansion",
"Act 2 Scene 2: Capulet's orchard",
"Act 2 Scene 3: Outside Friar Lawrence's cell",
"Act 2 Scene 4: A street in Verona",
"Act 2 Scene 5: Capulet's mansion",
"Act 2 Scene 6: Friar Lawrence's cell"
]
var act1SceneCount = 0
for scene in romeoAndJuliet { if scene.hasPrefix("Act 1 ") { ++act1SceneCount } }       //hasPrefix() perform character-by-character equivalence
print("\(act1SceneCount) scenes in Act 1")

var mansionCount = 0
var cellCount = 0
for scene in romeoAndJuliet { if scene.hasSuffix("Capulet's mansion") { ++mansionCount } //hasSuffix() perform character-by-character equivalence
else if scene.hasSuffix("Friar Lawrence's cell") { ++cellCount } }
print("\(mansionCount) mansion scenes; \(cellCount) cell scenes")


//:# String Unicode Representation
let dogString = "Dog‼🐶"

//:# UTF-8 : 8-bit
for codeUnit in dogString.utf8 {print("\(codeUnit) ", terminator: "")}
//:(68, 111, 103) represent D, o, and g, //UTF-8 representation is same as ASCII representation
//:(226, 128, 188) UTF-8 representation of DOUBLE EXCLAMATION MARK character !!
//:(240, 159, 144, 182) UTF-8 representation of DOG FACE character

//:# UTF-16 : 16-bit
for codeUnit in dogString.utf16 {print("\(codeUnit) ", terminator: "")}
//:(68, 111, 103) represent D, o, and g //UTF-16 have same values as in UTF-8 representation (Unicode scalars represent ASCII characters)
//:(8252) decimal equivalent of hexadecimal value 203C, which represents Unicode scalar U+203C
//:(55357 and 56374)  UTF-16 surrogate pair representation of DOG FACE character. These are high-surrogate value of U+D83D (decimal value 55357) and low-surrogate value of U+DC36 (decimal value 56374)

//:# Unicode Scalar : 21-bit equivalent to UTF32 (32bit)
for scalar in dogString.unicodeScalars { print("\(scalar.value) ", terminator: "")}
//:(68, 111, 103) once again represent characters D, o, and g
//:(8252) decimal equivalent of hexadecimal value 203C, which represents Unicode scalar U+203C
//:128054, decimal equivalent of hex value 1F436, which represents Unicode scalar U+1F436
//:each UnicodeScalar value can also be used to construct a new String value, such as with string interpolation
for scalar in dogString.unicodeScalars { print("\(scalar) ")}


//:# [String] to String
var array100 = ["1","2","3"]
array100.joinWithSeparator(" , ")

//:# String to [String]
import Foundation
var csbp = "1,2,3".componentsSeparatedByString(",")