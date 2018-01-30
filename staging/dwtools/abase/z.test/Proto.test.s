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
      require.resolve( toolsPath )/*hhh*/;
    }
    catch( err )
    {
      toolsExternal = 1;
      require( 'wTools' );
    }
    if( !toolsExternal )
    require( toolsPath )/*hhh*/;
  }

  var _ = _global_.wTools;

  _.include( 'wTesting' );

  if( !_.isIncluded( 'wProto' ) )
  require( '../../abase/layer3/Proto.s' );

}

var _ = _global_.wTools;

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

function _accessorOptions( test )
{

  test.description = 'one args call';
  var Alpha = { };
  var o =
  {
    object : Alpha,
    names : { a : '_a' },
    message : [ 'set/get call' ],
  }
  var got = _._accessorOptions( o );
  var expected =
  {
    object : o.object,
    names : _.nameFielded( o.names ),
    message : o.message,
    methods : o.object,
  };
  test.identical( got, expected );

  test.description = 'two args call';
  var Alpha = function Alpha( ){ };
  var names = { a : '_a' };
  var got = _.toStr( _._accessorOptions( Alpha, names ), { levels : 2 } );
  var expected =
  [
    '{',
    '  object : [ routine Alpha ], ',
    '  methods : [ routine Alpha ], ',
    '  names : { a : "_a" }',
    '}',
  ].join( '\n' );
  test.identical( got, expected );

  test.description = 'three args call';
  var Alpha = function Alpha( ){ };
  var names = { a : '_a' };
  var message = [ 'set/get call' ];
  var got = _.toStr( _._accessorOptions( Alpha, names, message ), { levels : 3 } );
  var expected =
  [
    '{',
    '  object : [ routine Alpha ], ',
    '  methods : [ routine Alpha ], ',
    '  names : { a : "_a" }, ',
    '  message : ',
    '  [',
    '    [ "set/get call" ]',
    '  ]',
    '}',

  ].join( '\n' );
  test.identical( got, expected );

  if( Config.debug )
  {
    test.description = 'empty call';
    test.shouldThrowError( function()
      {
        _._accessorOptions( );
      });
  }
}

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

  if( Config.debug )
  {
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

  if( Config.debug )
  {
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

  if( Config.debug )
  {
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

    _accessorOptions : _accessorOptions,
    accessor : accessor,
    accessorForbid : accessorForbid,
    accessorReadOnly : accessorReadOnly,
    constant : constant

  },

}

//

Self = wTestSuit( Self );
if( typeof module !== 'undefined' && !module.parent )
_.Tester.test( Self.name );

} )( );
