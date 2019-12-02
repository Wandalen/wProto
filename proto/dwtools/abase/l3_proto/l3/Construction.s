( function _Construction_s_() {

'use strict';

let _global = _global_;
let _ = _global_.wTools;

// --
// implementation
// --

function extend( dst, src )
{
  if( dst === null )
  dst = Object.create( null );

  for( let s in src )
  {
    let def = src[ s ];
    if( _.definitionIs( def ) )
    definitionExtend( def, dst, s );
    else
    dst[ s ] = def;
  }

  return dst;

  function definitionExtend( def, dst, s )
  {
    def.OnConstructionExtend( dst, s );
  }
}

// --
// define construction
// --

let construction = Object.create( null );

var Fields =
{
}

var Routines =
{
  extend,
}

//

Object.assign( construction, Routines );
Object.assign( construction, Fields );
_.assert( _.construction === undefined );

// --
// define tools
// --

var Fields =
{
}

var Routines =
{
  construction,
}

Object.assign( _, Routines );
Object.assign( _, Fields );

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = _;

})();
