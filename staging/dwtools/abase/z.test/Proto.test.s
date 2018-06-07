( function _Proto_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  if( typeof _global_ === 'undefined' || !_global_.wBase )
  {
    let toolsPath = '../../../dwtools/Base.s';
    let toolsExternal = 0;
    try
    {
      toolsPath = require.resolve( toolsPath );/*hhh*/
    }
    catch( err )
    {
      toolsExternal = 1;
      require( 'wTools' );
    }
    if( !toolsExternal )
    require( toolsPath );
  }

  var _global = _global_; var _ = _global_.wTools;

  _.include( 'wTesting' );

  if( !_.isIncluded( 'wProto' ) )
  require( '../../abase/layer3/Proto.s' );

}

var _global = _global_; var _ = _global_.wTools;

// --
// test
// --

function instanceIs( t )
{
  var self = this;
  // debugger;

  t.will = 'pure map';
  t.shouldBe( !_.instanceIs( Object.create( null ) ) );

  t.will = 'map';
  t.shouldBe( !_.instanceIs( {} ) );

  t.will = 'primitive';
  t.shouldBe( !_.instanceIs( 0 ) );
  t.shouldBe( !_.instanceIs( 1 ) );
  t.shouldBe( !_.instanceIs( '1' ) );
  t.shouldBe( !_.instanceIs( null ) );
  t.shouldBe( !_.instanceIs( undefined ) );

  t.will = 'routine';
  t.shouldBe( !_.instanceIs( Date ) );
  t.shouldBe( !_.instanceIs( Float32Array ) );
  t.shouldBe( !_.instanceIs( function(){} ) );
  t.shouldBe( !_.instanceIs( Self.constructor ) );

  t.will = 'object-like';
  t.shouldBe( _.instanceIs( [] ) );
  t.shouldBe( _.instanceIs( /x/ ) );
  t.shouldBe( _.instanceIs( new Date() ) );
  t.shouldBe( _.instanceIs( new Float32Array() ) );
  t.shouldBe( _.instanceIs( new (function(){})() ) );
  t.shouldBe( _.instanceIs( Self ) );

  t.will = 'object-like prototype';
  t.shouldBe( !_.instanceIs( Object.getPrototypeOf( [] ) ) );
  t.shouldBe( !_.instanceIs( Object.getPrototypeOf( /x/ ) ) );
  t.shouldBe( !_.instanceIs( Object.getPrototypeOf( new Date() ) ) );
  t.shouldBe( !_.instanceIs( Object.getPrototypeOf( new Float32Array() ) ) );
  t.shouldBe( !_.instanceIs( Object.getPrototypeOf( new (function(){})() ) ) );
  t.shouldBe( !_.instanceIs( Object.getPrototypeOf( Self ) ) );

  // debugger;
}

//

function prototypeIs( t )
{
  var self = this;
  debugger;

  t.will = 'pure map';
  t.shouldBe( !_.prototypeIs( Object.create( null ) ) );

  t.will = 'map';
  t.shouldBe( !_.prototypeIs( {} ) );

  t.will = 'primitive';
  t.shouldBe( !_.prototypeIs( 0 ) );
  t.shouldBe( !_.prototypeIs( 1 ) );
  t.shouldBe( !_.prototypeIs( '1' ) );
  t.shouldBe( !_.prototypeIs( null ) );
  t.shouldBe( !_.prototypeIs( undefined ) );

  t.will = 'routine';
  t.shouldBe( !_.prototypeIs( Date ) );
  t.shouldBe( !_.prototypeIs( Float32Array ) );
  t.shouldBe( !_.prototypeIs( function(){} ) );
  t.shouldBe( !_.prototypeIs( Self.constructor ) );

  t.will = 'object-like';
  t.shouldBe( !_.prototypeIs( [] ) );
  t.shouldBe( !_.prototypeIs( /x/ ) );
  t.shouldBe( !_.prototypeIs( new Date() ) );
  t.shouldBe( !_.prototypeIs( new Float32Array() ) );
  t.shouldBe( !_.prototypeIs( new (function(){})() ) );
  t.shouldBe( !_.prototypeIs( Self ) );

  t.will = 'object-like prototype';
  t.shouldBe( _.prototypeIs( Object.getPrototypeOf( [] ) ) );
  t.shouldBe( _.prototypeIs( Object.getPrototypeOf( /x/ ) ) );
  t.shouldBe( _.prototypeIs( Object.getPrototypeOf( new Date() ) ) );
  t.shouldBe( _.prototypeIs( Object.getPrototypeOf( new Float32Array() ) ) );
  t.shouldBe( _.prototypeIs( Object.getPrototypeOf( new (function(){})() ) ) );
  t.shouldBe( _.prototypeIs( Object.getPrototypeOf( Self ) ) );

  debugger;
}

//

function constructorIs( t )
{
  var self = this;
  debugger;

  t.will = 'pure map';
  t.shouldBe( !_.constructorIs( Object.create( null ) ) );

  t.will = 'map';
  t.shouldBe( !_.constructorIs( {} ) );

  t.will = 'primitive';
  t.shouldBe( !_.constructorIs( 0 ) );
  t.shouldBe( !_.constructorIs( 1 ) );
  t.shouldBe( !_.constructorIs( '1' ) );
  t.shouldBe( !_.constructorIs( null ) );
  t.shouldBe( !_.constructorIs( undefined ) );

  t.will = 'routine';
  t.shouldBe( _.constructorIs( Date ) );
  t.shouldBe( _.constructorIs( Float32Array ) );
  t.shouldBe( _.constructorIs( function(){} ) );
  t.shouldBe( _.constructorIs( Self.constructor ) );

  t.will = 'object-like';
  t.shouldBe( !_.constructorIs( [] ) );
  t.shouldBe( !_.constructorIs( /x/ ) );
  t.shouldBe( !_.constructorIs( new Date() ) );
  t.shouldBe( !_.constructorIs( new Float32Array() ) );
  t.shouldBe( !_.constructorIs( new (function(){})() ) );
  t.shouldBe( !_.constructorIs( Self ) );

  t.will = 'object-like prototype';
  t.shouldBe( !_.constructorIs( Object.getPrototypeOf( [] ) ) );
  t.shouldBe( !_.constructorIs( Object.getPrototypeOf( /x/ ) ) );
  t.shouldBe( !_.constructorIs( Object.getPrototypeOf( new Date() ) ) );
  t.shouldBe( !_.constructorIs( Object.getPrototypeOf( new Float32Array() ) ) );
  t.shouldBe( !_.constructorIs( Object.getPrototypeOf( new (function(){})() ) ) );
  t.shouldBe( !_.constructorIs( Object.getPrototypeOf( Self ) ) );

  debugger;
}

//

function prototypeIsStandard( t )
{
  var self = this;
  debugger;

  t.will = 'pure map';
  t.shouldBe( !_.prototypeIsStandard( Object.create( null ) ) );

  t.will = 'map';
  t.shouldBe( !_.prototypeIsStandard( {} ) );

  t.will = 'primitive';
  t.shouldBe( !_.prototypeIsStandard( 0 ) );
  t.shouldBe( !_.prototypeIsStandard( 1 ) );
  t.shouldBe( !_.prototypeIsStandard( '1' ) );
  t.shouldBe( !_.prototypeIsStandard( null ) );
  t.shouldBe( !_.prototypeIsStandard( undefined ) );

  t.will = 'routine';
  t.shouldBe( !_.prototypeIsStandard( Date ) );
  t.shouldBe( !_.prototypeIsStandard( Float32Array ) );
  t.shouldBe( !_.prototypeIsStandard( function(){} ) );
  t.shouldBe( !_.prototypeIsStandard( Self.constructor ) );

  t.will = 'object-like';
  t.shouldBe( !_.prototypeIsStandard( [] ) );
  t.shouldBe( !_.prototypeIsStandard( /x/ ) );
  t.shouldBe( !_.prototypeIsStandard( new Date() ) );
  t.shouldBe( !_.prototypeIsStandard( new Float32Array() ) );
  t.shouldBe( !_.prototypeIsStandard( new (function(){})() ) );
  t.shouldBe( !_.prototypeIsStandard( Self ) );

  t.will = 'object-like prototype';
  t.shouldBe( !_.prototypeIsStandard( Object.getPrototypeOf( [] ) ) );
  t.shouldBe( !_.prototypeIsStandard( Object.getPrototypeOf( /x/ ) ) );
  t.shouldBe( !_.prototypeIsStandard( Object.getPrototypeOf( new Date() ) ) );
  t.shouldBe( !_.prototypeIsStandard( Object.getPrototypeOf( new Float32Array() ) ) );
  t.shouldBe( !_.prototypeIsStandard( Object.getPrototypeOf( new (function(){})() ) ) );
  t.shouldBe( _.prototypeIsStandard( Object.getPrototypeOf( Self ) ) );

  // console.log( 'Self',Self );
  // debugger;
}

//

// function _accessorOptions( test )
// {
//
//   test.description = 'one args call';
//   var Alpha = { };
//   var o =
//   {
//     object : Alpha,
//     names : { a : '_a' },
//     message : [ 'set/get call' ],
//   }
//   var got = _._accessorOptions( o );
//   var expected =
//   {
//     object : o.object,
//     names : _.nameFielded( o.names ),
//     message : o.message,
//     methods : o.object,
//   };
//   test.identical( got, expected );
//
//   test.description = 'two args call';
//   var Alpha = function Alpha( ){ };
//   var names = { a : '_a' };
//   var got = _.toStr( _._accessorOptions( Alpha, names ), { levels : 2 } );
//   var expected =
//   [
//     '{',
//     '  object : [ routine Alpha ], ',
//     '  methods : [ routine Alpha ], ',
//     '  names : { a : "_a" }',
//     '}',
//   ].join( '\n' );
//   test.identical( got, expected );
//
//   test.description = 'three args call';
//   var Alpha = function Alpha( ){ };
//   var names = { a : '_a' };
//   var message = [ 'set/get call' ];
//   var got = _.toStr( _._accessorOptions( Alpha, names, message ), { levels : 3 } );
//   var expected =
//   [
//     '{',
//     '  object : [ routine Alpha ], ',
//     '  methods : [ routine Alpha ], ',
//     '  names : { a : "_a" }, ',
//     '  message : ',
//     '  [',
//     '    [ "set/get call" ]',
//     '  ]',
//     '}',
//
//   ].join( '\n' );
//   test.identical( got, expected );
//
//   if( Config.debug )
//   {
//     test.description = 'empty call';
//     test.shouldThrowError( function()
//       {
//         _._accessorOptions( );
//       });
//   }
// }

//

function accessor( test )
{

  test.description = 'setter'; /**/
  var Alpha = function _Alpha(){}
  _.classMake
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
  _.accessor( Alpha.prototype, { a : 'a' } );
  var x = new Alpha();
  x.a = 5;
  var got = x.a;
  var expected = 10;
  test.identical( got, expected );

  test.description = 'getter'; /**/
  var Alpha = function _Alpha(){}
  _.classMake
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
  _.accessor( Alpha.prototype, { a : 'a' } );
  var x = new Alpha();
  x.a = 5;
  var got = x.a;
  var expected = 10;
  test.identical( got, expected );

  test.description = 'getter & setter'; /**/
  var Alpha = function _Alpha(){}
  _.classMake
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
  _.accessor( Alpha.prototype, { a : 'a' } );
  var x = new Alpha();
  x.a = 5;
  var got = x.a;
  var expected = 5;
  test.identical( got, expected );

  if( !Config.debug )
  return;

  test.description = 'empty call'; /**/
  test.shouldThrowError( function()
  {
    _.accessor( );
  });

  test.description = 'invalid first argument type'; /**/
  test.shouldThrowError( function()
  {
    _.accessor( 1, { a : 'a' } );
  });

  test.description = 'invalid second argument type'; /**/
  test.shouldThrowError( function()
  {
    _.accessor( {}, [] );
  });

  test.description = 'does not have Composes'; /**/
  test.shouldThrowError( function()
  {
    _.accessor( { constructor : function(){}, },{ a : 'a' } );
  });

  test.description = 'does not have constructor'; /**/
  test.shouldThrowError( function()
  {
    _.accessor( { Composes : {}, },{ a : 'a' } );
  });

}

//

function accessorForbid( test )
{

  test.description = 'accessor forbid getter&setter';
  var Alpha = { };
  _.accessorForbid( Alpha, { a : 'a' } );
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

  test.description = 'forbid get';
  test.shouldThrowError( function()
  {
    var Alpha = { };
    _.accessorForbid( Alpha, { a : 'a' } );
    Alpha.a;
  });

  test.description = 'forbid set';
  test.shouldThrowError( function()
  {
    var Alpha = { };
    _.accessorForbid( Alpha, { a : 'a' } );
    Alpha.a = 5;
  });

  test.description = 'empty call';
  test.shouldThrowError( function()
  {
    _.accessorForbid( );
  });

  test.description = 'invalid first argument type';
  test.shouldThrowError( function()
  {
    _.accessorForbid( 1, { a : 'a' } );
  });

  test.description = 'invalid second argument type';
  test.shouldThrowError( function()
  {
    _.accessorForbid( {}, 1 );
  });

}

//

function accessorReadOnly( test )
{
  test.description = 'readOnly';

  var Alpha = function _Alpha(){}
  _.classMake
  ({
    cls : Alpha,
    parent : null,
    extend : { Composes : { a : null } }
  });
  _.accessorReadOnly( Alpha.prototype,{ a : 'a' });
  var x = new Alpha();
  test.shouldThrowError( () => x.a = 1 );
  var descriptor = Object.getOwnPropertyDescriptor( Alpha.prototype, 'a' );
  var got = descriptor.set ? true : false;
  var expected = false;
  test.identical( got, expected );

  test.description = 'saves field value';
  var Alpha = function _Alpha( a )
  {
    this[ Symbol.for( 'a' ) ] = a;
  }
  _.classMake
  ({
    cls : Alpha,
    parent : null,
    extend : { Composes : { a : 6 } }
  });
  _.accessorReadOnly( Alpha.prototype, { a : 'a' } );
  var x = new Alpha( 5 );
  test.shouldThrowError( () => x.a = 1 );
  var descriptor = Object.getOwnPropertyDescriptor( Alpha.prototype, 'a' );
  var got = !descriptor.set && x.a === 5;
  var expected = true;
  test.identical( got, expected );

  if( !Config.debug )
  return;

  test.description = 'readonly';
  test.shouldThrowError( function()
  {
    var Alpha = { };
    _.accessorReadOnly( Alpha, { a : 'a' } );
    Alpha.a = 5;
  });

  test.description = 'setter defined';
  test.shouldThrowError( function()
  {
    var Alpha = { _aSet : function() { } };
    _.accessorReadOnly( Alpha, { a : 'a' } );
  });

  test.description = 'empty call';
  test.shouldThrowError( function()
  {
    _.accessorReadOnly( );
  });

  test.description = 'invalid first argument type';
  test.shouldThrowError( function()
  {
    _.accessorReadOnly( 1, { a : 'a' } );
  });

  test.description = 'invalid second argument type';
  test.shouldThrowError( function()
  {
    _.accessorReadOnly( {}, [] );
  });

}

//

function constant( test )
{
  test.description = 'creates new constant';
  var Alpha = { };
  _.constant( Alpha, { a : 5 } );
  var descriptor = Object.getOwnPropertyDescriptor( Alpha, 'a' );
  var got = descriptor.writable;
  var expected = false;
  test.identical( got, expected );

  test.description = 'rewrites existing field';
  var Alpha = { a : 5 };
  _.constant( Alpha, { a : 1 } );
  var descriptor = Object.getOwnPropertyDescriptor( Alpha, 'a' );
  var got = !descriptor.writable  && Alpha.a === 1;
  var expected = true;
  test.identical( got, expected );

  if( !Config.debug )
  return;

  test.description = 'empty call';
  test.shouldThrowError( function()
  {
    _.constant( );
  });

  test.description = 'invalid first argument type';
  test.shouldThrowError( function()
  {
    _.constant( 1, { a : 'a' } );
  });

  test.description = 'invalid second argument type';
  test.shouldThrowError( function()
  {
    _.constant( {}, [] );
  });

}

//

function classMake( test )
{
  var context = this;

  function test1( o )
  {

    if( o.ownStatics === undefined )
    o.ownStatics = 1;

    if( !o.Statics )
    o.Statics = Statics1;

    if( !o.Extend )
    o.Extend = Extend1;

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

    test.description = 'presence of valid prototype and constructor fields on class and prototype';

    test.identical( o.Class, o.Class.prototype.constructor );
    test.identical( Object.getPrototypeOf( o.Class ), o.Class0 );
    test.identical( Object.getPrototypeOf( o.Class.prototype ), C0proto );


    test.description = 'presence of valid static field on class and prototype';

    test.identical( o.Class.instances, o.Class.prototype.instances );

    test.description = 'getting property descriptor of static field from constructor';

    var cd = Object.getOwnPropertyDescriptor( o.Class,'instances' );
    if( !o.ownStatics )
    {
      test.identical( cd, undefined );
    }
    else
    {
      test.identical( cd.configurable, true );
      test.identical( cd.enumerable, true );
      test.shouldBe( !!cd.get );
      test.shouldBe( !!cd.set );
    }

    var pd = Object.getOwnPropertyDescriptor( o.Class.prototype,'instances' );

    if( !o.ownStatics )
    {
      test.identical( pd, undefined );
    }
    else
    {
      test.identical( pd.configurable, true );
      test.identical( pd.enumerable, false );
      test.shouldBe( !!pd.get );
      test.shouldBe( !!pd.set );
    }

    test.description = 'making the first instance';

    var c1a = new o.Class();

    test.description = 'presence of valid static field on all';

    if( o.Class !== C1 && !o.ownStatics )
    test.shouldBe( o.Class.instances === C1.instances );
    test.shouldBe( o.Class.instances === o.Class.prototype.instances );
    test.shouldBe( o.Class.instances === c1a.instances );
    test.shouldBe( o.Class.instances === o.Statics.instances );
    test.identical( o.Class.instances.length, o.Statics.instances.length );
    test.identical( o.Class.instances[ o.Statics.instances.length-1 ], c1a );

    test.description = 'presence of valid prototype and constructor fields on instance';

    test.identical( Object.getPrototypeOf( c1a ), o.Class.prototype );
    test.identical( c1a.constructor, o.Class );

    test.description = 'presence of valid Statics descriptor';

    test.shouldBe( o.Statics !== o.Class.prototype.Statics );
    test.shouldBe( o.Statics !== c1a.Statics );

    test.identical( _.mapKeys( c1a.Statics ), o.keys );
    test.identical( _.mapVals( c1a.Statics ), o.vals );
    test.identical( o.Class.Statics, undefined );
    if( !C0proto )
    {
      test.identical( o.Class.prototype.Statics, o.Statics );
      test.identical( c1a.Statics, o.Statics );
    }

    test.description = 'presence of conflicting fields';

    test.shouldBe( o.Class.prototype.f1 === c1a.f1 );
    test.shouldBe( o.Class.prototype.f2 === c1a.f2 );
    test.shouldBe( o.Class.prototype.f3 === c1a.f3 );
    test.shouldBe( o.Class.prototype.f4 === c1a.f4 );

    test.description = 'making the second instance';

    var c1b = new o.Class();
    test.identical( o.Class.instances, o.Class.prototype.instances );
    test.identical( o.Class.instances, c1a.instances );
    test.identical( o.Class.instances.length, o.Statics.instances.length );
    test.identical( o.Class.instances[ o.Statics.instances.length-2 ], c1a );
    test.identical( o.Class.instances[ o.Statics.instances.length-1 ], c1b );

    test.description = 'setting static field with constructor';

    o.Class.instances = o.Class.instances.slice();
    if( o.Class !== C1 && !o.ownStatics )
    test.shouldBe( o.Class.instances === C1.instances );
    test.shouldBe( o.Class.instances === o.Class.prototype.instances );
    test.shouldBe( o.Class.instances === c1a.instances );
    test.shouldBe( o.Class.instances === c1b.instances );
    test.shouldBe( o.Class.instances !== o.Statics.instances );
    o.Class.instances = Statics1.instances;

    test.description = 'setting static field with prototype';

    o.Class.prototype.instances = o.Class.prototype.instances.slice();
    if( o.Class !== C1 && !o.ownStatics )
    test.shouldBe( o.Class.instances === C1.instances );
    test.shouldBe( o.Class.instances === o.Class.prototype.instances );
    test.shouldBe( o.Class.instances === c1a.instances );
    test.shouldBe( o.Class.instances === c1b.instances );
    test.shouldBe( o.Class.instances !== o.Statics.instances );
    o.Class.instances = Statics1.instances;

    test.description = 'setting static field with instance';

    c1a.instances = o.Class.instances.slice();
    if( o.Class !== C1 && !o.ownStatics )
    test.shouldBe( o.Class.instances === C1.instances );
    test.shouldBe( o.Class.instances === o.Class.prototype.instances );
    test.shouldBe( o.Class.instances === c1a.instances );
    test.shouldBe( o.Class.instances === c1b.instances );
    test.shouldBe( o.Class.instances !== o.Statics.instances );
    o.Class.instances = Statics1.instances;

  }

  /* */

  function testFields( f3 )
  {

    test.description = 'presence of conflicting fields in the first class';

    test.shouldBe( Statics1.f1 === C1.f1 );
    test.shouldBe( Extend1.f1 === C1.prototype.f1 );

    test.shouldBe( Statics1.f2 === C1.f2 );
    test.shouldBe( Extend1.f2 === C1.prototype.f2 );

    test.shouldBe( f3 === C1.f3 );
    test.shouldBe( f3 === C1.prototype.f3 );

    test.shouldBe( Statics1.f4 === undefined );
    test.shouldBe( Statics1.f4 === C1.f4 );
    test.shouldBe( Extend1.f4 === C1.prototype.f4 );

    var d = Object.getOwnPropertyDescriptor( C1,'f1' );
    test.shouldBe( d.enumerable === true );
    test.shouldBe( d.configurable === true );
    test.shouldBe( d.writable === true );
    test.shouldBe( !!d.value );

    var d = Object.getOwnPropertyDescriptor( C1.prototype,'f1' );
    test.shouldBe( d.enumerable === true );
    test.shouldBe( d.configurable === true );
    test.shouldBe( d.writable === true );
    test.shouldBe( !!d.value );

    var d = Object.getOwnPropertyDescriptor( C1,'f2' );
    test.shouldBe( d.enumerable === true );
    test.shouldBe( d.configurable === true );
    test.shouldBe( d.writable === true );
    test.shouldBe( !!d.value );

    var d = Object.getOwnPropertyDescriptor( C1.prototype,'f2' );
    test.shouldBe( d.enumerable === true );
    test.shouldBe( d.configurable === true );
    test.shouldBe( d.writable === true );
    test.shouldBe( !!d.value );

    var d = Object.getOwnPropertyDescriptor( C1,'f3' );
    test.shouldBe( d.enumerable === true );
    test.shouldBe( d.configurable === true );
    test.shouldBe( !!d.get );
    test.shouldBe( !!d.set );

    var d = Object.getOwnPropertyDescriptor( C1.prototype,'f3' );
    test.shouldBe( d.enumerable === false );
    test.shouldBe( d.configurable === true );
    test.shouldBe( !!d.get );
    test.shouldBe( !!d.set );

    var d = Object.getOwnPropertyDescriptor( C1,'f4' );
    test.shouldBe( !d );

    var d = Object.getOwnPropertyDescriptor( C1.prototype,'f4' );
    test.shouldBe( d.enumerable === true );
    test.shouldBe( d.configurable === true );
    test.shouldBe( d.writable === true );
    test.shouldBe( !!d.value );

  }

  /* */

  function testFields2()
  {

    test.description = 'presence of conflicting fields in the second class';

    test.shouldBe( Statics2.f1 === C3.f1 );
    test.shouldBe( Statics2.f1 === C3.prototype.f1 );

    test.shouldBe( Statics1.f2 === C3.f2 );
    test.shouldBe( Extend2.f2 === C3.prototype.f2 );

    test.shouldBe( Extend2.f3 === C3.f3 );
    test.shouldBe( Extend2.f3 === C3.prototype.f3 );

    test.shouldBe( Statics2.f4 === C3.f4 );
    test.shouldBe( Statics2.f4 === C3.prototype.f4 );

    var d = Object.getOwnPropertyDescriptor( C3,'f1' );
    test.shouldBe( d.enumerable === true );
    test.shouldBe( d.configurable === true );
    test.shouldBe( !!d.get );
    test.shouldBe( !!d.set );

    var d = Object.getOwnPropertyDescriptor( C3.prototype,'f1' );
    test.shouldBe( d.enumerable === false );
    test.shouldBe( d.configurable === true );
    test.shouldBe( !!d.get );
    test.shouldBe( !!d.set );

    var d = Object.getOwnPropertyDescriptor( C3,'f2' );
    test.shouldBe( !d );

    var d = Object.getOwnPropertyDescriptor( C3.prototype,'f2' );
    test.shouldBe( d.enumerable === true );
    test.shouldBe( d.configurable === true );
    test.shouldBe( d.writable === true );
    test.shouldBe( !!d.value );

    var d = Object.getOwnPropertyDescriptor( C3,'f3' );
    test.shouldBe( !d );

    var d = Object.getOwnPropertyDescriptor( C3.prototype,'f3' );
    test.shouldBe( !d );

    var d = Object.getOwnPropertyDescriptor( C3,'f4' );
    test.shouldBe( d.enumerable === true );
    test.shouldBe( d.configurable === true );
    test.shouldBe( !!d.get );
    test.shouldBe( !!d.set );

    var d = Object.getOwnPropertyDescriptor( C3.prototype,'f4' );
    test.shouldBe( d.enumerable === false );
    test.shouldBe( d.configurable === true );
    test.shouldBe( !!d.get );
    test.shouldBe( !!d.set );

    test.description = 'assigning static fields';

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
    test.identical( C1.f3,33 );
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

/*
  var Statics2 =
  {
    instances : [],
    f1 : [],
    f4 : [],
  }
  var Extend2 =
  {
    Statics : Statics2,
    Associates : Associates,
    f2 : [],
    f3 : [],
  }
*/

  /* */

  test.description = 'first classMake';

  function C1()
  {
    this.instances.push( this );
  }
  var Statics1 =
  {
    instances : [],
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
  var classMade = _.classMake
  ({
    cls : C1,
    parent : null,
    extend : Extend1,
  });

  test.identical( C1,classMade );
  test.shouldBe( C1.instances === Statics1.instances );
  test1({ Class : C1 });
  testFields( Statics1.f3 );

  /* */

  test.description = 'classMake with parent';

  function C2()
  {
    C1.call( this );
  }
  var classMade = _.classMake
  ({
    cls : C2,
    parent : C1,
  });

  test.identical( C2,classMade );

  test1({ Class : C1, Statics : Statics1 });
  test1({ Class : C2, Class0 : C1, Statics : Statics1, ownStatics : 0 });

  /* */

  test.description = 'classMake with supplement';

  function Csupplement()
  {
    C1.call( this );
  }
  var Statics2 =
  {
    instances : [],
  }
  var classMade = _.classMake
  ({
    cls : Csupplement,
    parent : C1,
    supplement : { Statics : Statics2 },
  });

  test.identical( Csupplement,classMade );

  test1({ Class : C1, Statics : Statics1 });
  test1({ Class : Csupplement, Class0 : C1, Statics : Statics1, ownStatics : 0 });

  /* */

  test.description = 'classMake with extend';

  function C3()
  {
    C1.call( this );
  }
  var Associates =
  {
  }
  var Statics2 =
  {
    instances : [],
    f1 : [],
    f4 : [],
  }
  var Extend2 =
  {
    Statics : Statics2,
    Associates : Associates,
    f2 : [],
    f3 : [],
  }
  var classMade = _.classMake
  ({
    cls : C3,
    parent : C1,
    extend : Extend2,
    allowingExtendStatics : 1,
  });

  test.identical( C3,classMade );

  test1({ Class : C1, Statics : Statics1 });
  test1
  ({
    Class : C3,
    Class0 : C1,
    Statics : Statics2,
    Extend : Extend2,
    keys : [ 'instances', 'f1', 'f4', 'f2', 'f3' ],
    vals : [ C3.instances, C3.f1, C3.f4, C1.f2, C1.f3 ],
  });

  testFields( Extend2.f3 );
  testFields2();

  if( !Config.debug )
  return;

  test.description = 'attempt to extend statics without order';

  test.shouldThrowError( function()
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
      instances : [],
      f1 : [],
      f4 : [],
    }
    var Extend2 =
    {
      Statics : Statics2,
      Associates : Associates,
      f2 : [],
      f3 : [],
    }
    var classMade = _.classMake
    ({
      cls : C3,
      parent : C1,
      extend : Extend2,
    });

  });

}

// --
// proto
// --

var Self =
{

  name : 'Proto.test',
  silencing : 1,
  // verbosity : 7,

  tests :
  {

    instanceIs : instanceIs,
    prototypeIs : prototypeIs,
    constructorIs : constructorIs,
    prototypeIsStandard : prototypeIsStandard,

    accessor : accessor,
    accessorForbid : accessorForbid,
    accessorReadOnly : accessorReadOnly,
    constant : constant,

    classMake : classMake,

  },

}

//

Self = wTestSuit( Self );
if( typeof module !== 'undefined' && !module.parent )
_.Tester.test( Self.name );

})();
