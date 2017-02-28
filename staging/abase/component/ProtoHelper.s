( function _ProtoHelper_s_() {

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

  // if( typeof wProto === 'undefined' )
  // try
  // {
  //   require( './Proto.s' );
  // }
  // catch( err )
  // {
  //   require( 'wProto' );
  // }

}

var _ = wTools;

var _hasOwnProperty = Object.hasOwnProperty;
var _assert = _.assert;
var _nameFielded = _.nameFielded;

//

var Parent = null;
var Self = function wProtoHelper( o )
{
}

Self.nameShort = 'ProtoHelper';

// --
// helper
// --

function like()
{
  var helper = new Self();
  var result = Object.create( null );

  Object.defineProperty( result, 'constructor',
  {
    enumerable : false,
    configurable : false,
    writable : false,
    value : function Construction( o )
    {
      _.assert( arguments.length === 0 || arguments.length === 1,'construction expects one or none argument' );

      if( !( this instanceof result.constructor ) )
      if( o instanceof result.constructor )
      return o;
      else
      return new( _.routineJoin( result.constructor, result.constructor, arguments ) );

      _.mapExtend( this,result );
      Object.preventExtensions( this );
      _.mapExtend( this,o );

      return this;

    }
  });

  // result.constructor.prototype = Object.create( null );
  result.constructor.prototype = result;

  Object.defineProperty( result, 'Parents',
  {
    enumerable : false,
    configurable : false,
    writable : false,
    value : _.arraySlice( arguments ),
  });

  helper.result = result;
  helper.usingPrototype = false;

  Object.freeze( helper );

  if( arguments.length > 0 )
  _.mapExtend.apply( _,Array.prototype.concat.apply( [ result ],arguments ) );

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
  _.mapExtend( this.result,src );
  return this;
}

//

function but( src )
{
  _.assert( arguments.length === 1 );
  _.mapDelete( this.result,src );
  return this;
}

//

function _endGet()
{
  return this.result;
}

//

function isLike( instance,parent )
{
  if( !instance.Parents )
  return false;
  return instance.Parents.indexOf( parent ) !== -1;
}

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

})();
