( function _Define_s_() {

'use strict';

let Self = _global_.wTools;
let _global = _global_;
let _ = _global_.wTools;

// --
// implementation
// --

/**
* Creates property-like entity with getter that returns reference to source object.
* @param {Object-like|Long} src - source value
* @returns {module:Tools/base/Proto.wTools.define.Definition}
* @function common
* @namespace Tools.define
*/

function common( src )
{
  let o2 = { val : src }
  o2.definitionGroup = 'definition.named';
  let definition = new _.Definition( o2 );

  _.assert( src !== undefined, () => 'Expects object-like or long, but got ' + _.strType( src ) );
  _.assert( arguments.length === 1 );
  _.assert( definition.val !== undefined );

  definition.valueGenerate = function get() { return this.val }

  _.propertyHide( definition, 'valueGenerate' );

  Object.freeze( definition );
  return definition;
}

//

/**
* Creates property-like entity with getter that returns shallow copy of source object.
* @param {Object-like|Long} src - source value
* @returns {module:Tools/base/Proto.wTools.define.Definition}
* @function own
* @namespace Tools.define
*/

function own( src )
{
  let o2 = { val : src }
  o2.definitionGroup = 'definition.named';
  let definition = new _.Definition( o2 );

  _.assert( src !== undefined, () => 'Expects object-like or long, but got ' + _.strType( src ) );
  _.assert( arguments.length === 1 );
  _.assert( definition.val !== undefined );

  // definition.valueGenerate = function get() { return _.entityMake( this.val ) }
  definition.valueGenerate = function get() { return _.cloneJust( this.val ) }

  _.propertyHide( definition, 'valueGenerate' );

  Object.freeze( definition );
  return definition;
}

//

/**
* Creates property-like entity with getter that returns new instance of source constructor.
* @param {Function} src - source constructor
* @returns {module:Tools/base/Proto.wTools.define.Definition}
* @function instanceOf
* @namespace Tools.define
*/

function instanceOf( src )
{
  let o2 = { val : src }
  o2.definitionGroup = 'definition.named';
  let definition = new _.Definition( o2 );

  _.assert( _.routineIs( src ), 'Expects constructor' );
  _.assert( arguments.length === 1 );
  _.assert( definition.val !== undefined );

  definition.valueGenerate = function get() { return new this.val() }

  _.propertyHide( definition, 'valueGenerate' );

  Object.freeze( definition );
  return definition;
}

//

/**
* Creates property-like entity with getter that returns result of source routine call.
* @param {Function} src - source routine
* @returns {module:Tools/base/Proto.wTools.define.Definition}
* @function makeWith
* @namespace Tools.define
*/

function makeWith( src )
{
  let o2 = { val : src }
  o2.definitionGroup = 'definition.named';
  let definition = new _.Definition( o2 );

  _.assert( _.routineIs( src ), 'Expects constructor' );
  _.assert( arguments.length === 1 );
  _.assert( definition.val !== undefined );

  definition.valueGenerate = function get() { return this.val() }

  _.propertyHide( definition, 'valueGenerate' );

  Object.freeze( definition );
  return definition;
}

//

/**
* @param {Object} src
* @returns {module:Tools/base/Proto.wTools.define.Definition}
* @function contained
* @namespace Tools.define
*/

/*
zzz : remove routine contained
*/

function contained( src )
{

  _.assert( _.mapIs( src ) );
  _.assert( arguments.length === 1 );
  _.assert( src.val !== undefined );

  let container = _.mapBut( src, contained.defaults );
  let o = _.mapOnly( src, contained.defaults );
  o.container = container;
  o.val = src.val;
  o.definitionGroup = 'definition.named';
  let definition = new _.Definition( o );

  if( o.shallowCloning )
  definition.valueGenerate = function get()
  {
    let result = this.container;
    result.value = _.entityMake( definition.val );
    return result;
  }
  else
  definition.valueGenerate = function get()
  {
    let result = this.container;
    result.value = definition.val;
    return result;
  }

  _.propertyHide( definition, 'valueGenerate' );
  Object.freeze( definition );
  _.assert( definition.val !== undefined );
  return definition;
}

contained.defaults =
{
  val : null,
  shallowCloning : 0,
}

// //
//
// function ownerCallback( o )
// {
//   if( !_.mapIs( o ) )
//   o = { callback : arguments[ 0 ] };
//   _.assert( _.routineIs( o.callback ) || _.strIs( o.callback ) );
//   o.isMeta = true;
//   o.val = null;
//   o.subKind = 'ownerCallback';
//
//   if( _.strIs( o.callback ) )
//   {
//     let callbackName = o.callback;
//     o.callback = function callback()
//     {
//       return this[ callbackName ]( ... arguments );
//     }
//   }
//
//   let definition = new _.Definition( o );
//   return definition;
// }
//
// ownerCallback.defaults =
// {
//   callback : null,
// }

//

function accessor( o )
{

  if( _.routineIs( o ) )
  o = { routine : arguments[ 0 ] }

  _.routineOptions( accessor, o );

  o.definitionGroup = 'definition.named';
  o.subKind = 'accessor';
  o.constructionAmend = constructionAmend;

  _.assert( _.routineIs( o.routine ) );
  _.assert( arguments.length === 1 );

  let definition = new _.Definition( o );
  _.propertyHide( definition, 'constructionAmend' );
  _.assert( definition.val !== undefined );
  return definition;

  /* */

  function constructionAmend( dst, key, amend )
  {
    let instanceIsStandard = _.instanceIsStandard( dst );
    _.assert( arguments.length === 3 );

    let args = []
    for( let i = 0 ; i < o.val.length ; i++ )
    args[ i ] = _.make( o.val[ i ] );
    let o2;
    if( o.routine.head )
    {
      o2 = o.routine.head( o.routine, args );
    }
    else
    {
      debugger;
      _.assert( args.length === 1 );
      o2 = args[ 0 ];
    }

    _.assert( _.mapIs( o2 ) );

    if( o.routine.defaults.fieldName !== undefined )
    if( o2.fieldName === undefined || o2.fieldName === null )
    {
      _.assert( 0, 'not tested' ); /* zzz : test */
      o2.fieldName = key;
    }

    let r;
    if( o.routine.body )
    r = o.routine.body( o2 );
    else
    r = o.routine( o2 );

    if( _.boolLike( o.get ) && !o.get && o.set === null )
    {
      if( _.routineIs( r ) )
      {
        o.set = r;
        if( o.put === null || _.boolLikeTrue( o.put ) )
        o.put = r;
      }
      else if( _.mapIs( r ) )
      {
        o.set = r.set;
        if( o.put === null || _.boolLikeTrue( o.put ) )
        if( r.put )
        o.put = r.put;
      }
      else _.assert( 0 );
    }
    else if( _.boolLike( o.set ) && !o.set && o.get === null )
    {
      if( _.routineIs( r ) )
      o.get = r;
      else if( _.mapIs( r ) )
      o.get = r.get
      else _.assert( 0 );
    }
    else
    {
      if( _.mapIs( r ) )
      {
        if( o.get === null || _.boolLikeTrue( o.get ) )
        o.get = r.get;
        if( o.set === null || _.boolLikeTrue( o.set ) )
        o.set = r.set;
        if( o.put === null || _.boolLikeTrue( o.put ) )
        o.put = r.put;
      }
    }

    _.assert( _.boolLikeFalse( o.get ) || _.routineIs( o.get ) );
    _.assert( _.boolLikeFalse( o.set ) || _.routineIs( o.set ) );

    _.accessor.declare
    ({
      object : dst,
      names : key,
      grab : o.grab,
      get : o.get,
      put : o.put,
      set : o.set,
      prime : instanceIsStandard,
      strict : instanceIsStandard,
    });

  }

  /* */

}

accessor.defaults =
{
  val : null,
  routine : null,
  grab : null,
  get : null,
  put : null,
  set : null,
}

//

function getter( o )
{

  if( _.routineIs( o ) )
  o = { routine : arguments[ 0 ] }

  _.routineOptions( getter, o );

  o.get = null;
  o.put = false;
  o.set = false;

  return _.define.accessor( o );
}

getter.defaults =
{
  val : null,
  routine : null,
}

//

function setter( o )
{

  if( _.routineIs( o ) )
  o = { routine : arguments[ 0 ] }

  _.routineOptions( setter, o );

  o.get = false;
  o.put = null;
  o.set = null;

  return _.define.accessor( o );
}

setter.defaults =
{
  val : null,
  routine : null,
}

//

function putter( o )
{

  if( _.routineIs( o ) )
  o = { routine : arguments[ 0 ] }

  _.routineOptions( putter, o );

  o.get = false;
  o.set = false;
  o.put = null;

  return _.define.accessor( o );
}

putter.defaults =
{
  val : null,
  routine : null,
}

//

function _constant( val )
{

  let o = { val }

  _.routineOptions( _constant, o );

  o.definitionGroup = 'definition.named';
  o.subKind = 'constant';
  o.constructionAmend = constructionAmend;

  _.assert( arguments.length === 1 );

  let definition = new _.Definition( o );
  _.propertyHide( definition, 'constructionAmend' );
  _.assert( definition.val !== undefined );
  return definition;

  /* */

  function constructionAmend( dst, key, amend ) /* xxx : implement, use inheriting instead? */
  {
    let instanceIsStandard = _.instanceIsStandard( dst );
    _.assert( arguments.length === 3 );
    _.assert( 0, 'not implemented' );
  }

}

_constant.defaults =
{
  val : null,
}

// --
// define
// --

/**
* Collection of definitions for constructions.
* @namespace wTools.define
* @extends Tools
* @module Tools/base/Proto
*/

let DefineExtension =
{

  // field,
  common,
  own,
  instanceOf,
  makeWith,
  contained,
  // ownerCallback,

  accessor,
  getter,
  setter,
  putter,
  constant : _constant,

}

_.define = _.define || Object.create( null );
_.mapExtend( _.define, DefineExtension );

//

/**
* Routines to manipulate definitions.
* @namespace wTools.definition
* @extends Tools
* @module Tools/base/Proto
*/

let DefinitionExtension =
{
}

_.definition = _.definition || Object.create( null );
_.mapExtend( _.definition, DefinitionExtension );
_.assert( _.routineIs( _.definitionIs ) );
_.assert( _.definition.is === _.definitionIs );

//

let ToolsExtension =
{
}

_.mapExtend( _, ToolsExtension );

// --
// export
// --

if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;

})();
