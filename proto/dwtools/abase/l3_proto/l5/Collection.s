( function _Collection_s_() {

'use strict';

let Self = _global_.wTools;
let _global = _global_;
let _ = _global_.wTools;

// --
// getter / setter functors
// --

function setterMapCollection_functor( o )
{

  _.assertMapHasOnly( o, setterMapCollection_functor.defaults );
  _.assert( _.strIs( o.name ) );
  _.assert( _.routineIs( o.elementMaker ) );
  let symbol = Symbol.for( o.name );
  let elementMakerOriginal = o.elementMaker;
  let elementMaker = o.elementMaker;
  let friendField = o.friendField;

  if( friendField )
  elementMaker = function elementMaker( src )
  {
    src[ friendField ] = this;
    return elementMakerOriginal.call( this, src );
  }

  return function _setterMapCollection( src )
  {
    let self = this;

    _.assert( _.objectIs( src ) );

    if( self[ symbol ] )
    {

      if( src !== self[ symbol ] )
      for( let d in self[ symbol ] )
      delete self[ symbol ][ d ];

    }
    else
    {

      self[ symbol ] = Object.create( null );

    }

    for( let d in src )
    {
      if( src[ d ] !== null )
      self[ symbol ][ d ] = elementMaker.call( self, src[ d ] );
    }

    return self[ symbol ];
  }

}

setterMapCollection_functor.defaults =
{
  name : null,
  elementMaker : null,
  friendField : null,
}

//

function setterArrayCollection_functor( o )
{

  if( _.strIs( arguments[ 0 ] ) )
  o = { name : arguments[ 0 ] }

  _.routineOptions( setterArrayCollection_functor, o );
  _.assert( _.strIs( o.name ) );
  _.assert( arguments.length === 1 );
  _.assert( _.routineIs( o.elementMaker ) || o.elementMaker === null );

  let symbol = Symbol.for( o.name );
  let elementMaker = o.elementMaker;
  let friendField = o.friendField;

  if( !elementMaker )
  elementMaker = function( src ){ return src }

  let elementMakerOriginal = elementMaker;

  if( friendField )
  elementMaker = function elementMaker( src )
  {
    src[ friendField ] = this;
    return elementMakerOriginal.call( this, src );
  }

  return function _setterArrayCollection( src )
  {
    let self = this;

    _.assert( src !== undefined );
    _.assert( arguments.length === 1 );

    if( src !== null )
    src = _.arrayAs( src );

    _.assert( _.arrayIs( src ) );

    if( self[ symbol ] )
    {

      if( src !== self[ symbol ] )
      self[ symbol ].splice( 0, self[ symbol ].length );

    }
    else
    {

      self[ symbol ] = [];

    }

    if( src === null )
    return self[ symbol ];

    if( src !== self[ symbol ] )
    for( let d = 0 ; d < src.length ; d++ )
    {
      if( src[ d ] !== null )
      self[ symbol ].push( elementMaker.call( self, src[ d ] ) );
    }
    else for( let d = 0 ; d < src.length ; d++ )
    {
      if( src[ d ] !== null )
      src[ d ] = elementMaker.call( self, src[ d ] );
    }

    return self[ symbol ];
  }

}

setterArrayCollection_functor.defaults =
{
  name : null,
  elementMaker : null,
  friendField : null,
}

//

/**
 * Makes a setter that makes a shallow copy of (src) before assigning.
 * @param {Object} o - options map
 * @param {Object} o.name - name of property
 * @returns {Function} Returns setter function.
 * @function own
 * @namespace Tools.accessor.setter
 */

function setterOwn_functor( op )
{
  let symbol = Symbol.for( op.name );

  _.routineOptions( setterOwn_functor, arguments );

  return function ownSet( src )
  {
    let self = this;

    _.assert( arguments.length === 1 );

    self[ symbol ] = _.entityMake( src );

    return self[ symbol ];
  }

}

setterOwn_functor.defaults =
{
  name : null,
}

//

function setterFriend_functor( o )
{

  let name = _.nameUnfielded( o.name ).coded;
  let friendName = o.friendName;
  let maker = o.maker;
  let symbol = Symbol.for( name );

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( name ) );
  _.assert( _.strIs( friendName ) );
  _.assert( _.routineIs( maker ), 'Expects maker {-o.maker-}' );
  _.assertMapHasOnly( o, setterFriend_functor.defaults );

  return function setterFriend( src )
  {

    let self = this;
    _.assert( src === null || _.objectIs( src ), 'setterFriend : expects null or object, but got ' + _.strType( src ) );

    if( !src )
    {

      self[ symbol ] = src;
      return;

    }
    else if( !self[ symbol ] )
    {

      if( _.mapIs( src ) )
      {
        let o2 = Object.create( null );
        o2[ friendName ] = self;
        o2.name = name;
        self[ symbol ] = maker( o2 );
        self[ symbol ].copy( src );
      }
      else
      {
        self[ symbol ] = src;
      }

    }
    else
    {

      if( self[ symbol ] !== src )
      self[ symbol ].copy( src );

    }

    if( self[ symbol ][ friendName ] !== self )
    self[ symbol ][ friendName ] = self;

    return self[ symbol ];
  }

}

setterFriend_functor.defaults =
{
  name : null,
  friendName : null,
  maker : null,
}

//

function setterCopyable_functor( o )
{

  let name = _.nameUnfielded( o.name ).coded;
  let maker = o.maker;
  let symbol = Symbol.for( name );
  let debug = o.debug;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( name ) );
  _.assert( _.routineIs( maker ) );
  _.assertMapHasOnly( o, setterCopyable_functor.defaults );

  return function setterCopyable( data )
  {
    let self = this;

    if( debug )
    debugger;

    if( data === null )
    {
      if( self[ symbol ] && self[ symbol ].finit )
      self[ symbol ].finit();
      self[ symbol ] = null;
      return self[ symbol ];
    }

    if( !_.objectIs( self[ symbol ] ) )
    {

      self[ symbol ] = maker( data );

    }
    else if( _.objectIs( self[ symbol ] ) && !self[ symbol ].copy )
    {
      self[ symbol ] = maker( data );
    }
    else
    {

      if( self[ symbol ] !== data )
      {
        _.assert( _.routineIs( self[ symbol ].copy ) );
        self[ symbol ].copy( data );
      }

    }

    return self[ symbol ];
  }

}

setterCopyable_functor.defaults =
{
  name : null,
  maker : null,
  debug : 0,
}

//

/**
 * Makes a setter that makes a buffer from (src) before assigning.
 * @param {Object} o - options map
 * @param {Object} o.name - name of property
 * @param {Object} o.bufferConstructor - buffer constructor
 * @returns {Function} Returns setter function.
 * @function bufferFrom
 * @namespace Tools.accessor.setter
 */

function setterBufferFrom_functor( o )
{

  let name = _.nameUnfielded( o.name ).coded;
  let bufferConstructor = o.bufferConstructor;
  let symbol = Symbol.for( name );

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( name ) );
  _.assert( _.routineIs( bufferConstructor ) );
  _.routineOptions( setterBufferFrom_functor, o );

  return function setterBufferFrom( data )
  {
    let self = this;

    if( data === null || data === false )
    {
      data = null;
    }
    else
    {
      data = _.bufferFrom({ src : data, bufferConstructor });
    }

    self[ symbol ] = data;
    return data;
  }

}

setterBufferFrom_functor.defaults =
{
  name : null,
  bufferConstructor : null,
}

//

function setterChangesTracking_functor( o )
{

  let name = Symbol.for( _.nameUnfielded( o.name ).coded );
  let nameOfChangeFlag = Symbol.for( _.nameUnfielded( o.nameOfChangeFlag ).coded );

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.routineOptions( setterChangesTracking_functor, o );

  throw _.err( 'not tested' );

  return function setterChangesTracking( data )
  {
    let self = this;

    if( data === self[ name ] )
    return;

    self[ name ] = data;
    self[ nameOfChangeFlag ] = true;

    return data;
  }

}

setterChangesTracking_functor.defaults =
{
  name : null,
  nameOfChangeFlag : 'needsUpdate',
  bufferConstructor : null,
}

//

/**
 * @summary Allows to get read and write access to property of inner container.
 * @param {Object} o
 * @param {String} o.name
 * @param {Number} o.index
 * @param {String} o.storageName
 * @function toElement
 * @namespace Tools.accessor.suite
 */

function toElementSet_functor( o )
{
  _.assert( 0, 'not tested' );
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.objectIs( o.names ) );
  _.assert( _.strIs( o.name ) );
  _.assert( _.strIs( o.storageName ) );
  _.assert( _.numberIs( o.index ) );
  _.routineOptions( toElementSet_functor, o );

  debugger;

  let index = o.index;
  let storageName = o.storageName;
  let name = o.name;
  let aname = _.accessor._propertyGetterSetterNames( name );

  _.assert( _.numberIs( index ) );
  _.assert( index >= 0 );

  return function accessorToElementSet( src )
  {
    this[ storageName ][ index ] = src;
  }

  return r;
}

toElementSet_functor.defaults =
{
  name : null,
  index : null,
  storageName : null,
}

//

function symbolPut_functor( o )
{
  o = _.routineOptions( symbolPut_functor, arguments );
  let symbol = Symbol.for( o.fieldName );
  return function put( val )
  {
    this[ symbol ] = val;
    return val;
  }
}

symbolPut_functor.defaults =
{
  fieldName : null,
}

symbolPut_functor.rubrics = [ 'accessor', 'put', 'functor' ];

//

function toElementGet_functor( o )
{
  _.assert( 0, 'not tested' );
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.objectIs( o.names ) );
  _.assert( _.strIs( o.name ) );
  _.assert( _.strIs( o.storageName ) );
  _.assert( _.numberIs( o.index ) );
  _.routineOptions( toElementGet_functor, o );

  debugger;

  let index = o.index;
  let storageName = o.storageName;
  let name = o.name;
  let aname = _.accessor._propertyGetterSetterNames( name );

  _.assert( _.numberIs( index ) );
  _.assert( index >= 0 );

  return function accessorToElementGet()
  {
    return this[ storageName ][ index ];
  }
}

toElementGet_functor.defaults =
{
  name : null,
  index : null,
  storageName : null,
}

//

function withSymbolGet_functor( o ) /* xxx : deprecate in favor of toValueGet_functor */
{

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.routineOptions( withSymbolGet_functor, o );
  _.assert( _.strDefined( o.fieldName ) );

  let spaceName = o.fieldName;
  let setter = Object.create( null );
  let getter = Object.create( null );
  let symbol = Symbol.for( spaceName );

  return function toStructure()
  {
    let helper = this[ symbol ];
    if( !helper )
    {
      helper = this[ symbol ] = proxyMake( this );
    }
    return helper;
  }

  /* */

  function proxyMake( original )
  {
    let handlers =
    {
      get( original, fieldName, proxy )
      {
        let method = getter[ fieldName ];
        if( method )
        return end();

        if( fieldName === spaceName )
        {
          method = getter[ fieldName ] = function get( value )
          {
            return undefined;
          }
          return end();
        }

        let symbol = _.symbolIs( fieldName ) ? fieldName : Symbol.for( fieldName );
        method = getter[ fieldName ] = function get( value )
        {
          return this[ symbol ];
        }
        return end();

        function end()
        {
          return method.call( original );
        }

      },
      set( original, fieldName, value, proxy )
      {
        let method = setter[ fieldName ];
        if( method )
        return end();

        let symbol = _.symbolIs( fieldName ) ? fieldName : Symbol.for( fieldName );
        method = setter[ fieldName ] = function put( value )
        {
          this[ symbol ] = value;
        }
        return end();

        function end()
        {
          method.call( original, value );
          return true;
        }
      },
    };

    let proxy = new Proxy( original, handlers );

    return proxy;
  }

}

withSymbolGet_functor.defaults =
{
  fieldName : null,
}

withSymbolGet_functor.rubrics = [ 'accessor', 'getter', 'functor' ];

//

function toStructureGet_functor( o ) /* xxx : deprecate in favor of toValueGet_functor */
{

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.routineOptions( toStructureGet_functor, o );
  _.assert( _.strDefined( o.fieldName ) );

  let spaceName = o.fieldName;
  let setter = Object.create( null );
  let getter = Object.create( null );
  let symbol = Symbol.for( spaceName );

  return function toStructure()
  {
    let helper = this[ symbol ];
    if( !helper )
    {
      helper = this[ symbol ] = proxyMake( this );
    }
    return helper;
  }

  /* */

  function proxyMake( original )
  {
    let handlers =
    {
      get( original, fieldName, proxy )
      {
        let method = getter[ fieldName ];
        if( method )
        return end();

        if( fieldName === spaceName )
        {
          method = getter[ fieldName ] = function get( value )
          {
            return undefined;
          }
          return end();
        }

        let symbol = _.symbolIs( fieldName ) ? fieldName : Symbol.for( fieldName );
        if( original.hasField( fieldName ) || Object.hasOwnProperty.call( original, symbol ) )
        {
          // debugger;
          method = getter[ fieldName ] = function get( value )
          {
            // debugger;
            return this[ symbol ];
          }
          return end();
        }

        method = getter[ fieldName ] = function get( value )
        {
          return this[ fieldName ];
        }
        return end();

        function end()
        {
          return method.call( original );
        }

      },
      set( original, fieldName, value, proxy )
      {
        let method = setter[ fieldName ];
        if( method )
        return end();

        let putName1 = '_' + fieldName + 'Put';
        if( original[ putName1 ] )
        {
          method = setter[ fieldName ] = function put( value )
          {
            return this[ putName1 ]( value );
          }
          return end();
        }

        let putName2 = fieldName + 'Put';
        if( original[ putName2 ] )
        {
          method = setter[ fieldName ] = function put( value )
          {
            return this[ putName2 ]( value );
          }
          return end();
        }

        let symbol = _.symbolIs( fieldName ) ? fieldName : Symbol.for( fieldName );
        if( original.hasField( fieldName ) || Object.hasOwnProperty.call( original, symbol ) )
        {
          method = setter[ fieldName ] = function put( value )
          {
            this[ symbol ] = value;
          }
          return end();
        }

        method = setter[ fieldName ] = function put( value )
        {
          this[ fieldName ] = value;
        }

        return end();

        function end()
        {
          method.call( original, value );
          return true;
        }
      },
    };

    let proxy = new Proxy( original, handlers );

    return proxy;
  }

}

toStructureGet_functor.defaults =
{
  fieldName : null,
}

toStructureGet_functor.rubrics = [ 'accessor', 'getter', 'functor' ];

//

function toValueGet_functor( o )
{

  _.routineOptions( toValueGet_functor, o );
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strDefined( o.fieldName ) );
  _.assert( _.longHas( [ 'get', 'suite' ], o.accessorKind ) );

  let spaceName = o.fieldName;
  let setter = Object.create( null );
  let getter = Object.create( null );
  let symbol = Symbol.for( spaceName );

  if( o.accessor.configurable === null )
  o.accessor.configurable = 1;
  let configurable = o.accessor.configurable;
  if( configurable === null )
  configurable = _.accessor.AccessorPreferences.configurable;
  _.assert( _.boolLike( configurable ) );

  if( o.accessorKind === 'suite' )
  {
    let result =
    {
      get : toValueGet_functor,
      set : false,
      put : false,
    }
    return result;
  }

  return function toStructure()
  {
    let helper;

    if( configurable )
    {
      helper = proxyMake( this );
      let o2 =
      {
        enumerable : false,
        configurable : false,
        value : helper
      }
      Object.defineProperty( this, spaceName, o2 );
    }
    else
    {
      helper = this[ symbol ];
      if( !helper )
      {
        helper = this[ symbol ] = proxyMake( this );
      }
    }

    return helper;
  }

  /* */

  function proxyMake( original )
  {
    let handlers =
    {
      get( original, fieldName, proxy )
      {
        let method = getter[ fieldName ];
        if( method )
        return end();

        if( fieldName === spaceName )
        {
          method = getter[ fieldName ] = function get( value )
          {
            return undefined;
          }
          return end();
        }

        if( _.symbolIs( fieldName ) )
        {
          let symbol = fieldName;
          method = getter[ fieldName ] = function get( value )
          {
            return this[ symbol ];
          }
          return end();
        }

        let getName1 = '_' + fieldName + 'Get';
        let getName2 = '' + fieldName + 'Get';

        if( _.routineIs( original[ getName1 ] ) )
        {
          method = getter[ fieldName ] = function get()
          {
            return this[ getName1 ]();
          }
          return end();
        }

        if( _.routineIs( original[ getName2 ] ) )
        {
          method = getter[ fieldName ] = function get()
          {
            return this[ getName2 ]();
          }
          return end();
        }

        let symbol = Symbol.for( fieldName );
        method = getter[ fieldName ] = function get()
        {
          return this[ symbol ];
        }
        return end();

        function end()
        {
          return method.call( original );
        }

      },
      set( original, fieldName, value, proxy )
      {
        let method = setter[ fieldName ];
        if( method )
        return end();

        let putName1 = '_' + fieldName + 'Put';
        if( original[ putName1 ] )
        {
          method = setter[ fieldName ] = function put( value )
          {
            return this[ putName1 ]( value );
          }
          return end();
        }

        let putName2 = fieldName + 'Put';
        if( original[ putName2 ] )
        {
          method = setter[ fieldName ] = function put( value )
          {
            return this[ putName2 ]( value );
          }
          return end();
        }

        let symbol = _.symbolIs( fieldName ) ? fieldName : Symbol.for( fieldName );
        method = setter[ fieldName ] = function put( value )
        {
          this[ symbol ] = value;
        }

        return end();

        function end()
        {
          method.call( original, value );
          return true;
        }
      },
    };

    let proxy = new Proxy( original, handlers );

    return proxy;
  }

}

toValueGet_functor.defaults =
{
  fieldName : null,
  accessor : null,
  accessorKind : null,
}

toValueGet_functor.rubrics = [ 'accessor', 'suite', 'getter', 'functor' ];

//

let toElementSuite = _.accessor.suiteMakerFrom_functor( toElementGet_functor, toElementSet_functor );

//

/**
 * Makes a setter that is an alias for other property.
 * @param {Object} o - options map
 * @param {Object} o.original - name of source property
 * @param {Object} o.alias - name of alias
 * @returns {Function} Returns setter function.
 * @function alias
 * @namespace Tools.accessor.setter
 */

function alias_pre( routine, args )
{

  let o = args[ 0 ];
  if( _.strIs( args[ 0 ] ) )
  o = { originalName : args[ 0 ] }

  _.routineOptions( routine, o );

  _.assert( args.length === 1, 'Expects single argument' );
  _.assert( _.strIs( o.originalName ) );

  return o;
}

//

function aliasSetter_functor_body( o )
{
  let container = o.container;
  let originalName = o.originalName;

  _.assertRoutineOptions( aliasSetter_functor_body, arguments );

  if( _.strIs( container ) )
  return function aliasSet( src )
  {
    let self = this;
    self[ container ][ originalName ] = src;
    return self[ container ][ originalName ];
  }
  else if( _.objectLike( container ) || _.routineLike( container ) )
  return function aliasSet( src )
  {
    let self = this;
    return container[ originalName ] = src;
  }
  else if( container === null )
  return function aliasSet( src )
  {
    let self = this;
    self[ originalName ] = src;
    return self[ originalName ];
  }
  else _.assert( 0, `Unknown type of container ${_.strType( container )}` );

}

aliasSetter_functor_body.defaults =
{
  container : null,
  originalName : null,
  // aliasName : null,
  // fieldName : null,
}

let aliasSet_functor = _.routineFromPreAndBody( alias_pre, aliasSetter_functor_body );

//

/**
 * Makes a getter that is an alias for other property.
 * @param {Object} o - options map
 * @param {Object} o.original - name of source property
 * @param {Object} o.alias - name of alias
 * @returns {Function} Returns getter function.
 * @function alias
 * @namespace Tools.accessor.getter
 */

function aliasGet_functor_body( o )
{

  let container = o.container;
  let originalName = o.originalName;
  // let aliasName = o.aliasName;

  _.assertRoutineOptions( aliasGet_functor_body, arguments );

  if( _.strIs( container ) )
  return function aliasGet( src )
  {
    let self = this;
    return self[ container ][ originalName ];
  }
  else if( _.objectLike( container ) || _.routineLike( container ) )
  return function aliasGet( src )
  {
    let self = this;
    return container[ originalName ];
  }
  else if( container === null )
  return function aliasGet( src )
  {
    let self = this;
    return self[ originalName ];
  }
  else _.assert( 0, `Unknown type of container ${_.strType( container )}` );

}

aliasGet_functor_body.defaults = Object.create( aliasSet_functor.defaults );

let aliasGetter_functor = _.routineFromPreAndBody( alias_pre, aliasGet_functor_body );

//

let aliasSuite = _.accessor.suiteMakerFrom_functor( aliasGetter_functor, aliasSet_functor );

// --
// relations
// --

let Getter =
{

  alias : aliasGetter_functor,
  toElement : toElementGet_functor,
  toStructure : toStructureGet_functor,
  toValue : toValueGet_functor,
  withSymbol : withSymbolGet_functor,

}

//

let Setter =
{

  mapCollection : setterMapCollection_functor,
  arrayCollection : setterArrayCollection_functor,

  own : setterOwn_functor,
  friend : setterFriend_functor,
  copyable : setterCopyable_functor,
  bufferFrom : setterBufferFrom_functor,
  changesTracking : setterChangesTracking_functor,

  alias : aliasSet_functor,
  toElement : toElementSet_functor,

}

//

let Putter =
{

  symbol : symbolPut_functor,

}

//

let Suite =
{

  toElement : toElementSuite,
  alias : aliasSuite,
  toValue : toValueGet_functor,

}

// --
// extend
// --

_.accessor.getter = _.accessor.getter || Object.create( null );
_.mapExtend( _.accessor.getter, Getter );

_.accessor.setter = _.accessor.setter || Object.create( null );
_.mapExtend( _.accessor.setter, Setter );

_.accessor.putter = _.accessor.putter || Object.create( null );
_.mapExtend( _.accessor.putter, Putter );

_.accessor.suite = _.accessor.suite || Object.create( null );
_.mapExtend( _.accessor.suite, Suite );

_.accessor.define.getter = _.accessor._DefinesGenerate( _.accessor.define.getter || null, _.accessor.getter, 'getter' );
_.accessor.define.setter = _.accessor._DefinesGenerate( _.accessor.define.setter || null, _.accessor.setter, 'setter' );
_.accessor.define.putter = _.accessor._DefinesGenerate( _.accessor.define.putter || null, _.accessor.putter, 'putter' );
_.accessor.define.suite = _.accessor._DefinesGenerate( _.accessor.define.suite || null, _.accessor.suite, 'accessor' );

_.assert( _.routineIs( _.accessor.define.getter.alias ) );

// --
// export
// --

if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;

})();
