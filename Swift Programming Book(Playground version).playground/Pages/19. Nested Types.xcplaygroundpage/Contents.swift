/*:
# Nested Types
* Enume often created to support specific class or struct functionality
* Similarly, it can be convenient to define utility classes and struct purely for use within context of a more complex type
* To accomplish this, Swift enables you to define nested types, whereby you nest supporting enum, class, and struct within definition of type they support
* To nest type within another type, write its definition within outer braces of type it supports
* Types can be nested to as many levels as are required.

# Nested Types in Action
* example below defines struct BlackjackCard, which models playing card as used in game of Blackjack
* BlackJack struct contains two nested enum types called Suit and Rank.
* In Blackjack, Ace cards have value of either one or eleven
* This feature is represented by a structure called Values, which is nested within the Rank enumeration */

struct BlackjackCard {
    enum Suit: Character { case Spades = "♠", Hearts = "♡", Diamonds = "♢", Clubs = "♣" }
    enum Rank: Int {
        case Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten
        case Jack, Queen, King, Ace
        struct Values { let first: Int, second: Int? }
        var values: Values {
            switch self {
            case .Ace: return Values(first: 1, second: 11)
            case .Jack, .Queen, .King: return Values(first: 10, second: nil)
            default: return Values(first: self.rawValue, second: nil)
            }
        }
}

let rank: Rank, suit: Suit
var description: String {
    var output = "suit is \(suit.rawValue),"
    output += " value is \(rank.values.first)"
    if let second = rank.values.second {
        output += " or \(second)"
    }
    return output
    }
}
/*:
* Suit enum describes 4 common playing card suits, together with a raw Character value to represent their symbol.
* Rank enum describes 13 possible playing card ranks, together with raw Int value to represent their face value
* This raw Int value is not used for the Jack, Queen, King, and Ace cards
* As mentioned above, Rank enum defines further nested struct of its own, called Values
* This struct encapsulates fact that most cards have one value, but Ace card has two values
* Values struct defines two properties to represent this
* 1st, of type Int
* 2nd, of type Int?, or “optional Int”
* Rank defines computed property, values, which return instance of Values struct
* This computed property considers rank of card and initializes new Values instance with appropriate values based on its rank
* It uses special values for Jack, Queen, King, and Ace
* For numeric cards, it uses rank’s raw Int value.
* BlackjackCard struct itself has two properties—rank and suit
* It also defines computed property called description, which uses values stored in rank and suit to build description of name and value of card
* description property uses optional binding to check whether there is 2nd value to display, and if so, inserts additional description detail for 2nd value
* Because BlackjackCard is struct with no custom initializers, it has implicit memberwise initializer
* use this initializer to initialize new constant called theAceOfSpades */
let theAceOfSpades = BlackjackCard(rank: .Ace, suit: .Spades)
print("theAceOfSpades: \(theAceOfSpades.description)")
//:* Even though Rank and Suit are nested within BlackjackCard, their type can be inferred from context, and so initialization of this instance is able to refer to enum members by their member names (.Ace and .Spades) alone
//:* In example above, description property correctly reports that Ace of Spades has a value of 1 or 11.

//:# Referring to Nested Types
//:* To use nested type outside of its definition context, prefix its name with the name of the type it is nested within
let heartsSymbol = BlackjackCard.Suit.Hearts.rawValue
//:* For example above, this enables names of Suit, Rank, and Values to be kept deliberately short, because their names are naturally qualified by the context in which they are defined