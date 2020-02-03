( function _Define_s_() {

'use strict';

let Self = _global_.wTools;
let _global = _global_;
let _ = _global_.wTools;

// --
// implementation
// --

// /**
// * @classdesc Class container for creating property-like entity from non-primitive value.
//   Is used by routines:
//   @see {@link module:Tools/base/Proto.wTools.define.own}
//   @see {@link module:Tools/base/Proto.wTools.define.common}
//   @see {@link module:Tools/base/Proto.wTools.define.instanceOf}
//   @see {@link module:Tools/base/Proto.wTools.define.makeWith}
//   @see {@link module:Tools/base/Proto.wTools.define.contained}
// * @class Definition
// * @memberof module:Tools/base/Proto.wTools.define
// */
//
// function Definition( o )
// {
//   _.assert( arguments.length === 1 );
//   if( !( this instanceof Definition ) )
//   if( o instanceof Definition )
//   return o;
//   else
//   return new( _.constructorJoin( Definition, arguments ) );
//   _.mapExtend( this, o );
//
//   return this;
// }
//
// Definition.prototype = Object.create( null );
//
// //
//
// function field( o )
// {
//
//   _.assert( _.mapIs( o ) );
//   _.assert( o.ini !== undefined );
//   o = _.routineOptions( field, arguments );
//   _.assert( arguments.length === 1 );
//   _.assert( _.strIs( o.iniToIns ) );
//   _.assert( _.longHas( [ 'scalar' , 'array' , 'map' ], o.collection ) );
//   _.assert( 'scalar' === o.collection, 'not implemented' ); /* zzz : implement */
//   _.assert( _.longHas( [ 'val' , 'shallow' , 'clone' , 'call' , 'construct' ], o.iniToIns ) );
//   _.assert( o.ini !== undefined );
//
//   _.assert( o.collection === 'scalar', 'not implemented' );
//   _.assert( o.insToIns === 'val', 'not implemented' );
//   _.assert( o.datToIns === 'val', 'not implemented' );
//   _.assert( o.insToDat === 'val', 'not implemented' );
//   _.assert( o.datToDat === 'val', 'not implemented' );
//
//   o.definitionGroup = 'definition.named';
//   o.blueprintForm2 = blueprintForm2;
//   o.name = null;
//
//   let definition = new _.Definition( o );
//
//   /* */
//
//   if( o.iniToIns === 'val' )
//   {
//     definition.initialValueGet = function get() { return this.ini }
//   }
//   else if( o.iniToIns === 'shallow' )
//   {
//     debugger;
//     definition.initialValueGet = function get() { return _.entityMake( this.ini ) }
//   }
//   else if( o.iniToIns === 'deep' )
//   {
//     debugger;
//     definition.initialValueGet = function get() { return _.cloneJust( this.ini ) }
//   }
//   else if( o.iniToIns === 'make' )
//   {
//     debugger;
//     definition.initialValueGet = function get() { return this.ini() }
//   }
//   else if( o.iniToIns === 'construct' )
//   {
//     debugger;
//     definition.initialValueGet = function get() { return new this.ini() }
//   }
//   else _.assert( 0 );
//
//   /* */
//
//   function blueprintForm2( blueprint, key )
//   {
//     let handlers = blueprint.constructionHandlers.constructionInit = blueprint.constructionHandlers.constructionInit || [];
//
//     if( o.iniToIns === 'val' )
//     {
//       handlers.push( constructionInitVal );
//     }
//     else if( o.iniToIns === 'shallow' )
//     {
//       debugger;
//       handlers.push( constructionInitShallow );
//     }
//     else if( o.iniToIns === 'clone' )
//     {
//       debugger;
//       handlers.push( constructionInitClone );
//     }
//     else if( o.iniToIns === 'make' )
//     {
//       debugger;
//       handlers.push( constructionInitCall )
//     }
//     else if( o.iniToIns === 'construct' )
//     {
//       debugger;
//       handlers.push( constructionInitNew )
//     }
//     else _.assert( 0 );
//
//   }
//
//   /* */
//
//   // definition.initialValueGet = function get() { return _.entityMake( this.ini ) }
//   // definition.initialValueGet = function get() { return _.cloneJust( this.ini ) }
//
// /*
//   common,
//   own,
//   instanceOf,
//   makeWith,
// */
//
//   Object.preventExtension( definition );
//   return definition;
//
//   function constructionInitVal( construction, name )
//   {
//     construction[ name ] = this.ini;
//   }
//   function constructionInitShallow( construction, name )
//   {
//     construction[ name ] = _.entityMake( this.ini );
//   }
//   function constructionInitClone( construction, name )
//   {
//     construction[ name ] = _.cloneJust( this.ini );
//   }
//   function constructionInitCall( construction, name )
//   {
//     construction[ name ] = this.ini()
//   }
//   function constructionInitNew( construction, name )
//   {
//     construction[ name ] = new this.ini()
//   }
//
// }
//
// field.defaults =
// {
//   order           : 0,
//   // static          : 0,
//   // enumerable      : 1,
//   // configurable    : 1,
//   // writable :      : 1,
//   collection      : 'scalar',
//   insToIns        : 'val',
//   datToIns        : 'val',
//   insToDat        : 'val',
//   datToDat        : 'val',
//   iniToIns        : 'val',
//   ini             : null,
//   // relation        : null,
// }
//
// /*
// |                | Composes | Aggregates | Associates  |  Restricts  |  Medials  |   Statics   |
// | -------------- |:--------:|:----------:|:-----------:|:-----------:|:---------:|:-----------:|
// | Static         |          |            |             |             |           |      +      |
// | Ins to Ins     |   deep   |    val     |    val      |      -      |     -     |             |
// | Dat to Ins     |   deep   |    deep    |    val      |      -      |   val     |             |
// | Ins to Dat     |   deep   |    deep    |    val      |      -      |     -     |             |
// | Dat to Dat     |   deep   |    deep    |    val      |      -      |   val     |             |
// */
//
// /*
// order           : [ -10 .. +10 ]                                                                            @default : 0
// static          : [ 0 , 1 ]                                                                                 @default : 0
// enumerable      : [ 0 , 1 ]                                                                                 @default : 1
// configurable    : [ 0 , 1 ]                                                                                 @default : 1
// writable        : [ 0 , 1 ]                                                                                 @default : 1
// initialValueGet : routine                                                                                   @default : null
// collection      : [ scalar , array , map ]                                                                  @default : scalar
// insToIns        : [ val , shallow , deep ]                                                                  @default : val
// datToIns        : [ val , shallow , deep ]                                                                  @default : val
// insToDat        : [ val , shallow , deep ]                                                                  @default : val
// datToDat        : [ val , shallow , deep ]                                                                  @default : val
// iniToIns        : [ val , shallow , deep , make , construct ]                                               @default : val
// relation        : [ null , composes , aggregates , associates , restricts , medials , statics , copiers ]   @default : null
// ini             : *                                                                                         @default : null
// */

//

/**
* Creates property-like entity with getter that returns reference to source object.
* @param {Object-like|Long} src - source value
* @returns {module:Tools/base/Proto.wTools.define.Definition}
* @function common
* @memberof module:Tools/base/Proto.wTools.define
*/

function common( src )
{
  let o2 = { ini : src }
  o2.definitionGroup = 'definition.named';
  let definition = new _.Definition( o2 );

  _.assert( src !== undefined, () => 'Expects object-like or long, but got ' + _.strType( src ) );
  _.assert( arguments.length === 1 );
  _.assert( definition.ini !== undefined );

  definition.initialValueGet = function get() { return this.ini }

  _.propertyHide( definition, 'initialValueGet' );

  Object.freeze( definition );
  return definition;
}

//

/**
* Creates property-like entity with getter that returns shallow copy of source object.
* @param {Object-like|Long} src - source value
* @returns {module:Tools/base/Proto.wTools.define.Definition}
* @function own
* @memberof module:Tools/base/Proto.wTools.define
*/

function own( src )
{
  let o2 = { ini : src }
  o2.definitionGroup = 'definition.named';
  let definition = new _.Definition( o2 );

  _.assert( src !== undefined, () => 'Expects object-like or long, but got ' + _.strType( src ) );
  _.assert( arguments.length === 1 );
  _.assert( definition.ini !== undefined );

  // definition.initialValueGet = function get() { return _.entityMake( this.ini ) }
  definition.initialValueGet = function get() { return _.cloneJust( this.ini ) }

  _.propertyHide( definition, 'initialValueGet' );

  Object.freeze( definition );
  return definition;
}

//

/**
* Creates property-like entity with getter that returns new instance of source constructor.
* @param {Function} src - source constructor
* @returns {module:Tools/base/Proto.wTools.define.Definition}
* @function instanceOf
* @memberof module:Tools/base/Proto.wTools.define
*/

function instanceOf( src )
{
  let o2 = { ini : src }
  o2.definitionGroup = 'definition.named';
  let definition = new _.Definition( o2 );

  _.assert( _.routineIs( src ), 'Expects constructor' );
  _.assert( arguments.length === 1 );
  _.assert( definition.ini !== undefined );

  definition.initialValueGet = function get() { return new this.ini() }

  _.propertyHide( definition, 'initialValueGet' );

  Object.freeze( definition );
  return definition;
}

//

/**
* Creates property-like entity with getter that returns result of source routine call.
* @param {Function} src - source routine
* @returns {module:Tools/base/Proto.wTools.define.Definition}
* @function makeWith
* @memberof module:Tools/base/Proto.wTools.define
*/

function makeWith( src )
{
  let o2 = { ini : src }
  o2.definitionGroup = 'definition.named';
  let definition = new _.Definition( o2 );

  _.assert( _.routineIs( src ), 'Expects constructor' );
  _.assert( arguments.length === 1 );
  _.assert( definition.ini !== undefined );

  definition.initialValueGet = function get() { return this.ini() }

  _.propertyHide( definition, 'initialValueGet' );

  Object.freeze( definition );
  return definition;
}

//

/**
* @param {Object} src
* @returns {module:Tools/base/Proto.wTools.define.Definition}
* @function contained
* @memberof module:Tools/base/Proto.wTools.define
*/

/*
zzz : remove routine contained
*/

function contained( src )
{

  _.assert( _.mapIs( src ) );
  _.assert( arguments.length === 1 );
  _.assert( src.ini !== undefined );

  let container = _.mapBut( src, contained.defaults );
  let o = _.mapOnly( src, contained.defaults );
  o.container = container;
  o.ini = src.ini;
  o.definitionGroup = 'definition.named';
  let definition = new _.Definition( o );

  if( o.shallowCloning )
  definition.initialValueGet = function get()
  {
    let result = this.container;
    result.value = _.entityMake( definition.ini );
    return result;
  }
  else
  definition.initialValueGet = function get()
  {
    let result = this.container;
    result.value = definition.ini;
    return result;
  }

  _.propertyHide( definition, 'initialValueGet' );
  Object.freeze( definition );
  _.assert( definition.ini !== undefined );
  return definition;
}

contained.defaults =
{
  ini : null,
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
//   o.ini = null;
//   o.kind = 'ownerCallback';
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
  o.kind = 'accessor';
  o.constructionAmend = constructionAmend;
  // o.blueprintForm = function(){};

  _.assert( _.routineIs( o.routine ) );
  _.assert( arguments.length === 1 );

  let definition = new _.Definition( o );
  _.propertyHide( definition, 'constructionAmend' );
  _.assert( definition.ini !== undefined );
  return definition;

  /* */

  function constructionAmend( dst, key, amend )
  {
    let instanceIsStandard = _.instanceIsStandard( dst );
    _.assert( arguments.length === 3 );

    let args = []
    for( let i = 0 ; i < o.ini.length ; i++ )
    args[ i ] = _.make( o.ini[ i ] );
    let o2;
    if( o.routine.pre )
    {
      o2 = o.routine.pre( o.routine, args );
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

    if( _.boolLike( o.getter ) && !o.getter && o.setter === null )
    {
      if( _.routineIs( r ) )
      o.setter = r;
      else if( _.mapIs( r ) )
      o.setter = r.setter
      else _.assert( 0 );
    }
    else if( _.boolLike( o.setter ) && !o.setter && o.getter === null )
    {
      if( _.routineIs( r ) )
      o.getter = r;
      else if( _.mapIs( r ) )
      o.getter = r.getter
      else _.assert( 0 );
    }
    else
    {
      if( _.mapIs( r ) )
      {
        if( o.getter === null )
        o.getter = r.get;
        if( o.setter === null )
        o.setter = r.set
      }
    }

    _.assert( _.boolLikeFalse( o.getter ) || _.routineIs( o.getter ) );
    _.assert( _.boolLikeFalse( o.setter ) || _.routineIs( o.setter ) );

    _.accessor.declare
    ({
      object : dst,
      names : key,
      getter : o.getter,
      setter : o.setter,
      prime : instanceIsStandard,
      strict : instanceIsStandard,
    });

  }

  /* */

}

accessor.defaults =
{
  ini : null,
  routine : null,
  getter : null,
  setter : null,
}

//

function getter( o )
{

  if( _.routineIs( o ) )
  o = { routine : arguments[ 0 ] }

  _.routineOptions( getter, o );

  o.getter = null;
  o.setter = false;

  return _.define.accessor( o );
}

getter.defaults =
{
  ini : null,
  routine : null,
}

//

function setter( o )
{

  if( _.routineIs( o ) )
  o = { routine : arguments[ 0 ] }

  _.routineOptions( setter, o );

  o.getter = false;
  o.setter = null;

  return _.define.accessor( o );
}

setter.defaults =
{
  ini : null,
  routine : null,
}

// --
// define
// --

/**
* Collection of definitions for constructions.
* @namespace "wTools.define"
* @augments wTools
* @memberof module:Tools/base/Proto
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

}

_.define = _.define || Object.create( null );
_.mapExtend( _.define, DefineExtension );

//

/**
* Routines to manipulate definitions.
* @namespace "wTools.definition"
* @augments wTools
* @memberof module:Tools/base/Proto
*/

let DefinitionExtension =
{

  // routines
  // is : _.definitionIs,

  // fields
  // KnownFields,

}

_.definition = _.definition || Object.create( null );
_.mapExtend( _.definition, DefinitionExtension );
_.assert( _.routineIs( _.definitionIs ) );
_.assert( _.definition.is === _.definitionIs );

//

let ToolsExtension =
{
  // Definition,
}

_.mapExtend( _, ToolsExtension );

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
