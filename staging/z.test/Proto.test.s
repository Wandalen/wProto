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

var Proto =
{

  name : 'wProto test',

  tests:
  {
    _accessorOptions : _accessorOptions,

  }

}

_.mapExtend( Self,Proto );

if( typeof module !== 'undefined' && !module.parent )
_.testing.test( Self );

} )( );
