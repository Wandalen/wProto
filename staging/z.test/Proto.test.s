( function Proto_test_s( ) {

'use strict';

/*

to run this test
from the project directory run

npm install
node ./staging/z.test/Proto.test.s

*/

if( typeof module !== 'undefined' )
{

  if( require( 'fs' ).existsSync( __dirname + '/../../amid/diagnostic/Testing.debug.s' ) )
  require( '../../amid/diagnostic/Testing.debug.s' );
  else
  require( 'wTesting' );

  try
  {
    require( '../component/wProto.s' );
  }
  catch( err )
  {
    require( 'wProto' );
  }

}

var _ = wTools;
var Self = {};

//

var _accessorOptions = function( test )
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

var accessor = function ( test )
{
  test.description = 'setter';
  var Alpha =
  {
    _aSet : function( src )
    {
      this[ Symbol.for( 'a' ) ] = src * 2;
    }
  };
  _.accessor( Alpha, { a : 'a' } );
  Alpha.a = 5;
  var got = Alpha.a;
  var expected = 10;
  test.identical( got, expected );

  test.description = 'getter';
  var Alpha =
  {
    _aGet : function( )
    {
      return this[ Symbol.for( 'a' ) ] * 2;
    }
  };
  _.accessor( Alpha, { a : 'a' } );
  Alpha.a = 5;
  var got = Alpha.a;
  var expected = 10;
  test.identical( got, expected );

  test.description = 'getter & setter';
  var Alpha =
  {
    _aSet : function( src )
    {
      this[ Symbol.for( 'a' ) ] = src * 2;
    },
    _aGet : function( )
    {
      return this[ Symbol.for( 'a' ) ] / 2;
    }
  };
  _.accessor( Alpha, { a : 'a' } );
  Alpha.a = 5;
  var got = Alpha.a;
  var expected = 5;
  test.identical( got, expected );

  if( Config.debug )
  {
    test.description = 'empty call';
    test.shouldThrowError( function()
    {
      _.accessor( );
    });

    test.description = 'invalid first argument type';
    test.shouldThrowError( function()
    {
      _.accessor( 1, { a : 'a' } );
    });

    test.description = 'invalid second argument type';
    test.shouldThrowError( function()
    {
      _.accessor( {}, [] );
    });
  }

}

//

var accessorForbid = function( test )
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
      _.accessorForbid( {}, [] );
    });

  }
}

//

var accessorReadOnly = function ( test )
{
  test.description = 'readOnly';
  var Alpha = { };
  _.accessorReadOnly( Alpha, { a : 'a' } );
  var descriptor = Object.getOwnPropertyDescriptor( Alpha, 'a' );
  var got = descriptor.set ? true : false;
  var expected = false;
  test.identical( got, expected );

  test.description = 'saves field value';
  var Alpha = { a : 5};
  _.accessorReadOnly( Alpha, { a : 'a' } );
  var descriptor = Object.getOwnPropertyDescriptor( Alpha, 'a' );
  var got = !descriptor.set && Alpha.a === 5;
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
      var Alpha = { _aSet : function () { } };
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



var Proto =
{

  name : 'wProto test',

  tests:
  {
    _accessorOptions : _accessorOptions,
    accessor : accessor,
    accessorForbid : accessorForbid,
    accessorReadOnly : accessorReadOnly

  }

}

_.mapExtend( Self,Proto );

if( typeof module !== 'undefined' && !module.parent )
_.testing.test( Self );

} )( );
