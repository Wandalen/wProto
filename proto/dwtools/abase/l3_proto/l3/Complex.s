( function _Complex_s_() {

'use strict';

let _global = _global_;
let _ = _global_.wTools;

// --
// range
// --

function is( src )
{
  return _.isPrototypeOf( Complex, src );
}

//

function isPrototype( src )
{
  return _.complex.complexToConstructorHash.has( src );
}

//

function isInstance( src )
{
  if( !_.complex.is( src ) )
  return false;
  return _.complex.complexToConstructorHash.has( src );
}

//

function isOf( src, prototype )
{
  if( !_.complex.is( src ) )
  return false;
  return _.isPrototypeOf( prototype, src );
}

//

function from()
{
  let fields = Object.create( Complex );
  let definitions = null;

  for( let a = 0 ; a < arguments.length ; a++ )
  {
    extend( arguments[ a ] );
  }

  let constructor;
  if( !definitions )
  constructor = ComplexWithoutDefinitions;
  else
  constructor = ComplexWithDefinition;

  constructor.fields = fields
  constructor.definitions = definitions;
  constructor.routines = null;

  complexToConstructorHash.set( fields, constructor );
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

  function ComplexWithoutDefinitions()
  {
    let complex = Object.assign( Object.create( fields ), fields );
    Object.preventExtensions( complex );
    return complex;
  }

  /* */

  function ComplexWithDefinition()
  {
    let complex = Object.assign( Object.create( fields ), fields );
    definitionsInit( complex );
    Object.preventExtensions( complex );
    return complex;
  }

  /* */

  function definitionsInit( complex )
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

// function from( o )
// {
//
//   _.assert( arguments.length === 1 );
//   _.assert( _.mapLike( o ) );
//
//   // let ownerCallbackDefinition;
//   let fields = _.mapExtend( Object.create( Complex ), o );
//   let definitions = definitionsOf( fields );
//
//   // debugger;
//   let constructor;
//   // if( ownerCallbackDefinition )
//   // constructor = callable_functor();
//   // else
//   constructor = Simple;
//
//   constructor.fields = fields
//   constructor.definitions = definitionsOf( fields );
//   constructor.routines = null;
//
//   complexToConstructorHash.set( fields, constructor );
//   // Object.setPrototypeOf( Complex, fields );
//   Object.preventExtensions( fields );
//
//   // debugger;
//   return fields;
//
//   /* */
//
//   function Simple()
//   {
//     let complex = Object.assign( Object.create( fields ), fields );
//     return complex;
//   }
//
//   /* */
//
//   // function callable_functor()
//   // {
//   //
//   //   let callback = ownerCallbackDefinition.callback;
//   //   // class CallableComplex extends Function
//   //   // {
//   //   //   constructor()
//   //   //   {
//   //   //     super( 'debugger; return this.ownerCallback.apply( this.routine, arguments );' );
//   //   //     let context = Object.create( null );
//   //   //     let routine = this.bind( context );
//   //   //     context.routine = routine;
//   //   //     context.ownerCallback = ownerCallbackDefinition.callback;
//   //   //     Object.freeze( context );
//   //   //     Object.defineProperty( routine, Symbol.toStringTag,
//   //   //     {
//   //   //       get : function() { return 'Complex' },
//   //   //       enumerable : false,
//   //   //       configurable : false,
//   //   //     });
//   //   //     return routine;
//   //   //   }
//   //   // }
//   //
//   //   let Handler =
//   //   {
//   //     // construct( original, args )
//   //     // {
//   //     //   debugger;
//   //     //   return callback.apply( thisArgs, args );
//   //     // },
//   //     apply : function apply( original, thisArg, args )
//   //     {
//   //       debugger;
//   //       return callback.apply( thisArgs, args );
//   //     },
//   //   };
//   //
//   //   return function Callable()
//   //   {
//   //     // debugger;
//   //
//   //     let complex = Object.assign( Object.create( fields ), fields );
//   //
//   //     if( definitions )
//   //     definitionsInit( complex );
//   //
//   //     Object.defineProperty( complex, Symbol.toStringTag,
//   //     {
//   //       get : function() { return 'Function' },
//   //       enumerable : false,
//   //       configurable : false,
//   //     });
//   //
//   //     let callableComplex = new Proxy( complex, Handler );
//   //     callableComplex.original = complex;
//   //
//   //     // let complex = Object.assign( new CallableComplex( ownerCallbackDefinition.callback ), fields );
//   //     // if( definitions )
//   //     // definitionsInit( callableComplex );
//   //     // debugger;
//   //
//   //     return callableComplex;
//   //   }
//   //
//   // }
//
//   /* */
//
//   function definitionsInit( complex )
//   {
//     for( let f in definitions )
//     {
//       let definition = definitions[ f ];
//       if( definition.isMeta )
//       continue;
//       _.assert( _.routineIs( definition.initialValueGet ) )
//       definition.initialValueGet({ fieldName : f });
//     }
//   }
//
//   /* */
//
//   function definitionsOf( fields )
//   {
//     let definitions = null;
//     for( let f in fields )
//     {
//       let field = fields[ f ];
//       if( _.definitionIs( field ) )
//       {
//         if( !definitions )
//         {
//           definitions = Object.create( null );
//           break;
//         }
//       }
//     }
//     if( definitions )
//     for( let f in fields )
//     {
//       let field = fields[ f ];
//       if( _.definitionIs( field ) )
//       {
//         definitions[ f ] = field;
//         delete fields[ f ];
//         // if( field.kind === 'ownerCallback' )
//         // ownerCallbackDefinition = field;
//       }
//     }
//     return definitions;
//   }
//
//   /* */
//
// }

//

function constructorOf( complex )
{
  return complexToConstructorHash.get( complex );
}

//

function make( complex )
{
  let result;
  _.assert( arguments.length === 1 );
  _.assert( _.isPrototypeOf( Complex, complex ) );
  let constructor = _.complex.constructorOf( complex );
  let complex2 = constructor();
  return complex2;
}

// --
// declare
// --

let complexToConstructorHash = new HashMap();

// class Complex
// {
//   static [ Symbol.hasInstance ]( instance )
//   {
//     return is( instance );
//   }
// }

// class CallableComplex extends Function
// {
//   constructor( ownerCallback )
//   {
//     debugger;
//     super( 'debugger; return this.ownerCallback.apply( this.routine, arguments );' );
//     let context = Object.create( null );
//     let routine = this.bind( context );
//     context.routine = routine;
//     context.ownerCallback = ownerCallback;
//     // context.ownerCallback = ownerCallbackDefinition.callback;
//     Object.freeze( context );
//     Object.defineProperty( routine, Symbol.toStringTag,
//     {
//       get : function() { return 'Complex' },
//       enumerable : false,
//       configurable : false,
//     });
//     return routine;
//   }
// }

let Complex = Object.create( null );

// let complex = Object.create( null );

let _complex = function Complex()
{
  return from( ... arguments );
}

let complex = _complex;

// Complex[ Symbol.hasInstance ] = function hasInstance( instance )
// {
//   return is( instance );
// }

// let Handler =
// {
//   construct( original, args )
//   {
//     return _complex( ... args );
//   }
// };
//
// let complex = new Proxy( _complex, Handler );
// complex.original = _complex;

// let Self = Complex;

//

var Fields =
{
  Complex,
  complexToConstructorHash,
}

//

var Routines =
{
  is,
  isPrototype,
  isInstance,
  isOf,
  from,
  constructorOf,
  make,
  construct : make,
}

//

Object.assign( complex, Routines );
Object.assign( complex, Fields );
_.assert( _.complex === undefined );
_.complex = complex;

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = complex;

})();
