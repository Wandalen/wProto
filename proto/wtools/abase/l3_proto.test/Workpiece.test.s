( function _Workpiece_test_s_( ) {

'use strict';

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

function prototypeIsStandard( t )
{
  var self = this;

  t.will = 'pure map';
  t.true( !_.workpiece.prototypeIsStandard( Object.create( null ) ) );

  t.will = 'map';
  t.true( !_.workpiece.prototypeIsStandard( {} ) );

  t.will = 'primitive';
  t.true( !_.workpiece.prototypeIsStandard( 0 ) );
  t.true( !_.workpiece.prototypeIsStandard( 1 ) );
  t.true( !_.workpiece.prototypeIsStandard( '1' ) );
  t.true( !_.workpiece.prototypeIsStandard( null ) );
  t.true( !_.workpiece.prototypeIsStandard( undefined ) );

  t.will = 'routine';
  t.true( !_.workpiece.prototypeIsStandard( Date ) );
  t.true( !_.workpiece.prototypeIsStandard( F32x ) );
  t.true( !_.workpiece.prototypeIsStandard( function(){} ) );
  t.true( !_.workpiece.prototypeIsStandard( Self.constructor ) );

  t.will = 'object-like';
  t.true( !_.workpiece.prototypeIsStandard( [] ) );
  t.true( !_.workpiece.prototypeIsStandard( /x/ ) );
  t.true( !_.workpiece.prototypeIsStandard( new Date() ) );
  t.true( !_.workpiece.prototypeIsStandard( new F32x() ) );
  t.true( !_.workpiece.prototypeIsStandard( new (function(){})() ) );
  t.true( !_.workpiece.prototypeIsStandard( Self ) );

  t.will = 'object-like prototype';
  t.true( !_.workpiece.prototypeIsStandard( Object.getPrototypeOf( [] ) ) );
  t.true( !_.workpiece.prototypeIsStandard( Object.getPrototypeOf( /x/ ) ) );
  t.true( !_.workpiece.prototypeIsStandard( Object.getPrototypeOf( new Date() ) ) );
  t.true( !_.workpiece.prototypeIsStandard( Object.getPrototypeOf( new F32x() ) ) );
  t.true( !_.workpiece.prototypeIsStandard( Object.getPrototypeOf( new (function(){})() ) ) );
  t.true( _.workpiece.prototypeIsStandard( Object.getPrototypeOf( Self ) ) );

}

//

function prototypeIs( t )
{
  var self = this;

  t.will = 'pure map';
  t.true( !_.workpiece.prototypeIs( Object.create( null ) ) );

  t.will = 'map';
  t.true( !_.workpiece.prototypeIs( {} ) );

  t.will = 'primitive';
  t.true( !_.workpiece.prototypeIs( 0 ) );
  t.true( !_.workpiece.prototypeIs( 1 ) );
  t.true( !_.workpiece.prototypeIs( '1' ) );
  t.true( !_.workpiece.prototypeIs( null ) );
  t.true( !_.workpiece.prototypeIs( undefined ) );

  t.will = 'routine';
  t.true( !_.workpiece.prototypeIs( Date ) );
  t.true( !_.workpiece.prototypeIs( F32x ) );
  t.true( !_.workpiece.prototypeIs( function(){} ) );
  t.true( !_.workpiece.prototypeIs( Self.constructor ) );

  t.will = 'object-like';
  t.true( !_.workpiece.prototypeIs( [] ) );
  t.true( !_.workpiece.prototypeIs( /x/ ) );
  t.true( !_.workpiece.prototypeIs( new Date() ) );
  t.true( !_.workpiece.prototypeIs( new F32x() ) );
  t.true( !_.workpiece.prototypeIs( new (function(){})() ) );
  t.true( !_.workpiece.prototypeIs( Self ) );

  t.will = 'object-like prototype';
  t.true( _.workpiece.prototypeIs( Object.getPrototypeOf( [] ) ) );
  t.true( _.workpiece.prototypeIs( Object.getPrototypeOf( /x/ ) ) );
  t.true( _.workpiece.prototypeIs( Object.getPrototypeOf( new Date() ) ) );
  t.true( _.workpiece.prototypeIs( Object.getPrototypeOf( new F32x() ) ) );
  t.true( _.workpiece.prototypeIs( Object.getPrototypeOf( new (function(){})() ) ) );
  t.true( _.workpiece.prototypeIs( Object.getPrototypeOf( Self ) ) );

}

//

function instanceIsStandard( t )
{
  var self = this;

  t.will = 'pure map';
  t.true( !_.workpiece.instanceIsStandard( Object.create( null ) ) );

  t.will = 'map';
  t.true( !_.workpiece.instanceIsStandard( {} ) );

  t.will = 'primitive';
  t.true( !_.workpiece.instanceIsStandard( 0 ) );
  t.true( !_.workpiece.instanceIsStandard( 1 ) );
  t.true( !_.workpiece.instanceIsStandard( '1' ) );
  t.true( !_.workpiece.instanceIsStandard( null ) );
  t.true( !_.workpiece.instanceIsStandard( undefined ) );

  t.will = 'routine';
  t.true( !_.workpiece.instanceIsStandard( Date ) );
  t.true( !_.workpiece.instanceIsStandard( F32x ) );
  t.true( !_.workpiece.instanceIsStandard( function(){} ) );
  t.true( !_.workpiece.instanceIsStandard( Self.constructor ) );

  t.will = 'long';
  t.true( !_.workpiece.instanceIsStandard( [] ) );
  t.true( !_.workpiece.instanceIsStandard( new F32x() ) );

  t.will = 'object-like';
  t.true( !_.workpiece.instanceIsStandard( /x/ ) );
  t.true( !_.workpiece.instanceIsStandard( new Date() ) );
  t.true( !_.workpiece.instanceIsStandard( new (function(){})() ) );
  t.true( _.workpiece.instanceIsStandard( Self ) );

  t.will = 'object-like prototype';
  t.true( !_.workpiece.instanceIsStandard( Object.getPrototypeOf( [] ) ) );
  t.true( !_.workpiece.instanceIsStandard( Object.getPrototypeOf( /x/ ) ) );
  t.true( !_.workpiece.instanceIsStandard( Object.getPrototypeOf( new Date() ) ) );
  t.true( !_.workpiece.instanceIsStandard( Object.getPrototypeOf( new F32x() ) ) );
  t.true( !_.workpiece.instanceIsStandard( Object.getPrototypeOf( new (function(){})() ) ) );
  t.true( !_.workpiece.instanceIsStandard( Object.getPrototypeOf( Self ) ) );

}

// --
// declare
// --

let Self =
{

  name : 'Tools.l3.proto/Workpiece',
  silencing : 1,

  tests :
  {

    // checker

    prototypeIs,
    prototypeIsStandard,
    instanceIsStandard,

  },

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
