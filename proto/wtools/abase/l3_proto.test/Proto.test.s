( function _Proto_test_s_( ) {

'use strict';

/*
xxx : split the test suite
*/

if( typeof module !== 'undefined' )
{

  let _ = require( '../../../wtools/Tools.s' );

  _.include( 'wTesting' );
  _.include( 'wEqualer' );

  require( '../../abase/l3_proto/Include.s' );

}

let _global = _global_;
let _ = _global_.wTools;

// --
// test
// --

function instanceIs( t )
{
  var self = this;

  t.will = 'pure map';
  t.true( !_.instanceIs( Object.create( null ) ) );

  t.will = 'map';
  t.true( !_.instanceIs( {} ) );

  t.will = 'primitive';
  t.true( !_.instanceIs( 0 ) );
  t.true( !_.instanceIs( 1 ) );
  t.true( !_.instanceIs( '1' ) );
  t.true( !_.instanceIs( null ) );
  t.true( !_.instanceIs( undefined ) );

  t.will = 'routine';
  t.true( !_.instanceIs( Date ) );
  t.true( !_.instanceIs( F32x ) );
  t.true( !_.instanceIs( function(){} ) );
  t.true( !_.instanceIs( Self.constructor ) );

  t.will = 'long';
  t.true( _.instanceIs( [] ) );
  t.true( _.instanceIs( new F32x() ) );

  t.will = 'object-like';
  t.true( _.instanceIs( /x/ ) );
  t.true( _.instanceIs( new Date() ) );
  t.true( _.instanceIs( new (function(){})() ) );
  t.true( _.instanceIs( Self ) );

  t.will = 'object-like prototype';
  t.true( !_.instanceIs( Object.getPrototypeOf( [] ) ) );
  t.true( !_.instanceIs( Object.getPrototypeOf( /x/ ) ) );
  t.true( !_.instanceIs( Object.getPrototypeOf( new Date() ) ) );
  t.true( !_.instanceIs( Object.getPrototypeOf( new F32x() ) ) );
  t.true( !_.instanceIs( Object.getPrototypeOf( new (function(){})() ) ) );
  t.true( !_.instanceIs( Object.getPrototypeOf( Self ) ) );

}

//

function instanceIsStandard( t )
{
  var self = this;

  t.will = 'pure map';
  t.true( !_.instanceIsStandard( Object.create( null ) ) );

  t.will = 'map';
  t.true( !_.instanceIsStandard( {} ) );

  t.will = 'primitive';
  t.true( !_.instanceIsStandard( 0 ) );
  t.true( !_.instanceIsStandard( 1 ) );
  t.true( !_.instanceIsStandard( '1' ) );
  t.true( !_.instanceIsStandard( null ) );
  t.true( !_.instanceIsStandard( undefined ) );

  t.will = 'routine';
  t.true( !_.instanceIsStandard( Date ) );
  t.true( !_.instanceIsStandard( F32x ) );
  t.true( !_.instanceIsStandard( function(){} ) );
  t.true( !_.instanceIsStandard( Self.constructor ) );

  t.will = 'long';
  t.true( !_.instanceIsStandard( [] ) );
  t.true( !_.instanceIsStandard( new F32x() ) );

  t.will = 'object-like';
  t.true( !_.instanceIsStandard( /x/ ) );
  t.true( !_.instanceIsStandard( new Date() ) );
  t.true( !_.instanceIsStandard( new (function(){})() ) );
  t.true( _.instanceIsStandard( Self ) );

  t.will = 'object-like prototype';
  t.true( !_.instanceIsStandard( Object.getPrototypeOf( [] ) ) );
  t.true( !_.instanceIsStandard( Object.getPrototypeOf( /x/ ) ) );
  t.true( !_.instanceIsStandard( Object.getPrototypeOf( new Date() ) ) );
  t.true( !_.instanceIsStandard( Object.getPrototypeOf( new F32x() ) ) );
  t.true( !_.instanceIsStandard( Object.getPrototypeOf( new (function(){})() ) ) );
  t.true( !_.instanceIsStandard( Object.getPrototypeOf( Self ) ) );

}

//

function prototypeIs( t )
{
  var self = this;

  t.will = 'pure map';
  t.true( !_.prototypeIs( Object.create( null ) ) );

  t.will = 'map';
  t.true( !_.prototypeIs( {} ) );

  t.will = 'primitive';
  t.true( !_.prototypeIs( 0 ) );
  t.true( !_.prototypeIs( 1 ) );
  t.true( !_.prototypeIs( '1' ) );
  t.true( !_.prototypeIs( null ) );
  t.true( !_.prototypeIs( undefined ) );

  t.will = 'routine';
  t.true( !_.prototypeIs( Date ) );
  t.true( !_.prototypeIs( F32x ) );
  t.true( !_.prototypeIs( function(){} ) );
  t.true( !_.prototypeIs( Self.constructor ) );

  t.will = 'object-like';
  t.true( !_.prototypeIs( [] ) );
  t.true( !_.prototypeIs( /x/ ) );
  t.true( !_.prototypeIs( new Date() ) );
  t.true( !_.prototypeIs( new F32x() ) );
  t.true( !_.prototypeIs( new (function(){})() ) );
  t.true( !_.prototypeIs( Self ) );

  t.will = 'object-like prototype';
  t.true( _.prototypeIs( Object.getPrototypeOf( [] ) ) );
  t.true( _.prototypeIs( Object.getPrototypeOf( /x/ ) ) );
  t.true( _.prototypeIs( Object.getPrototypeOf( new Date() ) ) );
  t.true( _.prototypeIs( Object.getPrototypeOf( new F32x() ) ) );
  t.true( _.prototypeIs( Object.getPrototypeOf( new (function(){})() ) ) );
  t.true( _.prototypeIs( Object.getPrototypeOf( Self ) ) );

}

//

function constructorIs( t )
{
  var self = this;

  t.will = 'pure map';
  t.true( !_.constructorIs( Object.create( null ) ) );

  t.will = 'map';
  t.true( !_.constructorIs( {} ) );

  t.will = 'primitive';
  t.true( !_.constructorIs( 0 ) );
  t.true( !_.constructorIs( 1 ) );
  t.true( !_.constructorIs( '1' ) );
  t.true( !_.constructorIs( null ) );
  t.true( !_.constructorIs( undefined ) );

  t.will = 'routine';
  t.true( _.constructorIs( Date ) );
  t.true( _.constructorIs( F32x ) );
  t.true( _.constructorIs( function(){} ) );
  t.true( _.constructorIs( Self.constructor ) );

  t.will = 'object-like';
  t.true( !_.constructorIs( [] ) );
  t.true( !_.constructorIs( /x/ ) );
  t.true( !_.constructorIs( new Date() ) );
  t.true( !_.constructorIs( new F32x() ) );
  t.true( !_.constructorIs( new (function(){})() ) );
  t.true( !_.constructorIs( Self ) );

  t.will = 'object-like prototype';
  t.true( !_.constructorIs( Object.getPrototypeOf( [] ) ) );
  t.true( !_.constructorIs( Object.getPrototypeOf( /x/ ) ) );
  t.true( !_.constructorIs( Object.getPrototypeOf( new Date() ) ) );
  t.true( !_.constructorIs( Object.getPrototypeOf( new F32x() ) ) );
  t.true( !_.constructorIs( Object.getPrototypeOf( new (function(){})() ) ) );
  t.true( !_.constructorIs( Object.getPrototypeOf( Self ) ) );

}

//

function prototypeIsStandard( t )
{
  var self = this;

  t.will = 'pure map';
  t.true( !_.prototypeIsStandard( Object.create( null ) ) );

  t.will = 'map';
  t.true( !_.prototypeIsStandard( {} ) );

  t.will = 'primitive';
  t.true( !_.prototypeIsStandard( 0 ) );
  t.true( !_.prototypeIsStandard( 1 ) );
  t.true( !_.prototypeIsStandard( '1' ) );
  t.true( !_.prototypeIsStandard( null ) );
  t.true( !_.prototypeIsStandard( undefined ) );

  t.will = 'routine';
  t.true( !_.prototypeIsStandard( Date ) );
  t.true( !_.prototypeIsStandard( F32x ) );
  t.true( !_.prototypeIsStandard( function(){} ) );
  t.true( !_.prototypeIsStandard( Self.constructor ) );

  t.will = 'object-like';
  t.true( !_.prototypeIsStandard( [] ) );
  t.true( !_.prototypeIsStandard( /x/ ) );
  t.true( !_.prototypeIsStandard( new Date() ) );
  t.true( !_.prototypeIsStandard( new F32x() ) );
  t.true( !_.prototypeIsStandard( new (function(){})() ) );
  t.true( !_.prototypeIsStandard( Self ) );

  t.will = 'object-like prototype';
  t.true( !_.prototypeIsStandard( Object.getPrototypeOf( [] ) ) );
  t.true( !_.prototypeIsStandard( Object.getPrototypeOf( /x/ ) ) );
  t.true( !_.prototypeIsStandard( Object.getPrototypeOf( new Date() ) ) );
  t.true( !_.prototypeIsStandard( Object.getPrototypeOf( new F32x() ) ) );
  t.true( !_.prototypeIsStandard( Object.getPrototypeOf( new (function(){})() ) ) );
  t.true( _.prototypeIsStandard( Object.getPrototypeOf( Self ) ) );

}

//

function accessor( test )
{

  /* */

  test.case = 'setter';
  var Alpha = function _Alpha(){}
  _.classDeclare
  ({
    cls : Alpha,
    parent : null,
    extend :
    {
      _aSet : function( src )
      {
        this[ Symbol.for( 'a' ) ] = src * 2;
      },
      Composes : {}
    }
  });
  _.accessor.declare( Alpha.prototype, { a : 'a' } );
  var x = new Alpha();
  x.a = 5;
  var got = x.a;
  var expected = 10;
  test.identical( got, expected );

  /* */

  test.case = 'getter';
  var Alpha = function _Alpha(){}
  _.classDeclare
  ({
    cls : Alpha,
    parent : null,
    extend :
    {
      _aGet : function()
      {
        return this[ Symbol.for( 'a' ) ] * 2;
      },
      Composes : {}
    }
  });
  _.accessor.declare( Alpha.prototype, { a : 'a' } );
  var x = new Alpha();
  x.a = 5;
  var got = x.a;
  var expected = 10;
  test.identical( got, expected );

  /* */

  test.case = 'getter & setter';
  var Alpha = function _Alpha(){}
  _.classDeclare
  ({
    cls : Alpha,
    parent : null,
    extend :
    {
      _aSet : function( src )
      {
        this[ Symbol.for( 'a' ) ] = src * 2;
      },
      _aGet : function()
      {
        return this[ Symbol.for( 'a' ) ] / 2;
      },
      Composes : {}
    }
  });
  _.accessor.declare( Alpha.prototype, { a : 'a' } );
  var x = new Alpha();
  x.a = 5;
  var got = x.a;
  var expected = 5;
  test.identical( got, expected );

  /* */

  test.case = 'has constructor only';
  var dst = { constructor : function(){}, };
  var exp = { 'constructor' : dst.constructor, 'a' : 'a1' };
  _.accessor.declare( dst, { a : 'a' } );
  dst[ Symbol.for( 'a' ) ] = 'a1';
  test.identical( dst, exp );

  /* */

  test.case = 'has Composes only';
  var dst = { Composes : {}, };
  var exp = { Composes : dst.Composes, 'a' : 'a1' };
  _.accessor.declare( dst, { a : 'a' } );
  dst[ Symbol.for( 'a' ) ] = 'a1';
  test.identical( dst, exp );

  /* - */

  if( !Config.debug )
  return;

  /* */

  test.case = 'empty call';
  test.shouldThrowErrorSync( function()
  {
    _.accessor.declare( );
  });

  /* */

  test.case = 'invalid first argument type';
  test.shouldThrowErrorSync( function()
  {
    _.accessor.declare( 1, { a : 'a' } );
  });

  /* */

  test.case = 'invalid second argument type';
  test.shouldThrowErrorSync( function()
  {
    _.accessor.declare( {}, [] );
  });

}

//

function accessorMethodsDeducing( test )
{

  /* */

  test.case = 'not, only grab';
  var symbol = Symbol.for( 'a' );
  var events = [];
  var ins1 =
  {
    aGrab : function()
    {
      events.push( 'aGrab' );
      return this[ symbol ];
    },
    a : 10,
  };

  _.accessor.declare
  ({
    object : ins1,
    names : { a : { get : 0, put : 0, set : 0 } },
    prime : 0,
  });

  test.identical( events, [] );
  test.identical( ins1.a, 10 );
  test.identical( events, [] );
  test.identical( ins1.aGrab(), 10 );
  test.identical( events, [ 'aGrab' ] );
  test.shouldThrowErrorSync( () => dst.a = 30 );

  /* */

  test.case = 'not, only get';
  var symbol = Symbol.for( 'a' );
  var events = [];
  var ins1 =
  {
    aGet : function()
    {
      events.push( 'aGet' );
      return this[ symbol ];
    },
    a : 10,
  };

  _.accessor.declare
  ({
    object : ins1,
    names : { a : { grab : 0, put : 0, set : 0 } },
    prime : 0,
  });

  test.identical( events, [] );
  test.identical( ins1.a, 10 );
  test.identical( events, [ 'aGet' ] );
  test.shouldThrowErrorSync( () => dst.a = 30 );

  /* */

  test.case = 'not, only put';
  var symbol = Symbol.for( 'a' );
  var events = [];
  var ins1 =
  {
    aPut : function()
    {
      events.push( 'aPut' );
      return this[ symbol ];
    },
    a : 10,
  };

  _.accessor.declare
  ({
    object : ins1,
    names : { a : { grab : 0, get : 0, set : 0 } },
    prime : 0,
  });

  test.identical( events, [ 'aPut' ] );
  test.identical( ins1.a, 10 );
  test.identical( events, [ 'aPut' ] );
  ins1.aPut( 20 );
  test.identical( ins1.a, 10 );
  test.identical( events, [ 'aPut', 'aPut' ] );
  test.shouldThrowErrorSync( () => dst.a = 30 );

  /* */

  test.case = 'not, only set';
  var symbol = Symbol.for( 'a' );
  var events = [];
  var ins1 =
  {
    aSet : function()
    {
      events.push( 'aSet' );
      return this[ symbol ];
    },
    a : 10,
  };

  _.accessor.declare
  ({
    object : ins1,
    names : { a : { grab : 0, get : 0, put : 0 } },
    prime : 0,
  });

  test.identical( events, [] );
  test.identical( ins1.a, undefined );
  test.identical( events, [] );
  ins1.aSet( 20 );
  test.identical( ins1.a, undefined );
  test.identical( events, [ 'aSet' ] );

  ins1.a = 30;
  test.identical( ins1.a, undefined );
  test.identical( events, [ 'aSet', 'aSet' ] );

  /* xxx : consider such case */

  // test.case = 'aGrab defined, despite options';
  // var symbol = Symbol.for( 'a' );
  // var events = [];
  // var ins1 =
  // {
  //   aGrab : function()
  //   {
  //     events.push( 'aGrab' );
  //     return this[ symbol ];
  //   },
  //   a : 10,
  // };
  //
  // test.shouldThrowErrorSync( () =>
  // {
  //   debugger;
  //   _global_.debugger = 1;
  //   _.accessor.declare
  //   ({
  //     object : ins1,
  //     names : { a : { grab : 0 } },
  //     prime : 0,
  //   });
  //   debugger;
  // });

  /* */

  test.case = 'only underscored';
  var symbol = Symbol.for( 'a' );
  var events = [];
  var ins1 =
  {
    _aGrab : function()
    {
      events.push( '_aGrab' );
      return this[ symbol ]
    },
    _aGet : function()
    {
      events.push( '_aGet' );
      return this[ symbol ]
    },
    _aPut : function( src )
    {
      events.push( '_aPut' );
      this[ symbol ] = src;
    },
    _aSet : function( src )
    {
      events.push( '_aSet' );
      this[ symbol ] = src;
    },
    a : 10,
  };

  _.accessor.declare
  ({
    object : ins1,
    names : { a : 'a' },
    prime : 0,
  });

  test.identical( events, [ '_aPut' ] );
  test.identical( ins1.a, 10 );
  test.identical( events, [ '_aPut', '_aGet' ] );
  ins1.a = 20;
  test.identical( events, [ '_aPut', '_aGet', '_aSet' ] );
  test.identical( ins1.a, 20 );
  test.identical( events, [ '_aPut', '_aGet', '_aSet', '_aGet' ] );

  /* */

  test.case = 'only not-underscored';
  var symbol = Symbol.for( 'a' );
  var events = [];
  var ins1 =
  {
    aGrab : function()
    {
      events.push( 'aGrab' );
      return this[ symbol ]
    },
    aGet : function()
    {
      events.push( 'aGet' );
      return this[ symbol ]
    },
    aPut : function( src )
    {
      events.push( 'aPut' );
      this[ symbol ] = src;
    },
    aSet : function( src )
    {
      events.push( 'aSet' );
      this[ symbol ] = src;
    },
    a : 10,
  };

  _.accessor.declare
  ({
    object : ins1,
    names : { a : 'a' },
    prime : 0,
  });

  test.identical( events, [ 'aPut' ] );
  test.identical( ins1.a, 10 );
  test.identical( events, [ 'aPut', 'aGet' ] );
  ins1.a = 20;
  test.identical( events, [ 'aPut', 'aGet', 'aSet' ] );
  test.identical( ins1.a, 20 );
  test.identical( events, [ 'aPut', 'aGet', 'aSet', 'aGet' ] );

  /* */

  test.case = 'underscored and not-underscored';
  var symbol = Symbol.for( 'a' );
  var events = [];
  var ins1 =
  {
    _aGrab : function()
    {
      events.push( '_aGrab' );
      return this[ symbol ]
    },
    _aGet : function()
    {
      events.push( '_aGet' );
      return this[ symbol ]
    },
    _aPut : function( src )
    {
      events.push( '_aPut' );
      this[ symbol ] = src;
    },
    _aSet : function( src )
    {
      events.push( '_aSet' );
      this[ symbol ] = src;
    },
    aGrab : function()
    {
      events.push( 'aGrab' );
      return this[ symbol ]
    },
    aGet : function()
    {
      events.push( 'aGet' );
      return this[ symbol ]
    },
    aPut : function( src )
    {
      events.push( 'aPut' );
      this[ symbol ] = src;
    },
    aSet : function( src )
    {
      events.push( 'aSet' );
      this[ symbol ] = src;
    },
    a : 10,
  };

  _.accessor.declare
  ({
    object : ins1,
    names : { a : 'a' },
    prime : 0,
  });

  test.identical( events, [ 'aPut' ] );
  test.identical( ins1.a, 10 );
  test.identical( events, [ 'aPut', 'aGet' ] );
  ins1.a = 20;
  test.identical( events, [ 'aPut', 'aGet', 'aSet' ] );
  test.identical( ins1.a, 20 );
  test.identical( events, [ 'aPut', 'aGet', 'aSet', 'aGet' ] );

  /* */

  test.case = 'only underscored and explicit true';
  var symbol = Symbol.for( 'a' );
  var events = [];
  var ins1 =
  {
    _aGrab : function()
    {
      events.push( '_aGrab' );
      return this[ symbol ]
    },
    _aGet : function()
    {
      events.push( '_aGet' );
      return this[ symbol ]
    },
    _aPut : function( src )
    {
      events.push( '_aPut' );
      this[ symbol ] = src;
    },
    _aSet : function( src )
    {
      events.push( '_aSet' );
      this[ symbol ] = src;
    },
    a : 10,
  };

  _.accessor.declare
  ({
    object : ins1,
    names : { a : { grab : true, get : true, put : true, set : true } },
    prime : 0,
  });

  test.identical( events, [ '_aPut' ] );
  test.identical( ins1.a, 10 );
  test.identical( events, [ '_aPut', '_aGet' ] );
  ins1.a = 20;
  test.identical( events, [ '_aPut', '_aGet', '_aSet' ] );
  test.identical( ins1.a, 20 );
  test.identical( events, [ '_aPut', '_aGet', '_aSet', '_aGet' ] );

  /* */

  test.case = 'only not underscored and explicit true';
  var symbol = Symbol.for( 'a' );
  var events = [];
  var ins1 =
  {
    _aGrab : function()
    {
      events.push( '_aGrab' );
      return this[ symbol ]
    },
    _aGet : function()
    {
      events.push( '_aGet' );
      return this[ symbol ]
    },
    _aPut : function( src )
    {
      events.push( '_aPut' );
      this[ symbol ] = src;
    },
    _aSet : function( src )
    {
      events.push( '_aSet' );
      this[ symbol ] = src;
    },
    aGrab : function()
    {
      events.push( 'aGrab' );
      return this[ symbol ]
    },
    aGet : function()
    {
      events.push( 'aGet' );
      return this[ symbol ]
    },
    aPut : function( src )
    {
      events.push( 'aPut' );
      this[ symbol ] = src;
    },
    aSet : function( src )
    {
      events.push( 'aSet' );
      this[ symbol ] = src;
    },
    a : 10,
  };

  _.accessor.declare
  ({
    object : ins1,
    names : { a : { grab : true, get : true, put : true, set : true } },
    prime : 0,
  });

  test.identical( events, [ 'aPut' ] );
  test.identical( ins1.a, 10 );
  test.identical( events, [ 'aPut', 'aGet' ] );
  ins1.a = 20;
  test.identical( events, [ 'aPut', 'aGet', 'aSet' ] );
  test.identical( ins1.a, 20 );
  test.identical( events, [ 'aPut', 'aGet', 'aSet', 'aGet' ] );

  /* */

  test.case = 'only not underscored and explicit true';
  var symbol = Symbol.for( 'a' );
  var events = [];
  var ins1 =
  {
    aGrab : function()
    {
      events.push( 'aGrab' );
      return this[ symbol ]
    },
    aGet : function()
    {
      events.push( 'aGet' );
      return this[ symbol ]
    },
    aPut : function( src )
    {
      events.push( 'aPut' );
      this[ symbol ] = src;
    },
    aSet : function( src )
    {
      events.push( 'aSet' );
      this[ symbol ] = src;
    },
    a : 10,
  };

  _.accessor.declare
  ({
    object : ins1,
    names : { a : { grab : true, get : true, put : true, set : true } },
    prime : 0,
  });

  test.identical( events, [ 'aPut' ] );
  test.identical( ins1.a, 10 );
  test.identical( events, [ 'aPut', 'aGet' ] );
  ins1.a = 20;
  test.identical( events, [ 'aPut', 'aGet', 'aSet' ] );
  test.identical( ins1.a, 20 );
  test.identical( events, [ 'aPut', 'aGet', 'aSet', 'aGet' ] );

  /* */

  test.case = '_aGrab only';
  var symbol = Symbol.for( 'a' );
  var events = [];
  var ins1 =
  {
    _aGrab : function()
    {
      events.push( '_aGrab' );
      return this[ symbol ]
    },
    a : 10,
  };

  _.accessor.declare
  ({
    object : ins1,
    names : { a : 'a' },
    prime : 0,
  });

  test.identical( events, [] );
  test.identical( ins1.a, 10 );
  test.identical( events, [ '_aGrab' ] );
  ins1.a = 20;
  test.identical( events, [ '_aGrab' ] );
  test.identical( ins1.a, 20 );
  test.identical( events, [ '_aGrab', '_aGrab' ] );

  /* */

  test.case = 'aGrab only';
  var symbol = Symbol.for( 'a' );
  var events = [];
  var ins1 =
  {
    aGrab : function()
    {
      events.push( 'aGrab' );
      return this[ symbol ]
    },
    a : 10,
  };

  _.accessor.declare
  ({
    object : ins1,
    names : { a : 'a' },
    prime : 0,
  });

  test.identical( events, [] );
  test.identical( ins1.a, 10 );
  test.identical( events, [ 'aGrab' ] );
  ins1.a = 20;
  test.identical( events, [ 'aGrab' ] );
  test.identical( ins1.a, 20 );
  test.identical( events, [ 'aGrab', 'aGrab' ] );

  /* */

  test.case = '_aGet only';
  var symbol = Symbol.for( 'a' );
  var events = [];
  var ins1 =
  {
    _aGet : function()
    {
      events.push( '_aGet' );
      return this[ symbol ]
    },
    a : 10,
  };

  _.accessor.declare
  ({
    object : ins1,
    names : { a : 'a' },
    prime : 0,
  });

  test.identical( events, [] );
  test.identical( ins1.a, 10 );
  test.identical( events, [ '_aGet' ] );
  ins1.a = 20;
  test.identical( events, [ '_aGet' ] );
  test.identical( ins1.a, 20 );
  test.identical( events, [ '_aGet', '_aGet' ] );

  /* */

  test.case = 'aGet only';
  var symbol = Symbol.for( 'a' );
  var events = [];
  var ins1 =
  {
    aGet : function()
    {
      events.push( 'aGet' );
      return this[ symbol ]
    },
    a : 10,
  };

  _.accessor.declare
  ({
    object : ins1,
    names : { a : 'a' },
    prime : 0,
  });

  test.identical( events, [] );
  test.identical( ins1.a, 10 );
  test.identical( events, [ 'aGet' ] );
  ins1.a = 20;
  test.identical( events, [ 'aGet' ] );
  test.identical( ins1.a, 20 );
  test.identical( events, [ 'aGet', 'aGet' ] );

  /* */

  test.case = '_aSet only';
  var symbol = Symbol.for( 'a' );
  var events = [];
  var ins1 =
  {
    _aSet : function( src )
    {
      events.push( '_aSet' );
      this[ symbol ] = src;
    },
    a : 10,
  };

  _.accessor.declare
  ({
    object : ins1,
    names : { a : 'a' },
    prime : 0,
  });

  test.identical( events, [ '_aSet' ] );
  test.identical( ins1.a, 10 );
  test.identical( events, [ '_aSet' ] );
  ins1.a = 20;
  test.identical( events, [ '_aSet', '_aSet' ] );
  test.identical( ins1.a, 20 );
  test.identical( events, [ '_aSet', '_aSet' ] );

  /* */

  test.case = '_aPut only';
  var symbol = Symbol.for( 'a' );
  var events = [];
  var ins1 =
  {
    _aPut : function( src )
    {
      events.push( '_aPut' );
      this[ symbol ] = src;
    },
    a : 10,
  };

  _.accessor.declare
  ({
    object : ins1,
    names : { a : 'a' },
    prime : 0,
  });

  test.identical( events, [ '_aPut' ] );
  test.identical( ins1.a, 10 );
  test.identical( events, [ '_aPut' ] );
  ins1.a = 20;
  test.identical( events, [ '_aPut', '_aPut' ] );
  test.identical( ins1.a, 20 );
  test.identical( events, [ '_aPut', '_aPut' ] );

  /* */

  test.case = 'aPut only';
  var symbol = Symbol.for( 'a' );
  var events = [];
  var ins1 =
  {
    aPut : function( src )
    {
      events.push( 'aPut' );
      this[ symbol ] = src;
    },
    a : 10,
  };

  _.accessor.declare
  ({
    object : ins1,
    names : { a : 'a' },
    prime : 0,
  });

  test.identical( events, [ 'aPut' ] );
  test.identical( ins1.a, 10 );
  test.identical( events, [ 'aPut' ] );
  ins1.a = 20;
  test.identical( events, [ 'aPut', 'aPut' ] );
  test.identical( ins1.a, 20 );
  test.identical( events, [ 'aPut', 'aPut' ] );

  /* */

  test.case = 'aSet only';
  var symbol = Symbol.for( 'a' );
  var events = [];
  var ins1 =
  {
    aSet : function( src )
    {
      events.push( 'aSet' );
      this[ symbol ] = src;
    },
    a : 10,
  };

  _.accessor.declare
  ({
    object : ins1,
    names : { a : 'a' },
    prime : 0,
  });

  test.identical( events, [ 'aSet' ] );
  test.identical( ins1.a, 10 );
  test.identical( events, [ 'aSet' ] );
  ins1.a = 20;
  test.identical( events, [ 'aSet', 'aSet' ] );
  test.identical( ins1.a, 20 );
  test.identical( events, [ 'aSet', 'aSet' ] );

  /* */

}

//

function accessorOptionReadOnly( test )
{

  /* */

  test.case = 'control, str';

  var dst =
  {
    aGet : function() { return 'a1' },
  };

  var exp = { 'a' : 'a1', 'aGet' : dst.aGet }
  _.accessor.declare
  ({
    object : dst,
    names : { a : 'a' },
    prime : 0,
  });
  test.identical( dst, exp );

  /* */

  test.case = 'control, map';

  var dst =
  {
    aGet : function() { return 'a1' },
  };

  var exp = { 'a' : 'a1', 'aGet' : dst.aGet }
  _.accessor.declare
  ({
    object : dst,
    names : { a : {} },
    prime : 0,
  });
  test.identical( dst, exp );

  /* */

  test.case = 'read only explicitly, value in object';

  var dst =
  {
    a : 'a1',
  };

  var exp = { 'a' : 'a1' }
  _.accessor.declare
  ({
    object : dst,
    names : { a : { readOnly : 1 } },
    prime : 0,
  });
  test.identical( dst, exp );
  test.shouldThrowErrorSync( () => dst.a = 'a2' );

  /* */

  test.case = 'read only implicitly, value in object';

  var dst =
  {
    a : 'a1',
  };

  var exp = { 'a' : 'a1' }
  _.accessor.declare
  ({
    object : dst,
    names : { a : { set : false } },
    prime : 0,
  });
  test.identical( dst, exp );
  test.shouldThrowErrorSync( () => dst.a = 'a2' );

  /* */

}

//

function declareConstant( test )
{

  /* */

  test.case = 'read only explicitly, get is definitition';

  var dst =
  {
  };

  var exp = { 'a' : 'a1' };
  debugger;
  _.accessor.declare
  ({
    object : dst,
    names : { a : { readOnly : 1, get : _.define.constant( 'a1' ) } },
    prime : 0,
  });
  debugger;
  test.identical( dst, exp );
  test.shouldThrowErrorSync( () => dst.a = 'a2' );

  /* */

  test.case = 'read only implicitly, value in descriptor';

  var dst =
  {
  };

  var exp = { 'a' : 'a1' }
  _.accessor.declare
  ({
    object : dst,
    names : { a : { set : false, get : _.define.constant( 'a1' ) } },
    prime : 0,
  });
  test.identical( dst, exp );
  test.shouldThrowErrorSync( () => dst.a = 'a2' );

  /* */

  test.case = 'read only implicitly, value instead of descriptor';

  var dst =
  {
  };

  var exp = { 'a' : 'a1' }
  _.accessor.declare
  ({
    object : dst,
    names : { a : _.define.constant( 'a1' ) },
    prime : 0,
  });
  test.identical( dst, exp );
  test.shouldThrowErrorSync( () => dst.a = 'a2' );

  /* */

}

//

function declareConstantSymbol( test )
{

  /* */

  test.case = 'read only implicitly, value in descriptor';

  var dst =
  {
  };

  var exp = {}
  _.accessor.declare
  ({
    object : dst,
    names : { [ Symbol.for( 'a' ) ] : { set : false, get : _.define.constant( 'a1' ) } },
    prime : 0,
  });
  test.identical( dst, exp );
  test.identical( dst[ Symbol.for( 'a' ) ], 'a1' );
  test.shouldThrowErrorSync( () => dst[ Symbol.for( 'a' ) ] = 'a2' );
  var exp = { a : 'a3' };
  dst.a = 'a3';
  test.identical( dst, exp );
  test.identical( dst[ Symbol.for( 'a' ) ], 'a1' );

  /* */

  test.case = 'read only implicitly, value instead of descriptor';

  var dst =
  {
  };

  var exp = {}
  _.accessor.declare
  ({
    object : dst,
    names : { [ Symbol.for( 'a' ) ] : _.define.constant( 'a1' ) },
    prime : 0,
  });
  test.identical( dst, exp );
  test.identical( dst[ Symbol.for( 'a' ) ], 'a1' );
  test.shouldThrowErrorSync( () => dst[ Symbol.for( 'a' ) ] = 'a2' );
  var exp = { a : 'a3' };
  dst.a = 'a3';
  test.identical( dst, exp );
  test.identical( dst[ Symbol.for( 'a' ) ], 'a1' );

  /* */

}

//

function accessorOptionAddingMethods( test )
{

  /* */

  test.case = 'deduce setter from put, object does not have methods, with _, addingMethods:1';
  var methods =
  {
    _aGet : function() { return this.b },
    _aPut : function( src ) { this.b = src },
  }
  var dst =
  {
    'a' : 'a1',
    'b' : 'b1',
  };
  var exp =
  {
    'a' : 'a1',
    'b' : 'a1',
  }
  _.accessor.declare
  ({
    object : dst,
    methods,
    names : { a : {} },
    prime : 0,
    strict : 0,
    addingMethods : 0,
  });
  test.identical( dst, exp );

  /* */

  test.case = 'deduce setter from put, object has methods, addingMethods:0';
  var dst =
  {
    'a' : 'a1',
    'b' : 'b1',
    aGet : function() { return this.b },
    aPut : function( src ) { this.b = src },
  };
  var exp =
  {
    'a' : 'a1',
    'b' : 'a1',
    aGet : dst.aGet,
    aPut : dst.aPut,
  }
  _.accessor.declare
  ({
    object : dst,
    names : { a : {} },
    prime : 0,
    strict : 0,
    addingMethods : 0,
  });
  test.identical( dst, exp );

  /* */

  test.case = 'deduce setter from put, deduce get from grab, object has methods, addingMethods:1';
  var dst =
  {
    'a' : 'a1',
    'b' : 'b1',
    aGrab : function() { return this.b },
    aPut : function( src ) { this.b = src },
  };
  var exp =
  {
    'a' : 'a1',
    'b' : 'a1',
    aGrab : dst.aGrab,
    aGet : dst.aGrab,
    aPut : dst.aPut,
    aSet : dst.aPut,
  }
  _.accessor.declare
  ({
    object : dst,
    names : { a : {} },
    prime : 0,
    strict : 0,
    addingMethods : 1,
  });
  test.identical( dst, exp );

  /* */

  test.case = 'deduce setter from put and get from grab, object has methods, with _, addingMethods:1';
  var dst =
  {
    'a' : 'a1',
    'b' : 'b1',
    _aGrab : function() { return this.b },
    _aPut : function( src ) { this.b = src },
  };
  var exp =
  {
    'a' : 'a1',
    'b' : 'a1',
    _aGrab : dst._aGrab,
    aGet : dst._aGrab,
    _aPut : dst._aPut,
    aSet : dst._aPut,
  }
  _.accessor.declare
  ({
    object : dst,
    names : { a : {} },
    prime : 0,
    strict : 0,
    addingMethods : 1,
  });
  test.identical( dst, exp );

  /* */

  test.case = 'deduce setter from put and get from grab, object does not have methods, with _, addingMethods:1';
  var methods =
  {
    _aGrab : function() { return this.b },
    _aPut : function( src ) { this.b = src },
  }
  var dst =
  {
    'a' : 'a1',
    'b' : 'b1',
  };
  var exp =
  {
    'a' : 'a1',
    'b' : 'a1',
    aGrab : methods._aGrab,
    aGet : methods._aGrab,
    aSet : methods._aPut,
    aPut : methods._aPut,
  }
  _.accessor.declare
  ({
    object : dst,
    methods,
    names : { a : {} },
    prime : 0,
    strict : 0,
    addingMethods : 1,
  });
  test.identical( dst, exp );

  /* */

}

//

function accessorOptionPreserveValues( test )
{

  /* */

  test.case = 'not symbol, explicit put, preservingValue : 1';
  var object =
  {
    'a' : 'a1',
    'b' : 'b1',
    aGet : function() { return this.b },
    aSet : function( src ) { this.b = src },
    aPut : function( src ) { this.b = src },
  };
  var exp =
  {
    'a' : 'a1',
    'b' : 'a1',
    aGet : object.aGet,
    aSet : object.aSet,
    aPut : object.aPut,
  }
  _.accessor.declare
  ({
    object,
    names : { a : {} },
    preservingValue : 1,
    prime : 0,
  });
  test.identical( object, exp );

  /* */

  test.case = 'not symbol, explicit put, preservingValue : 0';
  var object =
  {
    'a' : 'a1',
    'b' : 'b1',
    aGet : function() { return this.b },
    aSet : function( src ) { this.b = src },
    aPut : function( src ) { this.b = src },
  };
  var exp =
  {
    'a' : 'b1',
    'b' : 'b1',
    aGet : object.aGet,
    aSet : object.aSet,
    aPut : object.aPut,
  }
  _.accessor.declare
  ({
    object,
    names : { a : {} },
    preservingValue : 0,
    prime : 0,
  });
  test.identical( object, exp );

  /* */

  test.case = 'not symbol, no put, preservingValue : 1';
  var object =
  {
    'a' : 'a1',
    'b' : 'b1',
    aGet : function() { return this.b },
    aSet : function( src ) { this.b = src },
  };
  var exp =
  {
    'a' : 'a1',
    'b' : 'a1',
    aGet : object.aGet,
    aSet : object.aSet,
  }
  _.accessor.declare
  ({
    object,
    names : { a : {} },
    preservingValue : 1,
    prime : 0,
  });
  test.identical( object, exp );

  /* */

  test.case = 'not symbol, no put, preservingValue : 0';
  var object =
  {
    'a' : 'a1',
    'b' : 'b1',
    aGet : function() { return this.b },
    aSet : function( src ) { this.b = src },
  };
  var exp =
  {
    'a' : 'b1',
    'b' : 'b1',
    aGet : object.aGet,
    aSet : object.aSet,
  }
  _.accessor.declare
  ({
    object,
    names : { a : {} },
    preservingValue : 0,
    prime : 0,
  });
  test.identical( object, exp );

  /* */

  test.case = 'default getter/setter, preservingValue : 1';
  var object =
  {
    'a' : 'a1',
    'b' : 'b1',
  };
  var exp =
  {
    'a' : 'a1',
    'b' : 'b1',
  }
  var names =
  {
    a : {},
  }
  _.accessor.declare
  ({
    object,
    names,
    prime : 0,
    strict : 0,
    addingMethods : 0,
    preservingValue : 1,
  });
  test.identical( object, exp );

  /* */

  test.case = 'default getter/setter, preservingValue : 0';
  var object =
  {
    'a' : 'a1',
    'b' : 'b1',
  };
  var exp =
  {
    'a' : undefined,
    'b' : 'b1',
  }
  var names =
  {
    a : {},
  }
  _.accessor.declare
  ({
    object,
    names,
    prime : 0,
    strict : 0,
    addingMethods : 0,
    preservingValue : 0,
  });
  test.identical( object, exp );

  /* */

}

//

function accessorDeducingMethods( test )
{

  /* */

  function symbolPut_functor( o )
  {
    o = _.routineOptions( symbolPut_functor, arguments );
    let symbol = Symbol.for( o.fieldName );
    return function put( val )
    {
      this[ symbol ] = val;
      return val;
    }
  }

  symbolPut_functor.defaults =
  {
    fieldName : null,
  }

  symbolPut_functor.identity = [ 'accessor', 'put', 'functor' ];

  /* */

  test.case = 'set : false, put : explicit';
  var object =
  {
    'a' : 'a1',
    'b' : 'b1',
  };
  var names =
  {
    a : { set : false, put : symbolPut_functor },
  }
  _.accessor.declare
  ({
    object,
    names,
    prime : 0,
    strict : 0,
    addingMethods : 1,
    preservingValue : 1,
  });
  var exp =
  {
    'a' : 'a1',
    'b' : 'b1',
    aGrab : object.aGrab,
    aGet : object.aGet,
    aPut : object.aPut,
  }
  test.identical( object, exp );

  test.shouldThrowErrorSync( () => object.a = 'c' );
  test.identical( object, exp );

  var exp =
  {
    'a' : 'd',
    'b' : 'b1',
    aPut : object.aPut,
    aGrab : object.aGrab,
    aGet : object.aGet,
  }
  object.aPut( 'd' );
  test.identical( object, exp );

  /* */

  test.case = 'set : false';
  var object =
  {
    'a' : 'a1',
    'b' : 'b1',
  };
  var names =
  {
    a : { set : false },
  }
  _.accessor.declare
  ({
    object,
    names,
    prime : 0,
    strict : 0,
    addingMethods : 1,
    preservingValue : 1,
  });
  var exp =
  {
    'a' : 'a1',
    'b' : 'b1',
    aGrab : object.aGrab,
    aGet : object.aGet,
    aPut : object.aPut,
  }
  test.identical( object, exp );

  test.shouldThrowErrorSync( () => object.a = 'c' );
  test.identical( object, exp );

  var exp =
  {
    'a' : 'd',
    'b' : 'b1',
    aGrab : object.aGrab,
    aGet : object.aGet,
    aPut : object.aPut,
  }
  object.aPut( 'd' );
  test.identical( object, exp );

  /* */

  test.case = 'put : false, set : true';
  var object =
  {
    'a' : 'a1',
    'b' : 'b1',
  };
  var names =
  {
    a : { put : false, set : true },
  }
  _.accessor.declare
  ({
    object,
    names,
    prime : 0,
    strict : 0,
    addingMethods : 1,
    preservingValue : 1,
  });

  var exp =
  {
    'a' : 'a1',
    'b' : 'b1',
    aGrab : object.aGrab,
    aGet : object.aGet,
    aSet : object.aSet,
  }
  test.identical( object, exp ); /* yyy */

  var exp =
  {
    'a' : 'd',
    'b' : 'b1',
    aGrab : object.aGrab,
    aGet : object.aGet,
    aSet : object.aSet,
  }
  object.aSet( 'd' );
  test.identical( object, exp );

  var exp =
  {
    'a' : 'e',
    'b' : 'b1',
    aGrab : object.aGrab,
    aGet : object.aGet,
    aSet : object.aSet,
  }
  object.a = 'e';
  test.identical( object, exp );

  /* */

  test.case = 'put : false';
  var object =
  {
    'a' : 'a1',
    'b' : 'b1',
  };
  var names =
  {
    a : { put : false },
  }
  _.accessor.declare
  ({
    object,
    names,
    prime : 0,
    strict : 0,
    addingMethods : 1,
    preservingValue : 1,
  });

  var exp =
  {
    'a' : 'a1',
    'b' : 'b1',
    aGrab : object.aGrab,
    aGet : object.aGet,
  }
  test.identical( object, exp );

  test.shouldThrowErrorSync( () => object.aSet( 'd' ) );

  /* */

}

//

function accessorIsClean( test )
{

  /* - */

  test.open( 'with class, readOnly:1' );

  test.case = 'setup';

  function BasicConstructor()
  {
    _.workpiece.initFields( this );
  }

  var Accessors =
  {
    f1 : { readOnly : 1 },
  }

  var Extension =
  {
    Accessors,
  }

  _.classDeclare
  ({
    cls : BasicConstructor,
    extend : Extension,
  });

  var methods = Object.create( null );
  _.accessor.declare
  ({
    object : BasicConstructor.prototype,
    names : { f2 : { readOnly : 1 } },
    methods,
  });

  var instance = new BasicConstructor();

  test.case = 'methods';

  var exp =
  {
    f2Grab : methods.f2Grab,
    f2Get : methods.f2Get,
    f2Put : methods.f2Put,
  }
  test.identical( methods, exp );
  test.true( _.routineIs( methods.f2Get ) );
  test.true( _.routineIs( methods.f2Put ) );
  test.identical( _.mapKeys( methods ).length, 3 );

  test.case = 'inline no method';

  test.identical( instance._f1Get, undefined );
  test.identical( instance._f1Set, undefined );
  test.identical( BasicConstructor._f1Get, undefined );
  test.identical( BasicConstructor._f1Set, undefined );
  test.identical( BasicConstructor.prototype._f1Get, undefined );
  test.identical( BasicConstructor.prototype._f1Set, undefined );

  test.identical( instance._f2Get, undefined );
  test.identical( instance._f2Set, undefined );
  test.identical( BasicConstructor._f2Get, undefined );
  test.identical( BasicConstructor._f2Set, undefined );
  test.identical( BasicConstructor.prototype._f2Get, undefined );
  test.identical( BasicConstructor.prototype._f2Set, undefined );

  test.close( 'with class, readOnly:1' );

}

//

function accessorDeducingPrime( test )
{

  /* */

  test.case = '_.accessor.declare';

  var proto = Object.create( null );
  proto.a = 'a1';
  proto.abcGet = function()
  {
    return 'abc1';
  }

  var object = Object.create( proto );
  object.b = 'b2';

  var exp = { 'b' : 'b2', 'abc' : 'abc1' }
  var names = { abc : 'abc' }
  var o2 =
  {
    object : object,
    names : names,
  }
  _.accessor.declare( o2 );

  test.identical( o2.prime, null );
  test.identical( o2.strict, 1 );
  test.contains( object, exp );

  /* */

  test.case = '_.accessor.readOnly';

  var proto = Object.create( null );
  proto.a = 'a1';
  proto.abcGet = function()
  {
    return 'abc1';
  }

  var object = Object.create( proto );
  object.b = 'b2';

  var exp = { 'b' : 'b2', 'abc' : 'abc1' }
  var names = { abc : 'abc' }
  var o2 =
  {
    object : object,
    names : names,
  }
  _.accessor.readOnly( o2 );

  test.identical( o2.prime, null );
  test.identical( o2.strict, 1 );
  test.contains( object, exp );

  /* */

  test.case = '_.accessor.forbid';

  var proto = Object.create( null );
  proto.a = 'a1';
  proto.abcGet = function()
  {
    return 'abc1';
  }

  var object = Object.create( proto );
  object.b = 'b2';

  var exp = { 'b' : 'b2' }
  var names = { abc : 'abc' }
  var o2 =
  {
    object : object,
    names : names,
  }
  _.accessor.forbid( o2 );

  test.identical( o2.prime, 0 );
  test.identical( o2.strict, 0 );
  test.contains( object, exp );
  test.shouldThrowErrorSync( () => dst.abc );

  /* */

}

//

function accessorUnfunct( test )
{

  /* */

  test.case = 'unfunct getter';
  var counter = 0;
  function getter_functor( fop )
  {
    counter += 1;
    var exp = { fieldName : 'a' };
    test.identical( fop, exp );
    return function get()
    {
      counter += 1;
      return this.b;
    }
  }
  getter_functor.identity = [ 'accessor', 'getter', 'functor' ];
  getter_functor.defaults =
  {
    fieldName : null,
  }
  var object =
  {
    'a' : 'a1',
    'b' : 'b1',
    aGet : getter_functor,
  };
  var exp =
  {
    'a' : 'b1',
    'b' : 'b1',
    aGet : object.aGet,
  }
  _.accessor.declare
  ({
    object,
    names : { a : {} },
    prime : 0,
    strict : 0,
  });
  test.identical( object, exp );
  test.identical( counter, 3 );

  /* */

  test.case = 'unfunct setter';
  var counter = 0;
  function setter_functor( fop )
  {
    counter += 1; debugger;
    var exp = { fieldName : 'a' };
    test.identical( fop, exp );
    return function set( src )
    {
      counter += 1; debugger;
      return this.b = src;
    }
  }
  setter_functor.identity = [ 'accessor', 'setter', 'functor' ];
  setter_functor.defaults =
  {
    fieldName : null,
  }
  var object =
  {
    'a' : 'a1',
    'b' : 'b1',
    aSet : setter_functor,
    aGet : function() { return this.b },
  };
  var exp =
  {
    'a' : 'a1',
    'b' : 'a1',
    aSet : object.aSet,
    aGet : object.aGet,
  }
  _.accessor.declare
  ({
    object,
    names : { a : {} },
    prime : 0,
    strict : 0,
  });
  test.identical( object, exp );
  test.identical( counter, 3 );

  object.a = 'c';
  var exp =
  {
    'a' : 'c',
    'b' : 'c',
    aSet : object.aSet,
    aGet : object.aGet,
  }
  test.identical( object, exp );
  test.identical( counter, 4 );

  /* */

  test.case = 'unfunct putter';
  var counter = 0;
  function putter_functor( fop )
  {
    counter += 1;
    var exp = { fieldName : 'a' };
    test.identical( fop, exp );
    return function set( src )
    {
      counter += 1;
      return this.b = src;
    }
  }
  putter_functor.identity = [ 'accessor', 'put', 'functor' ];
  putter_functor.defaults =
  {
    fieldName : null,
  }
  var object =
  {
    'a' : 'a1',
    'b' : 'b1',
    aPut : putter_functor,
    aGet : function() { return this.b },
  };
  var exp =
  {
    'a' : 'a1',
    'b' : 'a1',
    aPut : object.aPut,
    aGet : object.aGet,
  }
  _.accessor.declare
  ({
    object,
    names : { a : {} },
    prime : 0,
    strict : 0,
  });
  test.identical( object, exp );
  test.identical( counter, 3 );

  object.a = 'c';
  var exp =
  {
    'a' : 'c',
    'b' : 'c',
    aPut : object.aPut,
    aGet : object.aGet,
  }
  test.identical( object, exp );
  test.identical( counter, 4 );

  /* */

  test.case = 'unfunct suite';
  var counter = 0;
  function accessor_functor( fop )
  {
    counter += 1;
    var exp = { fieldName : 'a' };
    test.identical( fop, exp );
    return {
      get : function() { return this.b },
      set : function set( src )
      {
        counter += 1;
        return this.b = src;
      }
    }
  }
  accessor_functor.identity = [ 'accessor', 'functor' ];
  accessor_functor.defaults =
  {
    fieldName : null,
  }
  var object =
  {
    'a' : 'a1',
    'b' : 'b1',
  };
  var exp =
  {
    'a' : 'a1',
    'b' : 'a1',
  }
  _.accessor.declare
  ({
    object,
    names : { a : {} },
    suite : accessor_functor,
    prime : 0,
    strict : 0,
  });
  test.identical( object, exp );
  test.identical( counter, 2 );

  object.a = 'c';
  var exp =
  {
    'a' : 'c',
    'b' : 'c',
  }
  test.identical( object, exp );
  test.identical( counter, 3 );

  /* */

}

//

function accessorUnfunctGetSuite( test )
{

  /* - */

  function get_functor( o )
  {

    _.assert( arguments.length === 1, 'Expects single argument' );
    _.routineOptions( get_functor, o );
    _.assert( _.strDefined( o.fieldName ) );

    if( o.accessor.configurable === null )
    o.accessor.configurable = 1;
    let configurable = o.accessor.configurable;
    if( configurable === null )
    configurable = _.accessor.AccessorPreferences.configurable;
    _.assert( _.boolLike( configurable ) );

    if( o.accessorKind === 'suite' )
    {
      let result =
      {
        get : get_functor,
        set : false,
        put : false,
      }
      return result;
    }

    return function get()
    {
      if( configurable )
      {
        let o2 =
        {
          enumerable : false,
          configurable : false,
          value : 'abc3',
        }
        Object.defineProperty( this, o.fieldName, o2 );
        return 'abc2'
      }
      return 'abc1';
    }

  }

  get_functor.defaults =
  {
    fieldName : null,
    accessor : null,
    accessorKind : null,
  }

  get_functor.identity = [ 'accessor', 'suite', 'getter', 'functor' ];

  /* - */

  test.case = 'configurable : 1, set : 0, put : 0';
  var object =
  {
    'a' : 'a1',
    'b' : 'b1',
  };
  var names =
  {
    _ : { get : get_functor, set : false, put : false, configurable : true },
    a : {},
  }
  _.accessor.declare
  ({
    object,
    names,
    prime : 0,
    strict : 0,
    addingMethods : 1,
  });
  var exp =
  {
    'get' : object._Get,
    'set' : object._Set,
    'enumerable' : true,
    'configurable' : true
  }
  test.identical( _.propertyDescriptorGet( object, '_' ).descriptor, exp );
  var exp =
  {
    'a' : 'a1',
    'b' : 'b1',
    '_' : 'abc2',
    'aGrab' : object.aGrab,
    'aGet' : object.aGet,
    'aPut' : object.aPut,
    'aSet' : object.aSet,
    '_Grab' : object._Grab,
    '_Get' : object._Get,
  }
  test.identical( object, exp );
  test.identical( object.a, exp.a );
  test.identical( object.b, exp.b );
  var exp = { 'writable' : false, 'enumerable' : false, 'configurable' : false, value : 'abc3' }
  test.identical( _.propertyDescriptorGet( object, '_' ).descriptor, exp );

  /* */

  test.case = 'configurable : 0, set : 0, put : 0';
  var object =
  {
    'a' : 'a1',
    'b' : 'b1',
  };
  var names =
  {
    _ : { get : get_functor, set : false, put : false, configurable : false },
    a : {},
  }
  _.accessor.declare
  ({
    object,
    names,
    prime : 0,
    strict : 0,
    addingMethods : 1,
  });
  var exp =
  {
    'get' : object._Get,
    'set' : undefined,
    'enumerable' : true,
    'configurable' : false,
  }
  test.identical( _.propertyDescriptorGet( object, '_' ).descriptor, exp );
  var exp =
  {
    'a' : 'a1',
    'b' : 'b1',
    '_' : 'abc1',
    'aGrab' : object.aGrab,
    'aGet' : object.aGet,
    'aPut' : object.aPut,
    'aSet' : object.aSet,
    '_Grab' : object._Grab,
    '_Get' : object._Get,
  }
  test.identical( object, exp );
  test.identical( object.a, exp.a );
  test.identical( object.b, exp.b );
  var exp =
  {
    'get' : object._Get,
    'set' : undefined,
    'enumerable' : true,
    'configurable' : false,
  }
  test.identical( _.propertyDescriptorGet( object, '_' ).descriptor, exp );

  /* */

  test.case = 'configurable : 0';
  var object =
  {
    'a' : 'a1',
    'b' : 'b1',
  };
  var names =
  {
    _ : { get : get_functor },
    a : {},
  }
  _.accessor.declare
  ({
    object,
    names,
    prime : 0,
    strict : 0,
    addingMethods : 1,
  });
  var exp =
  {
    'get' : object._Get,
    'set' : object._Set,
    'enumerable' : true,
    'configurable' : true,
  }
  test.identical( _.propertyDescriptorGet( object, '_' ).descriptor, exp );
  var exp =
  {
    'a' : 'a1',
    'b' : 'b1',
    'aGrab' : object.aGrab,
    'aGet' : object.aGet,
    'aPut' : object.aPut,
    'aSet' : object.aSet,
    '_Grab' : object._Grab,
    '_Get' : object._Get,
    '_Put' : object._Put,
    '_Set' : object._Set,
    '_' : 'abc2',
  }
  test.identical( object, exp );
  test.identical( object.a, exp.a );
  test.identical( object.b, exp.b );
  var exp = { 'writable' : false, 'enumerable' : false, 'configurable' : false, 'value' : 'abc3' };
  test.identical( _.propertyDescriptorGet( object, '_' ).descriptor, exp );

  /* */

  test.case = 'suite';
  var object =
  {
    'a' : 'a1',
    'b' : 'b1',
  };
  var names =
  {
    _ : get_functor,
    a : {},
  }
  _.accessor.declare
  ({
    object,
    names,
    prime : 0,
    strict : 0,
    addingMethods : 1,
  });
  var exp =
  {
    'get' : object._Get,
    'set' : object._Set,
    'enumerable' : true,
    'configurable' : true
  }
  test.identical( _.propertyDescriptorGet( object, '_' ).descriptor, exp );
  var exp =
  {
    'a' : 'a1',
    'b' : 'b1',
    '_' : 'abc2',
    'aGrab' : object.aGrab,
    'aGet' : object.aGet,
    'aPut' : object.aPut,
    'aSet' : object.aSet,
    '_Grab' : object._Grab,
    '_Get' : object._Get,
    '_Put' : object._Put,
    '_Set' : object._Set,
  }
  test.identical( object, exp );
  test.identical( object.a, exp.a );
  test.identical( object.b, exp.b );
  var exp = { 'writable' : false, 'enumerable' : false, 'configurable' : false, 'value' : 'abc3' };
  test.identical( _.propertyDescriptorGet( object, '_' ).descriptor, exp );

  /* */

  test.case = 'suite in fields';
  var object =
  {
    'a' : 'a1',
    'b' : 'b1',
  };
  var names =
  {
    _ : { suite : get_functor },
    a : {},
  }

  _.accessor.declare
  ({
    object,
    names,
    prime : 0,
    strict : 0,
    addingMethods : 1,
  });
  var exp =
  {
    'get' : object._Get,
    'set' : object._Set,
    'enumerable' : true,
    'configurable' : true
  }
  test.identical( _.propertyDescriptorGet( object, '_' ).descriptor, exp );
  var exp =
  {
    'a' : 'a1',
    'b' : 'b1',
    '_' : 'abc2',
    'aGrab' : object.aGrab,
    'aGet' : object.aGet,
    'aPut' : object.aPut,
    'aSet' : object.aSet,
    '_Grab' : object._Grab,
    '_Get' : object._Get,
    '_Put' : object._Put,
    '_Set' : object._Set,
  }
  test.identical( object, exp );
  test.identical( object.a, exp.a );
  test.identical( object.b, exp.b );
  var exp = { 'writable' : false, 'enumerable' : false, 'configurable' : false, 'value' : 'abc3' };
  test.identical( _.propertyDescriptorGet( object, '_' ).descriptor, exp );

  /* */

  test.case = 'suite in fields, explicit configurable';
  var object =
  {
    'a' : 'a1',
    'b' : 'b1',
  };
  var names =
  {
    _ : { suite : get_functor, configurable : false },
    a : {},
  }
  _.accessor.declare
  ({
    object,
    names,
    prime : 0,
    strict : 0,
    addingMethods : 1,
  });
  var exp =
  {
    'get' : object._Get,
    'set' : object._Set,
    'enumerable' : true,
    'configurable' : false
  }
  test.identical( _.propertyDescriptorGet( object, '_' ).descriptor, exp );
  var exp =
  {
    'a' : 'a1',
    'b' : 'b1',
    '_' : 'abc1',
    'aGrab' : object.aGrab,
    'aGet' : object.aGet,
    'aPut' : object.aPut,
    'aSet' : object.aSet,
    '_Grab' : object._Grab,
    '_Get' : object._Get,
    '_Put' : object._Put,
    '_Set' : object._Set,
  }
  test.identical( object, exp );
  test.identical( object.a, exp.a );
  test.identical( object.b, exp.b );
  var exp =
  {
    'get' : object._Get,
    'set' : object._Set,
    'enumerable' : true,
    'configurable' : false
  }
  test.identical( _.propertyDescriptorGet( object, '_' ).descriptor, exp );

  /* */

}

//

function accessorForbid( test )
{

  test.case = 'accessor forbid getter&setter';
  var Alpha = { };
  _.accessor.forbid( Alpha, { a : 'a' } );
  try
  {
    Alpha.a = 5;
  }
  catch( err )
  {
    Alpha[ Symbol.for( 'a' ) ] = 5;
  }
  var got;
  try
  {
    got = Alpha.a;
  }
  catch( err )
  {
    got = Alpha[ Symbol.for( 'a' ) ];
  }
  var expected = 5;
  test.identical( got, expected );

  if( !Config.debug ) /* */
  return;

  test.case = 'forbid get';
  test.shouldThrowErrorSync( function()
  {
    var Alpha = { };
    _.accessor.forbid( Alpha, { a : 'a' } );
    Alpha.a;
  });

  test.case = 'forbid set';
  test.shouldThrowErrorSync( function()
  {
    var Alpha = { };
    _.accessor.forbid( Alpha, { a : 'a' } );
    Alpha.a = 5;
  });

  test.case = 'empty call';
  test.shouldThrowErrorSync( function()
  {
    _.accessor.forbid( );
  });

  test.case = 'invalid first argument type';
  test.shouldThrowErrorSync( function()
  {
    _.accessor.forbid( 1, { a : 'a' } );
  });

  test.case = 'invalid second argument type';
  test.shouldThrowErrorSync( function()
  {
    _.accessor.forbid( {}, 1 );
  });

}

//

function accessorReadOnly( test )
{
  test.case = 'readOnly';

  var Alpha = function _Alpha(){}
  _.classDeclare
  ({
    cls : Alpha,
    parent : null,
    extend : { Composes : { a : null } }
  });
  _.accessor.readOnly( Alpha.prototype,{ a : 'a' });
  var x = new Alpha();
  test.shouldThrowErrorSync( () => x.a = 1 );
  var descriptor = Object.getOwnPropertyDescriptor( Alpha.prototype, 'a' );
  var got = descriptor.set ? true : false;
  var expected = false;
  test.identical( got, expected );

  test.case = 'saves field value';
  var Alpha = function _Alpha( a )
  {
    this[ Symbol.for( 'a' ) ] = a;
  }
  _.classDeclare
  ({
    cls : Alpha,
    parent : null,
    extend : { Composes : { a : 6 } }
  });
  _.accessor.readOnly( Alpha.prototype, { a : 'a' } );
  var x = new Alpha( 5 );
  test.shouldThrowErrorSync( () => x.a = 1 );
  var descriptor = Object.getOwnPropertyDescriptor( Alpha.prototype, 'a' );
  var got = !descriptor.set && x.a === 5;
  var expected = true;
  test.identical( got, expected );

  if( !Config.debug )
  return;

  test.case = 'readonly';
  test.shouldThrowErrorSync( function()
  {
    var Alpha = { };
    _.accessor.readOnly( Alpha, { a : 'a' } );
    Alpha.a = 5;
  });

  test.case = 'setter defined';
  test.shouldThrowErrorSync( function()
  {
    var Alpha = { _aSet : function() { } };
    _.accessor.readOnly( Alpha, { a : 'a' } );
  });

  test.case = 'empty call';
  test.shouldThrowErrorSync( function()
  {
    _.accessor.readOnly( );
  });

  test.case = 'invalid first argument type';
  test.shouldThrowErrorSync( function()
  {
    _.accessor.readOnly( 1, { a : 'a' } );
  });

  test.case = 'invalid second argument type';
  test.shouldThrowErrorSync( function()
  {
    _.accessor.readOnly( {}, [] );
  });

}

//

function forbids( test )
{

  test.open( 'pure map' );

  test.case = 'setup';

  var Forbids =
  {
    f1 : 'f1',
  }

  var instance = Object.create( null );

  _.accessor.forbid( instance, Forbids );

  test.case = 'inline no method';

  test.identical( instance._f1Get, undefined );
  test.identical( instance._f1Set, undefined );
  test.identical( _.mapProperties( instance ), Object.create( null ) );

  test.case = 'throwing';

  if( Config.debug )
  {
    test.shouldThrowErrorSync( () => instance.f1 );
  }

  test.close( 'pure map' );

  /* - */

  test.open( 'with class' );

  test.case = 'setup';

  function BasicConstructor()
  {
    _.workpiece.initFields( this );
  }

  var Forbids =
  {
    f1 : 'f1',
  }

  var Extension =
  {
    Forbids,
  }

  // Extension.constructor = BasicConstructor;

  _.classDeclare
  ({
    cls : BasicConstructor,
    extend : Extension,
  });

  var instance = new BasicConstructor();

  test.case = 'inline no method';

  test.identical( instance._f1Get, undefined );
  test.identical( instance._f1Set, undefined );
  test.identical( BasicConstructor._f1Get, undefined );
  test.identical( BasicConstructor._f1Set, undefined );
  test.identical( BasicConstructor.prototype._f1Get, undefined );
  test.identical( BasicConstructor.prototype._f1Set, undefined );

  test.case = 'throwing';

  if( Config.debug )
  {
    test.shouldThrowErrorSync( () => instance.f1 );
    test.shouldThrowErrorSync( () => BasicConstructor.prototype.f1 );
  }

  test.close( 'with class' );

}

// forbids.timeOut = 300000;

//

function forbidWithoutConstructor( test )
{

  /* */

  test.case = 'basic';

  var proto = Object.create( null );
  proto.a = 'a1';

  var dst = Object.create( proto );
  dst.b = 'b2';

  var exp = { 'b' : 'b2' }

  var names = { abc : 'abc' }
  _.accessor.forbid
  ({
    object : dst,
    names : names,
  });

  test.contains( dst, exp );
  test.shouldThrowErrorSync( () => dst.abc = 'abc' );

  /* */

}

//

function getterWithSymbol( test )
{

  var object =
  {
    'a' : 'a1',
    'b' : 'b1',
  };
  var names =
  {
    _ : { get : _.accessor.getter.withSymbol, set : false, put : false },
    a : {},
  }
  _.accessor.declare
  ({
    object,
    names,
    prime : 0,
    strict : 0,
    addingMethods : 1,
  });
  var exp =
  {
    'a' : 'a1',
    'b' : 'b1',
    'aGrab' : object.aGrab,
    'aGet' : object.aGet,
    'aPut' : object.aPut,
    'aSet' : object.aSet,
    '_Grab' : object._Grab,
    '_Get' : object._Get,
    '_' :
    {
      'a' : 'a1',
      'b' : undefined,
      '_Grab' : undefined,
      '_Get' : undefined,
      '_' : undefined,
      'aGrab' : undefined,
      'aGet' : undefined,
      'aSet' : undefined,
      'aPut' : undefined,
    }
  }
  test.identical( object, exp );
  test.identical( object.a, exp.a );
  test.identical( object.b, exp.b );

}

//

function getterToValueDefine( test )
{

  /* */

  test.case = 'configurable : 1, set : 0, put : 0';
  var object =
  {
    'a' : 'a1',
    'b' : 'b1',
  };
  var names =
  {
    _ : { get : _.accessor.getter.toValue, set : false, put : false, configurable : true },
    a : {},
  }
  _.accessor.declare
  ({
    object,
    names,
    prime : 0,
    strict : 0,
    addingMethods : 1,
  });
  var exp =
  {
    'get' : object._Get,
    'set' : object._Set,
    'enumerable' : true,
    'configurable' : true
  }
  test.identical( _.mapBut( _.propertyDescriptorGet( object, '_' ).descriptor, [ 'value' ] ), exp );
  var exp =
  {
    'a' : 'a1',
    'b' : 'b1',
    'aGrab' : object.aGrab,
    'aGet' : object.aGet,
    'aPut' : object.aPut,
    'aSet' : object.aSet,
    '_Grab' : object._Grab,
    '_Get' : object._Get,
    '_' :
    {
      'a' : 'a1',
      'b' : undefined,
      '_Grab' : undefined,
      '_Get' : undefined,
      'aGrab' : undefined,
      'aGet' : undefined,
      'aPut' : undefined,
      'aSet' : undefined,
    }
  }
  test.identical( object, exp );
  test.identical( object.a, exp.a );
  test.identical( object.b, exp.b );
  var exp = { 'writable' : false, 'enumerable' : false, 'configurable' : false }
  test.identical( _.mapBut( _.propertyDescriptorGet( object, '_' ).descriptor, [ 'value' ] ), exp );

  /* */

  test.case = 'configurable : 0, set : 0, put : 0';
  var object =
  {
    'a' : 'a1',
    'b' : 'b1',
  };
  var names =
  {
    _ : { get : _.accessor.getter.toValue, set : false, put : false, configurable : false },
    a : {},
  }
  _.accessor.declare
  ({
    object,
    names,
    prime : 0,
    strict : 0,
    addingMethods : 1,
  });
  var exp =
  {
    'get' : object._Get,
    'set' : undefined,
    'enumerable' : true,
    'configurable' : false,
  }
  test.identical( _.mapBut( _.propertyDescriptorGet( object, '_' ).descriptor, [ 'value' ] ), exp );
  var exp =
  {
    'a' : 'a1',
    'b' : 'b1',
    '_Grab' : object._Grab,
    '_Get' : object._Get,
    'aGrab' : object.aGrab,
    'aGet' : object.aGet,
    'aPut' : object.aPut,
    'aSet' : object.aSet,
    '_' :
    {
      'a' : 'a1',
      'b' : undefined,
      '_Grab' : undefined,
      '_Get' : undefined,
      'aGrab' : undefined,
      'aGet' : undefined,
      'aPut' : undefined,
      'aSet' : undefined,
      '_' : undefined,
    }
  }
  test.identical( object, exp );
  test.identical( object.a, exp.a );
  test.identical( object.b, exp.b );
  var exp =
  {
    'get' : object._Get,
    'set' : undefined,
    'enumerable' : true,
    'configurable' : false,
  }
  test.identical( _.mapBut( _.propertyDescriptorGet( object, '_' ).descriptor, [ 'value' ] ), exp );

  /* */

  test.case = 'configurable : 0';
  var object =
  {
    'a' : 'a1',
    'b' : 'b1',
  };
  var names =
  {
    _ : { get : _.accessor.getter.toValue },
    a : {},
  }
  _.accessor.declare
  ({
    object,
    names,
    prime : 0,
    strict : 0,
    addingMethods : 1,
  });
  var exp =
  {
    'get' : object._Get,
    'set' : object._Set,
    'enumerable' : true,
    'configurable' : true,
  }
  test.identical( _.mapBut( _.propertyDescriptorGet( object, '_' ).descriptor, [ 'value' ] ), exp );
  var exp =
  {
    'a' : 'a1',
    'b' : 'b1',
    'aGrab' : object.aGrab,
    'aGet' : object.aGet,
    'aPut' : object.aPut,
    'aSet' : object.aSet,
    '_Grab' : object._Grab,
    '_Get' : object._Get,
    '_Put' : object._Put,
    '_Set' : object._Set,
    '_' :
    {
      'a' : 'a1',
      'b' : undefined,
      '_Grab' : undefined,
      '_Get' : undefined,
      '_Put' : undefined,
      '_Set' : undefined,
      'aGrab' : undefined,
      'aGet' : undefined,
      'aPut' : undefined,
      'aSet' : undefined,
    }
  }
  test.identical( object, exp );
  test.identical( object.a, exp.a );
  test.identical( object.b, exp.b );
  var exp = { 'writable' : false, 'enumerable' : false, 'configurable' : false };
  test.identical( _.mapBut( _.propertyDescriptorGet( object, '_' ).descriptor, [ 'value' ] ), exp );

  /* */

  test.case = 'suite';
  var object =
  {
    'a' : 'a1',
    'b' : 'b1',
  };
  var names =
  {
    _ : _.accessor.suite.toValue,
    a : {},
  }
  _.accessor.declare
  ({
    object,
    names,
    prime : 0,
    strict : 0,
    addingMethods : 1,
  });
  var exp =
  {
    'get' : object._Get,
    'set' : object._Set,
    'enumerable' : true,
    'configurable' : true
  }
  test.identical( _.mapBut( _.propertyDescriptorGet( object, '_' ).descriptor, [ 'value' ] ), exp );
  var exp =
  {
    'a' : 'a1',
    'b' : 'b1',
    'aGrab' : object.aGrab,
    'aGet' : object.aGet,
    'aPut' : object.aPut,
    'aSet' : object.aSet,
    '_Grab' : object._Grab,
    '_Get' : object._Get,
    '_Put' : object._Put,
    '_Set' : object._Set,
    '_' :
    {
      'a' : 'a1',
      'b' : undefined,
      '_Grab' : undefined,
      '_Get' : undefined,
      '_Put' : undefined,
      '_Set' : undefined,
      'aGrab' : undefined,
      'aGet' : undefined,
      'aPut' : undefined,
      'aSet' : undefined,
    }
  }
  test.identical( object, exp );
  test.identical( object.a, exp.a );
  test.identical( object.b, exp.b );
  var exp = { 'writable' : false, 'enumerable' : false, 'configurable' : false };
  test.identical( _.mapBut( _.propertyDescriptorGet( object, '_' ).descriptor, [ 'value' ] ), exp );

  /* */

  test.case = 'suite in fields';
  var object =
  {
    'a' : 'a1',
    'b' : 'b1',
  };
  var names =
  {
    _ : { suite : _.accessor.suite.toValue },
    a : {},
  }
  _.accessor.declare
  ({
    object,
    names,
    prime : 0,
    strict : 0,
    addingMethods : 1,
  });
  var exp =
  {
    'get' : object._Get,
    'set' : object._Set,
    'enumerable' : true,
    'configurable' : true
  }
  test.identical( _.mapBut( _.propertyDescriptorGet( object, '_' ).descriptor, [ 'value' ] ), exp );
  var exp =
  {
    'a' : 'a1',
    'b' : 'b1',
    'aGrab' : object.aGrab,
    'aGet' : object.aGet,
    'aPut' : object.aPut,
    'aSet' : object.aSet,
    '_Grab' : object._Grab,
    '_Get' : object._Get,
    '_Put' : object._Put,
    '_Set' : object._Set,
    '_' :
    {
      'a' : 'a1',
      'b' : undefined,
      '_Grab' : undefined,
      '_Get' : undefined,
      '_Put' : undefined,
      '_Set' : undefined,
      'aGrab' : undefined,
      'aGet' : undefined,
      'aPut' : undefined,
      'aSet' : undefined,
    }
  }
  test.identical( object, exp );
  test.identical( object.a, exp.a );
  test.identical( object.b, exp.b );
  var exp = { 'writable' : false, 'enumerable' : false, 'configurable' : false };
  test.identical( _.mapBut( _.propertyDescriptorGet( object, '_' ).descriptor, [ 'value' ] ), exp );

  /* */

  test.case = 'suite in fields, explicit configurable';
  var object =
  {
    'a' : 'a1',
    'b' : 'b1',
  };
  var names =
  {
    _ : { suite : _.accessor.suite.toValue, configurable : false },
    a : {},
  }
  _.accessor.declare
  ({
    object,
    names,
    prime : 0,
    strict : 0,
    addingMethods : 1,
  });
  var exp =
  {
    'get' : object._Get,
    'set' : object._Set,
    'enumerable' : true,
    'configurable' : false
  }
  test.identical( _.mapBut( _.propertyDescriptorGet( object, '_' ).descriptor, [ 'value' ] ), exp );
  var exp =
  {
    'a' : 'a1',
    'b' : 'b1',
    'aGrab' : object.aGrab,
    'aGet' : object.aGet,
    'aPut' : object.aPut,
    'aSet' : object.aSet,
    '_Grab' : object._Grab,
    '_Get' : object._Get,
    '_Put' : object._Put,
    '_Set' : object._Set,
    '_' :
    {
      'a' : 'a1',
      'b' : undefined,
      '_' : undefined,
      '_Grab' : undefined,
      '_Get' : undefined,
      '_Put' : undefined,
      '_Set' : undefined,
      'aGrab' : undefined,
      'aGet' : undefined,
      'aPut' : undefined,
      'aSet' : undefined,
    }
  }
  test.identical( object, exp );
  test.identical( object.a, exp.a );
  test.identical( object.b, exp.b );
  var exp =
  {
    'get' : object._Get,
    'set' : object._Set,
    'enumerable' : true,
    'configurable' : false
  }
  test.identical( _.mapBut( _.propertyDescriptorGet( object, '_' ).descriptor, [ 'value' ] ), exp );

  /* */

}

//

function getterToValueAccess( test )
{

  /* */

  test.case = 'had value, addingMethods : 1';
  var object =
  {
    'a' : 'a1',
    'b' : 'b1',
    'c' : 'c1',
  };
  var names =
  {
    _ : { suite : _.accessor.suite.toValue },
    a : {},
    b : {},
  }
  _.accessor.declare
  ({
    object,
    names,
    prime : 0,
    strict : 0,
    addingMethods : 1,
  });
  var exp =
  {
    'get' : object._Get,
    'set' : object._Set,
    'enumerable' : true,
    'configurable' : true
  }
  test.identical( _.mapBut( _.propertyDescriptorGet( object, '_' ).descriptor, [ 'value' ] ), exp );

  var exp =
  {
    'a' : 'a1',
    'b' : 'b1',
    'c' : 'c1',
    '_Grab' : object._Grab,
    '_Get' : object._Get,
    '_Put' : object._Put,
    '_Set' : object._Set,
    'aGrab' : object.aGrab,
    'aSet' : object.aSet,
    'aGet' : object.aGet,
    'aPut' : object.aPut,
    'bGrab' : object.bGrab,
    'bSet' : object.bSet,
    'bGet' : object.bGet,
    'bPut' : object.bPut,
    '_' :
    {
      'a' : 'a1',
      'b' : 'b1',
      'c' : undefined,
      '_Grab' : undefined,
      '_Get' : undefined,
      '_Put' : undefined,
      '_Set' : undefined,
      'aGrab' : undefined,
      'aSet' : undefined,
      'aGet' : undefined,
      'aPut' : undefined,
      'bGrab' : undefined,
      'bSet' : undefined,
      'bGet' : undefined,
      'bPut' : undefined,
    }
  }
  test.identical( object, exp );

  var exp =
  {
    'enumerable' : false,
    'configurable' : false,
    'writable' : false,
  }
  test.identical( _.mapBut( _.propertyDescriptorGet( object, '_' ).descriptor, [ 'value' ] ), exp );
  test.identical( object.a, 'a1' );
  test.identical( object._.a, 'a1' );
  test.identical( object.b, 'b1' );
  test.identical( object._.b, 'b1' );
  test.identical( object.c, 'c1' );
  test.identical( object._.c, undefined );

  object._.a = 'a2';
  test.identical( object.a, 'a2' );
  test.identical( object._.a, 'a2' );
  test.identical( object.b, 'b1' );
  test.identical( object._.b, 'b1' );
  test.identical( object.c, 'c1' );
  test.identical( object._.c, undefined );

  object.a = 'a3';
  test.identical( object.a, 'a3' );
  test.identical( object._.a, 'a3' );
  test.identical( object.b, 'b1' );
  test.identical( object._.b, 'b1' );
  test.identical( object.c, 'c1' );
  test.identical( object._.c, undefined );

  object.b = 'b2';
  test.identical( object.a, 'a3' );
  test.identical( object._.a, 'a3' );
  test.identical( object.b, 'b2' );
  test.identical( object._.b, 'b2' );
  test.identical( object.c, 'c1' );
  test.identical( object._.c, undefined );

  object._.b = 'b3';
  test.identical( object.a, 'a3' );
  test.identical( object._.a, 'a3' );
  test.identical( object.b, 'b3' );
  test.identical( object._.b, 'b3' );
  test.identical( object.c, 'c1' );
  test.identical( object._.c, undefined );

  object.c = 'c2';
  test.identical( object.a, 'a3' );
  test.identical( object._.a, 'a3' );
  test.identical( object.b, 'b3' );
  test.identical( object._.b, 'b3' );
  test.identical( object.c, 'c2' );
  test.identical( object._.c, undefined );

  object._.c = 'c3';
  test.identical( object.a, 'a3' );
  test.identical( object._.a, 'a3' );
  test.identical( object.b, 'b3' );
  test.identical( object._.b, 'b3' );
  test.identical( object.c, 'c2' );
  test.identical( object._.c, 'c3' );

  /* */

  test.case = 'had value, addingMethods : 0';
  var object =
  {
    'a' : 'a1',
    'b' : 'b1',
    'c' : 'c1',
  };
  var names =
  {
    _ : { suite : _.accessor.suite.toValue },
    a : {},
    b : {},
  }
  _.accessor.declare
  ({
    object,
    names,
    prime : 0,
    strict : 0,
    addingMethods : 0,
  });
  var exp =
  {
    'enumerable' : true,
    'configurable' : true
  }
  test.identical( _.mapBut( _.propertyDescriptorGet( object, '_' ).descriptor, [ 'value', 'set', 'get' ] ), exp );
  var exp =
  {
    'a' : 'a1',
    'b' : 'b1',
    'c' : 'c1',
    '_' :
    {
      'a' : 'a1',
      'b' : 'b1',
      'c' : undefined,
    }
  }

  test.identical( object, exp );
  var exp =
  {
    'enumerable' : false,
    'configurable' : false,
    'writable' : false,
  }
  test.identical( _.mapBut( _.propertyDescriptorGet( object, '_' ).descriptor, [ 'value' ] ), exp );
  test.identical( object.a, 'a1' );
  test.identical( object._.a, 'a1' );
  test.identical( object.b, 'b1' );
  test.identical( object._.b, 'b1' );
  test.identical( object.c, 'c1' );
  test.identical( object._.c, undefined );

  object._.a = 'a2';
  test.identical( object.a, 'a2' );
  test.identical( object._.a, 'a2' );
  test.identical( object.b, 'b1' );
  test.identical( object._.b, 'b1' );
  test.identical( object.c, 'c1' );
  test.identical( object._.c, undefined );

  object.a = 'a3';
  test.identical( object.a, 'a3' );
  test.identical( object._.a, 'a3' );
  test.identical( object.b, 'b1' );
  test.identical( object._.b, 'b1' );
  test.identical( object.c, 'c1' );
  test.identical( object._.c, undefined );

  object.b = 'b2';
  test.identical( object.a, 'a3' );
  test.identical( object._.a, 'a3' );
  test.identical( object.b, 'b2' );
  test.identical( object._.b, 'b2' );
  test.identical( object.c, 'c1' );
  test.identical( object._.c, undefined );

  object._.b = 'b3';
  test.identical( object.a, 'a3' );
  test.identical( object._.a, 'a3' );
  test.identical( object.b, 'b3' );
  test.identical( object._.b, 'b3' );
  test.identical( object.c, 'c1' );
  test.identical( object._.c, undefined );

  object.c = 'c2';
  test.identical( object.a, 'a3' );
  test.identical( object._.a, 'a3' );
  test.identical( object.b, 'b3' );
  test.identical( object._.b, 'b3' );
  test.identical( object.c, 'c2' );
  test.identical( object._.c, undefined );

  object._.c = 'c3';
  test.identical( object.a, 'a3' );
  test.identical( object._.a, 'a3' );
  test.identical( object.b, 'b3' );
  test.identical( object._.b, 'b3' );
  test.identical( object.c, 'c2' );
  test.identical( object._.c, 'c3' );

  /* */

  test.case = 'had no value, addingMethods : 1';
  var object =
  {
  };
  var names =
  {
    _ : { suite : _.accessor.suite.toValue },
    a : {},
    b : {},
  }
  _.accessor.declare
  ({
    object,
    names,
    prime : 0,
    strict : 0,
    addingMethods : 1,
  });
  var exp =
  {
    'get' : object._Get,
    'set' : object._Set,
    'enumerable' : true,
    'configurable' : true
  }
  test.identical( _.mapBut( _.propertyDescriptorGet( object, '_' ).descriptor, [ 'value' ] ), exp );

  var exp =
  {
    'a' : undefined,
    'b' : undefined,
    '_Grab' : object._Grab,
    '_Get' : object._Get,
    '_Put' : object._Put,
    '_Set' : object._Set,
    'aGrab' : object.aGrab,
    'aSet' : object.aSet,
    'aGet' : object.aGet,
    'aPut' : object.aPut,
    'bGrab' : object.bGrab,
    'bSet' : object.bSet,
    'bGet' : object.bGet,
    'bPut' : object.bPut,
    '_' :
    {
      'a' : undefined,
      'b' : undefined,
      '_Grab' : undefined,
      '_Get' : undefined,
      '_Put' : undefined,
      '_Set' : undefined,
      'aGrab' : undefined,
      'aSet' : undefined,
      'aGet' : undefined,
      'aPut' : undefined,
      'bGrab' : undefined,
      'bSet' : undefined,
      'bGet' : undefined,
      'bPut' : undefined,
    }
  }
  test.identical( object, exp );
  var exp =
  {
    'enumerable' : false,
    'configurable' : false,
    'writable' : false,
  }
  test.identical( _.mapBut( _.propertyDescriptorGet( object, '_' ).descriptor, [ 'value' ] ), exp );
  test.identical( object.a, undefined );
  test.identical( object._.a, undefined );
  test.identical( object.b, undefined );
  test.identical( object._.b, undefined );
  test.identical( object.c, undefined );
  test.identical( object._.c, undefined );

  object._.a = 'a2';
  test.identical( object.a, 'a2' );
  test.identical( object._.a, 'a2' );
  test.identical( object.b, undefined );
  test.identical( object._.b, undefined );
  test.identical( object.c, undefined );
  test.identical( object._.c, undefined );

  object.a = 'a3';
  test.identical( object.a, 'a3' );
  test.identical( object._.a, 'a3' );
  test.identical( object.b, undefined );
  test.identical( object._.b, undefined );
  test.identical( object.c, undefined );
  test.identical( object._.c, undefined );

  object.b = 'b2';
  test.identical( object.a, 'a3' );
  test.identical( object._.a, 'a3' );
  test.identical( object.b, 'b2' );
  test.identical( object._.b, 'b2' );
  test.identical( object.c, undefined );
  test.identical( object._.c, undefined );

  object._.b = 'b3';
  test.identical( object.a, 'a3' );
  test.identical( object._.a, 'a3' );
  test.identical( object.b, 'b3' );
  test.identical( object._.b, 'b3' );
  test.identical( object.c, undefined );
  test.identical( object._.c, undefined );

  object.c = 'c2';
  test.identical( object.a, 'a3' );
  test.identical( object._.a, 'a3' );
  test.identical( object.b, 'b3' );
  test.identical( object._.b, 'b3' );
  test.identical( object.c, 'c2' );
  test.identical( object._.c, undefined );

  object._.c = 'c3';
  test.identical( object.a, 'a3' );
  test.identical( object._.a, 'a3' );
  test.identical( object.b, 'b3' );
  test.identical( object._.b, 'b3' );
  test.identical( object.c, 'c2' );
  test.identical( object._.c, 'c3' );

  /**/

  test.case = 'had no value, addingMethods : 0';
  var object =
  {
  };
  var names =
  {
    _ : { suite : _.accessor.suite.toValue },
    a : {},
    b : {},
  }
  _.accessor.declare
  ({
    object,
    names,
    prime : 0,
    strict : 0,
    addingMethods : 0,
  });
  var exp =
  {
    'enumerable' : true,
    'configurable' : true
  }
  test.identical( _.mapBut( _.propertyDescriptorGet( object, '_' ).descriptor, [ 'value', 'get', 'set' ] ), exp );
  var exp =
  {
    'a' : undefined,
    'b' : undefined,
    '_' :
    {
      'a' : undefined,
      'b' : undefined,
    }
  }
  test.identical( object, exp );
  var exp =
  {
    'enumerable' : false,
    'configurable' : false,
    'writable' : false,
  }
  test.identical( _.mapBut( _.propertyDescriptorGet( object, '_' ).descriptor, [ 'value' ] ), exp );
  test.identical( object.a, undefined );
  test.identical( object._.a, undefined );
  test.identical( object.b, undefined );
  test.identical( object._.b, undefined );
  test.identical( object.c, undefined );
  test.identical( object._.c, undefined );

  object._.a = 'a2';
  test.identical( object.a, 'a2' );
  test.identical( object._.a, 'a2' );
  test.identical( object.b, undefined );
  test.identical( object._.b, undefined );
  test.identical( object.c, undefined );
  test.identical( object._.c, undefined );

  object.a = 'a3';
  test.identical( object.a, 'a3' );
  test.identical( object._.a, 'a3' );
  test.identical( object.b, undefined );
  test.identical( object._.b, undefined );
  test.identical( object.c, undefined );
  test.identical( object._.c, undefined );

  object.b = 'b2';
  test.identical( object.a, 'a3' );
  test.identical( object._.a, 'a3' );
  test.identical( object.b, 'b2' );
  test.identical( object._.b, 'b2' );
  test.identical( object.c, undefined );
  test.identical( object._.c, undefined );

  object._.b = 'b3';
  test.identical( object.a, 'a3' );
  test.identical( object._.a, 'a3' );
  test.identical( object.b, 'b3' );
  test.identical( object._.b, 'b3' );
  test.identical( object.c, undefined );
  test.identical( object._.c, undefined );

  object.c = 'c2';
  test.identical( object.a, 'a3' );
  test.identical( object._.a, 'a3' );
  test.identical( object.b, 'b3' );
  test.identical( object._.b, 'b3' );
  test.identical( object.c, 'c2' );
  test.identical( object._.c, undefined );

  object._.c = 'c3';
  test.identical( object.a, 'a3' );
  test.identical( object._.a, 'a3' );
  test.identical( object.b, 'b3' );
  test.identical( object._.b, 'b3' );
  test.identical( object.c, 'c2' );
  test.identical( object._.c, 'c3' );

  /* */

}

//

function putterSymbol( test )
{

  /* */

  test.case = 'addingMethods : 1';
  var object =
  {
    'a' : 'a1',
    'b' : 'b1',
    aPut : _.accessor.putter.symbol,
    aSet : function( src ) { this[ Symbol.for( 'a' ) ] = src; this.b = src },
    aGet : function() { return this[ Symbol.for( 'a' ) ] },
  };
  _.accessor.declare
  ({
    object,
    names : { a : {} },
    prime : 0,
    strict : 0,
    addingMethods : 1,
  });
  var exp =
  {
    'a' : 'a1',
    'b' : 'b1',
    aGrab : object.aGrab,
    aGet : object.aGet,
    aPut : object.aPut,
    aSet : object.aSet,
  }
  test.identical( object, exp );
  test.true( object.aPut !== _.accessor.putter.symbol );

  object.aPut( 'c' );
  var exp =
  {
    'a' : 'c',
    'b' : 'b1',
    aGrab : object.aGrab,
    aGet : object.aGet,
    aPut : object.aPut,
    aSet : object.aSet,
  }
  test.identical( object, exp );

  object.aSet( 'd' );
  var exp =
  {
    'a' : 'd',
    'b' : 'd',
    aGrab : object.aGrab,
    aGet : object.aGet,
    aPut : object.aPut,
    aSet : object.aSet,
  }
  test.identical( object, exp );

  object.a = 'e';
  var exp =
  {
    'a' : 'e',
    'b' : 'e',
    aGrab : object.aGrab,
    aGet : object.aGet,
    aPut : object.aPut,
    aSet : object.aSet,
  }
  test.identical( object, exp );

  /* */

}

//

function propertyConstant( test )
{

  test.case = 'second argument is map';
  var dstMap = {};
  _.propertyConstant( dstMap, { a : 5 } );
  var descriptor = Object.getOwnPropertyDescriptor( dstMap, 'a' );
  test.identical( descriptor.writable, false );
  test.identical( dstMap.a, 5 );

  test.case = 'rewrites existing field';
  var dstMap = { a : 5 };
  _.propertyConstant( dstMap, { a : 1 } );
  var descriptor = Object.getOwnPropertyDescriptor( dstMap, 'a' );
  test.identical( descriptor.writable, false );
  test.identical( dstMap.a, 1 );

  test.case = '3 arguments';
  var dstMap = {};
  _.propertyConstant( dstMap, 'a', 5 );
  var descriptor = Object.getOwnPropertyDescriptor( dstMap, 'a' );
  test.identical( descriptor.writable, false );
  test.identical( dstMap.a, 5 );

  test.case = '2 arguments, no value';
  var dstMap = {};
  _.propertyConstant( dstMap, 'a' );
  var descriptor = Object.getOwnPropertyDescriptor( dstMap, 'a' );
  test.identical( descriptor.writable, false );
  test.identical( dstMap.a, undefined );
  test.true( 'a' in dstMap );

  test.case = 'second argument is array';
  var dstMap = {};
  _.propertyConstant( dstMap, [ 'a' ], 5 );
  var descriptor = Object.getOwnPropertyDescriptor( dstMap, 'a' );
  test.identical( descriptor.writable, false );
  test.identical( dstMap.a, 5 );

  if( !Config.debug )
  return;

  test.case = 'empty call';
  test.shouldThrowErrorSync( function()
  {
    _.propertyConstant( );
  });

  test.case = 'invalid first argument type';
  test.shouldThrowErrorSync( function()
  {
    _.propertyConstant( 1, { a : 'a' } );
  });

  test.case = 'invalid second argument type';
  test.shouldThrowErrorSync( function()
  {
    _.propertyConstant( {}, 13 );
  });

}

//

function classDeclare( test )
{
  var context = this;

  /* */

  test.case = 'first classDeclare';

  function C1()
  {
    this.Instances.push( this );
  }
  var Statics1 =
  {
    Instances : [],
    f1 : [],
    f2 : [],
    f3 : [],
  }
  var Extend1 =
  {
    Statics : Statics1,
    f1 : [],
    f2 : [],
    f4 : [],
  }
  var classMade = _.classDeclare
  ({
    cls : C1,
    parent : null,
    extend : Extend1,
  });

  test.identical( C1, classMade );
  test.true( C1.Instances === Statics1.Instances );

  test1({ Class : C1 });
  testFields( Statics1.f3 );

  /* */

  test.case = 'classDeclare with parent';

  function C2()
  {
    C1.call( this );
  }
  var classMade = _.classDeclare
  ({
    cls : C2,
    parent : C1,
  });

  test.identical( C2, classMade );

  test1({ Class : C1, Statics : Statics1 });

  test.true( C1.Instances === Statics1.Instances );
  test.true( C2.Instances === C1.Instances );

  test1({ Class : C2, Class0 : C1, Statics : Statics1, ownStatics : 0 });

  /* */

  test.case = 'classDeclare with supplement';

  function Csupplement()
  {
    C1.call( this );
  }
  var Statics2 =
  {
    Instances : [],
  }
  var classMade = _.classDeclare
  ({
    cls : Csupplement,
    parent : C1,
    supplement : { Statics : Statics2 },
  });

  test.identical( Csupplement,classMade );

  test1({ Class : C1, Statics : Statics1 });
  test1({ Class : Csupplement, Class0 : C1, Statics : Statics1, ownStatics : 0 });

  /* */

  test.case = 'classDeclare with extend';

  function C3()
  {
    C1.call( this );
  }
  var Associates =
  {
  }
  var Statics2 =
  {
    Instances : [],
    f1 : [],
    f4 : [],
  }
  var Extend2 =
  {
    Statics : Statics2,
    Associates,
    f2 : [],
    f3 : [],
  }
  var classMade = _.classDeclare
  ({
    cls : C3,
    parent : C1,
    extend : Extend2,
    allowingExtendStatics : 1,
  });

  test.identical( C3, classMade );

  test1({ Class : C1, Statics : Statics1 });
  test1
  ({
    Class : C3,
    Class0 : C1,
    Statics : Statics2,
    Extension : Extend2,
    keys : [ 'Instances', 'f1', 'f4', 'f2', 'f3' ],
    vals : [ C3.Instances, C3.f1, C3.f4, C1.f2, C1.f3 ],
  });

  testFields( Extend2.f3 );
  testFields2();

  if( !Config.debug )
  return;

  test.case = 'attempt to extend statics without order';

  test.shouldThrowErrorSync( function()
  {

    function C3()
    {
      C1.call( this );
    }
    var Associates =
    {
    }
    var Statics2 =
    {
      Instances : [],
      f1 : [],
      f4 : [],
    }
    var Extend2 =
    {
      Statics : Statics2,
      Associates,
      f2 : [],
      f3 : [],
    }
    var classMade = _.classDeclare
    ({
      cls : C3,
      parent : C1,
      extend : Extend2,
    });

  });

  /* */

  function test1( o )
  {

    if( o.ownStatics === undefined )
    o.ownStatics = 1;

    if( !o.Statics )
    o.Statics = Statics1;

    if( !o.Extension )
    o.Extension = Extend1;

    if( !o.keys )
    o.keys = _.mapKeys( o.Statics );

    if( !o.vals )
    o.vals = _.mapVals( o.Statics );

    var C0proto = null;
    if( !o.Class0 )
    {
      o.Class0 = Function.prototype;
    }
    else
    {
      C0proto = o.Class0.prototype;
    }

    test.case = 'presence of valid prototype and constructor fields on class and prototype';

    test.identical( o.Class, o.Class.prototype.constructor );
    test.identical( Object.getPrototypeOf( o.Class ), o.Class0 );
    test.identical( Object.getPrototypeOf( o.Class.prototype ), C0proto );

    test.case = 'presence of valid static field on class and prototype';

    test.identical( o.Class.Instances, o.Class.prototype.Instances );

    test.case = 'getting property descriptor of static field from constructor';

    var cd = Object.getOwnPropertyDescriptor( o.Class, 'Instances' );
    if( !o.ownStatics )
    {
      test.identical( cd, undefined );
    }
    else
    {
      test.identical( cd.configurable, true );
      test.identical( cd.enumerable, true );
      test.true( !!cd.get );
      test.true( !!cd.set );
    }

    var pd = Object.getOwnPropertyDescriptor( o.Class.prototype, 'Instances' );

    if( !o.ownStatics )
    {
      test.identical( pd, undefined );
    }
    else
    {
      test.identical( pd.configurable, true );
      test.identical( pd.enumerable, false );
      test.true( !!pd.get );
      test.true( !!pd.set );
    }

    test.case = 'making the first instance';

    var c1a = new o.Class();

    test.case = 'presence of valid static field on all';

    if( o.Class !== C1 && !o.ownStatics )
    test.true( o.Class.Instances === C1.Instances );
    test.true( o.Class.Instances === o.Class.prototype.Instances );
    test.true( o.Class.Instances === c1a.Instances );
    test.true( o.Class.Instances === o.Statics.Instances );
    test.identical( o.Class.Instances.length, o.Statics.Instances.length );
    test.identical( o.Class.Instances[ o.Statics.Instances.length-1 ], c1a );

    test.case = 'presence of valid prototype and constructor fields on instance';

    test.identical( Object.getPrototypeOf( c1a ), o.Class.prototype );
    test.identical( c1a.constructor, o.Class );

    test.case = 'presence of valid Statics descriptor';

    test.true( o.Statics !== o.Class.prototype.Statics );
    test.true( o.Statics !== c1a.Statics );

    test.identical( _.mapKeys( c1a.Statics ), o.keys );
    test.identical( _.mapVals( c1a.Statics ), o.vals );
    test.identical( o.Class.Statics, undefined );

    if( !C0proto )
    {
      var r = _.entityIdentical( o.Class.prototype.Statics, o.Statics );
      test.identical( o.Class.prototype.Statics, o.Statics );
      test.identical( c1a.Statics, o.Statics );
    }

    test.case = 'presence of conflicting fields';

    test.true( o.Class.prototype.f1 === c1a.f1 );
    test.true( o.Class.prototype.f2 === c1a.f2 );
    test.true( o.Class.prototype.f3 === c1a.f3 );
    test.true( o.Class.prototype.f4 === c1a.f4 );

    test.case = 'making the second instance';

    var c1b = new o.Class();
    test.identical( o.Class.Instances, o.Class.prototype.Instances );
    test.identical( o.Class.Instances, c1a.Instances );
    test.identical( o.Class.Instances.length, o.Statics.Instances.length );
    test.identical( o.Class.Instances[ o.Statics.Instances.length-2 ], c1a );
    test.identical( o.Class.Instances[ o.Statics.Instances.length-1 ], c1b );

    test.case = 'setting static field with constructor';

    o.Class.Instances = o.Class.Instances.slice();
    test.true( o.Class.Instances === C1.Instances || _.mapOwnKey( o.Class.prototype.Statics, 'Instances' ) );
    test.true( o.Class.Instances === o.Class.prototype.Instances );
    test.true( o.Class.Instances === c1a.Instances );
    test.true( o.Class.Instances === c1b.Instances );
    test.true( o.Class.Instances !== o.Statics.Instances );
    o.Class.Instances = Statics1.Instances;

    test.case = 'setting static field with prototype';

    o.Class.prototype.Instances = o.Class.prototype.Instances.slice();
    test.true( o.Class.Instances === C1.Instances || _.mapOwnKey( o.Class.prototype.Statics, 'Instances' ) );
    test.true( o.Class.Instances === o.Class.prototype.Instances );
    test.true( o.Class.Instances === c1a.Instances );
    test.true( o.Class.Instances === c1b.Instances );
    test.true( o.Class.Instances !== o.Statics.Instances );
    o.Class.Instances = Statics1.Instances;

    test.case = 'setting static field with instance';

    c1a.Instances = o.Class.Instances.slice();
    test.true( o.Class.Instances === C1.Instances || _.mapOwnKey( o.Class.prototype.Statics, 'Instances' ) );
    test.true( o.Class.Instances === o.Class.prototype.Instances );
    test.true( o.Class.Instances === c1a.Instances );
    test.true( o.Class.Instances === c1b.Instances );
    test.true( o.Class.Instances !== o.Statics.Instances );
    o.Class.Instances = Statics1.Instances;

  }

  /* */

  function testFields( f3 )
  {

    test.case = 'presence of conflicting fields in the first class';

    test.true( Statics1.f1 === C1.f1 );
    test.true( Extend1.f1 === C1.prototype.f1 );

    test.true( Statics1.f2 === C1.f2 );
    test.true( Extend1.f2 === C1.prototype.f2 );

    test.true( f3 === C1.f3 );
    test.true( f3 === C1.prototype.f3 );

    test.true( Statics1.f4 === undefined );
    test.true( Statics1.f4 === C1.f4 );
    test.true( Extend1.f4 === C1.prototype.f4 );

    var d = Object.getOwnPropertyDescriptor( C1,'f1' );
    test.true( d.enumerable === true );
    test.true( d.configurable === true );
    test.true( d.writable === true );
    test.true( !!d.value );

    var d = Object.getOwnPropertyDescriptor( C1.prototype,'f1' );
    test.true( d.enumerable === true );
    test.true( d.configurable === true );
    test.true( d.writable === true );
    test.true( !!d.value );

    var d = Object.getOwnPropertyDescriptor( C1,'f2' );
    test.true( d.enumerable === true );
    test.true( d.configurable === true );
    test.true( d.writable === true );
    test.true( !!d.value );

    var d = Object.getOwnPropertyDescriptor( C1.prototype,'f2' );
    test.true( d.enumerable === true );
    test.true( d.configurable === true );
    test.true( d.writable === true );
    test.true( !!d.value );

    var d = Object.getOwnPropertyDescriptor( C1,'f3' );
    test.true( d.enumerable === true );
    test.true( d.configurable === true );
    test.true( !!d.get );
    test.true( !!d.set );

    var d = Object.getOwnPropertyDescriptor( C1.prototype,'f3' );
    test.true( d.enumerable === false );
    test.true( d.configurable === true );
    test.true( !!d.get );
    test.true( !!d.set );

    var d = Object.getOwnPropertyDescriptor( C1,'f4' );
    test.true( !d );

    var d = Object.getOwnPropertyDescriptor( C1.prototype,'f4' );
    test.true( d.enumerable === true );
    test.true( d.configurable === true );
    test.true( d.writable === true );
    test.true( !!d.value );

  }

  /* */

  function testFields2()
  {

    test.case = 'presence of conflicting fields in the second class';

    test.true( Statics2.f1 === C3.f1 );
    test.true( Statics2.f1 === C3.prototype.f1 );

    test.true( Statics1.f2 === C3.f2 );
    test.true( Extend2.f2 === C3.prototype.f2 );

    test.true( Extend2.f3 === C3.f3 );
    test.true( Extend2.f3 === C3.prototype.f3 );

    test.true( Statics2.f4 === C3.f4 );
    test.true( Statics2.f4 === C3.prototype.f4 );

    var d = Object.getOwnPropertyDescriptor( C3,'f1' );
    test.true( d.enumerable === true );
    test.true( d.configurable === true );
    test.true( !!d.get );
    test.true( !!d.set );

    var d = Object.getOwnPropertyDescriptor( C3.prototype,'f1' );
    test.true( d.enumerable === false );
    test.true( d.configurable === true );
    test.true( !!d.get );
    test.true( !!d.set );

    var d = Object.getOwnPropertyDescriptor( C3,'f2' );
    test.true( !d );

    var d = Object.getOwnPropertyDescriptor( C3.prototype,'f2' );
    test.true( d.enumerable === true );
    test.true( d.configurable === true );
    test.true( d.writable === true );
    test.true( !!d.value );

    var d = Object.getOwnPropertyDescriptor( C3,'f3' );
    test.true( !d );

    var d = Object.getOwnPropertyDescriptor( C3.prototype,'f3' );
    test.true( !d );

    var d = Object.getOwnPropertyDescriptor( C3,'f4' );
    test.true( d.enumerable === true );
    test.true( d.configurable === true );
    test.true( !!d.get );
    test.true( !!d.set );

    var d = Object.getOwnPropertyDescriptor( C3.prototype,'f4' );
    test.true( d.enumerable === false );
    test.true( d.configurable === true );
    test.true( !!d.get );
    test.true( !!d.set );

    test.case = 'assigning static fields';

    C1.f1 = 1;
    C1.f2 = 2;
    C1.f3 = 3;
    C1.f4 = 4;

    C1.prototype.f1 = 11;
    C1.prototype.f2 = 12;
    C1.prototype.f3 = 13;
    C1.prototype.f4 = 14;

    C2.f1 = 21;
    C2.f2 = 22;
    C2.f3 = 23;
    C2.f4 = 24;

    C2.prototype.f1 = 31;
    C2.prototype.f2 = 32;
    C2.prototype.f3 = 33;
    C2.prototype.f4 = 34;

    test.identical( C1.f1,1 );
    test.identical( C1.f2,2 );
    debugger;
    test.identical( C1.f3,33 );
    debugger;
    test.identical( C1.f4,4 );

    test.identical( C1.prototype.f1,11 );
    test.identical( C1.prototype.f2,12 );
    test.identical( C1.prototype.f3,33 );
    test.identical( C1.prototype.f4,14 );

    test.identical( C2.f1,21 );
    test.identical( C2.f2,22 );
    test.identical( C2.f3,33 );
    test.identical( C2.f4,24 );

    test.identical( C2.prototype.f1,31 );
    test.identical( C2.prototype.f2,32 );
    test.identical( C2.prototype.f3,33 );
    test.identical( C2.prototype.f4,34 );

  }

}

//

function callable( test )
{

  class Cls extends _.CallableObject
  {
    constructor()
    {
      let self = super();
      self.x = 1;
      return self;
    }
    __call__( y )
    {
      return this.x+y;
    }
  }

  var ins = new Cls;
  var got = ins( 5 );
  test.identical( got, 6 );
  var got = ins.x;
  test.identical( got, 1 );

}

//

function accessorSupplement( test )
{
  test.case = 'supplement Beta with accessor "a" declared on Alpha'
  var Alpha = function _Alpha(){}
  _.classDeclare
  ({
    cls : Alpha,
    parent : null,
    extend :
    {
      Composes : {},
    }
  });
  _.accessor.declare( Alpha.prototype, { a : 'a' } );

  var Beta = function _Beta(){}
  _.classDeclare
  ({
    cls : Beta,
    parent : null,
    extend :
    {
      Accessors : {}
    }
  });
  _.accessor.supplement( Beta.prototype,Alpha.prototype );

  var x = new Beta();
  x.a = 2;
  test.identical( x.a, 2 );

  test.case = 'supplement Beta with accessor "a" declared on Alpha, Beta has accessor "b"'
  var Alpha = function _Alpha(){}
  _.classDeclare
  ({
    cls : Alpha,
    parent : null,
    extend :
    {
      Composes : {},
    }
  });
  _.accessor.declare( Alpha.prototype, { a : 'a' } );

  var Beta = function _Beta(){}
  _.classDeclare
  ({
    cls : Beta,
    parent : null,
    extend :
    {
      Accessors : {}
    }
  });
  _.accessor.declare( Beta.prototype, { b : 'b' } );

  _.accessor.supplement( Beta.prototype,Alpha.prototype );

  var x = new Beta();
  x.a = 2;
  x.b = 4;
  test.identical( x.a, 2 );
  test.identical( x.b, 4 );

  /* */

  test.case = 'supplement Beta with accessors of Alpha, both have same accessor'
  var Alpha = function _Alpha(){}
  _.classDeclare
  ({
    cls : Alpha,
    parent : null,
    extend :
    {
      Composes : {},
    }
  });
  _.accessor.declare( Alpha.prototype, { a : 'a' } );

  var Beta = function _Beta(){}
  _.classDeclare
  ({
    cls : Beta,
    parent : null,
    extend :
    {
      _aGet : function()
      {
        return this[ Symbol.for( 'a' ) ] * 2;
      },
      Accessors : {}
    }
  });
  _.accessor.declare( Beta.prototype, { a : 'a' } );

  _.accessor.supplement( Beta.prototype,Alpha.prototype );

  var x = new Beta();
  x.a = 2;
  test.identical( x.a, 4 );

  /* */

  test.case = 'Alpha: a, b - getter, c - setter, Beta: a - getter'
  var Alpha = function _Alpha(){}
  _.classDeclare
  ({
    cls : Alpha,
    parent : null,
    extend :
    {
      _bGet : function()
      {
        return this[ Symbol.for( 'b' ) ] * 2;
      },
      _cSet : function( src )
      {
        this[ Symbol.for( 'c' ) ] = src * 2;
      },
      Composes : {},
    }
  });
  _.accessor.declare( Alpha.prototype, { a : 'a' } );
  _.accessor.declare( Alpha.prototype, { b : 'b' } );
  _.accessor.declare( Alpha.prototype, { c : 'c' } );

  var Beta = function _Beta(){}
  _.classDeclare
  ({
    cls : Beta,
    parent : null,
    extend :
    {
      _aGet : function()
      {
        return this[ Symbol.for( 'a' ) ] * 2;
      },
      Accessors : {}
    }
  });

  _.accessor.declare( Beta.prototype, { a : 'a' } );
  _.accessor.supplement( Beta.prototype,Alpha.prototype );

  var x = new Beta();
  x.a = 2;
  x.b = 3;
  x.c = 4;
  test.identical( x[ Symbol.for( 'a' ) ], 2 );
  test.identical( x[ Symbol.for( 'b' ) ], 3 );
  test.identical( x[ Symbol.for( 'c' ) ], 8 );
  test.identical( x.a, 4 );
  test.identical( x.b, 6 );
  test.identical( x.c, 8 );

}

//

function accessorCopyBasic( test )
{

  /* */

  test.case = 'basic';

  var events = [];
  var ins1 =
  {
    aCopy : function( it )
    {
      console.log( 'accessorKind', it.accessorKind );
      events.push( it.accessorKind );
      if( it.accessorKind === 'set' || it.accessorKind === 'put' )
      {
        it.value += 1;
        it.dstInstance[ Symbol.for( 'a' ) ] = it.value;
      }
      else
      {
        it.value = it.srcInstance[ Symbol.for( 'a' ) ];
      }
    },
    a : 10,
    b : 20,
  };

  _.accessor.declare
  ({
    object : ins1,
    names : { a : 'a' },
    prime : 0,
  });

  test.identical( events, [ 'put' ] );
  var exp = { 'a' : 11, 'b' : 20, 'aCopy' : ins1.aCopy }
  test.identical( ins1, exp );
  test.identical( events, [ 'put', 'get' ] );

  ins1.a = 30;

  test.identical( events, [ 'put', 'get', 'set' ] );
  var exp = { 'a' : 31, 'b' : 20, 'aCopy' : ins1.aCopy }
  test.identical( ins1, exp );
  test.identical( events, [ 'put', 'get', 'set', 'get' ] );

  /* */

}

// --
// declare
// --

let Self =
{

  name : 'Tools.l3.proto',
  silencing : 1,

  tests :
  {

    // checker

    instanceIs,
    instanceIsStandard,
    prototypeIs,
    constructorIs,
    prototypeIsStandard,

    //

    accessor,
    accessorMethodsDeducing,
    accessorOptionReadOnly,
    accessorOptionAddingMethods,
    declareConstant,
    declareConstantSymbol,
    accessorOptionPreserveValues,
    accessorDeducingMethods,
    accessorIsClean,
    accessorDeducingPrime,
    accessorUnfunct,
    accessorUnfunctGetSuite,

    accessorForbid,
    accessorReadOnly,
    forbids,
    forbidWithoutConstructor,

    getterWithSymbol,
    getterToValueDefine,
    getterToValueAccess,
    putterSymbol,

    // etc

    propertyConstant,
    callable,
    accessorSupplement,
    accessorCopyBasic,

  },

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
