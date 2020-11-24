# Instances construction

Routine `_.workpiece.construct` is used for instances construction.

### Benefits:
* Constructors have standart behaviour( identical and predictable ).
* Reusable code.
* Functional.

### Details:
* Returns an instance that was passed as an argument if it's an instance of the same class.
* Calls `init` method of the class - optional method to initialize instance with options.
* Call with `new` changes the behaviour: always a new instance is returned.
* Advanced: An array can be processed: returns an array with passed arguments ( if they are instances of the same class ) and newly created instances.

### Example

```javascript
var Constructor = function Constructor()
{
  return _.workpiece.construct( Constructor, this, arguments );
}

function init()
{
  counter += 1;
}

var counter = 0;
var Extension =
{
  init,
}

_.classDeclare
({
  cls : BasicConstructor,
  parent : null,
  extend : Extension,
});

var instance = Constructor();

console.log( instance instanceof BasicConstructor );
// log : true
console.log( instance.constructor === BasicConstructor );
// log : true
console.log( instance.init === init );
// log : true
console.log( counter === 1 );
// log : true

```

<!---
Міні план
Конструювання інстансів
- викликається метод init
- робляться певні перевірки ?
- потрібна для того щоб конструктори стандартно поводились ( однаково і передбачувано ),
щоб не переписувати код багато разів,
функціонально ( конструктори роблять що роблять )
- повертаємо екземпляр який був аргументом, якщо це екземпляр цього ж класу ( виклик без new )
- new змінює поведінку конструктора.
- Продвинута ( advanced ) поведінка ? ( можна опрацювати масив )
-->