( function _Proto_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../../abase/component/Proto.s' );

  try
  {
    require( '../../abase/wTools.s' );
  }
  catch( err )
  {
    require( 'wTools' );
  }

  var _ = wTools;

  _.include( 'wTesting' );

}

var _ = wTools;

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

// --
// proto
// --

var Self =
{

  name : 'Proto.test',
  sourceFilePath : _.diagnosticLocation().full,
  verbosity : 7,

  tests :
  {

    instanceIs : instanceIs,
    prototypeIs : prototypeIs,
    constructorIs : constructorIs,
    prototypeIsStandard : prototypeIsStandard,

  },

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
_.Tester.test( Self.name );

} )( );
