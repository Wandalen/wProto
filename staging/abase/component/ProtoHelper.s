( function _ProtoLike_s_() {

'use strict';

if( typeof module !== 'undefined' )
{

  if( typeof wBase === 'undefined' )
  try
  {
    require( '../wTools.s' );
  }
  catch( err )
  {
    require( 'wTools' );
  }

  require( './Proto.s' );

}

var _ = wTools;
var _hasOwnProperty = Object.hasOwnProperty;
var _assert = _.assert;
var _nameFielded = _.nameFielded;

if( wTools.construction )
return;

//

var Parent = null;
var Self = function wLike( o )
{
}

Self.nameShort = 'Like';

// --
// helper
// --

// function _classesOf()
// {
//   var result = [];
//   for( var a = 0 ; a < arguments.length ; a++ )
//   __classesOf( arguments[ a ],result );
//   return result;
// }
//
// //
//
// function __classesOf( src,result )
// {
//   _.assert( arguments.length === 1 );
//   if(  )
//   _.arrayAppendOnceMerging( result,src[ symbolForClass ] );
//   _.arrayAppendOnceMerging( result,src[ symbolForParents ] );
// }

//

function like()
{
  var helper = new Self();
  var proto = Object.create( null );
  var location;

  // if( Config.debug )
  // location = _.diagnosticLocation( 1 ).full;

  Object.defineProperty( proto, 'constructor',
  {
    enumerable : false,
    configurable : false,
    writable : false,
    value : function Construction( o )
    {
      _.assert( arguments.length === 0 || arguments.length === 1,'construction expects one or none argument' );

      if( !( this instanceof proto.constructor ) )
      if( o instanceof proto.constructor )
      return o;
      else
      return new( _.routineJoin( proto.constructor, proto.constructor, arguments ) );

      _.assertMapHasOnly( this,proto,'Prototype of the object ' + ( location ? 'defined at\n' + location + '\n' : '' ) + 'does not have requested fields.' );

      _.mapExtend( this,proto );
      Object.preventExtensions( this );
      _.mapExtend( this,o );

      return this;
    }
  });

  var allClasses = [ proto ];
  for( var a = 0 ; a < arguments.length ; a++ )
  {
    var arg = arguments[ a ];
    _.assert( arg[ symbolForAllClasses ] );
    if( arg[ symbolForAllClasses ] )
    _.arrayAppendOnceMerging( allClasses,arg[ symbolForAllClasses ] );
  }

  proto.constructor.prototype = proto;

  Object.defineProperty( proto, symbolForParents,
  {
    enumerable : false,
    configurable : false,
    writable : false,
    value : _.arraySlice( arguments ),
  });

  Object.defineProperty( proto, symbolForAllClasses,
  {
    enumerable : false,
    configurable : false,
    writable : false,
    value : allClasses,
  });

  Object.defineProperty( proto, symbolForClass,
  {
    enumerable : false,
    configurable : false,
    writable : false,
    value : proto,
  });

  /* */

  helper.proto = proto;
  helper.usingPrototype = false;

  Object.freeze( helper );

  if( arguments.length > 0 )
  _.mapExtend.apply( _,Array.prototype.concat.apply( [ proto ],arguments ) );

  return helper;
}

//

function name( src )
{
  _.assert( arguments.length === 1 );
  return this;
}

//

function also( src )
{
  _.assert( arguments.length === 1 );
  _.mapExtend( this.proto,src );
  return this;
}

//

function but( src )
{
  _.assert( arguments.length === 1 );
  _.mapDelete( this.proto,src );
  return this;
}

//

function _endGet()
{
  return this.proto;
}

//

function isLike( instance,parent )
{
  if( !instance[ symbolForAllClasses ] )
  return false;
  return instance[ symbolForAllClasses ].indexOf( parent ) !== -1;
}

// --
// var
// --

var symbolForParents = Symbol.for( 'parents' );
var symbolForClass = Symbol.for( 'class' );
var symbolForAllClasses = Symbol.for( 'allClasses' );

// --
// prototype
// --

var Proto =
{
  isLike : isLike,
}

_.assert( !wTools.construction );
wTools.construction = Object.create( null );
_.mapExtend( wTools.construction, Proto );

// --
// prototype
// --

var Proto =
{
  like : like,
}

_.mapExtend( wTools, Proto );

// --
// prototype
// --

var Proto =
{
  name : name,
  also : also,
  but : but,
  _endGet : _endGet,
}

_.protoMake
({
  constructor : Self,
  parent : Parent,
  extend : Proto,
});

_.accessorReadOnly
({
  object : Self.prototype,
  names : { end : 'end' },
});

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
{
  module[ 'exports' ] = Self;
}

// --
// assert
// --

})();
