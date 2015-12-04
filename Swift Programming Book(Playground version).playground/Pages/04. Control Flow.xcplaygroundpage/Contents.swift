/*:
# Control Flow
* for and while : to perform task multiple times
* if, guard, and switch : execute different branches of code based on certain conditions
* break and continue : transfer flow of execution to another point in code
* for-in loop : iteration over array, dictionary, range, string, and other sequences
* in switch complex match conditions can be expressed with where clause for each case

### For-In
* perform statement set for each item in sequence
* to iterate over sequence, such as ranges of numbers, items in array, or characters in string */
for index in 1...5 { print("\(index) times 5 is \(index * 5)")}

let base = 3
let power = 10
var answer = 1
for _ in 1...power { answer *= base }
print("\(base) to the power of \(power) is \(answer)")

//: for-in with array iteration
let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names { print("Hello, \(name)!")}

//: for-in with dictionary iteration
let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs { print("\(animalName)s have \(legCount) legs")}

//:### For
//:* perform statement set until specific condition met, typically by incrementing counter each time loop ends
for var index = 0; index < 3; ++index { print("index is \(index)")}

var index: Int
for index = 0; index < 3; ++index { print("index is \(index)")}
print("The loop statements were executed \(index) times")

/*:
## While Loops
* perform set of statements until condition becomes false
* best used when number of iterations is not known before first iteration begins
* while evaluates its condition at start of each pass through loop
* repeat-while evaluates its condition at end of each pass through loop

### While
* while loop starts by evaluating single condition
* If condition true, set of statements is repeated until condition becomes false
* example play simple game of Snakes and Ladders, rules of game are as follows:
* board has 25 squares, and aim is to land on or beyond square 25
* Each turn, you roll 6-sided dice and move by that number of squares, following horizontal path indicated by dotted arrow above.
* If your turn ends at bottom of ladder, you move up that ladder
* If your turn ends at head of snake, you move down that snake
* game board is represented by array of Int values
* Its size is based on constant called finalSquare, which is used to initialize array and also to check for a win condition later in example
* board is initialized with 26 zero Int values, not 25 (one each at indexes 0 through 25 inclusive) */
let finalSquare = 25
var board = [Int](count: finalSquare + 1, repeatedValue: 0)
//:* Some squares are then set to have more specific values for snakes and ladders
//:* Squares with ladder base have positive number to move you up board
//:* squares with snake head have negative number to move you back down board
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
/*:
* Square 3 contains bottom of ladder that moves you up to square 11
* to represent this, board[03] is equal to +08, which is equivalent to an integer value of 8 (difference between 3 and 11)
* unary plus operator (+i) balances with unary minus operator (-i), and numbers lower than 10 are padded with zeros so that all board definitions align
* Neither stylistic tweak is strictly necessary, but they lead to neater code
* player’s starting square is “square zero”, which is just off bottom left corner of board
* first dice roll always moves player on to board */
var square = 0
var diceRoll = 0
while square < finalSquare { /*roll dice*/ if ++diceRoll == 7 { diceRoll = 1 } /*move by rolled amount*/
square += diceRoll
if square < board.count {/*if we're still on board, move up or down for a snake or a ladder*/
square += board[square] }
}
print("Game over!")



/*:
* example uses very simple approach to dice rolling
* Instead of random number generator, it starts with diceRoll value of 0
* Each time through while loop, diceRoll is incremented with prefix increment operator (++i)
* then checked to see if it has become too large
* return value of ++diceRoll is equal to value of diceRoll after it is incremented
* Whenever this return value equals 7, dice roll has become too large, and is reset to value of 1
* This gives sequence of diceRoll values that is always 1, 2, 3, 4, 5, 6, 1, 2 and so on.
* After rolling dice, player moves forward by diceRoll squares
* It’s possible that dice roll may have moved player beyond square 25, in which case game is over
* To cope with this scenario, code checks that square is less than board array’s count property before adding value stored in board[square] onto current square value to move player up or down any ladders or snakes
* Had this check not been performed, board[square] might try to access value outside bounds of board array, which would trigger error
* If square is now equal to 26, code would try to check value of board[26], which larger than array size
* current while loop then ends, and loop’s condition is checked to see if loop should be executed again
* If player has moved on or beyond square number 25, loop condition evaluates to false, and game ends
* while loop is appropriate in this case because length of game is not clear at start of while loop
* Instead, loop is executed until particular condition is satisfied

### Repeat-While
* perform single pass through loop block first, before considering loop’s condition
* It then continues to repeat loop until condition is false
* repeat { statements } while condition
* Snakes and Ladders, written as repeat-while loop rather than while loop
* values of finalSquare, board, square, and diceRoll are initialized in exactly same way as while loop */
let myfinalSquare = 25
var myboard = [Int](count: myfinalSquare + 1, repeatedValue: 0)
myboard[03] = +08; myboard[06] = +11; myboard[09] = +09; myboard[10] = +02
myboard[14] = -10; myboard[19] = -11; myboard[22] = -02; myboard[24] = -08
var mysquare = 0
var mydiceRoll = 0
/*:
* first action in loop is to check for ladder or snake
* No ladder on board takes player straight to square 25, and not possible to win game by moving up  ladder
* Therefore, it is safe to check for snake or ladder as first action in loop
* At start of game, player is on “square zero”. board[0] always equals 0, and has no effect */
repeat { mysquare += myboard[mysquare]
    if ++mydiceRoll == 7 { mydiceRoll = 1 }
    mysquare += mydiceRoll }
    while mysquare < myfinalSquare
print("Game over!")
/*:
* After code checks for snakes and ladders, dice is rolled, and player is moved forward by diceRoll squares
* current loop execution then ends
* loop’s condition (while square < finalSquare) is same as before, but this time not evaluated until end of first run through loop
* structure of repeat-while loop is better suited to this game than while loop
* square += board[square] always executed after loop’s while condition confirms that square is still on board
* This behavior removes need for array bounds check seen in earlier version of game

## Conditional Statements
* execute different pieces of code based on certain conditions
* want to run extra piece of code when error occurs, or display message when value becomes too high or too low
* use if statement to evaluate simple conditions with only few possible outcomes
* switch statement for complex conditions with multiple possible permutations, and useful where pattern-matching

## If
* executes statement set only if that condition is true */
var temperatureInFahrenheit = 30
if temperatureInFahrenheit <= 32 { print("Cold.")}

//:* if statement provide alternative statement set, known as else clause, for if condition is false
temperatureInFahrenheit = 40
if temperatureInFahrenheit <= 32 { print("Cold") } else {print("not cold")}

//:* You can chain multiple if statement together, to consider additional clauses
temperatureInFahrenheit = 90
if temperatureInFahrenheit <= 32 { print("Cold")}
else if temperatureInFahrenheit >= 86 {print("It's really warm")}
else { print("It's not that cold")}

temperatureInFahrenheit = 72
if temperatureInFahrenheit <= 32 { print("It's very cold")}
else if temperatureInFahrenheit >= 86 {print("It's really warm")}

/*:
# Switch
* considers value and compares it against several possible matching patterns
* then executes appropriate block, based on first pattern that matches successfully
* switch statement consists of multiple possible cases, each of which begins with case keyword
* switch statement determines which branch should be selected
* every switch statement must be exhaustive */
let someCharacter: Character = "e"
switch someCharacter {
case "a", "e", "i", "o", "u": print("\(someCharacter) is a vowel")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z": print("\(someCharacter) is a consonant")
default:print("\(someCharacter) is not a vowel or a consonant")
}

/*:
### No Implicit Fallthrough
* switch not fall through bottom of each case and into next one by default
* Instead, entire switch statement finishes its execution as soon as first matching switch case is completed, without requiring explicit break statement
* This makes switch safer and easier to use, and avoids executing more than one switch case by mistake
* break not required in Swift, you can still use break statement to match and ignore particular case, or to break out of a matched case before that case has completed its execution */
let anotherCharacter: Character = "a"
switch anotherCharacter {
case "a": break
case "A": print("The letter A")
default: print("Not the letter A")
}

switch anotherCharacter  {
case "a": fallthrough
case "A": print("The letter A")
default: print("Not the letter A")
}

//: * switch statement does not match both "a" and "A"
//: * To opt in to fallthrough behavior for particular switch case, use fallthrough keyword */

//:### Interval Matching
let approximateCount = 62
let countedThings = "moons orbiting Saturn"
var naturalCount: String
switch approximateCount {
case 0: naturalCount = "no"
case 1..<5: naturalCount = "a few"
case 5..<12: naturalCount = "several"
case 12..<100: naturalCount = "dozens of"
case 100..<1000: naturalCount = "hundreds of"
default: naturalCount = "many" }
print("There are \(naturalCount) \(countedThings).")

//:### Tuples
//:* use tuples to test multiple values in same switch
//:* Each element of tuple can be tested against different value or interval of values
//:* Alternatively, use (_) identifier to match any possible value
let somePoint = (1, 1)
switch somePoint {
case (0, 0): print("(0, 0) is at the origin")
case (_, 0): print("(\(somePoint.0), 0) is on the x-axis")
case (0, _): print("(0, \(somePoint.1)) is on the y-axis")
case (-2...2, -2...2): print("(\(somePoint.0), \(somePoint.1)) is inside the box")
default: print("(\(somePoint.0), \(somePoint.1)) is outside of the box") }

//:### Value Bindings
//:* switch case can bind value it matches to temporary constants or variables, for use in body of case
//:* values are “bound” to temporary constants or variables within case’s body.
let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0): print("on the x-axis with an x value of \(x)")
case (0, let y): print("on the y-axis with a y value of \(y)")
case let (x, y): print("somewhere else at (\(x), \(y))")}
//:* it match all possible remaining values, and default case not needed to make switch exhaustive

//:### Where
//:* switch case can use where clause to check for additional conditions
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y: print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y: print("(\(x), \(y)) is on the line x == -y")
case let (x, y): print("(\(x), \(y)) is just some arbitrary point") }
//:* constants used as part of where clause, to create a dynamic filter
//:* final case match all possible remaining values, and so default case is not needed

/*:
## Control Transfer Statements
* change order in which code is executed, by transferring control from one piece of code to another
* Swift has 5 control transfer statements:
* continue * break  * fallthrough  * return  * throw

### Continue
* says “I am done with current loop iteration” without leaving loop altogether
* In for loop with condition and incrementer, loop’s incrementer is still evaluated after calling continue
* loop itself continues to work as usual; only code within loop’s body is skipped.
* example removes all vowels and spaces from lowercase string to create cryptic puzzle phrase */
let puzzleInput = "great minds think alike"
var puzzleOutput = ""
for character in puzzleInput.characters {
switch character {
case "a", "e", "i", "o", "u", " ": continue
default: puzzleOutput.append(character) }
}
print(puzzleOutput)

/*:
### Break
* ends execution of entire control flow statement immediately
* used inside switch or loop to terminate execution of switch or loop earlier than would otherwise be case.

### Break in Loop
* ends loop’s execution, and transfers control to first line of code after loop’s closing brace (})
* No further code from current iteration of loop is executed, and no further iterations of loop are started.

### Break in Switch
* causes switch to end execution, and to transfer control to first line of code after switch closing brace (})
* This behavior can be used to match and ignore one or more cases in a switch statement
* Always use break statement to ignore a switch case*/
let numberSymbol: Character = "三"  // Simplified Chinese for number 3
var possibleIntegerValue: Int?
switch numberSymbol {
case "1", "١", "一", "๑": possibleIntegerValue = 1
case "2", "٢", "二", "๒": possibleIntegerValue = 2
case "3", "٣", "三", "๓": possibleIntegerValue = 3
case "4", "٤", "四", "๔": possibleIntegerValue = 4
default: break
}
if let integerValue = possibleIntegerValue { print("The integer value of \(numberSymbol) is \(integerValue).")}
else { print("An integer value could not be found for \(numberSymbol).")}

/*:
### Fallthrough
* Switch not fall through bottom of each case and into next one
* Instead, entire switch statement completes its execution as soon as first matching case is completed */
let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19: description += " a prime number, and also"
fallthrough
default: description += " an integer." }
print(description)
/*:
* uses fallthrough keyword to “fall into” default case as well
* default case adds some extra text to end of description, and switch statement is complete.
* fallthrough keyword does not check case conditions for switch case that it causes execution to fall into

### Labeled Statements
* nest loops and conditional inside other loops and conditional to create complex control flow structures.
* loops and conditional can both use break statement to end their execution prematurely
* sometimes useful to be explicit about which loop or conditional want break statement to terminate
* for have multiple nested loops, useful to be explicit about which loop continue should affect.
* mark loop or conditional with statement label.
* With conditional, use label with break to end execution of labeled statement
* with loop, use label with break or continue to end or continue execution of labeled statement.
* labeled statement indicated by placing label on same line as statement’s introducer keyword, followed by colon
* label name: while condition { statements } */
let newfinalSquare = 25
var newboard = [Int](count: newfinalSquare + 1, repeatedValue: 0)
newboard[03] = +08; newboard[06] = +11; newboard[09] = +09; newboard[10] = +02
newboard[14] = -10; newboard[19] = -11; newboard[22] = -02; newboard[24] = -08
var newsquare = 0
var newdiceRoll = 0
/*:
* this version uses while loop and switch to implement game’s logic
* while loop has a statement label called gameLoop, to indicate that it is main game loop for game
* while loop’s condition is while square != finalSquare, to reflect that must land exactly on square 25 */
gameLoop: while newsquare != newfinalSquare { if ++newdiceRoll == 7 { newdiceRoll = 1 }
switch newsquare + newdiceRoll { case newfinalSquare:
    break gameLoop
case let newSquare where newSquare > newfinalSquare:
    continue gameLoop
default:
    newsquare += newdiceRoll
    newsquare += newboard[newsquare] }}
print("Game over!")
/*:
* break gameLoop transfers control to first line of code outside of while loop, which ends game
* If dice roll will move player beyond final square, move is invalid, and player needs to roll again
* continue gameLoop ends the current while loop iteration and begins the next iteration of the loop.
* In all other cases, dice roll is valid move
* player moves forward by diceRoll squares, and game logic checks for any snakes and ladders
* loop then ends, and control returns to while condition to decide whether another turn is required.
* If break statement above did not use gameLoop label, it would break out of switch, not while statement
* Using gameLoop label makes it clear which control statement should be terminated.
* not strictly necessary to use gameLoop label when calling continue gameLoop to jump to next iteration of loop
* There is only one loop in game, and so there is no ambiguity as to which loop continue will affect
* there is no harm in using gameLoop label with continue statement
* Doing so is consistent with label’s use alongside break, and helps make game’s logic cleaner to read

###Early Exit
* guard statement, like if, executes statements depending on Boolean value of expression
* use guard to require that condition must be true in order for code after guard to be executed
* guard always has else clause— else clause is executed if condition is not true */
func greet(person: [String: String]) {
    guard let name = person["name"] else { return }
    print("Hello \(name)!")
    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return }
    print("I hope the weather is nice in \(location).")}
greet(["name": "John"])
greet(["name": "Jane", "location": "Cupertino"])
/*:
* If guard condition is met, code execution continues after guard statement’s closing brace


### Checking API Availability
* ensures that don’t accidentally use APIs that are unavailable on given deployment target.
* compiler uses availability information in SDK to verify that all APIs used in code are available
* Swift reports error at compile time if you try to use API that isn’t available.
* use availability condition in if or guard to conditionally execute code block, depending APIs available
* compiler uses info from availability condition when verifies that APIs in that block of code are available */
if #available(iOS 9, OSX 10.10, *) { // Use iOS 9 APIs on iOS, and use OS X v10.10 APIs on OS X
} else { // Fall back to earlier iOS and OS X APIs 
}
/*:
* availability condition specifies that on iOS, body of if executes only on iOS 9 and later; on OS X, only on OS X v10.10 and later
* (*), is required and specifies that on any other platform, body of if executes on minimum deployment target specified by target.
* use iOS, OSX, and watchOS for platform names
* In addition to specifying major version numbers like iOS 8, you can specify minor versions numbers like iOS 8.3 and OS X v10.10.3 */




//:==============================
//:## Control Flow
let individualScores = [75, 43, 103, 87, 12]
var teamScore = 0
for score in individualScores {
    if score > 50 {teamScore += 3}
    else {teamScore += 1}
}
print(teamScore)

/*:
* `if` statement, conditional must be Boolean expression.
* Use `if` and `let` together to work with values that might be missing
* These values represented as optionals.
* Optional value either contains value or `nil` (value is missing).
* Write (`?`) after type of value to mark value as optional */
var optionalString: String? = "Hello"
print(optionalString == nil)
var optionalName: String? = "John Appleseed"
var greeting = "Hello!"
if let name = optionalName { greeting = "Hello, \(name)"}

/*:
* If optional value is `nil`, conditional is `false` and code in braces is skipped.
* Otherwise, optional value is unwrapped and assigned to constant after `let`, which makes unwrapped value available inside block of code.
* Switches support any kind of data and wide variety of comparison operations */
let vegetable = "red pepper"
switch vegetable {
case "celery": let vegetableComment = "Add some raisins and make ants on a log."
case "cucumber", "watercress": let vegetableComment = "That would make a good tea sandwich."
case let x where x.hasSuffix("pepper"):let vegetableComment = "Is it a spicy \(x)?"
default:let vegetableComment = "Everything tastes good in soup."
}

/*:
* `let` used in pattern to assign value that matched that part of a pattern to a constant.
* After executing code inside switch case that matched, program exits from switch statement
* Execution not continue to next case.
* Not need to explicitly break out of switch at end of each case.
* Use `for`-`in` to iterate over items in dictionary by providing pair of names to use for each key-value pair.
* Dictionaries are unordered collection
* Their keys and values are iterated over in arbitrary order */
let interestingNumbers = ["Prime": [2, 3, 5, 7, 11, 13], "Fibonacci": [1, 1, 2, 3, 5, 8], "Square": [1, 4, 9, 16, 25],]
var largest = 0
for (kind, numbers) in interestingNumbers {
    for number in numbers { if number > largest { largest = number }}
}
print(largest)

/*:
* Use `while` to repeat block of code until a condition changes.
* Condition of a loop can be at end instead, ensuring that loop is run at least once */
var n = 2
while n < 100 { n = n * 2 }
print(n)
var m = 2
repeat { m = m * 2 } while m < 100
print(m)

//: keep index in loop—either by using `..<` to make range of indexes or by writing explicit initialization, condition, and increment.
var firstForLoop = 0
for i in 0..<4 { firstForLoop += i }
print(firstForLoop)
var secondForLoop = 0
for var i = 0; i < 4; ++i { secondForLoop += i }
print(secondForLoop)