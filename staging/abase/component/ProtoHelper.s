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

var like = function like()
{
  var helper = new Self();
  var result = Object.create( null );

  helper.result = result;
  helper.usingPrototype = false;

  Object.freeze( helper );

  if( arguments.length > 0 )
  _.mapExtend.apply( _,Array.prototype.concat.apply( [ result ],arguments ) );

  return helper;
}

//

var also = function also( src )
{
  _.assert( arguments.length === 1 );
  _.mapExtend( this.result,src );
  return this;
}

//

var but = function but( src )
{
  _.assert( arguments.length === 1 );
  _.mapDelete( this.result,src );
  return this;
}

//

var _endGet = function _endGet()
{
  return this.result;
}

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
