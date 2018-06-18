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
    :: A consists of B.s
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

  if( typeof _global_ === 'undefined' || !_global_.wBase )
  {
    let toolsPath = '../../../dwtools/Base.s';
    let toolsExternal = 0;
    try
    {
      toolsPath = require.resolve( toolsPath );
    }
    catch( err )
    {
      toolsExternal = 1;
      require( 'wTools' );
    }
    if( !toolsExternal )
    require( toolsPath );
  }

  if( !_global_.wTools.nameFielded )
  try
  {
    require( './NameTools.s' );
  }
  catch( err )
  {
  }

}

var Self = _global_.wTools;
var _global = _global_; var _ = _global_.wTools;

var _hasOwnProperty = Object.hasOwnProperty;
var _propertyIsEumerable = Object.propertyIsEnumerable;
var _assert = _.assert;
var _nameFielded = _.nameFielded;

_.assert( _.objectIs( _.field ),'wProto needs wTools/staging/dwtools/abase/layer1/FieldMapper.s' );
_.assert( _.routineIs( _nameFielded ),'wProto needs wTools/staging/dwtools/abase/layer3/NameTools.s' );

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
 * var Self = function ClassName( o ) { };
 * _._accessorOptions( Self,{ a : 'a', b : 'b' }, 'set/get call' );
 *
 * @private
 * @method _accessorOptions
 * @memberof wTools
 */

// function _accessorOptions( object,names )
function _accessorOptions( routine, args )
{
  var o;

  if( args.length === 1 )
  {
    o = args[ 0 ];
  }
  else
  {
    o = Object.create( null );
    o.object = args[ 0 ];
    o.names = args[ 1 ];
  }

  if( !o.methods )
  o.methods = o.object;
  else
  o.methods = _.mapExtend( null,o.methods );

  // if( _.arrayIs( o.names ) )
  // debugger;

  if( !_.arrayIs( o.names ) )
  o.names = _nameFielded( o.names );
  else
  o.names = o.names;

  if( args.length > 2 )
  {
    o.message = _.arraySlice( args,2 );
  }

  return o;
}

//

function _accessorRegister( o )
{

  _.routineOptions( _accessorRegister,o );
  _.assert( _.prototypeIsStandard( o.proto ),'expects formal prototype' );
  _.assert( _.strIsNotEmpty( o.declaratorName ) );
  _.assert( _.arrayIs( o.declaratorArgs ) );
  _.descendantMakeOwnedBy( o.proto,'_Accessors' );

  // if( Config.debug )
  // for( var a = 0 ; a < o.declaratorArgs.length ; a++ )
  // _.entityFreeze( o.declaratorArgs[ a ] );

  var accessors = o.proto._Accessors;

  if( o.combining && o.combining !== 'rewrite' && o.combining !== 'supplement' )
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

  _.assert( !o.combining || o.combining === 'rewrite' || o.combining === 'append' || o.combining === 'supplement', 'not supported ( o.combining )',o.combining );
  _.assert( _.strIs( o.name ) );

  if( accessors[ o.name ] && o.combining === 'supplement' )
  return;

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

  // if( o.declaratorName )
  // debugger;
  // if( o.declaratorKind )
  // debugger;

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
 * Example : if( rawName ) is 'a', function searchs for '_aSet' or 'aSet' and same for getter.
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
 * var Self = function ClassName( o ) { };
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

  _assert( !_.primitiveIs( o.object ) );
  _assert( !_.primitiveIs( o.methods ) );
  _assert( !o.message || _.arrayIs( o.message ) );
  _.assertMapHasOnly( o,_accessor.defaults );
  _.mapComplement( o,_accessor.defaults );

  if( o.strict )
  {

    var has =
    {
      constructor : 'constructor',
    }

    _.assertMapOwnAll( o.object,has );
    _.accessorForbid
    ({
      object : o.object,
      names : ClassForbiddenNames,
      prime : 0,
      strict : 0,
    });

  }

  _assert( _.objectLikeOrRoutine( o.object ),'_.accessor :','expects object ( object ), but got', o.object );
  _assert( _.objectIs( o.names ),'_.accessor :','expects object ( names ), but got', o.names );

  /* */

  var AllowedIndividualOptions =
  {
    strict : 1,
    enumerable : 1,
    preserveValues : 1,
    readOnly : 0,
    readOnlyProduct : 0,
    prime : 1,
    combining : 0,
  }

  /* */

  for( var n in o.names )
  {

    var individual = o.names[ n ];

    _.assert( _.strIs( individual ) || _.objectIs( individual ) );

    if( _.strIs( individual ) )
    {
      _.assert( individual === n,'map for forbid should have same key and value' );
      individual = o;
    }
    else
    {
      _.assertMapHasOnly( individual,AllowedIndividualOptions );
      individual = _.mapExtend( null,o,individual );
      _.assert( individual.object );
    }

    _accessorProperty( individual,n );

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
  readOnlyProduct : 0,
  prime : 1,
  combining : 0,

}

//

function _accessorProperty( o,name )
{

  _.assert( arguments.length === 2 );
  _.assert( _.strIs( name ) );

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
      'overriding of property',encodedName + '\n' +
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

    if( !optionsForRegister.methods[ '_' + rawName + 'Get' ] && !optionsForRegister.methods[ rawName + 'Get' ] )
    optionsForRegister.methods[ '_' + rawName + 'Get' ] = o.object[ '_' + name + 'Get' ] ? o.object[ '_' + name + 'Get' ] : o.object[ name + 'Get' ];

    if( !optionsForRegister.methods[ '_' + rawName + 'Set' ] && !optionsForRegister.methods[ rawName + 'Set' ] )
    optionsForRegister.methods[ '_' + rawName + 'Set' ] = o.object[ '_' + name + 'Set' ] ? o.object[ '_' + name + 'Set' ] : o.object[ name + 'Set' ];

    _._accessorRegister
    ({
      proto : o.object,
      name : encodedName,
      declaratorName : 'Accessor',
      declaratorArgs : [ optionsForRegister ],
      combining : o.combining,
    });

  }

  /* */

  var settrGetter = _accessorSetterGetterMake( o,o.methods,rawName );
  var forbiddenName = '_' + rawName;
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

  /* forbid underscore field */

  if( o.strict && !propertyDescriptor.descriptor  )
  {

    var m =
    [
      'use Symbol.for( \'' + rawName + '\' ) ',
      'to get direct access to property\'s field, ',
      'not ' + forbiddenName,
    ].join( '' );

    if( !_.prototypeIsStandard( o.object ) || ( _.prototypeIsStandard( o.object ) && !_.prototypeHasField( o.object,forbiddenName ) ) )
    _.accessorForbid
    ({
      object : o.object,
      names : forbiddenName,
      message : [ m ],
      prime : 0,
      strict : 1,
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

  /* get */

  // _.assert( !o.readOnlyProduct || !result.get,'not tested' );

  if( !result.get )
  {

    if( !o.readOnlyProduct )
    result.get = function get()
    {
      return this[ fieldSymbol ];
    }
    else if( o.readOnlyProduct )
    result.get = function get()
    {
      var result = this[ fieldSymbol ];
      debugger;
      if( !_.primitiveIs( result ) )
      result = _.proxyReadOnly( result );
      return result;
    }

    if( o.message )
    {
      var message = o.message;
      var _getWithoutMessage = o.get;
      o.get = function()
      {
        console.info.apply( console,message );
        return _getWithoutMessage.apply( this,arguments );
      }
    }

  }

  /* validation */

  _.assert( !result.set || !o.readOnly,'accessor :','read only, but setter found in',o.object );

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
 * var Self = function ClassName( o ) { };
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

function accessor( o )
{
  var o = _accessorOptions( accessor, arguments );

  return _accessor( o );
}

//

function accessorForbid()
{
  var o = _accessorOptions( accessorForbid, arguments );
  var object = o.object;
  var names = o.names;

  if( _.objectIs( o.names ) )
  names = _.mapExtend( null,o.names );

  if( o.combining === 'rewrite' && o.strict === undefined )
  o.strict = 0;

  if( o.prime === undefined )
  o.prime = _.prototypeIsStandard( o.object );

  /* verification */

  _.assert( _.objectLikeOrRoutine( object ),'_.accessor :','expects object as argument but got', object );
  _.assert( _.objectIs( names ) || _.arrayIs( names ),'_.accessor :','expects object names as argument but got', names );
  _.routineOptions( accessorForbid,o );

  /* message */

  var _constructor = object.constructor || Object.getPrototypeOf( object );
  _.assert( _.routineIs( _constructor ) || _constructor === null );
  _.assert( _constructor === null || _constructor.name || _constructor._name,'accessorForbid :','object should have name' );
  var protoName = ( _constructor ? ( _constructor.name || _constructor._name || '' ) : '' ) + '.';
  var message = 'is deprecated';
  if( o.message )
  message = o.message.join( ' : ' );

  /* _accessorForbid */

  var encodedName,rawName;
  function _accessorForbid()
  {

    var setterName = '_' + rawName + 'Set';
    var getterName = '_' + rawName + 'Get';

    // if( rawName === 'type' )
    // debugger;

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

    if( o.prime )
    {

      var optionsForRegister = _.mapExtend( null,o );
      optionsForRegister.names = encodedName;
      optionsForRegister.object = null;

      _._accessorRegister
      ({
        proto : o.object,
        name : encodedName,
        declaratorName : 'accessorForbid',
        declaratorArgs : [ optionsForRegister ],
        combining : o.combining,
      });

    }

    /* */

    var propertyDescriptor = _.accessorDescriptorGet( o.object,encodedName );
    if( propertyDescriptor.descriptor )
    {
      _.assert( o.combining,'accessorForbid : if accessor overided expect ( o.combining ) is',Combining.join() );

      if( _.routineIs( propertyDescriptor.descriptor.get ) && propertyDescriptor.descriptor.get.name === 'forbidden' )
      {
        delete names[ encodedName ];
        return;
      }

    }

    /* field */

    if( o.strict )
    if( _hasOwnProperty.call( object,encodedName ) )
    {
      if( _.accessorForbidOwn( object,encodedName ) )
      {
        delete names[ encodedName ];
        return;
      }
      else
      {
        handler();
      }
    }

    // if( o.strict )
    // if( _.accessorForbidOwn( object,encodedName ) )
    // {
    //   delete names[ encodedName ];
    //   return;
    // }
    // else
    // {
    //   handler();
    // }

    // if( o.strict )
    // if( _hasOwnProperty.call( object,encodedName ) )
    // {
    //   var descriptor = Object.getOwnPropertyDescriptor( object,encodedName );
    //   if( _.routineIs( descriptor.get ) && descriptor.get.isForbid )
    //   {
    //     delete names[ encodedName ];
    //     return;
    //   }
    //   else
    //   {
    //     handler();
    //   }
    // }

    /* descendant */

    if( o.strict && _.prototypeIsStandard( o.object ) )
    if( _.prototypeHasField( o.object,encodedName ) )
    {
      handler();
    }

    /* */

    if( !Object.isExtensible( object ) )
    {
      delete names[ encodedName ];
    }

  }

  /* property */

  var methods = Object.create( null );

  if( _.objectIs( names ) )
  {

    for( var n in names )
    {
      var encodedName = n;
      var rawName = names[ n ];
      _accessorForbid();
    }

  }
  else
  {

    var namesArray = names;
    names = Object.create( null );
    for( var n = 0 ; n < namesArray.length ; n++ )
    {
      var encodedName = namesArray[ n ];
      var rawName = namesArray[ n ];
      names[ encodedName ] = rawName;
      _accessorForbid();
    }

  }

  o.names = names;
  o.object = object;
  o.methods = methods;
  o.strict = 0;
  o.prime = 0;

  return _accessor( _.mapScreen( _accessor.defaults,o ) );
}

accessorForbid.defaults =
{
  preserveValues : 0,
  enumerable : 0,
  prime : 1,
  strict : 1,
  combining : 'rewrite',
}

accessorForbid.defaults.__proto__ = _accessor.defaults;

//

function accessorForbidOwn( object,name )
{
  if( !_hasOwnProperty.call( object,name ) )
  return false;

  var descriptor = Object.getOwnPropertyDescriptor( object,name );
  if( _.routineIs( descriptor.get ) && descriptor.get.isForbid )
  {
    return true;
  }
  else
  {
    return false;
  }

}

//

function accessorReadOnly( object,names )
{
  var o = _accessorOptions( accessorReadOnly, arguments );

  _.assert( !o.readOnly );
  o.readOnly = true;

  // if( o.readOnlyProduct === undefined )
  // o.readOnlyProduct = true;

  return _accessor( o );
}

//

function accessorsSupplement( dst,src )
{

  _.descendantMakeOwnedBy( dst,'_Accessors' );

  _.assert( arguments.length === 2 );
  _.assert( _hasOwnProperty.call( dst,'_Accessors' ),'accessorsSupplement : dst should has _Accessors map' );
  _.assert( _hasOwnProperty.call( src,'_Accessors' ),'accessorsSupplement : src should has _Accessors map' );

  /* */

  function supplement( accessor )
  {

    _.assert( _.arrayIs( accessor.declaratorArgs ) );
    _.assert( !accessor.combining || accessor.combining === 'rewrite' || accessor.combining === 'supplement' || accessor.combining === 'append','not implemented' );

    if( _.objectIs( dst._Accessors[ a ] ) )
    return;

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

  for( var a in src._Accessors )
  {

    var accessor = src._Accessors[ a ];

    if( _.objectIs( accessor ) )
    supplement( accessor );
    else for( var i = 0 ; i < accessor.length ; i++ )
    supplement( accessor[ i ] );

  }

}

//

/**
 * Makes constants properties on object by creating new or replacing existing properties.
 * @param {object} dstProto - prototype of class which will get new constant property.
 * @param {object} namesObject - name/value map of constants.
 *
 * @example
 * var Self = function ClassName( o ) { };
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
 * var Self = function ClassName( o ) { };
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

// --
// mixin
// --

/**
 * Make mixin which could be mixed into prototype of another object.
 * @param {object} o - options.
 * @method mixinMake
 * @memberof wTools#
 */

function mixinMake( o )
{

  _.assert( arguments.length === 1 );
  _.assert( _.mapIs( o ) || _.routineIs( o ) );
  _.assert( _.routineIs( o._mixin ) || o._mixin === undefined,'expects routine ( o._mixin ), but got',_.strTypeOf( o ) );
  _.assert( _.strIsNotEmpty( o.name ),'mixin should have name' );
  _.assert( _.objectIs( o.extend ) || o.extend === undefined || o.extend === null );
  _.assert( _.objectIs( o.supplementOwn ) || o.supplementOwn === undefined || o.supplementOwn === null );
  _.assert( _.objectIs( o.supplement ) || o.supplement === undefined || o.supplement === null );
  _.assertOwnNoConstructor( o );
  _.assertMapOwnOnly( o,mixinMake.defaults );

  if( !o._mixin )
  o.mixin = function mixin( cls )
  {
    _.assert( arguments.length === 1 );
    _.assert( _.routineIs( cls ) );
    _.assert( cls === cls.prototype.constructor );
    _.mixinApply({ descriptor : this, dstProto : cls.prototype });
    return cls;
  }
  else
  o.mixin = function mixin( cls )
  {
    _.assert( arguments.length === 1 );
    _.assert( _.routineIs( cls ) );
    _.assert( cls === cls.prototype.constructor );
    this._mixin( cls );
    return cls;
  }

  /* */

  o._mixinDetails = _.mapExtend( null,o );

  if( !o.prototype )
  {

    var got = _._classConstructorAndPrototypeGet( o );

    if( got.prototype )
    o.prototype = got.prototype;
    else
    o.prototype = Object.create( null );

    _.classExtend
    ({
      cls : got.cls,
      prototype : o.prototype,
      extend : o.extend,
      supplementOwn : o.supplementOwn,
      supplement : o.supplement,
    });

  }

  if( o.prototype )
  {
    _.assert( !o.prototype.mixin,'not tested' );
    o.prototype.mixin = o.mixin;
    if( o.prototype.constructor )
    {
      _.assert( !o.prototype.constructor.mixin || o.prototype.constructor.mixin === o.mixin,'not tested' );
      o.prototype.constructor.mixin = o.mixin;
    }
  }

  Object.freeze( o._mixinDetails );
  Object.freeze( o );

  return o;
}

mixinMake.defaults =
{

  _mixin : null,
  name : null,
  nameShort : null,
  prototype : null,

  extend : null,
  supplementOwn : null,
  supplement : null,
  functor : null,

}

//

/**
 * Mixin methods and fields into prototype of another object.
 * @param {object} o - options.
 * @method mixinApply
 * @memberof wTools#
 */

function mixinApply( o )
{
  var dstProto = o.dstProto;
  var d = o.descriptor._mixinDetails;

  _assert( arguments.length === 1 );
  _.assertOwnNoConstructor( o );
  _assert( _.objectIs( dstProto ),'expects ( dstProto ) object, but got',_.strTypeOf( dstProto ) );
  _assert( _.routineIs( d.mixin ),'looks like mixn descriptor is not made' );
  _assert( Object.isFrozen( d ),'looks like mixn descriptor is not made' );
  _.assertMapHasOnly( o,mixinApply.defaults );

  /* mixin into routine */

  if( !_.mapIs( dstProto ) )
  {
    _assert( dstProto.constructor.prototype === dstProto,'mixin :','expects prototype with own constructor field' );
    _assert( dstProto.constructor.name.length || dstProto.constructor._name.length,'mixin :','constructor should has name' );
    _assert( _.routineIs( dstProto.init ) );
  }

  /* extend */

  _.assert( _.mapOwnKey( dstProto,'constructor' ) );
  _.assert( dstProto.constructor.prototype === dstProto );
  _.classExtend
  ({
    cls : dstProto.constructor,
    extend : d.extend,
    supplementOwn : d.supplementOwn,
    supplement : d.supplement,
    functor : d.functor,
  });

  /* mixins map */

  if( !_hasOwnProperty.call( dstProto,'_mixinsMap' ) )
  {
    dstProto._mixinsMap = Object.create( dstProto._mixinsMap || null );
  }

  _.assert( !dstProto._mixinsMap[ d.name ],'attempt to mixin same mixin "' + d.name + '" several times into ' + dstProto.constructor.name );

  dstProto._mixinsMap[ d.name ] = 1;

}

mixinApply.defaults =
{
  dstProto : null,
  descriptor : null,
}

//

function mixinHas( proto,mixin )
{
  if( _.constructorIs( proto ) )
  proto = _.prototypeGet( proto );

  _.assert( _.prototypeIsStandard( proto ) );
  _.assert( arguments.length === 2 );

  if( _.strIs( mixin ) )
  {
    return proto._mixinsMap && proto._mixinsMap[ mixin ];
  }
  else
  {
    _.assert( _.routineIs( mixin.mixin ),'expects mixin, but got not mixin',_.strTypeOf( mixin ) );
    _.assert( _.strIsNotEmpty( mixin.name ),'expects mixin, but got not mixin',_.strTypeOf( mixin ) );
    return proto._mixinsMap && proto._mixinsMap[ mixin.name ];
  }

}

// --
// descendant
// --

function descendantMakeOwnedBy( dst,fieldName )
{

  _.assert( arguments.length === 2 );
  _.assert( _.strIs( fieldName ) );

  if( !_hasOwnProperty.call( dst,fieldName ) )
  {
    var field = dst[ fieldName ];
    dst[ fieldName ] = Object.create( null );
    if( field )
    Object.setPrototypeOf( dst[ fieldName ], field );
  }

  if( Config.debug )
  {
    var parent = Object.getPrototypeOf( dst );
    if( parent && parent[ fieldName ] )
    _.assert( Object.getPrototypeOf( dst[ fieldName ] ) === parent[ fieldName ] );
  }

  return dst;
}

//

/**
* Default options for descendantAdd function
* @typedef {object} wTools~protoAddDefaults
* @property {object} [ o.descendantName=null ] - object that contains class relationship type name.
* Example : { Composes : 'Composes' }. See {@link wTools~ClassSubfieldsGroupsRelationships}
* @property {object} [ o.dstProto=null ] - prototype of class which will get new constant property.
* @property {object} [ o.srcMap=null ] - name/value map of defaults.
* @property {bool} [ o.override=false ] - to override defaults if exist.
*/

/**
 * Adds own defaults to object. Creates new defaults container, if there is no such own.
 * @param {wTools~protoAddDefaults} o - options {@link wTools~protoAddDefaults}.
 * @private
 *
 * @example
 * var Self = function ClassName( o ) { };
 * _.descendantAdd
 * ({
 *   descendantName : { Composes : 'Composes' },
 *   dstProto : Self.prototype,
 *   srcMap : { a : 1, b : 2 },
 * });
 * console.log( Self.prototype ); // returns { Composes: { a: 1, b: 2 } }
 *
 * @method descendantAdd
 * @throws {exception} If no argument provided.
 * @throws {exception} If( o.srcMap ) is not a Object.
 * @throws {exception} If( o ) is extented by unknown property.
 * @memberof wTools
 */

function descendantAdd( o )
{
  var o = o || Object.create( null );

  _.routineOptions( descendantAdd,o );
  _.assert( arguments.length === 1 );
  _.assert( o.srcMap === null || _.objectIs( o.srcMap ),'expects object ( o.srcMap ), got', _.strTypeOf( o.srcMap ) );

  o.descendantName = _.nameUnfielded( o.descendantName );

  _.descendantMakeOwnedBy( o.dstProto,o.descendantName.coded );

  var descendant = o.dstProto[ o.descendantName.coded ];

  if( o.srcMap )
  for( var n in o.srcMap )
  {

    if( o.override === false )
    if( n in descendant )
    continue;

    if( o.dstNotOwn === true )
    if( _hasOwnProperty.call( descendant,n ) )
    continue;

    descendant[ n ] = o.srcMap[ n ];

  }

}

descendantAdd.defaults =
{
  descendantName : null,
  dstProto : null,
  srcMap : null,

  override : false,
  dstNotOwn : false,
}

//

/**
 * Adds own defaults( Composes ) to object. Creates new defaults container, if there is no such own.
 * @param {array-like} arguments - for arguments details see {@link wTools~protoAddDefaults}.
 *
 * @example
 * var Self = function ClassName( o ) { };
 * var Composes = { tree : null };
 * _.descendantComposesAddTo( Self.prototype, Composes );
 * console.log( Self.prototype ); // returns { Composes: { tree: null } }
 *
 * @method descendantComposesAddTo
 * @throws {exception} If no arguments provided.
 * @memberof wTools
 */

function descendantComposesAddTo( dstProto,srcMap )
{

  _.assert( arguments.length === 2 );

  var descendantName = 'Composes';
  return _.descendantAdd
  ({
    descendantName : descendantName,
    dstProto : dstProto,
    srcMap : srcMap,
    override : false,
  });

}

//

/**
 * Adds own aggregates to object. Creates new aggregates container, if there is no such own.
 * @param {array-like} arguments - for arguments details see {@link wTools~protoAddDefaults}.
 *
 * @example
 * var Self = function ClassName( o ) { };
 * var Aggregates = { tree : null };
 * _.descendantAggregatesAddTo( Self.prototype, Aggregates );
 * console.log( Self.prototype ); // returns { Aggregates: { tree: null } }
 *
 * @method descendantAggregatesAddTo
 * @throws {exception} If no arguments provided.
 * @memberof wTools
 */

function descendantAggregatesAddTo( dstProto,srcMap )
{

  _.assert( arguments.length === 2 );

  var descendantName = 'Aggregates';
  return _.descendantAdd
  ({
    descendantName : descendantName,
    dstProto : dstProto,
    srcMap : srcMap,
    override : false,
  });

}

//

/**
 * Adds own associates to object. Creates new associates container, if there is no such own.
 * @param {array-like} arguments - for arguments details see {@link wTools~protoAddDefaults}.
 *
 * @example
 * var Self = function ClassName( o ) { };
 * var Associates = { tree : null };
 * _.descendantAssociatesAddTo( Self.prototype, Associates );
 * console.log( Self.prototype ); // returns { Associates: { tree: null } }
 *
 * @method descendantAssociatesAddTo
 * @throws {exception} If no arguments provided.
 * @memberof wTools
 */

function descendantAssociatesAddTo( dstProto,srcMap )
{

  _.assert( arguments.length === 2 );

  var descendantName = 'Associates';
  return _.descendantAdd
  ({
    descendantName : descendantName,
    dstProto : dstProto,
    srcMap : srcMap,
    override : false,
  });

}

//

/**
 * Adds own restricts to object. Creates new restricts container, if there is no such own.
 * @param {array-like} arguments - for arguments details see {@link wTools~protoAddDefaults}.
 *
 * @example
 * var Self = function ClassName( o ) { };
 * var Restricts = { tree : null };
 * _.descendantRestrictsAddTo( Self.prototype, Restricts );
 * console.log( Self.prototype ); // returns { Restricts: { tree: null } }
 *
 * @method descendantRestrictsAddTo
 * @throws {exception} If no arguments provided.
 * @memberof wTools
 */

function descendantRestrictsAddTo( dstProto,srcMap )
{

  _.assert( arguments.length === 2 );

  var descendantName = 'Restricts';
  return _.descendantAdd
  ({
    descendantName : descendantName,
    dstProto : dstProto,
    srcMap : srcMap,
    override : false,
  });

}

// --
// getter / setter functor
// --

function setterMapCollection_functor( o )
{

  _.assertMapHasOnly( o,setterMapCollection_functor.defaults );
  _.assert( _.strIs( o.name ) );
  _.assert( _.routineIs( o.elementMaker ) );
  var symbol = Symbol.for( o.name );
  var elementMakerOriginal = o.elementMaker;
  var elementMaker = o.elementMaker;
  var friendField = o.friendField;

  if( friendField )
  elementMaker = function elementMaker( src )
  {
    src[ friendField ] = this;
    return elementMakerOriginal.call( this,src );
  }

  return function _setterMapCollection( src )
  {
    var self = this;

    _.assert( _.objectIs( src ) );

    if( self[ symbol ] )
    {

      if( src !== self[ symbol ] )
      for( var d in self[ symbol ] )
      delete self[ symbol ][ d ];

    }
    else
    {

      self[ symbol ] = Object.create( null );

    }

    for( var d in src )
    {
      if( src[ d ] !== null )
      self[ symbol ][ d ] = elementMaker.call( self,src[ d ] );
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

  _.assertMapHasOnly( o,setterMapCollection_functor.defaults );
  _.assert( _.strIs( o.name ) );
  _.assert( _.routineIs( o.elementMaker ) );
  var symbol = Symbol.for( o.name );
  var elementMakerOriginal = o.elementMaker;
  var elementMaker = o.elementMaker;
  var friendField = o.friendField;

  if( friendField )
  elementMaker = function elementMaker( src )
  {
    src[ friendField ] = this;
    return elementMakerOriginal.call( this,src );
  }

  return function _setterMapCollection( src )
  {
    var self = this;

    _.assert( _.arrayIs( src ) );

    if( self[ symbol ] )
    {

      if( src !== self[ symbol ] )
      self[ symbol ].splice( 0,self[ symbol ].length );

    }
    else
    {

      self[ symbol ] = [];

    }

    if( src !== self[ symbol ] )
    for( var d = 0 ; d < src.length ; d++ )
    {
      if( src[ d ] !== null )
      self[ symbol ].push( elementMaker.call( self,src[ d ] ) );
    }
    else for( var d = 0 ; d < src.length ; d++ )
    {
      if( src[ d ] !== null )
      src[ d ] = elementMaker.call( self,src[ d ] );
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

      if( self[ symbol ] !== src )
      self[ symbol ].copy( src );

    }

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
  var debug = o.debug;

  _.assert( arguments.length === 1 );
  _.assert( _.strIs( name ) );
  _.assert( _.routineIs( maker ) );
  _.assertMapHasOnly( o,setterCopyable_functor.defaults );

  return function setterCopyable( data )
  {
    var self = this;

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
    else
    {

      if( self[ symbol ] !== data )
      {
        _.assert( self[ symbol ].copy );
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

function setterAlias_functor( o )
{

  var original = o.original;
  var alias = o.alias;

  _.assert( arguments.length === 1 );
  _.routineOptions( setterAlias_functor,o );

  return function setterAlias( src )
  {
    var self = this;

    self[ original ] = src;

    return self[ original ];
  }

}

setterAlias_functor.defaults =
{
  original : null,
  alias : null,
}

//

function getterAlias_functor( o )
{

  var original = o.original;
  var alias = o.alias;

  _.assert( arguments.length === 1 );
  _.routineOptions( getterAlias_functor,o );

  return function getterAlias( src )
  {
    var self = this;
    return self[ original ];
  }

}

getterAlias_functor.defaults =
{
  original : null,
  alias : null,
}

// --
// etc
// --

function propertyDescriptorGet( object,name )
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
// proxy
// --

function proxyNoUndefined( ins )
{

  var validator =
  {
    set : function( obj, k, e )
    {
      if( obj[ k ] === undefined )
      throw _.err( 'Map does not have field',k );
      obj[ k ] = e;
      return true;
    },
    get : function( obj, k )
    {
      if( !_.symbolIs( k ) )
      if( obj[ k ] === undefined )
      throw _.err( 'Map does not have field',k );
      return obj[ k ];
    },

  }

  var result = new Proxy( ins, validator );

  return result;
}

//

function proxyReadOnly( ins )
{

  var validator =
  {
    set : function( obj, k, e )
    {
      throw _.err( 'Read only',_.strTypeOf( ins ),ins );
    }
  }

  var result = new Proxy( ins, validator );

  return result;
}

//

function ifDebugProxyReadOnly( ins )
{

  if( !Config.debug )
  return ins;

  return _.proxyReadOnly( ins );
}

//

function proxyMap( dst,original )
{

  _.assert( arguments.length === 2 );
  _.assert( dst );
  _.assert( original );

  var handler =
  {
    get : function( obj, k )
    {
      if( obj[ k ] !== undefined )
      return obj[ k ];
      return original[ k ];
    },
    set : function( obj, k, val, target )
    {
      if( obj[ k ] !== undefined )
      obj[ k ] = val;
      else if( original[ k ] !== undefined )
      original[ k ] = val;
      else
      obj[ k ] = val;
      return true;
    },
  }

  var result = new Proxy( dst, handler );

  return result;
}

//
//
// function synchronizerFor( instance )
// {
//   var cls = instance.Self;
//
//   _.assert( _.instanceIs( instance ) );
//   _.assert( _.classIs( cls ) );
//
//   debugger;
//
//   _.Consequence._synchronizerRoutinesFor( cls );
//
//   var result = new cls._Synchronizer();
//   Object.prevenExtensions( result );
//
//   var handler =
//   {
//     set : function( obj, k, e )
//     {
//       instance[ k ] = e;
//       return true;
//     },
//     get : function( obj, k )
//     {
//       if( obj[ k ] !== undefined )
//       return instance[ k ];
//       return true;
//     },
//   }
//
//   var result = new Proxy( instance , validator );
//   if( o.verbosity > 1 )
//   console.log( 'watching for',instance );
//
//   xxx
//
// }

// --
// class
// --

/**
* @typedef {object} wTools~prototypeOptions
* @property {routine} [o.cls=null] - constructor for which prototype is needed.
* @property {routine} [o.parent=null] - constructor of parent class.
* @property {object} [o.extend=null] - extend prototype by this map.
* @property {object} [o.supplement=null] - supplement prototype by this map.
* @property {object} [o.static=null] - static fields of a class.
* @property {boolean} [o.usingAtomicExtension=false] - extends class with atomic fields from relationship descriptors.
* @property {boolean} [o.usingOriginalPrototype=false] - makes prototype using original constructor prototype.
*/

/**
 * Make prototype for constructor repairing relationship : Composes, Aggregates, Associates, Medials, Restricts.
 * Execute optional extend / supplement if such o present.
 * @param {wTools~prototypeOptions} o - options {@link wTools~prototypeOptions}.
 * @returns {object} Returns constructor's prototype based on( o.parent ) prototype and complemented by fields, static and non-static methods.
 *
 * @example
 *  var Parent = function Alpha(){ };
 *  Parent.prototype.init = function(  )
 *  {
 *    var self = this;
 *    self.c = 5;
 *  };
 *
 *  var Self = function Betta( o )
 *  {
 *    return Self.prototype.init.apply( this,arguments );
 *  }
 *
 *  function init()
 *  {
 *    var self = this;
 *    Parent.prototype.init.call( this );
 *    _.mapExtendConditional( _.field.mapper.srcOwn,self,Composes );
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
 *   init : init,
 *   constructor : Self,
 *   Composes : Composes
 *  }
 *
 *  var proto = _.classMake
 *  ({
 *    // cls : Self, // xxx
 *    parent : Parent,
 *    extend : Proto,
 *  });
 *
 *  var betta = new Betta();
 *  console.log( proto === Self.prototype ); //returns true
 *  console.log( Parent.prototype.isPrototypeOf( betta ) ); //returns true
 *  console.log( betta.a, betta.b, betta.c ); //returns 1 2 5
 *
 * @method classMake
 * @throws {exception} If no argument provided.
 * @throws {exception} If( o ) is not a Object.
 * @throws {exception} If( o.cls ) is not a Routine.
 * @throws {exception} If( o.cls.name ) is not defined.
 * @throws {exception} If( o.cls.prototype ) has not own constructor.
 * @throws {exception} If( o.cls.prototype ) has restricted properties.
 * @throws {exception} If( o.parent ) is not a Routine.
 * @throws {exception} If( o.extend ) is not a Object.
 * @throws {exception} If( o.supplement ) is not a Object.
 * @throws {exception} If( o.parent ) is equal to( o.extend ).
 * @throws {exception} If function cant rewrite constructor using original prototype.
 * @throws {exception} If( o.usingOriginalPrototype ) is false and ( o.cls.prototype ) has manually defined properties.
 * @throws {exception} If( o.cls.prototype.constructor ) is not equal( o.cls  ).
 * @memberof wTools
 */

/*
_.classMake
({
  cls : Self,
  parent : Parent,
  extend : Proto,
  supplement : Original.prototype,
  usingAtomicExtension : true,
});
*/

function classMake( o )
{
  var result;

  if( o.withClass === undefined )
  o.withClass = true;

  if( o.cls && !o.name )
  o.name = o.cls.name;

  if( o.cls && !o.nameShort )
  o.nameShort = o.cls.nameShort;

  /* */

  var has =
  {
    constructor : 'constructor',
  }

  var hasNot =
  {
    Parent : 'Parent',
    Self : 'Self',
  }

  _.assert( arguments.length === 1 );
  _.assert( _.objectIs( o ) );
  _.assertOwnNoConstructor( o,'options for classMake should have no constructor' );
  _.assert( !( 'parent' in o ) || o.parent !== undefined,'parent is "undefined", something is wrong' );

  if( o.withClass )
  {

    _.assert( o.cls,'expects ( o.cls )' );
    _.assert( _.routineIs( o.cls ),'classMake expects constructor' );
    _.assert( o.cls.name || o.cls._name,'constructor should have name' );
    _.assert( _hasOwnProperty.call( o.cls.prototype,'constructor' ) );
    _.assert( !o.name || o.cls.name === o.name || o.cls._name === o.name,'class has name',o.cls.name + ', but options',o.name );
    _.assert( !o.nameShort || !o.cls.nameShort|| o.cls.nameShort === o.nameShort,'class has short name',o.cls.nameShort + ', but options',o.nameShort );

    _.assertMapOwnAll( o.cls.prototype,has,'classMake : expects constructor' );
    _.assertMapOwnNone( o.cls.prototype,hasNot );
    _.assertMapOwnNone( o.cls.prototype,ClassForbiddenNames );

    if( o.extend && _hasOwnProperty.call( o.extend,'constructor' ) )
    _.assert( o.extend.constructor === o.cls );

  }
  else
  {
    _.assert( !o.cls );
  }

  _.assert( _.routineIs( o.parent ) || o.parent === undefined || o.parent === null,'wrong type of parent :',_.strTypeOf( 'o.parent' ) );
  _.assert( _.objectIs( o.extend ) || o.extend === undefined );
  _.assert( _.objectIs( o.supplement ) || o.supplement === undefined );
  _.assert( o.parent !== o.extend );

  _.routineOptions( classMake,o );

  /* */

  var prototype;

  if( !o.parent )
  o.parent = null;

  // if( o.withMixin && o.withClass )
  // debugger;

  /* make prototype */

  if( o.withClass )
  {

    if( o.usingOriginalPrototype )
    {

      prototype = o.cls.prototype;

      // if( _hasOwnProperty.call( o.cls.prototype,'constructor' ) )
      // {
      //   // debugger;
      //   // // throw _.err( 'not tested' );
      //   // if( o.extend )
      //   // _assert( !o.extend.constructor || o.extend.constructor === o.cls,'cant rewrite constructor, using original prototype' );
      //   // if( o.supplementOwn )
      //   // _assert( !o.supplementOwn.constructor || o.supplementOwn.constructor === o.cls,'cant rewrite constructor, using original prototype' );
      //   // if( o.supplement )
      //   // _assert( !o.supplement.constructor || o.supplement.constructor === o.cls,'cant rewrite constructor, using original prototype' );
      // }

    }
    else
    {
      if( o.cls.prototype )
      {
        _.assert( Object.keys( o.cls.prototype ).length === 0,'misuse of classMake, prototype of constructor has properties which where put there manually',Object.keys( o.cls.prototype ) );
        _.assert( o.cls.prototype.constructor === o.cls );
      }
      if( o.parent )
      {
        prototype = o.cls.prototype = Object.create( o.parent.prototype );
      }
      else
      {
        prototype = o.cls.prototype = Object.create( null );
      }
    }

    /* constructor */

    prototype.constructor = o.cls;

    if( o.parent )
    {
      Object.setPrototypeOf( o.cls,o.parent );
    }

    /* extend */

    _.classExtend
    ({
      cls : o.cls,
      extend : o.extend,
      supplementOwn : o.supplementOwn,
      supplement : o.supplement,
      usingAtomicExtension : o.usingAtomicExtension,
      usingStatics : 1,
      allowingExtendStatics : o.allowingExtendStatics,
    });

    /* statics */

    /*
      !!! implement accessor for static properties
    */

    _.assert( prototype.constructor );
    _.assert( prototype.Statics );

    _.mapExtendConditional( _.field.mapper.dstNotOwnSrcOwn,prototype,prototype.Statics ); // xxx
    _.mapExtendConditional( _.field.mapper.dstNotOwnSrcOwn,prototype.constructor,prototype.Statics ); // xxx

    _.assert( prototype === o.cls.prototype );
    _.assert( _hasOwnProperty.call( prototype,'constructor' ),'prototype should has own constructor' );
    _.assert( _.routineIs( prototype.constructor ),'prototype should has own constructor' );

    /* mixin tracking */

    if( !_hasOwnProperty.call( prototype,'_mixinsMap' ) )
    {
      prototype._mixinsMap = Object.create( prototype._mixinsMap || null );
    }

    _.assert( !prototype._mixinsMap[ o.cls.name ] );

    prototype._mixinsMap[ o.cls.name ] = 1;

    result = o.cls;
  }

  /* */

  if( o.withMixin )
  {

    var mixinOptions = _.mapExtend( null,o );

    _.assert( !o.usingAtomicExtension );
    _.assert( !o.usingOriginalPrototype );
    _.assert( !o.parent );
    _.assert( !o.cls || o.withClass );

    // if( o.withClass )
    // mixinOptions = _.mapSupplement( mixinOptions.cls,mixinOptions );

    delete mixinOptions.parent;
    delete mixinOptions.cls;
    delete mixinOptions.withMixin;
    delete mixinOptions.withClass;
    delete mixinOptions.usingAtomicExtension;
    delete mixinOptions.usingOriginalPrototype;
    delete mixinOptions.allowingExtendStatics;

    mixinOptions.prototype = prototype;

    result = _.mixinMake( mixinOptions );

    if( o.withClass )
    {
      result = _.mapSupplement( o.cls,result );
    }

  }

  /* handler */

  if( prototype.onClassMakeEnd )
  prototype.onClassMakeEnd( o );

  /* */

  if( Config.debug )
  if( prototype )
  {
    var descriptor = Object.getOwnPropertyDescriptor( prototype,'constructor' );
    _.assert( descriptor.writable || descriptor.set );
    _.assert( descriptor.configurable );
  }

  return result;
}

classMake.defaults =
{
  cls : null,
  parent : null,

  extend : null,
  supplementOwn : null,
  supplement : null,

  name : null,
  nameShort : null,

  usingAtomicExtension : false,
  usingOriginalPrototype : false,
  allowingExtendStatics : false,

  withMixin : false,
  withClass : true,
}

//

/**
 * Extends and supplements( o.cls ) prototype by fields and methods repairing relationship : Composes, Aggregates, Associates, Medials, Restricts.
 *
 * @param {wTools~prototypeOptions} o - options {@link wTools~prototypeOptions}.
 * @returns {object} Returns constructor's prototype complemented by fields, static and non-static methods.
 *
 * @example
 * var Self = function Betta( o ) { };
 * var Statics = { staticFunction : function staticFunction(){ } };
 * var Composes = { a : 1, b : 2 };
 * var Proto = { constructor : Self, Composes : Composes, Statics : Statics };
 *
 * var proto =  _.classExtend
 * ({
 *     cls : Self,
 *     extend : Proto,
 * });
 * console.log( Self.prototype === proto ); //returns true
 *
 * @method classExtend
 * @throws {exception} If no argument provided.
 * @throws {exception} If( o ) is not a Object.
 * @throws {exception} If( o.cls ) is not a Routine.
 * @throws {exception} If( prototype.cls ) is not a Routine.
 * @throws {exception} If( o.cls.name ) is not defined.
 * @throws {exception} If( o.cls.prototype ) has not own constructor.
 * @throws {exception} If( o.parent ) is not a Routine.
 * @throws {exception} If( o.extend ) is not a Object.
 * @throws {exception} If( o.supplement ) is not a Object.
 * @throws {exception} If( o.static) is not a Object.
 * @throws {exception} If( o.cls.prototype.Constitutes ) is defined.
 * @throws {exception} If( o.cls.prototype ) is not equal( prototype ).
 * @memberof wTools
 */

function classExtend( o )
{

  if( arguments.length === 2 )
  o = { cls : arguments[ 0 ], extend : arguments[ 1 ] };

  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.objectIs( o ) );
  _.assert( !_hasOwnProperty.call( o,'constructor' ) );
  _.assertOwnNoConstructor( o );
  _.assert( _.objectIs( o.extend ) || o.extend === undefined || o.extend === null );
  _.assert( _.objectIs( o.supplementOwn ) || o.supplementOwn === undefined || o.supplementOwn === null );
  _.assert( _.objectIs( o.supplement ) || o.supplement === undefined || o.supplement === null );

  if( o.cls || !o.prototype )
  {
    _.assert( _.routineIs( o.cls ),'expects constructor of class ( o.cls )' );
    _.assert( o.cls.name || o.cls._name,'class constructor should have name' );
  }

  if( o.extend )
  {
    _.assert( o.extend.cls === undefined );
    _.assertOwnNoConstructor( o.extend );
  }
  if( o.supplementOwn )
  {
    _.assert( o.supplementOwn.cls === undefined );
    _.assertOwnNoConstructor( o.supplementOwn );
  }
  if( o.supplement )
  {
    _.assert( o.supplement.cls === undefined );
    _.assertOwnNoConstructor( o.supplement );
  }

  _.routineOptions( classExtend,o );

  if( !o.prototype )
  o.prototype = o.cls.prototype;

  _.assert( _.objectIs( o.prototype ) );

  /* adjust relationships */

  for( var f in _.ClassSubfieldsGroups )
  _.descendantAdd
  ({
    descendantName : f,
    dstProto : o.prototype,
    override : true,
  });

  function descendantAdd( src,override,dstNotOwn )
  {
    if( !src )
    return;

    for( var f in _.ClassSubfieldsGroups )
    {

      if( !src[ f ] )
      continue;

      _.descendantAdd
      ({
        descendantName : f,
        dstProto : o.prototype,
        srcMap : src[ f ],
        override : override,
        dstNotOwn : dstNotOwn,
      });

      if( !_.ClassSubfieldsGroupsRelationships[ f ] )
      continue;

      if( Config.debug )
      for( var f2 in _.ClassSubfieldsGroupsRelationships )
      if( f2 === f )
      continue;
      else for( var k in src[ f ] )
      {
        _.assert( o.prototype[ f2 ][ k ] === undefined,'facility group','"'+f2+'"','already has facility','"'+k+'"','facility group','"'+f+'"','should not have the same' );
      }

    }

  }

  descendantAdd( o.extend,true,false );
  descendantAdd( o.supplementOwn,true,true );
  descendantAdd( o.supplement,false,false );

  /* get constructor */

  if( !o.cls )
  o.cls = _._classConstructorAndPrototypeGet( o ).cls;

  var StaticsOwn = _.mapOwnProperties( o.prototype.Statics );
  function ordinaryExtend( extend,src )
  {
    var map = _.mapBut( src,_.ClassSubfieldsGroups );
    extend( o.prototype,map );
    if( Config.debug )
    if( !o.allowingExtendStatics )
    if( Object.getPrototypeOf( o.prototype.Statics ) )
    {
      map = _.mapBut( map,StaticsOwn );
      var keys = _.mapKeys( _.mapScreen( Object.getPrototypeOf( o.prototype.Statics ), map ) );
      if( keys.length )
      {
        _.assert( 0,'attempt to extend static field',keys );
      }
    }
  }

/*

to prioritize ordinary facets adjustment order should be

- static extend
- ordinary extend
- ordinary supplement
- static supplement

*/

  /* static extend */

  if( !o.prototype.constructor )
  if( o.usingStatics && o.extend && o.extend.Statics )
  {
    _.mapExtend( o.prototype,o.extend.Statics );
    if( o.cls )
    _.mapExtend( o.cls,o.extend.Statics );
  }

  /* ordinary extend */

  if( o.extend )
  {
    ordinaryExtend( _.mapExtend, o.extend );
  }

  /* ordinary supplementOwn */

  if( o.supplementOwn )
  {
    ordinaryExtend( _.mapSupplementOwn, o.supplementOwn );
  }

  /* ordinary supplement */

  if( o.supplement )
  {
    ordinaryExtend( _.mapSupplement, o.supplement );
  }

  /* static supplementOwn */

  if( !o.prototype.constructor )
  if( o.usingStatics && o.supplementOwn && o.supplementOwn.Statics )
  {
    _.mapSupplementOwn( o.prototype, o.supplementOwn.Statics );
    if( o.cls )
    _.mapSupplementOwn( o.cls, o.supplementOwn.Statics );
  }

  /* static supplement */

  if( !o.prototype.constructor )
  if( o.usingStatics && o.supplement && o.supplement.Statics )
  {
    _.mapSupplement( o.prototype, o.supplement.Statics );
    if( o.cls )
    _.mapSupplement( o.cls, o.supplement.Statics );
  }

  /* atomic extend */

  if( o.usingAtomicExtension )
  {
    for( var f in _.ClassSubfieldsGroups )
    if( f !== 'Statics' )
    if( _.mapOwnKey( o.prototype,f ) )
    _.mapExtendConditional( _.field.mapper.srcOwnPrimitive, o.prototype, o.prototype.Composes );
  }

  /* accessors */

  function declareAccessors( src )
  {
    for( var d in ClassAccessorsMap )
    if( src[ d ] )
    {
      ClassAccessorsMap[ d ]( o.prototype,src[ d ] );
    }
  }

  if( o.supplement )
  declareAccessors( o.supplement );
  if( o.supplementOwn )
  declareAccessors( o.supplementOwn );
  if( o.extend )
  declareAccessors( o.extend );

  /* statics */

  if( o.usingStatics )
  if( o.prototype.constructor )
  for( var _s in o.prototype.Statics ) (function()
  {
    var s = _s;
    var prototype = o.prototype;
    var value = o.prototype.Statics[ s ];

    // if( s === '_allFieldsGet' )
    // debugger;

    if( !_hasOwnProperty.call( o.prototype.Statics,s ) )
    return;

    var pd = _.propertyDescriptorGet( o.prototype,s );
    var cd = _.propertyDescriptorGet( o.prototype.constructor,s );

    // if( pd.descriptor && pd.descriptor.value !== undefined )
    // {
    //   if( pd.descriptor.value === value )
    //   pd.descriptor = null;
    // }
    //
    // if( cd.descriptor && cd.descriptor.value !== undefined )
    // {
    //   if( cd.descriptor.value === value )
    //   cd.descriptor = null;
    // }

    if( pd.object !== prototype )
    pd.descriptor = null;

    if( cd.object !== prototype.constructor )
    cd.descriptor = null;

    if( s === 'constructor' )
    return;

    // _.assert( !pd ^ !!cd.descriptor );
    _.assert( s !== 'constructor' );

    // if( pd.descriptor || cd.descriptor )
    // return;

    var symbol = Symbol.for( s );

    if( !pd.descriptor )
    {
      if( cd.descriptor )
      {
        o.prototype[ s ] = value;
      }
      else
      {
        o.prototype[ symbol ] = value;
        Object.defineProperty( o.prototype, s,
        {
          set : function( src ){ prototype[ symbol ] = src; prototype.constructor[ symbol] = src; },
          get : function(){ return this[ symbol ]; },
          enumerable : false,
          configurable : true,
        });
      }
    }

    if( !cd.descriptor )
    {
      if( pd.descriptor )
      {
        o.prototype.constructor[ s ] = value;
      }
      else
      {
        o.prototype.constructor[ symbol ] = value;
        Object.defineProperty( o.prototype.constructor, s,
        {
          set : function( src ){ prototype[ symbol ] = src; prototype.constructor[ symbol] = src; },
          get : function(){ return this[ symbol ]; },
          enumerable : true,
          configurable : true,
        });
      }
    }

  })();

  /* functors */

  if( o.functor )
  for( var m in o.functor )
  {
    var func = o.functor[ m ].call( o,o.prototype[ m ] );
    _.assert( _.routineIs( func ),'not tested' );
    o.prototype[ m ] = func;
  }

  /* validation */

  if( o.cls )
  {
    _.assert( o.prototype === o.cls.prototype );
    _.assert( _hasOwnProperty.call( o.prototype,'constructor' ),'prototype should has own constructor' );
    _.assert( _.routineIs( o.prototype.constructor ),'prototype should has own constructor' );
  }

  return o.prototype;
}

classExtend.defaults =
{
  cls : null,
  prototype : null,

  extend : null,
  supplementOwn : null,
  supplement : null,
  functor : null,

  usingStatics : true,
  usingAtomicExtension : false,
  allowingExtendStatics : false,
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

  if( proto === null )
  return null;
  else
  return proto.constructor;
}

//

function subclassIs( cls,subCls )
{

  _.assert( _.routineIs( cls ) );
  _.assert( _.routineIs( subCls ) );
  _.assert( arguments.length === 2 );

  if( cls === subCls )
  return true;

  return Object.isPrototypeOf.call( cls.prototype, subCls.prototype );
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

function _classConstructorAndPrototypeGet( o )
{
  var result = Object.create( null );

  if( !result.cls )
  if( o.prototype )
  result.cls = o.prototype.constructor;

  if( !result.cls )
  if( o.extend )
  if( o.extend.constructor !== Object.prototype.constructor )
  result.cls = o.extend.constructor;

  if( !result.cls )
  if( o.usingStatics && o.extend && o.extend.Statics )
  if( o.extend.Statics.constructor !== Object.prototype.constructor )
  result.cls = o.extend.Statics.constructor;

  if( !result.cls )
  if( o.supplement )
  if( o.supplement.constructor !== Object.prototype.constructor )
  result.cls = o.supplement.constructor;

  if( !result.cls )
  if( o.usingStatics && o.supplement && o.supplement.Statics )
  if( o.supplement.Statics.constructor !== Object.prototype.constructor )
  result.cls = o.supplement.Statics.constructor;

  if( o.prototype )
  result.prototype = o.prototype;
  else if( result.cls )
  result.prototype = result.cls.prototype;

  if( o.prototype )
  _.assert( result.cls === o.prototype.constructor );

  return result;
}

// --
// define class
// --

function prototypeGet( src )
{

  if( !( 'constructor' in src ) )
  return null;

  var c = constructorGet( src );

  _.assert( arguments.length === 1 );

  return c.prototype;
}

//

/**
 * Make united interface for several maps. Access to single map cause read and write to original maps.
 * @param {array} protos - maps to united.
 * @return {object} united interface.
 * @method prototypeUnitedInterface
 * @memberof wTools
 */

function prototypeUnitedInterface( protos )
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
      throw _.err( 'prototypeUnitedInterface :','several objects try to unite have same field :',f );
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

/**
 * Append prototype to object. Find archi parent and replace its proto.
 * @param {object} dstMap - dst object to append proto.
 * @method prototypeAppend
 * @memberof wTools
 */

function prototypeAppend( dstMap )
{

  _assert( _.objectIs( dstMap ) );

  for( var a = 1 ; a < arguments.length ; a++ )
  {
    var proto = arguments[ a ];

    _assert( _.objectIs( proto ) );

    var parent = _.prototypeArchyGet( dstMap );
    Object.setPrototypeOf( parent, proto );

  }

  return dstMap;
}

//

/**
 * Does srcProto has insProto as prototype.
 * @param {object} srcProto - proto stack to investigate.
 * @param {object} insProto - proto to look for.
 * @method prototypeHas
 * @memberof wTools
 */

function prototypeHas( srcProto,insProto )
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
 * @param {object} srcPrototype - src object to investigate proto stack.
 * @method prototypeHasProperty
 * @memberof wTools
 */

function prototypeHasProperty( srcPrototype,names )
{
  var names = _nameFielded( names );
  _assert( _.objectIs( srcPrototype ) );

  do
  {
    var has = true;
    for( var n in names )
    if( !_hasOwnProperty.call( srcPrototype,n ) )
    {
      has = false;
      break;
    }
    if( has )
    return srcPrototype;

    srcPrototype = Object.getPrototypeOf( srcPrototype );
  }
  while( srcPrototype !== Object.prototype && srcPrototype );

  return null;
}

//

/**
 * Returns parent which has default proto.
 * @param {object} srcPrototype - dst object to append proto.
 * @method prototypeArchyGet
 * @memberof wTools
 */

function prototypeArchyGet( srcPrototype )
{

  _assert( _.objectIs( srcPrototype ) );

  while( Object.getPrototypeOf( srcPrototype ) !== Object.prototype )
  srcPrototype = Object.getPrototypeOf( srcPrototype );

  return srcPrototype;
}

//

var _protoCrossReferAssociations = Object.create( null );
function prototypeCrossRefer( o )
{
  var names = _.mapKeys( o.entities );
  var length = names.length;

  var association = _protoCrossReferAssociations[ o.name ];
  if( !association )
  {
    _.assert( _protoCrossReferAssociations[ o.name ] === undefined );
    association = _protoCrossReferAssociations[ o.name ] = Object.create( null );
    association.name = o.name;
    association.length = length;
    association.have = 0;
    association.entities = _.mapExtend( null,o.entities );
  }
  else
  {
    _.assert( _.arraySetIdentical( _.mapKeys( association.entities ), _.mapKeys( o.entities ) ),'cross reference should have same associations' );
  }

  _.assert( association.name === o.name );
  _.assert( association.length === length );

  for( var e in o.entities )
  {
    if( !association.entities[ e ] )
    association.entities[ e ] = o.entities[ e ];
    else if( o.entities[ e ] )
    _.assert( association.entities[ e ] === o.entities[ e ] );
  }

  association.have = 0;
  for( var e in association.entities )
  if( association.entities[ e ] )
  association.have += 1;

  if( association.have === association.length )
  {

    for( var src in association.entities )
    for( var dst in association.entities )
    {
      if( src === dst )
      continue;
      var dstEntity = association.entities[ dst ];
      var srcEntity = association.entities[ src ];
      _.assert( !dstEntity[ src ] || dstEntity[ src ] === srcEntity,'override of entity',src );
      _.assert( !dstEntity.prototype[ src ] || dstEntity.prototype[ src ] === srcEntity );
      _.classExtend( dstEntity,{ Statics : { [ src ] : srcEntity } } );
      _.assert( dstEntity[ src ] === srcEntity );
      _.assert( dstEntity.prototype[ src ] === srcEntity );
    }

    _protoCrossReferAssociations[ o.name ] = null;

    return true;
  }

  return false;
}

prototypeCrossRefer.defaults =
{
  entities : null,
  name : null,
}

// _.prototypeCrossRefer
// ({
//   namespace : _,
//   entities :
//   {
//     System : Self,
//   },
//   names :
//   {
//     System : 'LiveSystem',
//     Node : 'LiveNode',
//   },
// });

//

/**
 * Iterate through prototypes.
 * @param {object} proto - prototype
 * @method prototypeEach
 * @memberof wTools
 */

function prototypeEach( proto,onEach )
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

function prototypeAllFieldsGet( src )
{
  var prototype = _.prototypeGet( src );
  var result = Object.create( null );

  _.assert( _.prototypeIs( prototype ) || _.constructorIs( prototype ) );
  _.assert( _.prototypeIsStandard( prototype ),'expects standard prototype' );
  _.assert( arguments.length === 1 );

  if( prototype.Composes )
  _.mapExtend( result,prototype.Composes );
  if( prototype.Aggregates )
  _.mapExtend( result,prototype.Aggregates );
  if( prototype.Associates )
  _.mapExtend( result,prototype.Associates );

  if( prototype.Medials )
  _.mapExtend( result,prototype.Medials );
  if( prototype.Restricts )
  _.mapExtend( result,prototype.Restricts );

  return result;
}

//

function prototypeCopyableFieldsGet( src )
{
  var prototype = _.prototypeGet( src );
  var result = Object.create( null );

  _.assert( _.prototypeIs( prototype ) || _.constructorIs( prototype ) );
  _.assert( _.prototypeIsStandard( prototype ),'expects standard prototype' );
  _.assert( arguments.length === 1 );

  if( prototype.Composes )
  _.mapExtend( result,prototype.Composes );
  if( prototype.Aggregates )
  _.mapExtend( result,prototype.Aggregates );
  if( prototype.Associates )
  _.mapExtend( result,prototype.Associates );

  return result;
}

//

function prototypeLoggableFieldsGet( src )
{
  var prototype = _.prototypeGet( src );
  var result = Object.create( null );

  _.assert( _.prototypeIs( prototype ) || _.constructorIs( prototype ) );
  _.assert( _.prototypeIsStandard( prototype ),'expects standard prototype' );
  _.assert( arguments.length === 1 );

  if( prototype.Composes )
  _.mapExtend( result,prototype.Composes );
  if( prototype.Aggregates )
  _.mapExtend( result,prototype.Aggregates );

  return result;
}

//

function prototypeHasField( src,fieldName )
{
  var prototype = _.prototypeGet( src );

  _.assert( _.prototypeIs( prototype ) || _.constructorIs( prototype ) );
  _.assert( _.prototypeIsStandard( prototype ),'expects standard prototype' );
  _.assert( arguments.length === 2 );

  for( var f in _.ClassSubfieldsGroupsRelationships )
  if( prototype[ f ][ fieldName ] )
  return true;

  return false;
}

// --
// instance
// --

/**
 * Is this instance finited.
 * @method instanceIsFinited
 * @param {object} src - instance of any class
 * @memberof wCopyable#
 */

function instanceIsFinited( src )
{
  _.assert( _.instanceIs( src ) )
  _.assert( _.objectLikeOrRoutine( src ) );
  return Object.isFrozen( src );
}

//

function instanceFinit( src )
{

  _.assert( !Object.isFrozen( src ) );
  _.assert( _.objectLikeOrRoutine( src ) );
  _.assert( arguments.length === 1 );

  // var validator =
  // {
  //   set : function( obj, k, e )
  //   {
  //     debugger;
  //     throw _.err( 'Attempt ot access to finited instance with field',k );
  //     return false;
  //   },
  //   get : function( obj, k, e )
  //   {
  //     debugger;
  //     throw _.err( 'Attempt ot access to finited instance with field',k );
  //     return false;
  //   },
  // }
  // var result = new Proxy( src, validator );

  Object.freeze( src );

}

//

/**
 * Complements instance by its semantic relationships : Composes, Aggregates, Associates, Medials, Restricts.
 * @param {object} instance - instance to complement.
 *
 * @example
 * var Self = function Alpha( o ) { };
 *
 * var Proto = { constructor: Self, Composes : { a : 1, b : 2 } };
 *
 * _.classMake
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
  _.mapSupplementOwnAssigning( instance,prototype.Associates );

  return instance;
}

//

function instanceInitExtending( instance,prototype )
{

  _.assert( arguments.length === 1 || arguments.length === 2 );

  if( prototype === undefined )
  prototype = instance;

  _.mapExtendConditional( _.field.mapper.assigning, instance, prototype.Restricts );
  _.mapExtendConditional( _.field.mapper.assigning, instance, prototype.Composes );
  _.mapExtendConditional( _.field.mapper.assigning, instance, prototype.Aggregates );
  _.mapExtend( instance,prototype.Associates );

  return instance;
}

//

function instanceFilterInit( o )
{

  _.routineOptions( instanceFilterInit,o );

  // var self = _.instanceFilterInit
  // ({
  //   cls : Self,
  //   parent : Parent,
  //   extend : Extend,
  // });

  _.assertOwnNoConstructor( o );
  _.assert( _.routineIs( o.cls ) );
  _.assert( !o.args || o.args.length === 0 || o.args.length === 1 );

  var result = Object.create( null );

  _.instanceInit( result,o.cls.prototype );

  if( o.args[ 0 ] )
  _.Copyable.prototype.copyCustom.call( o.cls.prototype,
  {
    proto : o.cls.prototype,
    src : o.args[ 0 ],
    dst : result,
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
  cls : null,
  parent : null,
  extend : null,
  args : null,
  strict : 1,
}

//

/**
 * Make sure src does not have redundant fields.
 * @param {object} src - source object of the class.
 * @method assertInstanceDoesNotHaveReduntantFields
 * @memberof wTools
 */

function assertInstanceDoesNotHaveReduntantFields( src )
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
// default
// --

/*
apply default to each element of map, if present
*/

function defaultApply( src )
{

  _.assert( _.objectIs( src ) || _.arrayLike( src ) );
  _.assert( def === _.def );

  var defVal = src[ def ];

  if( !defVal )
  return src;

  _.assert( _.objectIs( src ) );

  if( _.objectIs( src ) )
  {

    for( var s in src )
    {
      if( !_.objectIs( src[ s ] ) )
      continue;
      _.mapSupplement( src[ s ],defVal );
    }

  }
  else
  {

    for( var s = 0 ; s < src.length ; s++ )
    {
      if( !_.objectIs( src[ s ] ) )
      continue;
      _.mapSupplement( src[ s ],defVal );
    }

  }

  return src;
}

//

/*
activate default proxy
*/

function defaultProxy( map )
{

  _.assert( _.objectIs( map ) );
  _.assert( arguments.length === 1 );

  var validator =
  {
    set : function( obj, k, e )
    {
      obj[ k ] = _.defaultApply( e );
      return true;
    }
  }

  var result = new Proxy( map, validator );
  // var result = new Proxy( [], validator );

  for( var k in map )
  {
    _.defaultApply( map[ k ] );
  }

  // debugger;
  // var is = _.mapIs( result );
  // var is = _.strTypeOf( result );
  // debugger;

  return result;
}

//

function defaultProxyFlatteningToArray( src )
{
  var result = [];

  _.assert( arguments.length === 1 );
  _.assert( _.objectIs( src ) || _.arrayIs( src ) );

  function flatten( src )
  {

    if( _.arrayIs( src ) )
    {
      for( var s = 0 ; s < src.length ; s++ )
      flatten( src[ s ] );
    }
    else
    {
      if( _.objectIs( src ) )
      result.push( defaultApply( src ) );
      else
      result.push( src );
    }

  }

  flatten( src );

  return result;
}

// --
// type
// --

class wCallableObject extends Function
{
  constructor()
  {
    super( 'return this.self.__call__.apply( this.self,arguments );' );

    var context = Object.create( null );
    var self = this.bind( context );
    context.self = self;
    Object.freeze( context );

    return self;
  }
}

wCallableObject.nameShort = 'CallableObject';

// --
// var
// --

var Combining = [ 'rewrite','supplement','apppend','prepend' ];

/**
 * @global {Object} wTools~ClassSubfieldsGroupsRelationships - contains predefined class relationship types.
 * @memberof wTools
 */

var ClassSubfieldsGroupsRelationships = Object.create( null );
ClassSubfieldsGroupsRelationships.Composes = 'Composes';
ClassSubfieldsGroupsRelationships.Aggregates = 'Aggregates';
ClassSubfieldsGroupsRelationships.Associates = 'Associates';
ClassSubfieldsGroupsRelationships.Restricts = 'Restricts';

var ClassSubfieldsGroups = Object.create( null );
ClassSubfieldsGroups.Composes = 'Composes';
ClassSubfieldsGroups.Aggregates = 'Aggregates';
ClassSubfieldsGroups.Associates = 'Associates';
ClassSubfieldsGroups.Medials = 'Medials';
ClassSubfieldsGroups.Restricts = 'Restricts';
ClassSubfieldsGroups.Statics = 'Statics';

var ClassForbiddenNames = Object.create( null );
ClassForbiddenNames.Static = 'Static';
ClassForbiddenNames.Type = 'Type';
Object.freeze( ClassForbiddenNames );

var ClassAccessorsMap = Object.create( null );
ClassAccessorsMap.Accessors = accessor;
ClassAccessorsMap.Forbids = accessorForbid;
ClassAccessorsMap.AccessorsForbid = accessorForbid;
ClassAccessorsMap.AccessorsReadOnly = accessorReadOnly;

// --
// define class
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

  // accessorOwn : accessorOwn,

  accessor : accessor,
  accessorForbid : accessorForbid,
  accessorForbidOwn : accessorForbidOwn,
  accessorReadOnly : accessorReadOnly,

  accessorsSupplement : accessorsSupplement,

  constant : constant,
  restrictReadOnly : restrictReadOnly,

  accessorToElement : accessorToElement,
  accessorDescriptorGet : accessorDescriptorGet,


  // mixin

  mixinMake : mixinMake,
  mixinApply : mixinApply,
  mixinHas : mixinHas,


  // descendant

  descendantMakeOwnedBy : descendantMakeOwnedBy, /* experimental */
  descendantAdd : descendantAdd,  /* experimental */

  descendantComposesAddTo : descendantComposesAddTo, /* experimental */
  descendantAggregatesAddTo : descendantAggregatesAddTo, /* experimental */
  descendantAssociatesAddTo : descendantAssociatesAddTo, /* experimental */
  descendantRestrictsAddTo : descendantRestrictsAddTo, /* experimental */


  // getter / setter functor

  setterMapCollection_functor : setterMapCollection_functor,
  setterArrayCollection_functor : setterArrayCollection_functor,

  setterFriend_functor : setterFriend_functor,
  setterCopyable_functor : setterCopyable_functor,
  setterBufferFrom_functor : setterBufferFrom_functor,
  setterChangesTracking_functor : setterChangesTracking_functor,

  setterAlias_functor : setterAlias_functor,
  getterAlias_functor : getterAlias_functor,


  // etc

  propertyDescriptorGet : propertyDescriptorGet,
  propertyGetterSetterGet : propertyGetterSetterGet,


  // proxy

  proxyNoUndefined : proxyNoUndefined,
  proxyReadOnly : proxyReadOnly,
  ifDebugProxyReadOnly : ifDebugProxyReadOnly,
  proxyMap : proxyMap,


  // class

  classMake : classMake,
  classExtend : classExtend,

  constructorGet : constructorGet,

  subclassIs : subclassIs,
  parentGet : parentGet,
  _classConstructorAndPrototypeGet : _classConstructorAndPrototypeGet,


  // define class

  prototypeGet : prototypeGet,

  prototypeUnitedInterface : prototypeUnitedInterface, /* experimental */

  prototypeAppend : prototypeAppend, /* experimental */
  prototypeHas : prototypeHas, /* experimental */
  prototypeHasProperty : prototypeHasProperty, /* experimental */
  prototypeArchyGet : prototypeArchyGet, /* experimental */

  prototypeCrossRefer : prototypeCrossRefer,
  prototypeEach : prototypeEach,

  prototypeAllFieldsGet : prototypeAllFieldsGet,
  prototypeCopyableFieldsGet : prototypeCopyableFieldsGet,
  prototypeLoggableFieldsGet : prototypeLoggableFieldsGet,

  prototypeHasField : prototypeHasField,


  // instance

  instanceIsFinited : instanceIsFinited,
  instanceFinit : instanceFinit,

  instanceInit : instanceInit,
  instanceInitExtending : instanceInitExtending,
  instanceFilterInit : instanceFilterInit, /* deprecated */

  assertInstanceDoesNotHaveReduntantFields : assertInstanceDoesNotHaveReduntantFields,


  // default

  defaultApply : defaultApply,
  defaultProxy : defaultProxy,
  defaultProxyFlatteningToArray : defaultProxyFlatteningToArray,


  // var

  CallableObject : wCallableObject,
  Combining : Combining,
  ClassSubfieldsGroupsRelationships : ClassSubfieldsGroupsRelationships,
  ClassSubfieldsGroups : ClassSubfieldsGroups,
  ClassForbiddenNames : ClassForbiddenNames,
  ClassAccessorsMap : ClassAccessorsMap,

}

_global_.wProto = Proto;

_.mapExtend( Self, Proto );

_.accessorForbid( _,
{
  _ArrayDescriptor : '_ArrayDescriptor',
  ArrayDescriptor : 'ArrayDescriptor',
  _ArrayDescriptors : '_ArrayDescriptors',
  ArrayDescriptors : 'ArrayDescriptors',
  arrays : 'arrays',
  arrayOf : 'arrayOf',
});

// --
// export
// --

if( typeof module !== 'undefined' )
if( _global_.WTOOLS_PRIVATE )
delete require.cache[ module.id ];

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

// --
// import
// --

if( typeof module !== 'undefined' )
{

  if( !_.construction )
  require( './ProtoLike.s' );

}

})();
