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
      toolsPath = require.resolve( toolsPath );
    }
    catch( err )
    {
      toolsExternal = 1;
      require( 'wTools' );
    }
    if( !toolsExternal )
    require( toolsPath );
  }

  var _ = _global_.wTools;

  _.include( 'wTesting' );

  if( !_.isIncluded( 'wProto' ) )
  require( '../../abase/layer3/Prototype.s' );

}

var _global = _global_;
var _ = _global_.wTools;

// --
// test
// --

function instanceIs( t )
{
  var self = this;

  t.will = 'pure map';
  t.is( !_.instanceIs( Object.create( null ) ) );

  t.will = 'map';
  t.is( !_.instanceIs( {} ) );

  t.will = 'primitive';
  t.is( !_.instanceIs( 0 ) );
  t.is( !_.instanceIs( 1 ) );
  t.is( !_.instanceIs( '1' ) );
  t.is( !_.instanceIs( null ) );
  t.is( !_.instanceIs( undefined ) );

  t.will = 'routine';
  t.is( !_.instanceIs( Date ) );
  t.is( !_.instanceIs( Float32Array ) );
  t.is( !_.instanceIs( function(){} ) );
  t.is( !_.instanceIs( Self.constructor ) );

  t.will = 'object-like';
  t.is( _.instanceIs( [] ) );
  t.is( _.instanceIs( /x/ ) );
  t.is( _.instanceIs( new Date() ) );
  t.is( _.instanceIs( new Float32Array() ) );
  t.is( _.instanceIs( new (function(){})() ) );
  t.is( _.instanceIs( Self ) );

  t.will = 'object-like prototype';
  t.is( !_.instanceIs( Object.getPrototypeOf( [] ) ) );
  t.is( !_.instanceIs( Object.getPrototypeOf( /x/ ) ) );
  t.is( !_.instanceIs( Object.getPrototypeOf( new Date() ) ) );
  t.is( !_.instanceIs( Object.getPrototypeOf( new Float32Array() ) ) );
  t.is( !_.instanceIs( Object.getPrototypeOf( new (function(){})() ) ) );
  t.is( !_.instanceIs( Object.getPrototypeOf( Self ) ) );

}

//

function prototypeIs( t )
{
  var self = this;

  t.will = 'pure map';
  t.is( !_.prototypeIs( Object.create( null ) ) );

  t.will = 'map';
  t.is( !_.prototypeIs( {} ) );

  t.will = 'primitive';
  t.is( !_.prototypeIs( 0 ) );
  t.is( !_.prototypeIs( 1 ) );
  t.is( !_.prototypeIs( '1' ) );
  t.is( !_.prototypeIs( null ) );
  t.is( !_.prototypeIs( undefined ) );

  t.will = 'routine';
  t.is( !_.prototypeIs( Date ) );
  t.is( !_.prototypeIs( Float32Array ) );
  t.is( !_.prototypeIs( function(){} ) );
  t.is( !_.prototypeIs( Self.constructor ) );

  t.will = 'object-like';
  t.is( !_.prototypeIs( [] ) );
  t.is( !_.prototypeIs( /x/ ) );
  t.is( !_.prototypeIs( new Date() ) );
  t.is( !_.prototypeIs( new Float32Array() ) );
  t.is( !_.prototypeIs( new (function(){})() ) );
  t.is( !_.prototypeIs( Self ) );

  t.will = 'object-like prototype';
  t.is( _.prototypeIs( Object.getPrototypeOf( [] ) ) );
  t.is( _.prototypeIs( Object.getPrototypeOf( /x/ ) ) );
  t.is( _.prototypeIs( Object.getPrototypeOf( new Date() ) ) );
  t.is( _.prototypeIs( Object.getPrototypeOf( new Float32Array() ) ) );
  t.is( _.prototypeIs( Object.getPrototypeOf( new (function(){})() ) ) );
  t.is( _.prototypeIs( Object.getPrototypeOf( Self ) ) );

}

//

function constructorIs( t )
{
  var self = this;

  t.will = 'pure map';
  t.is( !_.constructorIs( Object.create( null ) ) );

  t.will = 'map';
  t.is( !_.constructorIs( {} ) );

  t.will = 'primitive';
  t.is( !_.constructorIs( 0 ) );
  t.is( !_.constructorIs( 1 ) );
  t.is( !_.constructorIs( '1' ) );
  t.is( !_.constructorIs( null ) );
  t.is( !_.constructorIs( undefined ) );

  t.will = 'routine';
  t.is( _.constructorIs( Date ) );
  t.is( _.constructorIs( Float32Array ) );
  t.is( _.constructorIs( function(){} ) );
  t.is( _.constructorIs( Self.constructor ) );

  t.will = 'object-like';
  t.is( !_.constructorIs( [] ) );
  t.is( !_.constructorIs( /x/ ) );
  t.is( !_.constructorIs( new Date() ) );
  t.is( !_.constructorIs( new Float32Array() ) );
  t.is( !_.constructorIs( new (function(){})() ) );
  t.is( !_.constructorIs( Self ) );

  t.will = 'object-like prototype';
  t.is( !_.constructorIs( Object.getPrototypeOf( [] ) ) );
  t.is( !_.constructorIs( Object.getPrototypeOf( /x/ ) ) );
  t.is( !_.constructorIs( Object.getPrototypeOf( new Date() ) ) );
  t.is( !_.constructorIs( Object.getPrototypeOf( new Float32Array() ) ) );
  t.is( !_.constructorIs( Object.getPrototypeOf( new (function(){})() ) ) );
  t.is( !_.constructorIs( Object.getPrototypeOf( Self ) ) );

}

//

function prototypeIsStandard( t )
{
  var self = this;

  t.will = 'pure map';
  t.is( !_.prototypeIsStandard( Object.create( null ) ) );

  t.will = 'map';
  t.is( !_.prototypeIsStandard( {} ) );

  t.will = 'primitive';
  t.is( !_.prototypeIsStandard( 0 ) );
  t.is( !_.prototypeIsStandard( 1 ) );
  t.is( !_.prototypeIsStandard( '1' ) );
  t.is( !_.prototypeIsStandard( null ) );
  t.is( !_.prototypeIsStandard( undefined ) );

  t.will = 'routine';
  t.is( !_.prototypeIsStandard( Date ) );
  t.is( !_.prototypeIsStandard( Float32Array ) );
  t.is( !_.prototypeIsStandard( function(){} ) );
  t.is( !_.prototypeIsStandard( Self.constructor ) );

  t.will = 'object-like';
  t.is( !_.prototypeIsStandard( [] ) );
  t.is( !_.prototypeIsStandard( /x/ ) );
  t.is( !_.prototypeIsStandard( new Date() ) );
  t.is( !_.prototypeIsStandard( new Float32Array() ) );
  t.is( !_.prototypeIsStandard( new (function(){})() ) );
  t.is( !_.prototypeIsStandard( Self ) );

  t.will = 'object-like prototype';
  t.is( !_.prototypeIsStandard( Object.getPrototypeOf( [] ) ) );
  t.is( !_.prototypeIsStandard( Object.getPrototypeOf( /x/ ) ) );
  t.is( !_.prototypeIsStandard( Object.getPrototypeOf( new Date() ) ) );
  t.is( !_.prototypeIsStandard( Object.getPrototypeOf( new Float32Array() ) ) );
  t.is( !_.prototypeIsStandard( Object.getPrototypeOf( new (function(){})() ) ) );
  t.is( _.prototypeIsStandard( Object.getPrototypeOf( Self ) ) );

}

//

// function _accessorOptions( test )
// {
//
//   test.case = 'one args call';
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
//   test.case = 'two args call';
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
//   test.case = 'three args call';
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
//     test.case = 'empty call';
//     test.shouldThrowError( function()
//       {
//         _._accessorOptions( );
//       });
//   }
// }

//

function accessor( test )
{

  test.case = 'setter'; /**/
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

  test.case = 'getter'; /**/
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

  test.case = 'getter & setter'; /**/
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

  test.case = 'empty call'; /**/
  test.shouldThrowError( function()
  {
    _.accessor( );
  });

  test.case = 'invalid first argument type'; /**/
  test.shouldThrowError( function()
  {
    _.accessor( 1, { a : 'a' } );
  });

  test.case = 'invalid second argument type'; /**/
  test.shouldThrowError( function()
  {
    _.accessor( {}, [] );
  });

  test.case = 'does not have Composes'; /**/
  test.shouldThrowError( function()
  {
    _.accessor( { constructor : function(){}, },{ a : 'a' } );
  });

  test.case = 'does not have constructor'; /**/
  test.shouldThrowError( function()
  {
    _.accessor( { Composes : {}, },{ a : 'a' } );
  });

}

//

function accessorForbid( test )
{

  test.case = 'accessor forbid getter&setter';
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

  test.case = 'forbid get';
  test.shouldThrowError( function()
  {
    var Alpha = { };
    _.accessorForbid( Alpha, { a : 'a' } );
    Alpha.a;
  });

  test.case = 'forbid set';
  test.shouldThrowError( function()
  {
    var Alpha = { };
    _.accessorForbid( Alpha, { a : 'a' } );
    Alpha.a = 5;
  });

  test.case = 'empty call';
  test.shouldThrowError( function()
  {
    _.accessorForbid( );
  });

  test.case = 'invalid first argument type';
  test.shouldThrowError( function()
  {
    _.accessorForbid( 1, { a : 'a' } );
  });

  test.case = 'invalid second argument type';
  test.shouldThrowError( function()
  {
    _.accessorForbid( {}, 1 );
  });

}

//

function accessorReadOnly( test )
{
  test.case = 'readOnly';

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

  test.case = 'saves field value';
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

  test.case = 'readonly';
  test.shouldThrowError( function()
  {
    var Alpha = { };
    _.accessorReadOnly( Alpha, { a : 'a' } );
    Alpha.a = 5;
  });

  test.case = 'setter defined';
  test.shouldThrowError( function()
  {
    var Alpha = { _aSet : function() { } };
    _.accessorReadOnly( Alpha, { a : 'a' } );
  });

  test.case = 'empty call';
  test.shouldThrowError( function()
  {
    _.accessorReadOnly( );
  });

  test.case = 'invalid first argument type';
  test.shouldThrowError( function()
  {
    _.accessorReadOnly( 1, { a : 'a' } );
  });

  test.case = 'invalid second argument type';
  test.shouldThrowError( function()
  {
    _.accessorReadOnly( {}, [] );
  });

}

//

function constant( test )
{

  test.case = 'second argument is map';
  var dstMap = {};
  _.constant( dstMap, { a : 5 } );
  var descriptor = Object.getOwnPropertyDescriptor( dstMap, 'a' );
  test.identical( descriptor.writable, false );
  test.identical( dstMap.a, 5 );

  test.case = 'rewrites existing field';
  var dstMap = { a : 5 };
  _.constant( dstMap, { a : 1 } );
  var descriptor = Object.getOwnPropertyDescriptor( dstMap, 'a' );
  test.identical( descriptor.writable, false );
  test.identical( dstMap.a, 1 );

  test.case = '3 arguments';
  var dstMap = {};
  _.constant( dstMap, 'a', 5 );
  var descriptor = Object.getOwnPropertyDescriptor( dstMap, 'a' );
  test.identical( descriptor.writable, false );
  test.identical( dstMap.a, 5 );

  test.case = '2 arguments, no value';
  var dstMap = {};
  _.constant( dstMap, 'a' );
  var descriptor = Object.getOwnPropertyDescriptor( dstMap, 'a' );
  test.identical( descriptor.writable, false );
  test.identical( dstMap.a, undefined );
  test.is( 'a' in dstMap );

  test.case = 'second argument is array';
  var dstMap = {};
  _.constant( dstMap, [ 'a' ], 5 );
  var descriptor = Object.getOwnPropertyDescriptor( dstMap, 'a' );
  test.identical( descriptor.writable, false );
  test.identical( dstMap.a, 5 );

  if( !Config.debug )
  return;

  test.case = 'empty call';
  test.shouldThrowError( function()
  {
    _.constant( );
  });

  test.case = 'invalid first argument type';
  test.shouldThrowError( function()
  {
    _.constant( 1, { a : 'a' } );
  });

  test.case = 'invalid second argument type';
  test.shouldThrowError( function()
  {
    _.constant( {}, 13 );
  });

}

//

function classMake( test )
{
  var context = this;

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

  test.case = 'first classMake';

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

  test.identical( C1, classMade );
  test.is( C1.instances === Statics1.instances );

  // test1({ Class : C1 });
  // testFields( Statics1.f3 );

  /* xxx */

  test.case = 'classMake with parent';

  function C2()
  {
    C1.call( this );
  }
  var classMade = _.classMake
  ({
    cls : C2,
    parent : C1,
  });

  test.identical( C2, classMade );

  // test1({ Class : C1, Statics : Statics1 });
  //
  // test.is( C1.instances === Statics1.instances );
  // test.is( C2.instances === C1.instances );

  test1({ Class : C2, Class0 : C1, Statics : Statics1, ownStatics : 0 });

  /* */

  // test.case = 'classMake with supplement';
  //
  // function Csupplement()
  // {
  //   C1.call( this );
  // }
  // var Statics2 =
  // {
  //   instances : [],
  // }
  // var classMade = _.classMake
  // ({
  //   cls : Csupplement,
  //   parent : C1,
  //   supplement : { Statics : Statics2 },
  // });
  //
  // test.identical( Csupplement,classMade );
  //
  // test1({ Class : C1, Statics : Statics1 });
  // test1({ Class : Csupplement, Class0 : C1, Statics : Statics1, ownStatics : 0 });
  //
  // /* */
  //
  // test.case = 'classMake with extend';
  //
  // function C3()
  // {
  //   C1.call( this );
  // }
  // var Associates =
  // {
  // }
  // var Statics2 =
  // {
  //   instances : [],
  //   f1 : [],
  //   f4 : [],
  // }
  // var Extend2 =
  // {
  //   Statics : Statics2,
  //   Associates : Associates,
  //   f2 : [],
  //   f3 : [],
  // }
  // var classMade = _.classMake
  // ({
  //   cls : C3,
  //   parent : C1,
  //   extend : Extend2,
  //   allowingExtendStatics : 1,
  // });
  //
  // test.identical( C3, classMade );
  //
  // // test1({ Class : C1, Statics : Statics1 });
  // // test1
  // // ({
  // //   Class : C3,
  // //   Class0 : C1,
  // //   Statics : Statics2,
  // //   Extend : Extend2,
  // //   keys : [ 'instances', 'f1', 'f4', 'f2', 'f3' ],
  // //   vals : [ C3.instances, C3.f1, C3.f4, C1.f2, C1.f3 ],
  // // });
  //
  // // testFields( Extend2.f3 );
  // testFields2();

  // if( !Config.debug )
  // return;
  //
  // test.case = 'attempt to extend statics without order';
  //
  // test.shouldThrowError( function()
  // {
  //
  //   function C3()
  //   {
  //     C1.call( this );
  //   }
  //   var Associates =
  //   {
  //   }
  //   var Statics2 =
  //   {
  //     instances : [],
  //     f1 : [],
  //     f4 : [],
  //   }
  //   var Extend2 =
  //   {
  //     Statics : Statics2,
  //     Associates : Associates,
  //     f2 : [],
  //     f3 : [],
  //   }
  //   var classMade = _.classMake
  //   ({
  //     cls : C3,
  //     parent : C1,
  //     extend : Extend2,
  //   });
  //
  // });

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

    test.case = 'presence of valid prototype and constructor fields on class and prototype';

    test.identical( o.Class, o.Class.prototype.constructor );
    test.identical( Object.getPrototypeOf( o.Class ), o.Class0 );
    test.identical( Object.getPrototypeOf( o.Class.prototype ), C0proto );

    test.case = 'presence of valid static field on class and prototype';

    test.identical( o.Class.instances, o.Class.prototype.instances );

    test.case = 'getting property descriptor of static field from constructor';

    var cd = Object.getOwnPropertyDescriptor( o.Class, 'instances' );
    if( !o.ownStatics )
    {
      test.identical( cd, undefined );
    }
    else
    {
      test.identical( cd.configurable, true );
      test.identical( cd.enumerable, true );
      test.is( !!cd.get );
      test.is( !!cd.set );
    }

    var pd = Object.getOwnPropertyDescriptor( o.Class.prototype, 'instances' );

    if( !o.ownStatics )
    {
      test.identical( pd, undefined );
    }
    else
    {
      test.identical( pd.configurable, true );
      test.identical( pd.enumerable, false );
      test.is( !!pd.get );
      test.is( !!pd.set );
    }

    test.case = 'making the first instance';

    var c1a = new o.Class();

    // xxx
    test.case = 'presence of valid static field on all';

    if( o.Class !== C1 && !o.ownStatics )
    test.is( o.Class.instances === C1.instances );
    test.is( o.Class.instances === o.Class.prototype.instances );
    test.is( o.Class.instances === c1a.instances );
    test.is( o.Class.instances === o.Statics.instances );
    test.identical( o.Class.instances.length, o.Statics.instances.length );
    test.identical( o.Class.instances[ o.Statics.instances.length-1 ], c1a );

    test.case = 'presence of valid prototype and constructor fields on instance';

    test.identical( Object.getPrototypeOf( c1a ), o.Class.prototype );
    test.identical( c1a.constructor, o.Class );

    test.case = 'presence of valid Statics descriptor';

    test.is( o.Statics !== o.Class.prototype.Statics );
    test.is( o.Statics !== c1a.Statics );

    test.identical( _.mapKeys( c1a.Statics ), o.keys );
    test.identical( _.mapVals( c1a.Statics ), o.vals );
    test.identical( o.Class.Statics, undefined );
    // xxx

    if( !C0proto )
    {
      var r = _.entityIdentical( o.Class.prototype.Statics, o.Statics );
      test.identical( o.Class.prototype.Statics, o.Statics );
      test.identical( c1a.Statics, o.Statics );
    }

    test.case = 'presence of conflicting fields';

    test.is( o.Class.prototype.f1 === c1a.f1 );
    test.is( o.Class.prototype.f2 === c1a.f2 );
    test.is( o.Class.prototype.f3 === c1a.f3 );
    test.is( o.Class.prototype.f4 === c1a.f4 );

    test.case = 'making the second instance';

    var c1b = new o.Class();
    test.identical( o.Class.instances, o.Class.prototype.instances );
    test.identical( o.Class.instances, c1a.instances );
    test.identical( o.Class.instances.length, o.Statics.instances.length );
    test.identical( o.Class.instances[ o.Statics.instances.length-2 ], c1a );
    test.identical( o.Class.instances[ o.Statics.instances.length-1 ], c1b );

    test.case = 'setting static field with constructor';

    o.Class.instances = o.Class.instances.slice();
    // test.is( o.Class === C1 || o.Class.instances !== C1.instances );
    test.is( o.Class.instances === C1.instances );
    test.is( o.Class.instances === o.Class.prototype.instances );
    test.is( o.Class.instances === c1a.instances );
    test.is( o.Class.instances === c1b.instances );
    test.is( o.Class.instances !== o.Statics.instances );
    o.Class.instances = Statics1.instances;

    test.case = 'setting static field with prototype';

    o.Class.prototype.instances = o.Class.prototype.instances.slice();
    // if( o.Class !== C1 && !o.ownStatics )
    // test.is( o.Class === C1 || o.Class.instances !== C1.instances );
    test.is( o.Class.instances === C1.instances );
    test.is( o.Class.instances === o.Class.prototype.instances );
    test.is( o.Class.instances === c1a.instances );
    test.is( o.Class.instances === c1b.instances );
    test.is( o.Class.instances !== o.Statics.instances );
    o.Class.instances = Statics1.instances;

    test.case = 'setting static field with instance';

    c1a.instances = o.Class.instances.slice();
    // if( o.Class !== C1 && !o.ownStatics )
    // test.is( o.Class === C1 || o.Class.instances !== C1.instances );
    test.is( o.Class.instances === C1.instances );
    test.is( o.Class.instances === o.Class.prototype.instances );
    test.is( o.Class.instances === c1a.instances );
    test.is( o.Class.instances === c1b.instances );
    test.is( o.Class.instances !== o.Statics.instances );
    o.Class.instances = Statics1.instances;

  }

  /* */

  function testFields( f3 )
  {

    test.case = 'presence of conflicting fields in the first class';

    test.is( Statics1.f1 === C1.f1 );
    test.is( Extend1.f1 === C1.prototype.f1 );

    test.is( Statics1.f2 === C1.f2 );
    test.is( Extend1.f2 === C1.prototype.f2 );

    test.is( f3 === C1.f3 );
    test.is( f3 === C1.prototype.f3 );

    test.is( Statics1.f4 === undefined );
    test.is( Statics1.f4 === C1.f4 );
    test.is( Extend1.f4 === C1.prototype.f4 );

    var d = Object.getOwnPropertyDescriptor( C1,'f1' );
    test.is( d.enumerable === true );
    test.is( d.configurable === true );
    test.is( d.writable === true );
    test.is( !!d.value );

    var d = Object.getOwnPropertyDescriptor( C1.prototype,'f1' );
    test.is( d.enumerable === true );
    test.is( d.configurable === true );
    test.is( d.writable === true );
    test.is( !!d.value );

    var d = Object.getOwnPropertyDescriptor( C1,'f2' );
    test.is( d.enumerable === true );
    test.is( d.configurable === true );
    test.is( d.writable === true );
    test.is( !!d.value );

    var d = Object.getOwnPropertyDescriptor( C1.prototype,'f2' );
    test.is( d.enumerable === true );
    test.is( d.configurable === true );
    test.is( d.writable === true );
    test.is( !!d.value );

    var d = Object.getOwnPropertyDescriptor( C1,'f3' );
    test.is( d.enumerable === true );
    test.is( d.configurable === true );
    test.is( !!d.get );
    test.is( !!d.set );

    var d = Object.getOwnPropertyDescriptor( C1.prototype,'f3' );
    test.is( d.enumerable === false );
    test.is( d.configurable === true );
    test.is( !!d.get );
    test.is( !!d.set );

    var d = Object.getOwnPropertyDescriptor( C1,'f4' );
    test.is( !d );

    var d = Object.getOwnPropertyDescriptor( C1.prototype,'f4' );
    test.is( d.enumerable === true );
    test.is( d.configurable === true );
    test.is( d.writable === true );
    test.is( !!d.value );

  }

  /* */

  function testFields2()
  {

    test.case = 'presence of conflicting fields in the second class';

    test.is( Statics2.f1 === C3.f1 );
    test.is( Statics2.f1 === C3.prototype.f1 );

    test.is( Statics1.f2 === C3.f2 );
    test.is( Extend2.f2 === C3.prototype.f2 );

    test.is( Extend2.f3 === C3.f3 );
    test.is( Extend2.f3 === C3.prototype.f3 );

    test.is( Statics2.f4 === C3.f4 );
    test.is( Statics2.f4 === C3.prototype.f4 );

    var d = Object.getOwnPropertyDescriptor( C3,'f1' );
    test.is( d.enumerable === true );
    test.is( d.configurable === true );
    test.is( !!d.get );
    test.is( !!d.set );

    var d = Object.getOwnPropertyDescriptor( C3.prototype,'f1' );
    test.is( d.enumerable === false );
    test.is( d.configurable === true );
    test.is( !!d.get );
    test.is( !!d.set );

    var d = Object.getOwnPropertyDescriptor( C3,'f2' );
    test.is( !d );

    var d = Object.getOwnPropertyDescriptor( C3.prototype,'f2' );
    test.is( d.enumerable === true );
    test.is( d.configurable === true );
    test.is( d.writable === true );
    test.is( !!d.value );

    var d = Object.getOwnPropertyDescriptor( C3,'f3' );
    test.is( !d );

    var d = Object.getOwnPropertyDescriptor( C3.prototype,'f3' );
    test.is( !d );

    var d = Object.getOwnPropertyDescriptor( C3,'f4' );
    test.is( d.enumerable === true );
    test.is( d.configurable === true );
    test.is( !!d.get );
    test.is( !!d.set );

    var d = Object.getOwnPropertyDescriptor( C3.prototype,'f4' );
    test.is( d.enumerable === false );
    test.is( d.configurable === true );
    test.is( !!d.get );
    test.is( !!d.set );

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

classMake.timeOut = 300000;

//

function staticsDeclaration( test )
{

  /* - */

  test.open( 'basic' );
  test.case = 'setup';

  function BasicConstructor()
  {
    _.instanceInit( this );
  }

  var Associates =
  {
    f2 : [ 'Associates' ],
  }

  var Statics =
  {
    f1 : [ 'Statics' ],
    f2 : [ 'Statics' ],
    f3 : [ 'Statics' ],
  }

  var Extend =
  {
    f3 : [ 'Extend' ],
    Associates : Associates,
    Statics : Statics,
  }

  Extend.constructor = BasicConstructor;

  _.classMake
  ({
    cls : BasicConstructor,
    extend : Extend,
  });

  var instance = new BasicConstructor();

  test.case = 'f1';

  test.is( BasicConstructor.f1 === BasicConstructor.prototype.f1 );
  test.is( BasicConstructor.prototype.f1 === Statics.f1 );
  test.is( BasicConstructor.f1 === Statics.f1 );
  test.is( BasicConstructor.prototype.Statics.f1 === Statics.f1 );
  test.is( instance.f1 === Statics.f1 );

  test.case = 'set prototype.f1';

  var newF1 = [ 'newF1' ];
  BasicConstructor.prototype.f1 = newF1;
  var instance2 = new BasicConstructor();

  test.is( BasicConstructor.f1 === BasicConstructor.prototype.f1 );
  test.is( BasicConstructor.prototype.f1 === newF1 );
  test.is( BasicConstructor.f1 === newF1 );
  test.is( instance.f1 === newF1 );
  test.is( instance2.f1 === newF1 );

  test.case = 'set class.f1';

  var newF1 = [ 'newF1' ];
  BasicConstructor.f1 = newF1;
  var instance2 = new BasicConstructor();

  test.is( BasicConstructor.f1 === BasicConstructor.prototype.f1 );
  test.is( BasicConstructor.prototype.f1 === newF1 );
  test.is( BasicConstructor.f1 === newF1 );
  test.is( instance.f1 === newF1 );
  test.is( instance2.f1 === newF1 );

  test.case = 'f2';

  test.is( BasicConstructor.prototype.f2 === undefined );
  test.is( BasicConstructor.f2 === Statics.f2 );
  test.is( BasicConstructor.prototype.Statics.f2 === Statics.f2 );
  test.is( BasicConstructor.prototype.Associates.f2 === Associates.f2 );
  test.is( instance.f2 === Associates.f2 );

  test.case = 'set prototype.f2';

  var newF2 = [ 'newF2' ];
  BasicConstructor.prototype.f2 = newF2;
  var instance2 = new BasicConstructor();

  test.is( BasicConstructor.f2 !== BasicConstructor.prototype.f2 );
  test.is( BasicConstructor.prototype.f2 === newF2 );
  test.is( BasicConstructor.f2 === Statics.f2 );
  test.is( instance.f2 === Associates.f2 );
  test.is( instance2.f2 === Associates.f2 );

  test.case = 'set constructor.f2';

  var newF2 = [ 'newF2' ];
  BasicConstructor.f2 = newF2;
  var instance2 = new BasicConstructor();

  test.is( BasicConstructor.f2 !== BasicConstructor.prototype.f2 );
  test.is( BasicConstructor.f2 === newF2 );
  test.is( instance.f2 === Associates.f2 );
  test.is( instance2.f2 === Associates.f2 );

  test.close( 'basic' );

  /* - */

}

// staticsDeclaration.timeOut = 300000;

// --
// define class
// --

var Self =
{

  name : 'Tools/base/layer3/Prototype',
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
    staticsDeclaration : staticsDeclaration,

  },

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
_.Tester.test( Self.name );

})();
