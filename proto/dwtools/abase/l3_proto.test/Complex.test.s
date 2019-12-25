( function _Blueprint_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wTesting' );

  if( !_.module.isIncluded( 'wProto' ) )
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

  var Blueprint1 = _.blueprint
  ({
    field1 : null,
  });

  var instance = _.blueprint.construct( Blueprint1 );
  instance.field1 = _getter;

  var prototypes = _.prototypeEach( _.Blueprint );
  test.is( prototypes.length === 1 );
  test.is( prototypes[ 0 ] === _.Blueprint );
  var prototypes = _.prototypeEach( Blueprint1 );
  test.is( prototypes.length === 2 );
  test.is( prototypes[ 0 ] === Blueprint1 );
  test.is( prototypes[ 1 ] === _.Blueprint );
  var prototypes = _.prototypeEach( instance );
  test.is( prototypes.length === 3 );
  test.is( prototypes[ 0 ] === instance );
  test.is( prototypes[ 1 ] === Blueprint1 );
  test.is( prototypes[ 2 ] === _.Blueprint );

  test.is( _.prototypeHasPrototype( instance, Blueprint1 ) );
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

  var Blueprint1 = new _.blueprint
  ({
    field1 : null,
  });

  var instance = _.blueprint.construct( Blueprint1 );
  instance.field1 = _getter;

  var prototypes = _.prototypeEach( _.Blueprint );
  test.is( prototypes.length === 1 );
  test.is( prototypes[ 0 ] === _.Blueprint );
  var prototypes = _.prototypeEach( Blueprint1 );
  test.is( prototypes.length === 2 );
  test.is( prototypes[ 0 ] === Blueprint1 );
  test.is( prototypes[ 1 ] === _.Blueprint );
  var prototypes = _.prototypeEach( instance );
  test.is( prototypes.length === 3 );
  test.is( prototypes[ 0 ] === instance );
  test.is( prototypes[ 1 ] === Blueprint1 );
  test.is( prototypes[ 2 ] === _.Blueprint );

  test.is( _.prototypeHasPrototype( instance, Blueprint1 ) );
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

  var Blueprint1 = _.blueprint
  ({
    field1 : null,
  });

  var Blueprint2 = _.blueprint( Blueprint1 );

  var instance = _.blueprint.construct( Blueprint2 );
  instance.field1 = '1';

  test.shouldThrowErrorSync( () =>
  {
    instance.field2 = 2;
  });

  var prototypes = _.prototypeEach( _.Blueprint );
  test.is( prototypes.length === 1 );
  test.is( prototypes[ 0 ] === _.Blueprint );
  var prototypes = _.prototypeEach( Blueprint2 );
  test.is( prototypes.length === 2 );
  test.is( prototypes[ 0 ] === Blueprint2 );
  test.is( prototypes[ 1 ] === _.Blueprint );
  var prototypes = _.prototypeEach( instance );
  test.is( prototypes.length === 3 );
  test.is( prototypes[ 0 ] === instance );
  test.is( prototypes[ 1 ] === Blueprint2 );
  test.is( prototypes[ 2 ] === _.Blueprint );

  test.is( !_.prototypeHasPrototype( instance, Blueprint1 ) );
  test.is( _.prototypeHasPrototype( instance, Blueprint2 ) );
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

  var Blueprint1 = _.blueprint
  ({
    field1 : null,
  });

  var Blueprint2 = _.blueprint
  ({
    field2 : null,
  });

  var Blueprint3 = _.blueprint( Blueprint1, Blueprint2, { field3 : '3' } );

  var instance = _.blueprint.construct( Blueprint3 );

  var prototypes = _.prototypeEach( _.Blueprint );
  test.is( prototypes.length === 1 );
  test.is( prototypes[ 0 ] === _.Blueprint );
  var prototypes = _.prototypeEach( Blueprint3 );
  test.is( prototypes.length === 2 );
  test.is( prototypes[ 0 ] === Blueprint3 );
  test.is( prototypes[ 1 ] === _.Blueprint );
  var prototypes = _.prototypeEach( instance );
  test.is( prototypes.length === 3 );
  test.is( prototypes[ 0 ] === instance );
  test.is( prototypes[ 1 ] === Blueprint3 );
  test.is( prototypes[ 2 ] === _.Blueprint );

  test.is( !_.prototypeHasPrototype( instance, Blueprint1 ) );
  test.is( !_.prototypeHasPrototype( instance, Blueprint2 ) );
  test.is( _.prototypeHasPrototype( instance, Blueprint3 ) );
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

  var Blueprint1 = _.blueprint
  ({
    functor : null,
    '__call__' : _.define.ownerCallback( 'functor' ),
  });

  var instance = _.blueprint.construct( Blueprint1 );
  instance.functor = _getter;

  debugger;
  var prototypes = _.prototypeEach( _.Blueprint );
  test.is( prototypes.length === 1 );
  test.is( prototypes[ 0 ] === _.Blueprint );
  var prototypes = _.prototypeEach( Blueprint1 );
  test.is( prototypes.length === 2 );
  test.is( prototypes[ 0 ] === Blueprint1 );
  test.is( prototypes[ 1 ] === _.Blueprint );
  var prototypes = _.prototypeEach( instance );
  test.is( prototypes.length === 3 );
  test.is( prototypes[ 0 ] === instance );
  test.is( prototypes[ 1 ] === Blueprint1 );
  test.is( prototypes[ 2 ] === _.Blueprint );
  debugger;

  test.is( _.prototypeHasPrototype( instance, Blueprint1 ) );
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

  var Blueprint1 = _.blueprint
  ({
    field1 : null,
  });

  var Blueprint2 = _.blueprint( Blueprint1 );

  var instance = _.blueprint.construct( Blueprint2 );

  test.identical( _.blueprint.is( _.blueprint ), false );
  test.identical( _.blueprint.is( _.Blueprint ), true );
  test.identical( _.blueprint.is( Blueprint1 ), true );
  test.identical( _.blueprint.is( Blueprint2 ), true );
  test.identical( _.blueprint.is( instance ), true );

}

//

function blueprintExtendGetterAlias( test )
{

  test.is( _.routineIs( _.accessor.define.getter.alias ) );

  var f1 = function f1(){};
  var _container =
  {
    Begin : function Begin(){ return 'Begin' },
    End : function End(){ return 'End' },
    Str : 'Str',
  }
  var container = _.mapExtend( function(){}, _container );

  var alias = ( originalName ) => _.accessor.define.getter.alias({ originalName, container : container });
  var blueprint =
  {
    begin : alias( 'Begin' ),
    end : alias( 'End' ),
    str : alias( 'Str' ),
    container1 : container,
    f1 : f1,
  }

  var map = _.construction.extend( null, blueprint );

  test.is( _.mapIs( map ) );
  test.is( _.mapIsPure( map ) );
  test.identical( _.mapKeys( map ), [ 'begin', 'end', 'str', 'container1', 'f1' ] );
  test.identical( map.begin, container.Begin );
  test.identical( map.str, container.Str );
  test.is( _.routineIs( map.begin ) );
  test.identical( map.str, 'Str' );
  test.identical( container.Str, 'Str' );

  container.Str = 'Str2';
  test.identical( map.str, 'Str2' );
  test.identical( container.Str, 'Str2' );

  test.shouldThrowErrorSync( () =>
  {
    map.str = 'Str2';
  });

}

//

function blueprintExtendSetterAlias( test )
{

  test.is( _.routineIs( _.accessor.define.setter.alias ) );

  var f1 = function f1(){};
  var _container =
  {
    Begin : function Begin(){ return 'Begin' },
    End : function End(){ return 'End' },
    Str : 'Str',
  }
  var container = _.mapExtend( function(){}, _container );

  var alias = ( originalName ) => _.accessor.define.setter.alias({ originalName, container : container });
  var blueprint =
  {
    begin : alias( 'Begin' ),
    end : alias( 'End' ),
    str : alias( 'Str' ),
    container1 : container,
    f1 : f1,
  }

  var map = _.construction.extend( null, blueprint );

  test.is( _.mapIs( map ) );
  test.is( _.mapIsPure( map ) );
  test.identical( _.mapKeys( map ), [ 'begin', 'end', 'str', 'container1', 'f1' ] );
  test.identical( map.begin, undefined );
  test.identical( map.str, undefined );

  container.Str = 'Str2';
  test.identical( map.str, undefined );
  test.identical( container.Str, 'Str2' );

  map.str = 'Str3';
  test.identical( map.str, undefined );
  test.identical( container.Str, 'Str3' );

}

//

function blueprintExtendAccessorAlias( test )
{

  test.is( _.routineIs( _.accessor.define.suite.alias ) );

  var f1 = function f1(){};
  var _container =
  {
    Begin : function Begin(){ return 'Begin' },
    End : function End(){ return 'End' },
    Str : 'Str',
  }
  var container = _.mapExtend( function(){}, _container );

  var alias = ( originalName ) => _.accessor.define.suite.alias({ originalName, container : container });
  var blueprint =
  {
    begin : alias( 'Begin' ),
    end : alias( 'End' ),
    str : alias( 'Str' ),
    container1 : container,
    f1 : f1,
  }

  var map = _.construction.extend( null, blueprint );

  test.is( _.mapIs( map ) );
  test.is( _.mapIsPure( map ) );
  test.identical( _.mapKeys( map ), [ 'begin', 'end', 'str', 'container1', 'f1' ] );
  test.identical( map.begin, container.Begin );
  test.identical( map.str, container.Str );
  test.is( _.routineIs( map.begin ) );
  test.identical( map.str, 'Str' );
  test.identical( container.Str, 'Str' );

  container.Str = 'Str2';
  test.identical( map.str, 'Str2' );
  test.identical( container.Str, 'Str2' );

  map.str = 'Str3';
  test.identical( map.str, 'Str3' );
  test.identical( container.Str, 'Str3' );

}

// --
// declare
// --

var Self =
{

  name : 'Tools.base.l3.Blueprint',
  silencing : 1,

  tests :
  {

    construct,
    constructWithNew,
    constructSingleReuse,
    constructMultipleReuse,
    is,
    // callable,

    blueprintExtendGetterAlias,
    blueprintExtendSetterAlias,
    blueprintExtendAccessorAlias,

  },

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
