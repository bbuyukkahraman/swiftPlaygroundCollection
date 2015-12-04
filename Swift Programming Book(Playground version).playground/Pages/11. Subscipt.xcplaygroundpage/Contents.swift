/*:
# Subscript : shortcut for access member elements of Collection/List/Sequence
* use to Set/Retrieve values by index
* access element in Array as someArray[index]
* access element in Dictionary as someDictionary[key]
* can define multiple subscripts for single type
* appropriate subscript overload to use is selected based on type of index value you pass to subscript
* Subscript not limited to single dimension
* can define subscripts with multiple input parameters to suit your custom type’s needs.

## Syntax
* Subscript enables to query instance of type by writing one or more values in [] after instance name
* syntax similar to both instance method syntax and computed property syntax
* write subscript definition with subscript keyword, and specify one or more input parameters and return type
* subscripts can be read-write or read-only */
//subscript(index: Int) -> Int {
//    get {}
//    set(newValue) {}
//}
/*:
* Type of newValue is same as return value of subscript
* As with computed properties, can choose not to specify setter’s (newValue) parameter
* default parameter called newValue is provided to your setter if do not provide one yourself
* example of read-only subscript, which defines a TimesTable structure to represent an n-times-table of integers */
struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {return multiplier * index } }
let threeTimesTable = TimesTable(multiplier: 3)
threeTimesTable[6]

/*:
## Subscript Usage
* meaning of “subscript” depends on context in which it is used
* typically used as shortcut for accessing member elements in collection, list, or sequence
* You are free to implement subscripts in most appropriate way for particular class or struct functionality.
* Dictionary type implement subscript to set and retrieve values stored in Dictionary instance
* can set value in dictionary by providing key of dictionary key type within subscript braces, and assign value of dictionary value type to subscript */
var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
numberOfLegs["bird"] = 2
/*:
* Dictionary type implements its key-value subscripting as a subscript that takes and receives optional type
* key-value subscript takes and returns a value of type Int?, or “optional int”
* Dictionary type uses an optional subscript type to model fact that not every key will have a value, and to give a way to delete a value for a key by assigning a nil value for that key.

## Subscript Options
* can take any number of input parameters, and these input parameters can be of any type
* can also return any type.
* can use variable parameters and variadic parameters, but not use in-out parameters or provide default parameter values.
* class or struct can provide as many subscript implementations as it needs, and appropriate subscript to be used will be inferred based on types of value or values that are contained within subscript braces at point that subscript is used
* This multiple subscripts is known as subscript overloading.
* can also define a subscript with multiple parameters if it is appropriate for your type
* example defines Matrix structure, which represents 2-dimensional matrix of Double values
* Matrix structure’s subscript takes two integer parameters: */
struct Matrix {
let rows: Int, columns: Int
var grid: [Double]
init(rows: Int, columns: Int) { self.rows = rows
self.columns = columns
grid = Array(count: rows * columns, repeatedValue: 0.0) }
func indexIsValidForRow(row: Int, column: Int) -> Bool { return row >= 0 && row < rows && column >= 0 && column < columns }
subscript(row: Int, column: Int) -> Double {
    get { assert(indexIsValidForRow(row, column: column), "Index out of range")
return grid[(row * columns) + column] }
set { assert(indexIsValidForRow(row, column: column), "Index out of range")
grid[(row * columns) + column] = newValue } } }

var matrix = Matrix(rows: 2, columns: 2)
/*:
* example creates new Matrix instance with two rows and two columns.
* grid array for this Matrix instance is effectively a flattened version of matrix, as read from top left to bottom right:
* Values in matrix can be set by passing row and column values into subscript, separated by a comma: */
matrix[0, 1] = 1.5
matrix[1, 0] = 3.2

//func indexIsValidForRow(row: Int, column: Int) -> Bool { return row >= 0 && row < rows && column >= 0 && column < columns }
//: assertion is triggered if you try to access a subscript that is outside of  matrix bounds
//let someValue = matrix[2, 2]
// this triggers an assert, because [2, 2] is outside of the matrix bounds