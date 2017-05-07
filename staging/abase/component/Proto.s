( function _Proto_s_() {

'use strict';

/**
* Definitions :

*  self :: current object.
*  Self :: current class.
*  Parent :: parent class.
*  Statics :: static fields.
*  extend :: extend destination with all properties from source.
*  supplement :: supplement destination with those properties from source which do not belong to source.

*  routine :: arithmetical,logical and other manipulations on input data, context and globals to get output data.
*  function :: routine which does not have side effects and don't use globals or context.
*  procedure :: routine which use globals, possibly modify global's states.
*  method :: routine which has context, possibly modify context's states.

* Synonym :

  A composes B
    :: A consists of B.
    :: A comprises B.
    :: A made up of B.
    :: A exists because of B, and B exists because of A.
    :: A складається із B.
  A aggregates B
    :: A has B.
    :: A exists because of B, but B exists without A.
    :: A має B.
  A associate B
    :: A has link on B
    :: A is linked with B
    :: A посилається на B.
  A restricts B
    :: A use B.
    :: A has occasional relation with B.
    :: A використовує B.
    :: A має обмежений, не чіткий, тимчасовий звязок із B.

*/

if( typeof module !== 'undefined' )
{

  if( typeof wBase === 'undefined' )
  try
  {
    require( '../../abase/akernel/aKernel.s' );
  }
  catch( err )
  {
    require( 'wTools' );
  }

  if( !wTools.nameFielded )
  try
  {
    require( './NameTools.s' );
  }
  catch( err )
  {
  }

}

var Self = wTools;
var _ = wTools;

var _hasOwnProperty = Object.hasOwnProperty;
var _assert = _.assert;
var _nameFielded = _.nameFielded;

_.assert( _.objectIs( _.filter ),'wProto needs wTools/staging/abase/akernel/FieldMapper.s' );
_.assert( _.routineIs( _nameFielded ),'wProto needs wTools/staging/abase/component/NameTools.s' );

// --
// property
// --

/* !!! no need to make examples for private routines */

/**
 * Generates options object for _accessor, _accessorForbid functions.
 * Can be called in three ways:
 * - First by passing all options in one object;
 * - Second by passing object and name options;
 * - Third by passing object,names and message option as third parameter.
 * @param {wTools~accessorOptions} o - options {@link wTools~accessorOptions}.
 *
 * @example
 * //returns
 * // { object: [Function],
 * // methods: [Function],
 * // names: { a: 'a', b: 'b' },
 * // message: [ 'set/get call' ] }
 *
 * var Self = function ClassName() { };
 * _._accessorOptions( Self,{ a : 'a', b : 'b' }, 'set/get call' );
 *
 * @private
 * @method _accessorOptions
 * @memberof wTools
 */

function _accessorOptions( object,names )
{
  var o = arguments.length === 1 ? arguments[ 0 ] : Object.create( null );

  if( arguments.length === 1 )
  {
    object = o.object;
    names = o.names;
  }
  else
  {
    o.object = object;
  }

  if( !o.methods )
  o.methods = object;
  else
  o.methods = _.mapExtend( null,o.methods );

  var names = o.names = _nameFielded( names );

  if( arguments.length > 2 )
  {
    o.message = _.arraySlice( arguments,2 );
  }

  return o;
}

//

function _accessorRegister( o )
{

  _.routineOptions( _accessorRegister,o );
  // _.assert( _hasOwnProperty.call( o.proto,'_Accessors' ),'_accessorRegister : proto should has _Accessors map' );

  _.protoMakeOwnDescendant( o.proto,'_Accessors' );
  // if( !o.proto._Accessors )
  // o.proto._Accessors = Object.create( null );
  var accessors = o.proto._Accessors;

  if( o.combining && o.combining !== 'rewrite' )
  debugger;

  if( Config.debug )
  if( !o.combining )
  {
    var stack = accessors[ o.name ] ? accessors[ o.name ].stack : '';
    _.assert
    (
      !accessors[ o.name ],
      'defined at' + '\n',
      stack,
      '\naccessor',o.name,'of',o.proto.constructor.name
    );
    if( accessors[ o.name ] )
    debugger;
  }

  _.assert( !o.combining || o.combining === 'rewrite' || o.combining === 'append', 'not supported ( o.combinng )',o.combinng );
  _.assert( _.strIs( o.name ) );

  var descriptor =
  {
    name : o.name,
    declaratorName : o.declaratorName,
    declaratorArgs : o.declaratorArgs,
    declaratorKind : o.declaratorKind,
    combining : o.combining,
  }

  if( Config.debug )
  descriptor.stack = _.diagnosticStack();

  if( o.combining === 'append' )
  {
    if( _.arrayIs( accessors[ o.name ] ) )
    accessors[ o.name ].push( descriptor );
    else
    accessors[ o.name ] = [ descriptor ];
  }

  accessors[ o.name ] = descriptor;

  return descriptor;
}

_accessorRegister.defaults =
{
  name : null,
  proto : null,
  declaratorName : null,
  declaratorArgs : null,
  declaratorKind : null,
  combining : 0,
}

//

/**
 * Accessor options
 * @typedef{object} wTools~accessorOptions
 * @property{object} [ object=null ] - source object wich properties will get getter/setter defined.
 * @property{object} [ names=null ] - properties of that object represent names of fields for wich function defines setter/getter.
 * Function uses values( rawName ) of object( o.names ) properties to check if fields of( o.object ) have setter/getter.
 * Example: if( rawName ) is 'a', function searchs for '_aSet' or 'aSet' and same for getter.
 * @property{object} [ methods=null ] - object where function searchs for existing setter/getter of property.
 * @property{array} [ message=null ] - setter/getter prints this message when called.
 * @property{boolean} [ strict=true ] - makes object field private if no getter defined but object must have own constructor.
 * @property{boolean} [ enumerable=true ] - sets property descriptor enumerable option.
 * @property{boolean} [ preserveValues=true ] - saves values of existing object properties.
 * @property{boolean} [ readOnly=false ] - if true function doesn't define setter to property.
 **/

/**
 * Defines set/get functions on source object( o.object ) properties if they dont have them.
 * If property specified by( o.names ) doesn't exist on source( o.object ) function creates it.
 * If ( o.object.constructor.prototype ) has property with getter defined function forbids set/get access
 * to object( o.object ) property. Field can be accessed by use of Symbol.for( rawName ) function,
 * where( rawName ) is value of property from( o.names ) object.
 *
 * @param {wTools~accessorOptions} o - options {@link wTools~accessorOptions}.
 *
 * @example
 * var Self = function ClassName() { };
 * var o = _._accessorOptions( Self, { a : 'a', b : 'b' }, [ 'set/get call' ] );
 * _._accessor( o );
 * Self.a = 1; // returns [ 'set/get call' ]
 * Self.b = 2; // returns [ 'set/get call' ]
 * console.log( Self.a );
 * // returns [ 'set/get call' ]
 * // 1
 * console.log( Self.b );
 * // returns [ 'set/get call' ]
 * // 2
 *
 * @private
 * @method _accessor
 * @throws {exception} If( o.object ) is not a Object.
 * @throws {exception} If( o.names ) is not a Object.
 * @throws {exception} If( o.methods ) is not a Object.
 * @throws {exception} If( o.message ) is not a Array.
 * @throws {exception} If( o ) is extented by unknown property.
 * @throws {exception} If( o.strict ) is true and object doesn't have own constructor.
 * @throws {exception} If( o.readOnly ) is true and property has own setter.
 * @memberof wTools
 */

function _accessor( o )
{

  /* verification */

  _assert( !_.atomicIs( o.object ) );
  _assert( !_.atomicIs( o.methods ) );
  _assert( !o.message || _.arrayIs( o.message ) );
  _.assertMapHasOnly( o,_accessor.defaults );
  _.mapComplement( o,_accessor.defaults );

  if( o.strict /*&& o.preserveValues*/ )
  {

    var has =
    {
      constructor : 'constructor',
    }

    _.assertMapOwnAll( o.object,has );
    _.accessorForbid
    ({
      object : o.object,
      names : ClassForbiddenFacility,
      prime : 0,
      strict : 0,
    });

  }

  _assert( _.objectLikeOrRoutine( o.object ),'_.accessor :','expects object ( object ), but got', o.object );
  _assert( _.objectIs( o.names ),'_.accessor :','expects object ( names ), but got', o.names );

  /* */

  for( var n in o.names )
  {

    _accessorProperty( o,n );

  }

}

_accessor.defaults =
{

  object : null,
  names : null,
  methods : null,
  message : null,

  strict : 1,
  enumerable : 1,
  preserveValues : 1,
  readOnly : 0,

  prime : 1,

  //rewriting : 0,
  combining : 0,

}

//

function _accessorProperty( o,name )
{

  _.assert( arguments.length === 2 );

  var encodedName = name;
  var rawName = name;
  var appending = 0;

  if( o.combining === 'append' )
  debugger;

  /* */

  var propertyDescriptor = _.accessorDescriptorGet( o.object,encodedName );
  if( propertyDescriptor.descriptor )
  {

    _.assert
    (
      o.combining,
      'overridin of property',encodedName + '\n' +
      '( o.combining ) suppose to be',Combining.join(),'if accessor overided'
    );

    _.assert( o.combining === 'rewrite' || o.combining === 'append' || o.combining === 'supplement','not implemented' );

    if( o.combining === 'supplement' )
    return;

    if( o.combining === 'append' )
    {

      debugger;

      if( o.methods[ '_' + rawName + 'Set' ] === propertyDescriptor.descriptor.set )
      o.methods[ '_' + rawName + 'Set' ] = null;
      if( o.methods[ rawName + 'Set' ] === propertyDescriptor.descriptor.set )
      o.methods[ rawName + 'Set' ] = null;
      if( o.methods[ '_' + rawName + 'Get' ] === propertyDescriptor.descriptor.get )
      o.methods[ '_' + rawName + 'Get' ] = null;
      if( o.methods[ rawName + 'Get' ] === propertyDescriptor.descriptor.get )
      o.methods[ rawName + 'Get' ] = null;

      var settrGetterSecond = _accessorSetterGetterMake( o,o.methods,rawName );

      if( o.methods[ '_' + rawName + 'Set' ] )
      o.methods[ '_' + rawName + 'Set' ] = null;
      if( o.methods[ rawName + 'Set' ] )
      o.methods[ rawName + 'Set' ] = null;
      if( o.methods[ '_' + rawName + 'Get' ] )
      o.methods[ '_' + rawName + 'Get' ] = null;
      if( o.methods[ rawName + 'Get' ] )
      o.methods[ rawName + 'Get' ] = null;

      o.methods[ '_' + rawName + 'Set' ] = function appendingSet( src )
      {
        debugger;
        src = propertyDescriptor.descriptor.set.call( this,src );
        _.assert( src !== undefined );
        return settrGetterSecond.set.call( this,src );
      }

      o.methods[ '_' + rawName + 'Get' ] = settrGetterSecond.get;

      appending = 1;
    }

  }

  /* */

  if( o.prime )
  {

    var optionsForRegister = _.mapExtend( null,o );
    optionsForRegister.names = encodedName;
    if( optionsForRegister.methods === optionsForRegister.object )
    optionsForRegister.methods = Object.create( null );
    optionsForRegister.object = null;

    // if( rawName === 'data' )
    // debugger;

    if( !optionsForRegister.methods[ '_' + rawName + 'Get' ] && !optionsForRegister.methods[ rawName + 'Get' ] )
    optionsForRegister.methods[ '_' + rawName + 'Get' ] = o.object[ '_' + name + 'Get' ] ? o.object[ '_' + name + 'Get' ] : o.object[ name + 'Get' ];

    if( !optionsForRegister.methods[ '_' + rawName + 'Set' ] && !optionsForRegister.methods[ rawName + 'Set' ] )
    optionsForRegister.methods[ '_' + rawName + 'Set' ] = o.object[ '_' + name + 'Set' ] ? o.object[ '_' + name + 'Set' ] : o.object[ name + 'Set' ];

    _._accessorRegister
    ({
      proto : o.object,
      name : encodedName,
      declaratorName : null,
      declaratorArgs : [ optionsForRegister ],
      combining : o.combining,
    });

  }

  /* */

  var settrGetter = _accessorSetterGetterMake( o,o.methods,rawName );
  var fieldName = '_' + rawName;
  var fieldSymbol = Symbol.for( rawName );

  if( o.preserveValues )
  if( _hasOwnProperty.call( o.object,encodedName ) )
  o.object[ fieldSymbol ] = o.object[ encodedName ];

  /* define accessor */

  Object.defineProperty( o.object, encodedName,
  {
    set : settrGetter.set,
    get : settrGetter.get,
    enumerable : !!o.enumerable,
    configurable : o.combining === 'append',
  });

  /* define private field */

  if( o.strict && !propertyDescriptor.descriptor )
  {

    var m =
    [
      'use Symbol.for( \'' + rawName + '\' ) ',
      'to get direct access to property\'s field, ',
      'not ' + fieldName,
    ].join( '' );

    _.accessorForbid
    ({
      object : o.object,
      names : fieldName,
      message : [ m ],
      prime : 0,
      strict : 0,
    });

  }

}

//

function _accessorSetterGetterMake( o,object,name )
{
  var result = Object.create( null );

  _.assert( arguments.length === 3 );
  _.assert( _.objectLikeOrRoutine( object ) );
  _.assert( _.strIs( name ) );

  result.set = object[ name + 'Set' ] ? object[ name + 'Set' ] : object[ '_' + name + 'Set' ];
  result.get = object[ name + 'Get' ] ? object[ name + 'Get' ] : object[ '_' + name + 'Get' ];

  var fieldName = '_' + name;
  var fieldSymbol = Symbol.for( name );

  if( o.preserveValues )
  if( _hasOwnProperty.call( o.object,name ) )
  o.object[ fieldSymbol ] = o.object[ name ];

  /* set */

  if( !result.set && !o.readOnly )
  if( o.message )
  result.set = function set( src )
  {
    console.info.apply( console,o.message );
    this[ fieldSymbol ] = src;
    return src;
  }
  else
  result.set = function set( src )
  {
    this[ fieldSymbol ] = src;
    return src;
  }

  _assert( !result.set || !o.readOnly,'accessor :','readOnly but settter found in',o.object );

  /* get */

  if( !result.get )
  if( o.message )
  result.get = function get()
  {
    console.info.apply( console,o.message );
    return this[ fieldSymbol ];
  }
  else
  result.get = function get()
  {
    return this[ fieldSymbol ];
  }

  /* return */

  return result;
}

//

function _accessorSetterGetterGet( object,name )
{
  var result = Object.create( null );

  _.assert( arguments.length === 2 );
  _.assert( _.objectIs( object ) );
  _.assert( _.strIs( name ) );

  result.setName = object[ name + 'Set' ] ? name + 'Set' : '_' + name + 'Set';
  result.getName = object[ name + 'Get' ] ? name + 'Get' : '_' + name + 'Get';

  result.set = object[ result.setName ];
  result.get = object[ result.getName ];

  return result;
}

//

/**
 * Short-cut for _accessor function.
 * Defines set/get functions on source object( o.object ) properties if they dont have them.
 * For more details @see {@link wTools._accessor }.
 * Can be called in three ways:
 * - First by passing all options in one object( o );
 * - Second by passing ( object ) and ( names ) options;
 * - Third by passing ( object ), ( names ) and ( message ) option as third parameter.
 *
 * @param {wTools~accessorOptions} o - options {@link wTools~accessorOptions}.
 *
 * @example
 * var Self = function ClassName() { };
 * _.accessor( Self,{ a : 'a' }, 'set/get call' )
 * Self.a = 1; // set/get call
 * Self.a;
 * // returns
 * // set/get call
 * // 1
 *
 * @method accessor
 * @memberof wTools
 */

function accessor( object,names )
{
  var o = _accessorOptions.apply( this,arguments );
  return _accessor( o );
}

//

function accessorForbid( object,names )
{
  var o = _accessorOptions.apply( this,arguments );
  var object = o.object;
  var names = _.mapExtend( null,o.names );

  if( o.combining === 'rewrite' && o.strict === undefined )
  o.strict = 0;

  /* verification */

  _assert( _.objectLikeOrRoutine( object ),'_.accessor :','expects object as argument but got', object );
  _assert( _.objectIs( names ),'_.accessor :','expects object names as argument but got', names );
  _.assertMapHasOnly( o,accessorForbid.defaults );
  _.mapComplement( o,accessorForbid.defaults );

  /* message */

  var _constructor = object.constructor || Object.getPrototypeOf( object );
  _assert( _.routineIs( _constructor ) || _constructor === null );
  _assert( _constructor === null || _constructor.name || _constructor._name,'accessorForbid :','object should have name' );
  var protoName = ( _constructor ? ( _constructor.name || _constructor._name || '' ) : '' ) + '.';
  var message = 'is deprecated';
  if( o.message )
  message = o.message.join( ' : ' );

  /* property */

  var methods = Object.create( null );
  for( var n in names )
  {

    var encodedName = n;
    var rawName = names[ n ];

    var setterName = '_' + rawName + 'Set';
    var getterName = '_' + rawName + 'Get';

    (function _accessorForbid()
    {

      var messageLine = protoName + rawName + ' : ' + message;
      var handler = function forbidden()
      {
        debugger;
        throw _.err( messageLine );
      }

      handler.isForbid = true;

      methods[ setterName ] = handler;
      methods[ getterName ] = handler;

      /* */

      var propertyDescriptor = _.accessorDescriptorGet( o.object,encodedName );
      if( propertyDescriptor.descriptor )
      {
        _.assert( o.combining,'accessorForbid : if accessor overided expect ( o.combining ) is',Combining.join() );

        if( _.routineIs( propertyDescriptor.descriptor.get ) && propertyDescriptor.descriptor.get.name === 'forbidden' )
        {
          delete names[ n ];
          return;
        }

      }

      if( o.strict )
      if( _hasOwnProperty.call( object,encodedName ) )
      {
        var descriptor = Object.getOwnPropertyDescriptor( object,encodedName );
        if( _.routineIs( descriptor.get ) && descriptor.get.isForbid )
        {
          delete names[ n ];
          return;
        }
        else
        handler();
      }

      if( !Object.isExtensible( object ) )
      {
        delete names[ n ];
      }

    })();

  }

  // o.preserveValues = 0;
  // o.strict = 0;
  // o.enumerable = false;

  o.names = names;
  o.object = object;
  o.methods = methods;
  o.strict = 0;

  return _accessor( _.mapScreen( _accessor.defaults,o ) );
}

accessorForbid.defaults =
{
  preserveValues : 0,
  strict : 1,
  enumerable : 0,
  prime : 0,
  //override : 0,
  //allowMultiple : 1,
  //rewriting : 1,
  combining : 'rewrite',
}

accessorForbid.defaults.__proto__ = _accessor.defaults;

//

function accessorReadOnly( object,names )
{
  var o = _accessorOptions.apply( this,arguments );
  o.readOnly = true;
  return _accessor( o );
}

//

function accessorsSupplement( dst,src )
{

  _.protoMakeOwnDescendant( dst,'_Accessors' );

  _.assert( arguments.length === 2 );
  _.assert( _hasOwnProperty.call( dst,'_Accessors' ),'accessorsSupplement : dst should has _Accessors map' );
  _.assert( _hasOwnProperty.call( src,'_Accessors' ),'accessorsSupplement : src should has _Accessors map' );

  /* */

  function supplement( accessor )
  {

    _.assert( _.arrayIs( accessor.declaratorArgs ) );
    _.assert( !accessor.combining || accessor.combining === 'rewrite' || accessor.combining === 'append','not implemented' );

    //if( accessor.combining !== 'append' && accessor.combining !== 'prepend' )
    if( _.objectIs( dst._Accessors[ a ] ) )
    return;

    // console.log( 'accessorsSupplement',a );

    if( accessor.declaratorName )
    {
      _.assert( _.routineIs( dst[ accessor.declaratorName ] ),'dst does not have accessor maker',accessor.declaratorName );
      dst[ accessor.declaratorName ].apply( dst,accessor.declaratorArgs );
    }
    else
    {
      _.assert( accessor.declaratorArgs.length === 1 );
      var optionsForAccessor = _.mapExtend( null,accessor.declaratorArgs[ 0 ] );
      optionsForAccessor.object = dst;
      if( !optionsForAccessor.methods )
      optionsForAccessor.methods = dst;
      _.accessor( optionsForAccessor );
    }

  }

  /* */

  // debugger;
  for( var a in src._Accessors )
  {

    var accessor = src._Accessors[ a ];

    if( _.objectIs( accessor ) )
    supplement( accessor );
    else for( var i = 0 ; i < accessor.length ; i++ )
    supplement( accessor[ i ] );

  }
  // debugger;

}

//

/**
 * Makes constants properties on object by creating new or replacing existing properties.
 * @param {object} dstProto - prototype of class which will get new constant property.
 * @param {object} namesObject - name/value map of constants.
 *
 * @example
 * var Self = function ClassName() { };
 * var Constants = { num : 100  };
 * _.constant ( Self.prototype,Constants );
 * console.log( Self.prototype ); // returns { num: 100 }
 * Self.prototype.num = 1;// error assign to read only property
 *
 * @method constant
 * @throws {exception} If no argument provided.
 * @throws {exception} If( dstProto ) is not a Object.
 * @throws {exception} If( namesObject ) is not a Map.
 * @memberof wTools
 */

function constant( dstProto,namesObject )
{

  _assert( arguments.length === 2 );
  _assert( _.objectLikeOrRoutine( dstProto ),'_.constant :','dstProto is needed :', dstProto );
  _assert( _.mapIs( namesObject ),'_.constant :','namesObject is needed :', namesObject );

  for( var n in namesObject )
  {

    var encodedName = n;
    var value = namesObject[ n ];

    Object.defineProperty( dstProto, encodedName,
    {
      value : value,
      enumerable : true,
      writable : false,
    });

  }

}

//

/**
 * Makes properties of object( dstProto ) read only without changing their values. Uses properties names from argument( namesObject ).
 * Sets undefined for property that not exists on source( dstProto ).
 * @param {object} dstProto - prototype of class which properties will get read only state.
 * @param {object|string} namesObject - property name as string/map with properties.
 *
 * @example
 * var Self = function ClassName() { };
 * Self.prototype.num = 100;
 * var ReadOnly = { num : null, num2 : null  };
 * _.restrictReadOnly ( Self.prototype,ReadOnly );
 * console.log( Self.prototype ); // returns { num: 100, num2: undefined }
 * Self.prototype.num2 = 1; // error assign to read only property
 *
 * @method restrictReadOnly
 * @throws {exception} If no argument provided.
 * @throws {exception} If( dstProto ) is not a Object.
 * @throws {exception} If( namesObject ) is not a Map.
 * @memberof wTools
 */

function restrictReadOnly( dstProto,namesObject )
{

  if( _.strIs( namesObject ) )
  {
    namesObject = Object.create( null );
    namesObject[ namesObject ] = namesObject;
  }

  _assert( arguments.length === 2 );
  _assert( _.objectLikeOrRoutine( dstProto ),'_.constant :','dstProto is needed :', dstProto );
  _assert( _.mapIs( namesObject ),'_.constant :','namesObject is needed :', namesObject );

  for( var n in namesObject )
  {

    var encodedName = n;
    var value = namesObject[ n ];

    Object.defineProperty( dstProto, encodedName,
    {
      value : dstProto[ n ],
      enumerable : true,
      writable : false,
    });

  }

}

//

/**
 * Mixin methods and fields into prototype of another object.
 * @param {object} o - options.
 * @method mixin
 * @memberof wTools#
 */

function mixin( o )
{

  var dst = o.dst;
  var mixinDefaults =
  {
    name : null,
    nameShort : null,
    mixin : null,
    Extend : null,
    Supplement : null,
    Functor : null,
  }

  _assert( arguments.length === 1 );
  _assert( _.objectIs( dst ),'mixin : expects dst object, but got',_.strTypeOf( dst ) );
  _assert( _.routineIs( o.mixin.mixin ),'expects ( o.mixin ), but got not mixin',_.strTypeOf( o.mixin ) );
  _assert( _.strIs( o.mixin.name ) );
  _assert( _.mapIs( o.mixin.Extend ) || o.mixin.Extend === undefined || o.mixin.Extend === null );
  _assert( _.mapIs( o.mixin.Supplement ) || o.mixin.Supplement === undefined || o.mixin.Supplement === null );
  _.assertMapHasOnly( o,mixin.defaults );
  _.assertMapOwnOnly( o.mixin,mixinDefaults );

  /* mixin into routine */

  if( !_.mapIs( dst ) )
  {
    _assert( dst.constructor.prototype === dst,'mixin :','expects prototype with own constructor field' );
    _assert( dst.constructor.name.length || dst.constructor._name.length,'mixin :','constructor should has name' );
    _assert( _.routineIs( dst.init ) );
  }

  /* extend */

  _.assert( _.mapOwn( dst,'constructor' ) );
  _.assert( dst.constructor.prototype === dst );
  _.protoExtend
  ({
    constructor : dst.constructor,
    extend : o.mixin.Extend,
    supplement : o.mixin.Supplement,
  });

  /* functor */

  if( o.mixin.Functor )
  for( var m in o.mixin.Functor )
  dst[ m ] = o.mixin.Functor[ m ].call( o,dst[ m ] );

  /* field */

  if( !_hasOwnProperty.call( dst,'_mixins' ) )
  {
    dst._mixins = Object.create( dst._mixins || null );
  }

  _.assert( !dst._mixins[ o.mixin.name ],'attempt to mixin same mixin "' + o.mixin.name + '" several times into ' + dst.constructor.name );

  dst._mixins[ o.mixin.name ] = 1;

}

mixin.defaults =
{
  dst : null,
  mixin : null,
}

//

function mixinHas( _constructor,mixin )
{
  _assert( _.routineIs( _constructor ) );

  if( _.strIs( mixin ) )
  {
    return _constructor.prototype._mixins && _constructor.prototype._mixins[ mixin ];
  }
  else
  {
    _assert( _.routineIs( mixin.mixin ),'expects ( mixin ), but got not mixin',_.strTypeOf( mixin ) );
    _assert( _.strIsNotEmpty( mixin.name ),'expects ( mixin ), but got not mixin',_.strTypeOf( mixin ) );
    return _constructor.prototype._mixins && _constructor.prototype._mixins[ mixin.name ];
  }
}

//

/**
* Default options for _propertyAddOwnDefaults function
* @typedef {object} wTools~propertyAddOwnDefaults
* @property {object} [ o.facilityName=null ] - object that contains class relationship type name.
* Example : { Composes : 'Composes' }. See {@link wTools~ClassFacility}
* @property {object} [ o.dstProto=null ] - prototype of class which will get new constant property.
* @property {object} [ o.srcDefaults=null ] - name/value map of defaults.
* @property {bool} [ o.override=false ] - to override defaults if exist.
*/

/**
 * Adds own defaults to object. Creates new defaults container, if there is no such own.
 * @param {wTools~propertyAddOwnDefaults} o - options {@link wTools~propertyAddOwnDefaults}.
 * @private
 *
 * @example
 * var Self = function ClassName() { };
 * _._propertyAddOwnDefaults
 * ({
 *   facilityName : { Composes : 'Composes' },
 *   dstProto : Self.prototype,
 *   srcDefaults : { a : 1, b : 2 },
 *   override : false,
 * });
 * console.log( Self.prototype ); // returns { Composes: { a: 1, b: 2 } }
 *
 * @method _propertyAddOwnDefaults
 * @throws {exception} If no argument provided.
 * @throws {exception} If( o.srcDefaults ) is not a Object.
 * @throws {exception} If( o ) is extented by unknown property.
 * @memberof wTools
 */

function _propertyAddOwnDefaults( o )
{
  var o = o || Object.create( null );

  _assert( arguments.length === 1 );
  _assert( _.objectIs( o.srcDefaults ),'expects object ( o.srcDefaults ), got', _.strTypeOf( o.srcDefaults ) );
  _.routineOptions( _propertyAddOwnDefaults,o );

  o.facilityName = _.nameUnfielded( o.facilityName );

  // if( !_hasOwnProperty.call( o.dstProto,o.facilityName.coded ) )
  // {
  //   var facility = o.dstProto[ o.facilityName.coded ];
  //   o.dstProto[ o.facilityName.coded ] = Object.create( null );
  //   if( facility )
  //   Object.setPrototypeOf( o.dstProto[ o.facilityName.coded ], facility );
  // }

  _.protoMakeOwnDescendant( o.dstProto,o.facilityName.coded );

  var facility = o.dstProto[ o.facilityName.coded ];

  for( var n in o.srcDefaults )
  {

    if( o.override === false )
    if( n in facility )
    continue;

    facility[ n ] = o.srcDefaults[ n ];

  }

}

_propertyAddOwnDefaults.defaults =
{
  facilityName : null,
  dstProto : null,
  srcDefaults : null,
  override : false,
}

//

/**
 * Adds own defaults( Composes ) to object. Creates new defaults container, if there is no such own.
 * @param {array-like} arguments - for arguments details see {@link wTools~propertyAddOwnDefaults}.
 *
 * @example
 * var Self = function ClassName() { };
 * var Composes = { tree : null };
 * _.propertyAddOwnComposes( Self.prototype, Composes );
 * console.log( Self.prototype ); // returns { Composes: { tree: null } }
 *
 * @method propertyAddOwnComposes
 * @throws {exception} If no arguments provided.
 * @memberof wTools
 */

function propertyAddOwnComposes( dstProto,srcDefaults )
{

  _.assert( arguments.length === 2 );

  var facilityName = { Composes : 'Composes' };
  return _propertyAddOwnDefaults
  ({
    facilityName : facilityName,
    dstProto : dstProto,
    srcDefaults : srcDefaults,
    override : false,
  });

}

//

/**
 * Adds own aggregates to object. Creates new aggregates container, if there is no such own.
 * @param {array-like} arguments - for arguments details see {@link wTools~propertyAddOwnDefaults}.
 *
 * @example
 * var Self = function ClassName() { };
 * var Aggregates = { tree : null };
 * _.propertyAddOwnAggregates( Self.prototype, Aggregates );
 * console.log( Self.prototype ); // returns { Aggregates: { tree: null } }
 *
 * @method propertyAddOwnAggregates
 * @throws {exception} If no arguments provided.
 * @memberof wTools
 */

function propertyAddOwnAggregates( dstProto,srcDefaults )
{

  _.assert( arguments.length === 2 );

  var facilityName = { Aggregates : 'Aggregates' };
  return _propertyAddOwnDefaults
  ({
    facilityName : facilityName,
    dstProto : dstProto,
    srcDefaults : srcDefaults,
    override : false,
  });

}

//

/**
 * Adds own associates to object. Creates new associates container, if there is no such own.
 * @param {array-like} arguments - for arguments details see {@link wTools~propertyAddOwnDefaults}.
 *
 * @example
 * var Self = function ClassName() { };
 * var Associates = { tree : null };
 * _.propertyAddOwnAssociates( Self.prototype, Associates );
 * console.log( Self.prototype ); // returns { Associates: { tree: null } }
 *
 * @method propertyAddOwnAssociates
 * @throws {exception} If no arguments provided.
 * @memberof wTools
 */

function propertyAddOwnAssociates( dstProto,srcDefaults )
{

  _.assert( arguments.length === 2 );

  var facilityName = { Associates : 'Associates' };
  return _propertyAddOwnDefaults
  ({
    facilityName : facilityName,
    dstProto : dstProto,
    srcDefaults : srcDefaults,
    override : false,
  });

}

//

/**
 * Adds own restricts to object. Creates new restricts container, if there is no such own.
 * @param {array-like} arguments - for arguments details see {@link wTools~propertyAddOwnDefaults}.
 *
 * @example
 * var Self = function ClassName() { };
 * var Restricts = { tree : null };
 * _.propertyAddOwnRestricts( Self.prototype, Restricts );
 * console.log( Self.prototype ); // returns { Restricts: { tree: null } }
 *
 * @method propertyAddOwnRestricts
 * @throws {exception} If no arguments provided.
 * @memberof wTools
 */

function propertyAddOwnRestricts( dstProto,srcDefaults )
{

  _.assert( arguments.length === 2 );

  var facilityName = { Restricts : 'Restricts' };
  return _propertyAddOwnDefaults
  ({
    facilityName : facilityName,
    dstProto : dstProto,
    srcDefaults : srcDefaults,
    override : false,
  });

}


//

/**
 * Make sure src does not have redundant fields.
 * @param {object} src - source object of the class.
 * @method assertDoesNotHaveReduntantFields
 * @memberof wTools
 */

//function doesNotHaveRedundantFields( src )
function assertDoesNotHaveReduntantFields( src )
{

  var Composes = src.Composes || Object.create( null );
  var Aggregates = src.Aggregates || Object.create( null );
  var Associates = src.Associates || Object.create( null );
  var Restricts = src.Restricts || Object.create( null );

  _.assert( _.ojbectIs( src ) )
  _.assertMapOwnOnly( src, Composes, Aggregates, Associates, Restricts );

  return dst;
}


// --
// typing
// --

/**
 * Is instance.
 * @function instanceIs
 * @param {object} src - entity to check
 * @memberof wTools#
 */

function instanceIs( src )
{
  _.assert( arguments.length === 1 );

  if( _hasOwnProperty.call( src,'constructor' ) )
  return false;
  else if( _hasOwnProperty.call( src,'prototype' ) && src.prototype )
  return false;

  return true;
}

//

/**
 * Is prototype.
 * @function prototypeIs
 * @param {object} src - entity to check
 * @memberof wTools#
 */

function prototypeIs( src )
{
  _.assert( arguments.length === 1 );
  return _hasOwnProperty.call( src, 'constructor' );
}

//

/**
 * Is constructor.
 * @function constructorIs
 * @param {object} src - entity to check
 * @memberof wTools#
 */

function constructorIs( src )
{
  _.assert( arguments.length === 1 );
  return _.routineIs( src ) && !instanceIs( src );
}

//

function constructorGet( src )
{
  var proto;

  _.assert( arguments.length === 1 );

  if( _hasOwnProperty.call( src,'constructor' ) )
  {
    proto = src; /* proto */
  }
  else if( _hasOwnProperty.call( src,'prototype' )  )
  {
    if( src.prototype )
    proto = src.prototype; /* constructor */
    else
    proto = Object.getPrototypeOf( Object.getPrototypeOf( src ) ); /* instance behind ruotine */
  }
  else
  {
    proto = Object.getPrototypeOf( src ); /* instance */
  }

  return proto.constructor;
}

//

/**
 * Get parent's constructor.
 * @method parentGet
 * @memberof wCopyable#
 */

function parentGet( src )
{
  var c = constructorGet( src );

  _.assert( arguments.length === 1 );

  var proto = Object.getPrototypeOf( c.prototype );
  var result = proto ? proto.constructor : null;

  return result;
}

//

function prototypeGet( src )
{
  var c = constructorGet( src );

  _.assert( arguments.length === 1 );

  return c.prototype;
}

// --
// getter / setter generator
// --

function setterMapCollection_functor( o )
{

  _.assertMapHasOnly( o,setterMapCollection_functor.defaults );
  _.assert( _.strIs( o.name ) );
  var symbol = Symbol.for( o.name );
  var elementMaker = o.elementMaker;

  return function _setterMapCollection( data )
  {
    var self = this;

    _.assert( _.objectIs( data ) );

    if( self[ symbol ] )
    {

      for( var d in self[ symbol ] )
      delete self[ symbol ][ d ];

    }
    else
    {

      self[ symbol ] = Object.create( null );

    }

    for( var d in data )
    {
      self[ symbol ][ d ] = elementMaker.call( self,data[ d ] );
    }

  }

}

setterMapCollection_functor.defaults =
{
  name : null,
  elementMaker : null,
}

//

function setterFriend_functor( o )
{

  var name = _.nameUnfielded( o.name ).coded;
  var nameOfLink = o.nameOfLink;
  var maker = o.maker;
  var symbol = Symbol.for( name );

  _.assert( arguments.length === 1 );
  _.assert( _.strIs( name ) );
  _.assert( _.strIs( nameOfLink ) );
  _.assert( _.routineIs( maker ) );
  _.assertMapHasOnly( o,setterFriend_functor.defaults );

  return function setterFriend( src )
  {

    var self = this;
    _.assert( src === null || _.objectIs( src ),'setterFriend : expects null or object, but got ' + _.strTypeOf( src ) );

    if( !src )
    {

      self[ symbol ] = src;
      return;

    }
    else if( !self[ symbol ] )
    {

      if( _.mapIs( src ) )
      {
        var o = Object.create( null );
        o[ nameOfLink ] = self;
        o.name = name;
        self[ symbol ] = maker( o );
        self[ symbol ].copy( src );
      }
      else
      {
        self[ symbol ] = src;
      }

    }
    else
    {

      self[ symbol ].copy( src );

    }

    // self[ symbol ].copy( src );

    if( self[ symbol ][ nameOfLink ] !== self )
    self[ symbol ][ nameOfLink ] = self;

    return self[ symbol ];
  }

}

setterFriend_functor.defaults =
{
  name : null,
  nameOfLink : null,
  maker : null,
}

//

function setterCopyable_functor( o )
{

  var name = _.nameUnfielded( o.name ).coded;
  var maker = o.maker;
  var symbol = Symbol.for( name );

  _.assert( arguments.length === 1 );
  _.assert( _.strIs( name ) );
  _.assert( _.routineIs( maker ) );
  _.assertMapHasOnly( o,setterCopyable_functor.defaults );

  return function setterCopyable( data )
  {

    var self = this;

    if( !_.objectIs( self[ symbol ] ) )
    {

      self[ symbol ] = maker( data );

    }
    else
    {

      self[ symbol ].copy( data );

    }

    return self[ symbol ];
  }

}

setterCopyable_functor.defaults =
{
  name : null,
  maker : null,
}

//

function setterBufferFrom_functor( o )
{

  var name = _.nameUnfielded( o.name ).coded;
  var bufferConstructor = o.bufferConstructor;
  var symbol = Symbol.for( name );

  _.assert( arguments.length === 1 );
  _.assert( _.strIs( name ) );
  _.assert( _.routineIs( bufferConstructor ) );
  _.routineOptions( setterBufferFrom_functor,o );

  return function setterBufferFrom( data )
  {
    var self = this;

    if( data === null || data === false )
    {
      data = null;
    }
    else
    {
      data = _.bufferFrom({ src : data, bufferConstructor : bufferConstructor });
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

  var name = Symbol.for( _.nameUnfielded( o.name ).coded );
  var nameOfChangeFlag = Symbol.for( _.nameUnfielded( o.nameOfChangeFlag ).coded );

  _.assert( arguments.length === 1 );
  _.routineOptions( setterChangesTracking_functor,o );

  throw _.err( 'not tested' );

  return function setterChangesTracking( data )
  {
    var self = this;

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

function accessorToElement( o )
{

  _.assert( arguments.length === 1 );
  _.assert( _.objectIs( o.names ) );
  _.routineOptions( accessorToElement,o );

  var names = Object.create( null );
  for( var n in o.names ) (function()
  {
    names[ n ] = n;

    var arrayName = o.arrayName;
    var index = o.names[ n ];
    _.assert( _.numberIs( index ) );
    _.assert( index >= 0 );

    var setterGetter = _accessorSetterGetterGet( o.object,n );

    if( !setterGetter.set )
    o.object[ setterGetter.setName ] = function accessorToElementSet( src )
    {
      this[ arrayName ][ index ] = src;
    }

    if( !setterGetter.get )
    o.object[ setterGetter.getName ] = function accessorToElementGet()
    {
      return this[ arrayName ][ index ];
    }

  })();

  _.accessor
  ({
    object : o.object,
    names : names,
  });

}

accessorToElement.defaults =
{
  object : null,
  names : null,
  arrayName : null,
}

// --
// prototype
// --

/**
* @typedef {object} wTools~prototypeOptions
* @property {routine} [o.constructor=null] - constructor for which prototype is needed.
* @property {routine} [o.parent=null] - constructor of parent class.
* @property {object} [o.extend=null] - extend prototype by this map.
* @property {object} [o.supplement=null] - supplement prototype by this map.
* @property {object} [o.static=null] - static fields of a class.
* @property {boolean} [o.usingAtomicExtension=false] - extends class with atomic fields from relationship descriptors.
* @property {boolean} [o.usingOriginalPrototype=false] - makes prototype using original constructor prototype.
*/

/**
 * Make prototype for constructor repairing relationship : Composes, Aggregates, Associates, Restricts.
 * Execute optional extend / supplement if such o present.
 * @param {wTools~prototypeOptions} o - options {@link wTools~prototypeOptions}.
 * @returns {object} Returns constructor's prototype based on( o.parent ) prototype and complemented by fields, static and non-static methods.
 *
 * @example
 *  var Parent = function Alpha(){ };
 *  Parent.prototype.init = function(  )
 *  {
 *    var self = this;
 *    self.x = 5;
 *  };
 *
 *  var Self = function Betta()
 *  {
 *    return Self.prototype.init.apply( this,arguments );
 *  }
 *
 *  function init()
 *  {
 *    var self = this;
 *    Parent.prototype.init.call( this );
 *    _.mapExtendFiltering( _.filter.srcOwn(),self,Composes );
 *  }
 *
 *  var Composes =
 *  {
 *   a : 1,
 *   b : 2,
 *  }
 *
 *  var Proto =
 *  {
 *   init: init,
 *   constructor : Self,
 *   Composes : Composes
 *  }
 *
 *  var proto = _.protoMake
 *  ({
 *    constructor : Self,
 *    parent : Parent,
 *    extend : Proto,
 *  });
 *
 *  var betta = new Betta();
 *  console.log( proto === Self.prototype ); //returns true
 *  console.log( Parent.prototype.isPrototypeOf( betta ) ); //returns true
 *  console.log( betta.a, betta.b, betta.x ); //returns 1 2 5
 *
 * @method protoMake
 * @throws {exception} If no argument provided.
 * @throws {exception} If( o ) is not a Object.
 * @throws {exception} If( o.constructor ) is not a Routine.
 * @throws {exception} If( o.constructor.name ) is not defined.
 * @throws {exception} If( o.constructor.prototype ) has not own constructor.
 * @throws {exception} If( o.constructor.prototype ) has restricted properties.
 * @throws {exception} If( o.parent ) is not a Routine.
 * @throws {exception} If( o.extend ) is not a Object.
 * @throws {exception} If( o.supplement ) is not a Object.
 * @throws {exception} If( o.parent ) is equal to( o.extend ).
 * @throws {exception} If function cant rewrite constructor using original prototype.
 * @throws {exception} If( o.usingOriginalPrototype ) is false and ( o.constructor.prototype ) has manually defined properties.
 * @throws {exception} If( o.constructor.prototype.constructor ) is not equal( o.constructor  ).
 * @memberof wTools
 */

/*
_.protoMake
({
  constructor : Self,
  parent : Parent,
  extend : Proto,
  supplement : Original.prototype,
  usingAtomicExtension : true,
});
*/

function protoMake( o )
{

  var has =
  {
    constructor : 'constructor',
  }

  var hasNot =
  {
    Parent : 'Parent',
    Self : 'Self',
  }

  /* */

  _assert( arguments.length === 1 );
  _assert( _.objectIs( o ) );

  _assert( _.routineIs( o.constructor ),'protoMake expects constructor' );
  _assert( o.constructor.name || o.constructor._name,'constructor should have name' );
  _assert( _hasOwnProperty.call( o.constructor.prototype,'constructor' ) );

  _.assertMapOwnAll( o.constructor.prototype,has,'protoMake : expects constructor' );
  _.assertMapOwnNone( o.constructor.prototype,hasNot );
  _.assertMapOwnNone( o.constructor.prototype,ClassForbiddenFacility );

  _assert( _.routineIs( o.parent ) || o.parent === undefined || o.parent === null,'wrong type of parent :',_.strTypeOf( 'o.parent' ) );
  _assert( _.objectIs( o.extend ) || o.extend === undefined );
  _assert( _.objectIs( o.supplement ) || o.supplement === undefined );
  _assert( o.parent !== o.extend );

  if( o.extend && _hasOwnProperty.call( o.extend,'constructor' ) )
  _assert( o.extend.constructor === o.constructor );

  // if( o.supplement && _hasOwnProperty.call( o.supplement,'constructor' ) )
  // _assert( o.supplement.constructor === o.constructor );

  _.routineOptions( protoMake,o );

  /* */

  var prototype;

  if( !o.parent )
  o.parent = null;

  /* make prototype */

  if( o.usingOriginalPrototype )
  {
    prototype = o.constructor.prototype;

    if( _hasOwnProperty.call( o.constructor.prototype,'constructor' ) )
    {
      if( o.extend )
      _assert( !o.extend.constructor || o.extend.constructor === o.constructor,'cant rewrite constructor, using original prototype' );
      if( o.supplement )
      _assert( !o.supplement.constructor || o.supplement.constructor === o.constructor,'cant rewrite constructor, using original prototype' );
    }

  }
  else
  {
    if( o.constructor.prototype )
    {
      _.assert( Object.keys( o.constructor.prototype ).length === 0,'misuse of protoMake, prototype of constructor has properties put there manually' );
      _.assert( o.constructor.prototype.constructor === o.constructor );
    }
    prototype = o.constructor.prototype = Object.create( o.parent ? o.parent.prototype : null );
    //prototype.constructor = null;
  }

  /* constructor */

  prototype.constructor = o.constructor;

  if( o.parent )
  {
    Object.setPrototypeOf( o.constructor,o.parent );
  }

  /* extend */

  if( o.constructor.name === 'wConsequence' )
  debugger;

  _.protoExtend
  ({
    constructor : o.constructor,
    extend : o.extend,
    supplement : o.supplement,
    usingAtomicExtension : o.usingAtomicExtension,
    usingStatics : 0,
  });

  /* statics */

  // if( o.constructor.name === 'wConsequence' )
  // debugger;

  /*
    !!! implement accessor for static properties
  */

  _.assert( prototype.constructor );
  _.assert( prototype.Statics );
  _.mapExtendFiltering( _.filter.dstNotOwnSrcOwn(),prototype,prototype.Statics ); // xxx
  _.mapExtendFiltering( _.filter.dstNotOwnSrcOwn(),prototype.constructor,prototype.Statics ); // xxx

  /* */

  return prototype;
}

protoMake.defaults =
{
  constructor : null,
  parent : null,
  extend : null,
  supplement : null,
  usingAtomicExtension : false,
  usingOriginalPrototype : false,
}

//

/**
 * Extends and supplements( o.constructor ) prototype by fields and methods repairing relationship : Composes, Aggregates, Associates, Restricts.
 *
 * @param {wTools~prototypeOptions} o - options {@link wTools~prototypeOptions}.
 * @returns {object} Returns constructor's prototype complemented by fields, static and non-static methods.
 *
 * @example
 * var Self = function Betta() { };
 * var Statics = { staticFunction : function staticFunction(){ } };
 * var Composes = { a : 1, b : 2 };
 * var Proto = { constructor : Self, Composes : Composes, Statics : Statics };
 *
 * var proto =  _.protoExtend
 * ({
 *     constructor: Self,
 *     extend: Proto,
 * });
 * console.log( Self.prototype === proto ); //returns true
 *
 * @method protoExtend
 * @throws {exception} If no argument provided.
 * @throws {exception} If( o ) is not a Object.
 * @throws {exception} If( o.constructor ) is not a Routine.
 * @throws {exception} If( prototype.constructor ) is not a Routine.
 * @throws {exception} If( o.constructor.name ) is not defined.
 * @throws {exception} If( o.constructor.prototype ) has not own constructor.
 * @throws {exception} If( o.parent ) is not a Routine.
 * @throws {exception} If( o.extend ) is not a Object.
 * @throws {exception} If( o.supplement ) is not a Object.
 * @throws {exception} If( o.static) is not a Object.
 * @throws {exception} If( o.constructor.prototype.Constitutes ) is defined.
 * @throws {exception} If( o.constructor.prototype ) is not equal( prototype ).
 * @memberof wTools
 */

function protoExtend( o )
{

  if( arguments.length === 2 )
  o = { constructor : arguments[ 0 ], extend : arguments[ 1 ] };

  _assert( arguments.length === 1 || arguments.length === 2 );
  _assert( _.objectIs( o ) );

  _assert( _.routineIs( o.constructor ),'expects constructor o.constructor' );
  _assert( o.constructor.name || o.constructor._name,'class constructor should have name' );

  _assert( _.objectIs( o.extend ) || o.extend === undefined || o.extend === null );
  _assert( _.objectIs( o.supplement ) || o.supplement === undefined || o.supplement === null );

  _.routineOptions( protoExtend,o );

  var prototype = o.constructor.prototype;

  /* adjust relationships */

  if( o.extend )
  for( var f in ClassFacility )
  _propertyAddOwnDefaults
  ({
    facilityName : f,
    dstProto : prototype,
    srcDefaults : o.extend[ f ] || Object.create( null ),
    override : true,
  });

  if( o.supplement )
  for( var f in ClassFacility )
  _propertyAddOwnDefaults
  ({
    facilityName : f,
    dstProto : prototype,
    srcDefaults : o.supplement[ f ] || Object.create( null ),
    override : false,
  });

/*

to prioritize ordinary facets adjustment order should be

- static extend
- ordinary extend
- ordinary supplement
- static supplement

*/

  /* static extend */

  if( o.usingStatics && o.extend && o.extend.Statics )
  {
    _.mapExtend( prototype,o.extend.Statics );
    _.mapExtend( o.constructor,o.extend.Statics );
  }

  /* ordinary extend */

  if( o.extend )
  {
    var extend = _.mapBut( o.extend,ClassFacility );
    _.mapExtend( prototype,extend );
    if( _hasOwnProperty.call( o.extend,'constructor' ) )
    prototype.constructor = o.extend.constructor;
  }

  /* ordinary supplement */

  if( o.supplement )
  {
    var supplement = _.mapBut( o.supplement,ClassFacility );
    _.mapSupplement( prototype,supplement );
    if( !prototype.constructor )
    if( _hasOwnProperty.call( o.supplement,'constructor' ) )
    prototype.constructor = o.supplement.constructor;
  }

  /* static supplement */

  if( o.usingStatics && o.supplement && o.supplement.Statics )
  {
    _.mapSupplement( prototype,o.supplement.Statics );
    _.mapSupplement( o.constructor,o.supplement.Statics );
  }

  /* atomic extend */

  if( o.usingAtomicExtension )
  {
    for( var f in ClassFacility )
    if( f !== 'Statics' )
    if( _.mapOwn( prototype,f ) )
    _.mapExtendFiltering( _.filter.atomicSrcOwn(),prototype,prototype.Composes );
  }

  /* validation */

  _assert( prototype === o.constructor.prototype );
  _assert( _hasOwnProperty.call( prototype,'constructor' ),'prototype should has own constructor' );
  _assert( _.routineIs( prototype.constructor ),'prototype should has own constructor' );
  _assert( o.constructor.prototype.Constitutes === undefined );

  return prototype;
}

protoExtend.defaults =
{
  constructor : null,
  extend : null,
  supplement : null,
  usingStatics : 1,
  usingAtomicExtension : 0,
}

//

/**
 * Complements instance by its semantic relationships : Composes,Aggregates,Associates and Restricts.
 * @param {object} instance - instance to complement.
 *
 * @example
 * var Self = function Alpha() { };
 *
 * var Proto = { constructor: Self, Composes : { a : 1, b : 2 } };
 *
 * _.protoMake
 * ({
 *     constructor: Self,
 *     extend: Proto,
 * });
 * var obj = new Self();
 * console.log( _.instanceInit( obj ) ); //returns Alpha { a: 1, b: 2 }
 *
 * @return {object} Returns complemented instance.
 * @method instanceInit
 * @memberof wTools
 */

function instanceInit( instance,prototype )
{

  _.assert( arguments.length === 1 || arguments.length === 2 );

  if( prototype === undefined )
  prototype = instance;

  _.mapComplement( instance,prototype.Restricts );
  _.mapComplement( instance,prototype.Composes );
  _.mapComplement( instance,prototype.Aggregates );
  _.mapSupplementOwn( instance,prototype.Associates );

  return instance;
}

//

function instanceInitExtending( instance,prototype )
{

  _.assert( arguments.length === 1 || arguments.length === 2 );

  if( prototype === undefined )
  prototype = instance;

  _.mapExtendFiltering( _.filter.cloning(),instance,prototype.Restricts );
  _.mapExtendFiltering( _.filter.cloning(),instance,prototype.Composes );
  _.mapExtendFiltering( _.filter.cloning(),instance,prototype.Aggregates );
  _.mapExtend( instance,prototype.Associates );

  return instance;
}

//

function instanceFilterInit( o )
{

  _.routineOptions( instanceFilterInit,o );

  // var self = _.instanceFilterInit
  // ({
  //   constructor : Self,
  //   parent : Parent,
  //   extend : Extend,
  // });

  _.assert( !o.args || o.args.length === 0 || o.args.length === 1 );

  var result = Object.create( null );

  _.instanceInit( result,o.constructor.prototype );

  if( o.args[ 0 ] )
  wCopyable.copyCustom.call( result,
  {
    proto : o.constructor.prototype,
    src : o.args[ 0 ],
    technique : 'object',
  });

  if( !result.original )
  result.original = _.FileProvider.Default();

  _.mapExtend( result,o.extend );

  Object.setPrototypeOf( result,result.original );

  if( o.strict )
  Object.preventExtensions( result );

  return result;
}

instanceFilterInit.defaults =
{
  constructor : null,
  parent : null,
  extend : null,
  args : null,
  strict : 1,
}

//

/**
 * Make united interface for several maps. Access to single map cause read and write to original maps.
 * @param {array} protos - maps to united.
 * @return {object} united interface.
 * @method protoUnitedInterface
 * @memberof wTools
 */

function protoUnitedInterface( protos )
{
  var result = Object.create( null );
  var unitedArraySymbol = Symbol.for( '_unitedArray_' );
  var unitedMapSymbol = Symbol.for( '_unitedMap_' );
  var protoMap = Object.create( null );

  _assert( arguments.length === 1 );
  _assert( _.arrayIs( protos ) );

  //

  function get( fieldName )
  {
    return function unitedGet()
    {
      return this[ unitedMapSymbol ][ fieldName ][ fieldName ];
    }
  }
  function set( fieldName )
  {
    return function unitedSet( value )
    {
      this[ unitedMapSymbol ][ fieldName ][ fieldName ] = value;
    }
  }

  //

  for( var p = 0 ; p < protos.length ; p++ )
  {
    var proto = protos[ p ];
    for( var f in proto )
    {
      if( f in protoMap )
      throw _.err( 'protoUnitedInterface :','several objects try to unite have same field :',f );
      protoMap[ f ] = proto;

      var methods = Object.create( null )
      methods[ f + 'Get' ] = get( f );
      methods[ f + 'Set' ] = set( f );
      var names = Object.create( null );
      names[ f ] = f;
      _.accessor
      ({
        object : result,
        names : names,
        methods : methods,
        strict : 0,
        prime : 0,
      });

    }
  }

  /*result[ unitedArraySymbol ] = protos;*/
  result[ unitedMapSymbol ] = protoMap;

  return result;
}

//

function protoMakeOwnDescendant( dst,fieldName )
{

  _assert( arguments.length === 2 );

  // var fieldName = _.nameUnfielded( fieldName ).coded;

  if( !_hasOwnProperty.call( dst,fieldName ) )
  {
    var field = dst[ fieldName ];
    dst[ fieldName ] = Object.create( null );
    if( field )
    Object.setPrototypeOf( dst[ fieldName ], field );
  }

  return dst;
}

//

/**
 * Append prototype to object. Find archi parent and replace its proto.
 * @param {object} dstObject - dst object to append proto.
 * @method protoAppend
 * @memberof wTools
 */

function protoAppend( dstObject )
{

  _assert( _.objectIs( dstObject ) );

  for( var a = 1 ; a < arguments.length ; a++ )
  {
    var proto = arguments[ a ];

    _assert( _.objectIs( proto ) );

    var parent = _.protoArchy( dstObject );
    Object.setPrototypeOf( parent, proto );

  }

  return dstObject;
}

//

/**
 * Does srcProto has insProto as prototype.
 * @param {object} srcProto - proto stack to investigate.
 * @param {object} insProto - proto to look for.
 * @method protoHas
 * @memberof wTools
 */

function protoHas( srcProto,insProto )
{

  do
  {
    if( srcProto === insProto )
    return true;
    srcProto = Object.getPrototypeOf( srcProto );
  }
  while( srcProto !== Object.prototype );

  return false;
}

//

/**
 * Return proto owning names.
 * @param {object} srcObject - src object to investigate proto stack.
 * @method protoOwning
 * @memberof wTools
 */

function protoOwning( srcObject,names )
{
  var names = _nameFielded( names );
  _assert( _.objectIs( srcObject ) );

  do
  {
    var has = true;
    for( var n in names )
    if( !_hasOwnProperty.call( srcObject,n ) )
    {
      has = false;
      break;
    }
    if( has )
    return srcObject;

    srcObject = Object.getPrototypeOf( srcObject );
  }
  while( srcObject !== Object.prototype );

  return null;
}

//

/**
 * Returns parent which has default proto.
 * @param {object} srcObject - dst object to append proto.
 * @method protoArchy
 * @memberof wTools
 */

function protoArchy( srcObject )
{

  _assert( _.objectIs( srcObject ) );

  while( Object.getPrototypeOf( srcObject ) !== Object.prototype )
  srcObject = Object.getPrototypeOf( srcObject );

  return srcObject;
}


//

/**
 * Iterate through prototypes.
 * @param {object} proto - prototype
 * @method protoEach
 * @memberof wTools
 */

function protoEach( proto,onEach )
{
  var result = [];

  _.assert( _.routineIs( onEach ) || !onEach );
  _.assert( _.prototypeIs( proto ) );
  _.assert( arguments.length === 1 || arguments.length === 2 );

  do
  {

    if( onEach )
    onEach.call( this,proto );

    result.push( proto );

    var parent = _.parentGet( proto );

    proto = parent ? parent.prototype : null;

    if( proto && proto.constructor === Object )
    proto = null;

  }
  while( proto );

  return result;
}

//

function accessorDescriptorGet( object,name )
{
  var result = Object.create( null );
  result.object = null;
  result.descriptor = null;

  _.assert( arguments.length === 2 );

  do
  {
    result.descriptor = Object.getOwnPropertyDescriptor( object,name );

    // if( result.descriptor )
    // if( 'value' in result.descriptor )
    // debugger;

    if( result.descriptor && !( 'value' in result.descriptor ) )
    {
      result.object = object;
      return result;
    }
    object = Object.getPrototypeOf( object );
  }
  while( object );

  return result;
}

//

function propertyDescriptorGet_( object,name )
{
  var result = Object.create( null );
  result.object = null;
  result.descriptor = null;

  _.assert( arguments.length === 2 );

  do
  {
    result.descriptor = Object.getOwnPropertyDescriptor( object,name );
    if( result.descriptor )
    {
      result.object = object;
      return result;
    }
    object = Object.getPrototypeOf( object );
  }
  while( object );

  return result;
}

//

function propertyGetterSetterGet( object,name )
{
  var result = Object.create( null );

  result.set = object[ '_' + name + 'Set' ] || object[ '' + name + 'Set' ];
  result.get = object[ '_' + name + 'Get' ] || object[ '' + name + 'Get' ];

  return result;
}

// --
// var
// --

/**
 * @global {Object} wTools~ClassFacility - contains predefined class relationship types.
 * @memberof wTools
 */

var ClassFacility = Object.create( null );
ClassFacility.Composes = 'Composes';
ClassFacility.Aggregates = 'Aggregates';
ClassFacility.Associates = 'Associates';
ClassFacility.Restricts = 'Restricts';
ClassFacility.Statics = 'Statics';
Object.freeze( ClassFacility );

var ClassForbiddenFacility = Object.create( null );
ClassForbiddenFacility.Static = 'Static';
ClassForbiddenFacility.Type = 'Type';
ClassForbiddenFacility.type = 'type';
Object.freeze( ClassForbiddenFacility );

var Combining = [ 'rewrite','supplement','apppend','prepend' ];

// --
// prototype
// --

var Proto =
{

  // property

  _accessorOptions : _accessorOptions,
  _accessorRegister : _accessorRegister,

  _accessor : _accessor,
  _accessorProperty : _accessorProperty,

  _accessorSetterGetterMake : _accessorSetterGetterMake,
  _accessorSetterGetterGet : _accessorSetterGetterGet,

  accessor : accessor,
  accessorForbid : accessorForbid,
  accessorReadOnly : accessorReadOnly,
  accessorsSupplement : accessorsSupplement,

  constant : constant,
  restrictReadOnly : restrictReadOnly,

  mixin : mixin,
  mixinHas : mixinHas,

  _propertyAddOwnDefaults : _propertyAddOwnDefaults,
  propertyAddOwnComposes : propertyAddOwnComposes,
  propertyAddOwnAggregates : propertyAddOwnAggregates,
  propertyAddOwnAssociates : propertyAddOwnAssociates,
  propertyAddOwnRestricts : propertyAddOwnRestricts,

  assertDoesNotHaveReduntantFields : assertDoesNotHaveReduntantFields,


  // typing

  instanceIs : instanceIs,
  prototypeIs : prototypeIs,
  constructorIs : constructorIs,

  constructorGet : constructorGet,
  parentGet : parentGet,
  prototypeGet : prototypeGet,


  // getter / setter generator

  setterMapCollection_functor : setterMapCollection_functor,
  setterFriend_functor : setterFriend_functor,
  setterCopyable_functor : setterCopyable_functor,
  setterBufferFrom_functor : setterBufferFrom_functor,
  setterChangesTracking_functor : setterChangesTracking_functor,

  accessorToElement : accessorToElement,


  // prototype

  protoMake : protoMake,
  protoExtend : protoExtend,

  instanceInit : instanceInit,
  instanceInitExtending : instanceInitExtending,
  instanceFilterInit : instanceFilterInit,

  protoUnitedInterface : protoUnitedInterface, /* experimental */

  protoMakeOwnDescendant : protoMakeOwnDescendant, /* experimental */

  protoAppend : protoAppend, /* experimental */
  protoHas : protoHas, /* experimental */
  protoOwning : protoOwning, /* experimental */
  protoArchy : protoArchy, /* experimental */

  protoEach : protoEach,

  accessorDescriptorGet : accessorDescriptorGet,

  propertyDescriptorGet_ : propertyDescriptorGet_,
  propertyGetterSetterGet : propertyGetterSetterGet,


  // var

  ClassFacility : ClassFacility,
  ClassForbiddenFacility : ClassForbiddenFacility,
  Combining : Combining,

}

_global_.wProto = Proto;

_.mapExtend( Self, Proto );

// --
// export
// --

if( typeof module !== 'undefined' )
{

  require( './ProtoLike.s' );
  try
  {
    require( '../../abase/akernel/aKernelWithComponents.s' );
  }
  catch( err )
  {
  }

}

if( typeof module !== 'undefined' && module !== null )
{
  module[ 'exports' ] = Self;
}

})();
