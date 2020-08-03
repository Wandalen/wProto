# Instances construction

Routine `_.workpiece.construct` is used for instances construction.

### Benefits:
* Constructors have standart behaviour( identical and predictable ).
* Reusable code.
* Functional.

### Details:
* Returns an instance that was passed as an argument if it's an instance of the same class.
* Calls `init` method of the class.
* Call with `new` changes the behaviour: always a new instance is returned.
* Advanced: An array can be processed.

### Example

```javascript
var Constructor = function Constructor()
{
    return _.workpiece.construct( Constructor, this, arguments );
}

var instance = Constructor();
```