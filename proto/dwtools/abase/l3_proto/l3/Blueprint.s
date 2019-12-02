( function _Blueprint_s_() {

'use strict';

let _global = _global_;
let _ = _global_.wTools;

// --
// implementation
// --

function is( src )
{
  return _.isPrototypeOf( _.Blueprint, src );
}

//

function from()
{
  let fields = Object.create( _.Blueprint );
  let definitions = null;

  for( let a = 0 ; a < arguments.length ; a++ )
  {
    extend( arguments[ a ] );
  }

  let constructor;
  if( !definitions )
  constructor = ConstructionWithoutDefinitions;
  else
  constructor = ConstructionWithDefinitions;

  constructor.fields = fields
  constructor.definitions = definitions;
  constructor.routines = null;

  _.blueprint.blueprintToConstructorHash.set( fields, constructor );
  Object.preventExtensions( fields );

  return fields;

  /* */

  function extend( o )
  {

    _.assert( _.mapLike( o ) );
    _.mapExtend( fields, o );
    definitions = definitionsOf( fields );

  }

  /* */

  function ConstructionWithoutDefinitions()
  {
    let construction = Object.assign( Object.create( fields ), fields );
    Object.preventExtensions( construction );
    return construction;
  }

  /* */

  function ConstructionWithDefinitions()
  {
    let construction = Object.assign( Object.create( fields ), fields );
    definitionsInit( construction );
    Object.preventExtensions( construction );
    return construction;
  }

  /* */

  function definitionsInit( construction )
  {
    for( let f in definitions )
    {
      let definition = definitions[ f ];
      if( definition.isMeta )
      continue;
      _.assert( _.routineIs( definition.initialValueGet ) )
      definition.initialValueGet({ fieldName : f });
    }
  }

  /* */

  function definitionsOf( fields )
  {
    for( let f in fields )
    {
      let field = fields[ f ];
      if( _.definitionIs( field ) )
      {
        if( !definitions )
        {
          definitions = Object.create( null );
          break;
        }
      }
    }
    if( definitions )
    for( let f in fields )
    {
      let field = fields[ f ];
      if( _.definitionIs( field ) )
      {
        definitions[ f ] = field;
        delete fields[ f ];
      }
    }
    return definitions;
  }

  /* */

}

//

function constructorOf( blueprint )
{
  return _.blueprint.blueprintToConstructorHash.get( blueprint );
}

//

function construct( blueprint )
{
  let result;
  _.assert( arguments.length === 1 );
  _.assert( _.blueprint.is( blueprint ) );
  let constructor = _.blueprint.constructorOf( blueprint );
  _.assert( _.routineIs( constructor ), 'Cant find constructor for blueprint' );
  let construction2 = constructor();
  return construction2;
}

// --
// declare
// --

let blueprintToConstructorHash = new HashMap();

let Blueprint = Object.create( null );

let _blueprint = function Blueprint()
{
  return _.blueprint.from( ... arguments );
}

let blueprint = _blueprint;

// --
// define blueprint
// --

var Fields =
{
  blueprintToConstructorHash,
}

//

var Routines =
{
  is,
  from,
  constructorOf,
  construct,
}

//

Object.assign( blueprint, Routines );
Object.assign( blueprint, Fields );
_.assert( _.blueprint === undefined );

// --
// define tools
// --

var Fields =
{
  Blueprint,
}

var Routines =
{
  blueprint,
}

Object.assign( _, Routines );
Object.assign( _, Fields );

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = _;

})();
