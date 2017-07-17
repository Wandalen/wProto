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
var _assert = wTools.assert;
var _nameFielded = wTools.nameFielded;

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

function like()
{
  var helper = new Self();
  var proto = Object.create( null );
  var location;
  var _ = wTools;

  // if( Config.debug )
  // location = wTools.diagnosticLocation( 1 ).full;

  Object.defineProperty( proto, 'constructor',
  {
    enumerable : false,
    configurable : false,
    writable : false,
    value : function Construction( o )
    {
      wTools.assert( arguments.length === 0 || arguments.length === 1,'construction expects one or none argument' );

      if( !( this instanceof proto.constructor ) )
      if( o instanceof proto.constructor )
      return o;
      else
      return new( wTools.routineJoin( proto.constructor, proto.constructor, arguments ) );

      wTools.assertMapHasOnly( this,proto,'Prototype of the object ' + ( location ? 'defined at\n' + location + '\n' : '' ) + 'does not have requested fields.' );

      wTools.mapComplement( this,proto );
      Object.preventExtensions( this );

      // if( !o )
      // debugger;

      if( o )
      wTools.mapExtend( this,o );

      return this;
    }
  });

  var allClasses = [ proto ];
  for( var a = 0 ; a < arguments.length ; a++ )
  {
    var arg = arguments[ a ];
    wTools.assert( arg[ symbolForAllClasses ] );
    // if( arg[ symbolForAllClasses ] )
    // debugger;
    if( arg[ symbolForAllClasses ] )
    wTools.__arrayAppendArrayOnce( allClasses,arg[ symbolForAllClasses ] );
  }

  proto.constructor.prototype = proto;

  Object.defineProperty( proto, symbolForParents,
  {
    enumerable : false,
    configurable : false,
    writable : false,
    value : wTools.arraySlice( arguments ),
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
  wTools.mapExtend.apply( wTools,Array.prototype.concat.apply( [ proto ],arguments ) );

  return helper;
}

//

function name( src )
{
  wTools.assert( arguments.length === 1 );
  return this;
}

//

function also( src )
{
  wTools.assert( arguments.length === 1 );
  wTools.mapExtend( this.proto,src );
  return this;
}

//

function but( src )
{
  wTools.assert( arguments.length === 1 );
  wTools.mapDelete( this.proto,src );
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

wTools.assert( !wTools.construction );
wTools.construction = Object.create( null );
wTools.mapExtend( wTools.construction, Proto );

// --
// prototype
// --

var Proto =
{
  like : like,
}

wTools.mapExtend( wTools, Proto );

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

wTools.protoMake
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

wTools.accessorReadOnly
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
