/*:
# Deinitialization : called immediately before class instance is deallocated
* write deinitializers with deinit keyword, similar to how initializers are written with init keyword
* Deinitializers are only available on class types.

## How Deinitialization Works
* Swift automatically deallocates instances when no longer needed, to free up resources
* Swift handles memory management of instances through ARC
* Typically don’t need to perform manual clean-up when instances are deallocated
* when you are working with own resources, might need to perform some additional clean-up yourself
* if you create custom class to open file and write some data to it, might need to close file before class instance is deallocated
* Class definitions can have at most one deinitializer per class
* deinitializer not take any parameters and is written without parentheses
* deinit { }
* Deinitializers called automatically, just before instance deallocation takes place
* You not allowed to call deinitializer yourself
* Superclass deinitializers are inherited by their subclasses, and superclass deinitializer is called automatically at end of subclass deinitializer implementation
* Superclass deinitializers always called, even if subclass not provide its own deinitializer
* Because instance is not deallocated until after its deinitializer is called, deinitializer can access all properties of instance it is called on and can modify its behavior based on those properties

## Deinitializers in Action
* Here example of deinitializer in action
* example defines two new types, Bank and Player, for simple game
* Bank class manages made-up currency, which can never have more than 10,000 coins in circulation
* There can only ever be one Bank in game, and so Bank is implemented as class with type properties and methods to store and manage its current state */
class Bank {
    static var coinsInBank = 10_000
    static func vendCoins(var numberOfCoinsToVend: Int) -> Int {
        numberOfCoinsToVend = min(numberOfCoinsToVend, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend }
    static func receiveCoins(coins: Int) {
        coinsInBank += coins }
}
/*:
* Bank keeps track of current number of coins it holds with its coinsInBank property
* It also offers two methods—vendCoins(_:) and receiveCoins(_:)—to handle the distribution and collection of coins.
* vendCoins(_:) checks that there are enough coins in bank before distributing them
* If not enough coins, Bank returns smaller number than number that was requested
* vendCoins(_:) declares numberOfCoinsToVend as variable parameter, so that number can be modified within method body without need to declare new variable
* It return integer value to indicate actual number of coins that were provided
* receiveCoins(_:) method simply adds received number of coins back into bank coin store
* Player class describes player in game
* Each player has certain number of coins stored in their purse at any time
* This is represented by player’s coinsInPurse property: */
class Player {
    var coinsInPurse: Int
    init(coins: Int) {
        coinsInPurse = Bank.vendCoins(coins)
    }
    func winCoins(coins: Int) {
        coinsInPurse += Bank.vendCoins(coins)}
    deinit { Bank.receiveCoins(coinsInPurse) }
}
/*:
* Each Player instance is initialized with starting allowance of specified number of coins from bank during initialization, although Player instance may receive fewer than that number if not enough coins available
* Player class defines winCoins(_:) method, which retrieves certain number of coins from bank and adds them to player purse
* Player class also implement deinitializer, which called just before Player instance is deallocated
* deinitializer simply returns all of player coins to bank: */
var playerOne: Player? = Player(coins: 100)
print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
print("There are now \(Bank.coinsInBank) coins left in the bank")
/*:
* new Player instance is created, with request for 100 coins if they are available
* This Player instance is stored in optional Player variable called playerOne
* optional variable is used here, because players can leave game at any point
* optional lets track whether there is currently player in game
* playerOne is optional, qualified with (!) when its coinsInPurse property is accessed to print its default number of coins, and whenever its winCoins(_:) method is called: */
playerOne!.winCoins(2_000)
print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")
print("The bank now only has \(Bank.coinsInBank) coins left")
//: player has won 2,000 coins. player purse now contains 2,100 coins, and bank has only 7,900 coins left
playerOne = nil
print("PlayerOne has left the game")
print("The bank now has \(Bank.coinsInBank) coins")
/*:
* player has now left game
* This is indicated by setting optional playerOne variable to nil, meaning “no Player instance.”
* At point that this happens, playerOne variable reference to Player instance is broken
* No other properties or variables are refer to Player instance, and so it is deallocated in order to free up its memory
* Just before this happens, its deinitializer is called automatically, and its coins are returned to bank */