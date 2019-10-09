( function _Complex_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wTesting' );

  if( !_.isIncluded( 'wProto' ) )
  {
    require( '../../abase/l3_proto/Include.s' );
  }

}

var _global = _global_;
var _ = _global_.wTools;

// --
// test
// --

function construct( test )
{

  function _getter( arg )
  {
    debugger;
    return 'x' + arg;
  }

  var Complex1 = _.complex
  ({
    field1 : null,
  });

  var instance = _.complex.make( Complex1 );
  instance.field1 = _getter;

  var prototypes = _.prototypeEach( _.complex.Complex );
  test.is( prototypes.length === 1 );
  test.is( prototypes[ 0 ] === _.complex.Complex );
  var prototypes = _.prototypeEach( Complex1 );
  test.is( prototypes.length === 2 );
  test.is( prototypes[ 0 ] === Complex1 );
  test.is( prototypes[ 1 ] === _.complex.Complex );
  var prototypes = _.prototypeEach( instance );
  test.is( prototypes.length === 3 );
  test.is( prototypes[ 0 ] === instance );
  test.is( prototypes[ 1 ] === Complex1 );
  test.is( prototypes[ 2 ] === _.complex.Complex );

  test.is( _.prototypeHasPrototype( instance, Complex1 ) );
  test.is( _.objectIs( instance ) );
  test.is( !_.mapIs( instance ) );
  test.is( _.mapLike( instance ) );
  test.is( !_.instanceIs( instance ) );
  test.identical( _.mapKeys( instance ), [ 'field1' ] );
  test.identical( _.mapAllKeys( instance ), [ 'field1' ] );

}

//

function constructWithNew( test )
{

  function _getter( arg )
  {
    debugger;
    return 'x' + arg;
  }

  var Complex1 = new _.complex
  ({
    field1 : null,
  });

  var instance = _.complex.make( Complex1 );
  instance.field1 = _getter;

  var prototypes = _.prototypeEach( _.complex.Complex );
  test.is( prototypes.length === 1 );
  test.is( prototypes[ 0 ] === _.complex.Complex );
  var prototypes = _.prototypeEach( Complex1 );
  test.is( prototypes.length === 2 );
  test.is( prototypes[ 0 ] === Complex1 );
  test.is( prototypes[ 1 ] === _.complex.Complex );
  var prototypes = _.prototypeEach( instance );
  test.is( prototypes.length === 3 );
  test.is( prototypes[ 0 ] === instance );
  test.is( prototypes[ 1 ] === Complex1 );
  test.is( prototypes[ 2 ] === _.complex.Complex );

  test.is( _.prototypeHasPrototype( instance, Complex1 ) );
  test.is( _.objectIs( instance ) );
  test.is( !_.mapIs( instance ) );
  test.is( _.mapLike( instance ) );
  test.is( !_.instanceIs( instance ) );
  test.identical( _.mapKeys( instance ), [ 'field1' ] );
  test.identical( _.mapAllKeys( instance ), [ 'field1' ] );

}

//

function constructSingleReuse( test )
{

  var Complex1 = _.complex
  ({
    field1 : null,
  });

  var Complex2 = _.complex( Complex1 );

  var instance = _.complex.make( Complex2 );
  instance.field1 = '1';

  test.shouldThrowErrorSync( () =>
  {
    instance.field2 = 2;
  });

  var prototypes = _.prototypeEach( _.complex.Complex );
  test.is( prototypes.length === 1 );
  test.is( prototypes[ 0 ] === _.complex.Complex );
  var prototypes = _.prototypeEach( Complex2 );
  test.is( prototypes.length === 2 );
  test.is( prototypes[ 0 ] === Complex2 );
  test.is( prototypes[ 1 ] === _.complex.Complex );
  var prototypes = _.prototypeEach( instance );
  test.is( prototypes.length === 3 );
  test.is( prototypes[ 0 ] === instance );
  test.is( prototypes[ 1 ] === Complex2 );
  test.is( prototypes[ 2 ] === _.complex.Complex );

  test.is( !_.prototypeHasPrototype( instance, Complex1 ) );
  test.is( _.prototypeHasPrototype( instance, Complex2 ) );
  test.is( _.objectIs( instance ) );
  test.is( !_.mapIs( instance ) );
  test.is( _.mapLike( instance ) );
  test.is( !_.instanceIs( instance ) );
  test.identical( _.mapKeys( instance ), [ 'field1' ] );
  test.identical( _.mapAllKeys( instance ), [ 'field1' ] );

}

//

function constructMultipleReuse( test )
{

  var Complex1 = _.complex
  ({
    field1 : null,
  });

  var Complex2 = _.complex
  ({
    field2 : null,
  });

  var Complex3 = _.complex( Complex1, Complex2, { field3 : '3' } );

  var instance = _.complex.make( Complex3 );

  var prototypes = _.prototypeEach( _.complex.Complex );
  test.is( prototypes.length === 1 );
  test.is( prototypes[ 0 ] === _.complex.Complex );
  var prototypes = _.prototypeEach( Complex3 );
  test.is( prototypes.length === 2 );
  test.is( prototypes[ 0 ] === Complex3 );
  test.is( prototypes[ 1 ] === _.complex.Complex );
  var prototypes = _.prototypeEach( instance );
  test.is( prototypes.length === 3 );
  test.is( prototypes[ 0 ] === instance );
  test.is( prototypes[ 1 ] === Complex3 );
  test.is( prototypes[ 2 ] === _.complex.Complex );

  test.is( !_.prototypeHasPrototype( instance, Complex1 ) );
  test.is( !_.prototypeHasPrototype( instance, Complex2 ) );
  test.is( _.prototypeHasPrototype( instance, Complex3 ) );
  test.is( _.objectIs( instance ) );
  test.is( !_.mapIs( instance ) );
  test.is( _.mapLike( instance ) );
  test.is( !_.instanceIs( instance ) );
  test.identical( _.mapKeys( instance ), [ 'field1', 'field2', 'field3' ] );
  test.identical( _.mapAllKeys( instance ), [ 'field1', 'field2', 'field3' ] );

}

//

function callable( test )
{

  function _getter( arg )
  {
    debugger;
    return 'x' + arg;
  }

  var Complex1 = _.complex
  ({
    functor : null,
    '__call__' : _.define.ownerCallback( 'functor' ),
  });

  var instance = _.complex.make( Complex1 );
  instance.functor = _getter;

  debugger;
  var prototypes = _.prototypeEach( _.complex.Complex );
  test.is( prototypes.length === 1 );
  test.is( prototypes[ 0 ] === _.complex.Complex );
  var prototypes = _.prototypeEach( Complex1 );
  test.is( prototypes.length === 2 );
  test.is( prototypes[ 0 ] === Complex1 );
  test.is( prototypes[ 1 ] === _.complex.Complex );
  var prototypes = _.prototypeEach( instance );
  test.is( prototypes.length === 3 );
  test.is( prototypes[ 0 ] === instance );
  test.is( prototypes[ 1 ] === Complex1 );
  test.is( prototypes[ 2 ] === _.complex.Complex );
  debugger;

  test.is( _.prototypeHasPrototype( instance, Complex1 ) );
  test.is( _.routineIs( instance ) );
  // test.identical( _.mapKeys( instance ), [ 'functor' ] );
  // test.identical( _.mapAllKeys( instance ), [ 'functor' ] );

  debugger;
  var got = instance( '+y' );
  test.identical( got, 'x+y' );
  debugger;

}

//

function is( test )
{

  var Complex1 = _.complex
  ({
    field1 : null,
  });

  var Complex2 = _.complex( Complex1 );

  var instance = _.complex.make( Complex2 );

  test.identical( _.complex.is( _.complex ), false );
  test.identical( _.complex.is( _.complex.Complex ), true );
  test.identical( _.complex.is( Complex1 ), true );
  test.identical( _.complex.is( Complex2 ), true );
  test.identical( _.complex.is( instance ), true );

}

// --
// declare
// --

var Self =
{

  name : 'Tools.base.l3.Complex',
  silencing : 1,

  tests :
  {

    construct,
    constructWithNew,
    constructSingleReuse,
    constructMultipleReuse,
    is,
    // callable,

  },

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
