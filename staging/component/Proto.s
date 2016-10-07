
/**
* Definitions :
*  self :: current object.
*  Self :: current class.
*  Parent :: parent class.
*  Static :: static fields.
*  extend :: extend destination with all properties from source.
*  supplement :: supplement destination with those properties from source which do not belong to source.
*  routine :: alias of a function.
*  method :: routine is called as 'method' when context( this ) points to instance of current class.
*/

/**
* Relationships:
*  A composes B
*    :: A consists of B.
*    :: A comprises B.
*    :: A made up of B.
*    :: A exists because of B, and B exists because of A.
*  A aggregates B
*    :: A has B.
*    :: A exists because of B, but B exists without A.
*  A associate B
*    :: A has link on B
*    :: A is linked with B
*  A restricts B
*    :: A use B.
*    :: A has occasional relation with B.
*/

( function _Proto_s_() {

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

_.assert( _.routineIs( _nameFielded ) );

// --
// property
// --

var _accessorOptions = function( object,names )
{
  var o = arguments.length === 1 ? arguments[ 0 ] : {};

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

  var names = o.names = _nameFielded( names );

  if( arguments.length > 2 )
  {
    o.message = _.arraySlice( arguments,2 );
  }

  return o;
}

//

var _accessor = function( o )
{
  var object = o.object;
  var names = o.names;
  var methods = o.methods;
  var message = o.message;

  /* verification */

  _assert( !_.atomicIs( object ) );
  _assert( !_.atomicIs( methods ) );
  _assert( !o.message || _.arrayIs( o.message ) );
  _.assertMapHasOnly( o,_accessor.defaults );
  _.mapComplement( o,_accessor.defaults );

  if( o.strict /*&& o.preserveValues*/ )
  {

    var has =
    {
      constructor : 'constructor',
    }

    var hasNot =
    {
      Type : 'Type',
      type : 'type',
    }

    _.assertMapOwnAll( object,has );
    _.accessorForbidOnce( object,hasNot );

  }

  _assert( _.objectLike( object ),'_.accessor :','expects object as argument but got', object );
  _assert( _.objectIs( names ),'_.accessor :','expects object names as argument but got', names );

  //

  var _name = names;
  for( var n in _name )
  {

    (function _accessorField()
    {

      var encodedName = n;
      var rawName = _name[ n ];

      var redefinition = false;
      var parent = object.constructor ? Object.getPrototypeOf( object.constructor.prototype ) : null;
      if( parent )
      redefinition = parent[ rawName + 'Get' ] !== undefined || parent[ '_' + rawName + 'Get' ] !== undefined;

      var setter = methods[ '_' + rawName + 'Set' ] ? methods[ '_' + rawName + 'Set' ] : methods[ rawName + 'Set' ];
      var getter = methods[ '_' + rawName + 'Get' ] ? methods[ '_' + rawName + 'Get' ] : methods[ rawName + 'Get' ];

      var fieldName = '_' + rawName;
      var fieldSymbol = Symbol.for( rawName );

      if( o.preserveValues )
      if( _hasOwnProperty.call( object,encodedName ) )
      object[ fieldSymbol ] = object[ encodedName ];

      // setter

      if( !setter && !o.readOnly )
      if( message )
      setter = function setter( src )
      {
        console.info.apply( console,message );
        this[ fieldSymbol ] = src;
      }
      else
      setter = function setter( src )
      {
        this[ fieldSymbol ] = src;
      }

      _assert( !setter || !o.readOnly,'accessor :','readOnly but setter found in',object );

      // getter

      if( !getter )
      if( message )
      getter = function getter()
      {
        console.info.apply( console,message );
        return this[ fieldSymbol ];
      }
      else
      getter = function getter()
      {
        return this[ fieldSymbol ];
      }

      // define accessor

      Object.defineProperty( object, encodedName,
      {
        set : setter,
        get : getter,
        enumerable : o.enumerable,
        configurable : false,
      });

      // define private field

      if( o.strict && !redefinition )
      {
        var m =
        [ 'use Symbol.for( \'' + rawName + '\' ) ',
          'to get direct access to property\'s field, ',
          'not ' + fieldName,
        ].join( '' );
        _.accessorForbid( object,fieldName,m );
      }

      // cache private field

    })();

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

}

//

var accessor = function accessor( object,names )
{
  var o = _accessorOptions.apply( this,arguments );
  return _accessor( o );
}

//

var accessorForbid = function accessorForbid( object,names )
{
  var o = _accessorOptions.apply( this,arguments );
  var object = o.object;
  var names = o.names;

  // verification

  _assert( _.objectLike( object ),'_.accessor :','expects object as argument but got', object );
  _assert( _.objectIs( names ),'_.accessor :','expects object names as argument but got', names );
  _.assertMapHasOnly( o,accessorForbid.defaults );
  _.mapComplement( o,accessorForbid.defaults );


  // message

  _assert( object.constructor === null || object.constructor.name || object.constructor._name,'accessorForbid :','object should have name' );
  var protoName = ( object.constructor ? ( object.constructor.name || object.constructor._name || '' ) : '' ) + '.';
  var message = 'is deprecated';
  if( o.message )
  message = o.message.join( ' : ' );


  // property

  /*var stack = _.stack();*/
  var methods = {};
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

      handler.forbid = true;

      methods[ setterName ] = handler;
      methods[ getterName ] = handler;

      if( !o.override || o.allowMultiple )
      if( _hasOwnProperty.call( object,encodedName ) )
      {
        var descriptor = Object.getOwnPropertyDescriptor( object,encodedName );
        if( _.routineIs( descriptor.get ) && descriptor.get.forbid && o.allowMultiple )
        {
          delete names[ n ];
          return;
        }
        else if( !o.override )
        handler();
      }

      if( !Object.isExtensible( object ) )
      {
        delete names[ n ];
      }

    })();

  }

  o.preserveValues = 0;
  o.strict = 0;
  o.enumerable = false;
  o.names = names;
  o.object = object;
  o.methods = methods;

  return _accessor( _.mapScreen( _accessor.defaults,o ) );
}

accessorForbid.defaults =
{
  override : 0,
  allowMultiple : 1,
}

accessorForbid.defaults.__proto__ = _accessor.defaults;

//

var accessorForbidOnce = function( object,names )
{
  var o = _accessorOptions.apply( this,arguments );

  o.allowMultiple = 1;

  return accessorForbid( o );
}

//

var accessorReadOnly = function accessorReadOnly( object,names )
{
  var o = _accessorOptions.apply( this,arguments );
  o.readOnly = true;
  return accessor( o );
}

//

/**
 * Makes constants properties on object by creating new or replacing existing properties.
 * @param {object} dstProto - prototype of class which will get new constant property.
 * @param {object} namesObject - name/value map of constants.
 *
 * @example
 * var Self = function () { };
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

var constant = function( dstProto,namesObject )
{

  // if( _.strIs( namesObject ) )
  // {
  //   namesObject = { [ namesObject ] : namesObject };
  // }

  _assert( arguments.length === 2 );
  _assert( _.objectLike( dstProto ),'_.constant :','dstProto is needed :', dstProto );
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
 *
 * @example
 * var Self = function () { };
 * Self.prototype.num = 100;
 * var ReadOnly = { num : null, num2 : null  };
 * _.restrictReadOnly ( Self.prototype,ReadOnly );
 * console.log( Self.prototype ); // returns { num: 100, num2: undefined }
 * Self.prototype.num2 = 1; // error assign to read only property
 *
 * @throws {exception} If no argument provided.
 * @throws {exception} If( dstProto ) is not a Object.
 * @throws {exception} If( namesObject ) is not a Map.
 * @memberof wTools
 */

var restrictReadOnly = function restrictReadOnly( dstProto,namesObject )
{

  if( _.strIs( namesObject ) )
  {
    namesObject = { [ namesObject ] : namesObject };
  }

  _assert( arguments.length === 2 );
  _assert( _.objectLike( dstProto ),'_.constant :','dstProto is needed :', dstProto );
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

var mixin = function( o )
{

  var dst = o.dst;
  var mixinDefaults =
  {
    name : null,
    mixin : null,
    Extend : null,
    Supplement : null,
    Functor : null,
  }

  _assert( arguments.length === 1 );
  _assert( _.objectIs( dst ) );
  _assert( _.routineIs( o.mixin.mixin ) );
  _assert( _.strIs( o.mixin.name ) );
  _assert( _.mapIs( o.mixin.Extend ) || o.mixin.Extend === undefined || o.mixin.Extend === null );
  _assert( _.mapIs( o.mixin.Supplement ) || o.mixin.Supplement === undefined || o.mixin.Supplement === null );
  //_assert( _.mapIs( o.mixin ) );
  _.assertMapHasOnly( o,mixin.defaults );
  _.assertMapOwnOnly( o.mixin,mixinDefaults );

  if( !_.mapIs( dst ) )
  {
    _assert( dst.constructor.prototype === dst,'mixin :','expects prototype with own constructor field' );
    _assert( dst.constructor.name.length > 0 || dst.constructor._name.length,'mixin :','constructor should has name' );
    _assert( _.routineIs( dst.init ) );
  }

  /* */

  if( o.mixin.Supplement )
  _.mapSupplement( dst,_.mapBut( o.mixin.Supplement,ClassFacility ) );
  if( o.mixin.Extend )
  _.mapExtend( dst,_.mapBut( o.mixin.Extend,ClassFacility ) );

  /* facility */

  if( o.mixin.Supplement )
  for( var f in ClassFacility )
  if( o.mixin.Supplement[ f ] )
  _propertyAddOwnDefaults
  ({
    facilityName : f,
    dstProto : dst,
    srcDefaults : o.mixin.Supplement[ f ],
    override : false,
  });

  if( o.mixin.Extend )
  for( var f in ClassFacility )
  if( o.mixin.Extend[ f ] )
  _propertyAddOwnDefaults
  ({
    facilityName : f,
    dstProto : dst,
    srcDefaults : o.mixin.Extend[ f ],
    override : true,
  });

  /* functor */

  if( o.mixin.Functor )
  for( var m in o.mixin.Functor )
  dst[ m ] = o.mixin.Functor[ m ].call( o,dst[ m ] );

  /* field */

  //if( !dst._mixins )
  if( !_hasOwnProperty.call( dst,'_mixins' ) )
  {
    //var _mixin = dst._mixins;
    dst._mixins = Object.create( dst._mixins || null );
    //if( _mixin )
    //Object.setPrototypeOf( dst._mixins, _mixin );
  }

  _.assert( !dst._mixins[ o.mixin.name ],'attempt to mixin same mixin same several times : ' + o.mixin.name + ' into ' + dst.constructor.name );

  dst._mixins[ o.mixin.name ] = 1;

}

mixin.defaults =
{
  dst : null,
  mixin : null,
  // proto : null,
  // functors : null,
  // name : null,
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
 * var Self = function () { };
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

//var _propertyAddOwnDefaults = function( defaultsName,dstProto,srcDefaults,o )
var _propertyAddOwnDefaults = function( o )
{
  var o = o || {};

  _assert( arguments.length === 1 );
  _assert( _.objectIs( o.srcDefaults ),'expects object ( o.srcDefaults ), got', _.strTypeOf( o.srcDefaults ) );
  _.routineOptions( _propertyAddOwnDefaults,o );

  o.facilityName = _.nameUnfielded( o.facilityName );

  if( !_hasOwnProperty.call( o.dstProto,o.facilityName.coded ) )
  {
    var facility = o.dstProto[ o.facilityName.coded ];
    o.dstProto[ o.facilityName.coded ] = {};
    if( facility )
    Object.setPrototypeOf( o.dstProto[ o.facilityName.coded ], facility );
  }

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
 * var Self = function () { };
 * var Composes = { tree : null };
 * _.propertyAddOwnComposes( Self.prototype, Composes );
 * console.log( Self.prototype ); // returns { Composes: { tree: null } }
 *
 * @method propertyAddOwnComposes
 * @throws {exception} If no arguments provided.
 * @memberof wTools
 */

var propertyAddOwnComposes = function( dstProto,srcDefaults )
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
 * var Self = function () { };
 * var Aggregates = { tree : null };
 * _.propertyAddOwnAggregates( Self.prototype, Aggregates );
 * console.log( Self.prototype ); // returns { Aggregates: { tree: null } }
 *
 * @method propertyAddOwnAggregates
 * @throws {exception} If no arguments provided.
 * @memberof wTools
 */

var propertyAddOwnAggregates = function( dstProto,srcDefaults )
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
 * var Self = function () { };
 * var Associates = { tree : null };
 * _.propertyAddOwnAssociates( Self.prototype, Associates );
 * console.log( Self.prototype ); // returns { Associates: { tree: null } }
 *
 * @method propertyAddOwnAssociates
 * @throws {exception} If no arguments provided.
 * @memberof wTools
 */

var propertyAddOwnAssociates = function( dstProto,srcDefaults )
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
 * var Self = function () { };
 * var Restricts = { tree : null };
 * _.propertyAddOwnRestricts( Self.prototype, Restricts );
 * console.log( Self.prototype ); // returns { Restricts: { tree: null } }
 *
 * @method propertyAddOwnRestricts
 * @throws {exception} If no arguments provided.
 * @memberof wTools
 */

var propertyAddOwnRestricts = function( dstProto,srcDefaults )
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

// --
// getter / setter generator
// --

var setterMapCollection_gen = function( o )
{

  _.assertMapHasOnly( o,setterMapCollection_gen.defaults );
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

      self[ symbol ] = {};

    }

    for( var d in data )
    {
      self[ symbol ][ d ] = elementMaker.call( self,data[ d ] );
    }

  }

}

setterMapCollection_gen.defaults =
{
  name : null,
  elementMaker : null,
}

//

var setterFriend_gen = function( o )
{

  var name = _.nameUnfielded( o.name ).coded;
  var nameOfLink = o.nameOfLink;
  var maker = o.maker;
  var symbol = Symbol.for( name );

  _.assert( arguments.length === 1 );
  _.assert( _.strIs( name ) );
  _.assert( _.strIs( nameOfLink ) );
  _.assert( _.routineIs( maker ) );
  _.assertMapHasOnly( o,setterFriend_gen.defaults );

  return function setterFriend( data )
  {

    var self = this;
    _.assert( data === null || _.objectIs( data ),'setterFriend : expects null or object, but got ' + _.strTypeOf( data ) );

    //console.log( 'setting ' + namename );

    if( !data )
    {

      self[ symbol ] = data;
      return;

    }
    else if( !self[ symbol ] )
    {

      var o = {};
      o[ nameOfLink ] = self;
      o.name = name;
      self[ symbol ] = maker( o );

    }

    self[ symbol ].copy( data );

    /*_.assert( self[ symbol ][ nameOfLink ] === null || self[ symbol ][ nameOfLink ] === self );*/
    if( self[ symbol ][ nameOfLink ] !== self )
    self[ symbol ][ nameOfLink ] = self;

  }

}

setterFriend_gen.defaults =
{
  name : null,
  nameOfLink : null,
  maker : null,
}

//

var setterCopyable_gen = function( o )
{

  var name = _.nameUnfielded( o.name ).coded;
  var maker = o.maker;
  var symbol = Symbol.for( name );

  _.assert( arguments.length === 1 );
  _.assert( _.strIs( name ) );
  _.assert( _.routineIs( maker ) );
  _.assertMapHasOnly( o,setterCopyable_gen.defaults );

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

  }

}

setterCopyable_gen.defaults =
{
  name : null,
  maker : null,
}

//

var setterBufferFrom_gen = function( o )
{

  var name = _.nameUnfielded( o.name ).coded;
  var bufferConstructor = o.bufferConstructor;
  var symbol = Symbol.for( name );

  _.assert( arguments.length === 1 );
  _.assert( _.strIs( name ) );
  _.assert( _.routineIs( bufferConstructor ) );
  _.assertMapHasOnly( o,setterBufferFrom_gen.defaults );

  return function setterBufferFrom( data )
  {
    var self = this;

    if( data === null )
    {
    }
    else
    {
      data = _.bufferFrom({ src : data, bufferConstructor : bufferConstructor });
    }

    self[ symbol ] = data;
  }

}

setterBufferFrom_gen.defaults =
{
  name : null,
  bufferConstructor : null,
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
 *  var init = function init()
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
  Self.prototype = Object.create( Parent.prototype );
  _.mapExtend( Self.prototype,Proto );
  _.mapSupplement( Self.prototype,Original.prototype );
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

var protoMake = function protoMake( o )
{

  var has =
  {
    constructor : 'constructor',
  }

  var hasNot =
  {
    Parent : 'Parent',
    Self : 'Self',
    Type : 'Type',
    type : 'type',
  }

  /**/

  _assert( arguments.length === 1 );
  _assert( _.objectIs( o ) );

  _assert( _.routineIs( o.constructor ) );
  _assert( o.constructor.name || o.constructor._name );
  _assert( _hasOwnProperty.call( o.constructor.prototype,'constructor' ) );

  _.assertMapOwnAll( o.constructor.prototype,has );
  _.assertMapOwnNone( o.constructor.prototype,hasNot );

  _assert( _.routineIs( o.parent ) || o.parent === undefined || o.parent === null,'wrong type of parent :',_.strTypeOf( 'o.parent' ) );
  _assert( _.objectIs( o.extend ) || o.extend === undefined );
  _assert( _.objectIs( o.supplement ) || o.supplement === undefined );
  _.assert( o.parent !== o.extend );

  _.routineOptions( protoMake,o );

  /**/

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
      _.assert( Object.keys( o.constructor.prototype ).length === 0,'misuse of protoMake, prototype of constructor has properties put there manually.' );
      _.assert( o.constructor.prototype.constructor === o.constructor );
    }
    prototype = o.constructor.prototype = Object.create( o.parent ? o.parent.prototype : null );
    prototype.constructor = null;
  }

  /**/

/*
  if( o.constructor.name.indexOf( 'FileProvider' ) != -1 )
  debugger;
*/

  /* extend */

  _.protoExtend
  ({
    constructor : o.constructor,
    extend : o.extend,
    supplement : o.supplement,
    static : o.static,
    usingAtomicExtension : o.usingAtomicExtension,
  });

  /**/

  return prototype;
}

protoMake.defaults =
{
  constructor : null,
  parent : null,
  extend : null,
  supplement : null,
  static : null,
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
 * var Static = { staticFunction : function staticFunction(){ } };
 * var Composes = { a : 1, b : 2 };
 * var Proto = { constructor: Self, Composes: Composes };
 *
 * var proto =  _.protoExtend({
 *     constructor: Self,
 *     extend: Proto,
 *     static : Static
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

var protoExtend = function protoExtend( o )
{

  _assert( arguments.length === 1 );
  _assert( _.objectIs( o ) );

  _assert( _.routineIs( o.constructor ),'expects constructor o.constructor' );
  _assert( o.constructor.name || o.constructor._name,'class constructor should have name' );

  _assert( _.objectIs( o.extend ) || o.extend === undefined || o.extend === null );
  _assert( _.objectIs( o.supplement ) || o.supplement === undefined || o.supplement === null );
  _assert( _.objectIs( o.static ) || o.static === undefined || o.static === null );

  _.routineOptions( protoExtend,o );

  var prototype = o.constructor.prototype;

  /* extend relationships */

  if( o.extend )
  for( var f in ClassFacility )
  _propertyAddOwnDefaults
  ({
    facilityName : f,
    dstProto : prototype,
    srcDefaults : o.extend[ f ] || {},
    override : true,
  });

  if( o.supplement )
  for( var f in ClassFacility )
  _propertyAddOwnDefaults
  ({
    facilityName : f,
    dstProto : prototype,
    srcDefaults : o.supplement[ f ] || {},
    override : false,
  });

  /* extend fields and methods */

  if( o.extend )
  {
    var extend = _.mapBut( o.extend,ClassFacility );
    _.mapExtend( prototype,extend );
    if( _hasOwnProperty.call( o.extend,'constructor' ) )
    prototype.constructor = o.extend.constructor;
  }

  if( o.supplement )
  {
    var supplement = _.mapBut( o.supplement,ClassFacility );
    _.mapSupplement( prototype,supplement );
    if( !prototype.constructor )
    if( _hasOwnProperty.call( o.supplement,'constructor' ) )
    prototype.constructor = o.supplement.constructor;
  }

  /* static */

  var addStatic = function( _static )
  {
    _.mapSupplement( prototype,_static );
    _.mapSupplement( o.constructor,_static );
  }

  if( o.static )
  addStatic( o.static );

  if( o.extend && o.extend.Static )
  addStatic( o.extend.Static );

  if( o.supplement && o.supplement.Static )
  addStatic( o.supplement.Static );

  /* atomic extension */

  if( o.usingAtomicExtension )
  {
    if( _.mapOwn( prototype,{ Composes : 'Composes' } ) )
    _.mapExtendFiltering( _.filter.atomicSrcOwn(),prototype,prototype.Composes );
    if( _.mapOwn( prototype,{ Aggregates : 'Aggregates' } ) )
    _.mapExtendFiltering( _.filter.atomicSrcOwn(),prototype,prototype.Aggregates );
    if( _.mapOwn( prototype,{ Associates : 'Associates' } ) )
    _.mapExtendFiltering( _.filter.atomicSrcOwn(),prototype,prototype.Associates );
    if( _.mapOwn( prototype,{ Restricts : 'Restricts' } ) )
    _.mapExtendFiltering( _.filter.atomicSrcOwn(),prototype,prototype.Restricts );
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
  static : null,
  usingAtomicExtension : false,
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
 * console.log( _.protoComplementInstance( obj ) ); //returns Alpha { a: 1, b: 2 }
 *
 * @return {object} Returns complemented instance.
 * @method protoComplementInstance
 * @memberof wTools
 */

var protoComplementInstance = function protoComplementInstance( instance )
{

  _.mapComplement( instance,instance.Composes );
  _.mapComplement( instance,instance.Aggregates );
  _.mapComplement( instance,instance.Associates );
  _.mapComplement( instance,instance.Restricts );

  return instance;
}

//

/**
 * Make united interface for several maps. Access to single map cause read and write to original maps.
 * @param {array} protos - maps to united.
 * @return {object} united interface.
 * @method protoUnitedInterface
 * @memberof wTools
 */

var protoUnitedInterface = function( protos )
{
  var result = {};
  var unitedArraySymbol = Symbol.for( '_unitedArray_' );
  var unitedMapSymbol = Symbol.for( '_unitedMap_' );
  var protoMap = {};

  _assert( arguments.length === 1 );
  _assert( _.arrayIs( protos ) );

  //

  var get = function( fieldName )
  {
    return function unitedGet()
    {
      return this[ unitedMapSymbol ][ fieldName ][ fieldName ];
    }
  }
  var set = function( fieldName )
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

      var methods = {}
      methods[ f + 'Get' ] = get( f );
      methods[ f + 'Set' ] = set( f );
      var names = {};
      names[ f ] = f;
      _.accessor
      ({
        object : result,
        names : names,
        methods : methods,
        strict : false,
      });

    }
  }

  /*result[ unitedArraySymbol ] = protos;*/
  result[ unitedMapSymbol ] = protoMap;

  return result;
}

/**
 * Append prototype to object. Find archi parent and replace its proto.
 * @param {object} dstObject - dst object to append proto.
 * @method protoAppend
 * @memberof wTools
 */

var protoAppend = function( dstObject )
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

var protoHas = function( srcProto,insProto )
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

var protoOwning = function( srcObject,names )
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

var protoArchy = function( srcObject )
{

  _assert( _.objectIs( srcObject ) );

  while( Object.getPrototypeOf( srcObject ) !== Object.prototype )
  srcObject = Object.getPrototypeOf( srcObject );

  return srcObject;
}

// --
// var
// --

/**
 * @global {Object} wTools~ClassFacility - contains predefined class relationship types.
 * @memberof wTools
 */

var ClassFacility =
{
  Composes : 'Composes',
  Aggregates : 'Aggregates',
  Associates : 'Associates',
  Restricts : 'Restricts',
  Static : 'Static',
}

// --
// prototype
// --

var Proto =
{

  // property

  _accessorOptions : _accessorOptions,
  _accessor : _accessor,
  accessor : accessor,
  accessorForbid : accessorForbid,
  accessorForbidOnce : accessorForbidOnce,
  accessorReadOnly : accessorReadOnly,

  constant : constant,
  restrictReadOnly : restrictReadOnly,

  mixin : mixin,

  _propertyAddOwnDefaults : _propertyAddOwnDefaults,
  propertyAddOwnComposes : propertyAddOwnComposes,
  propertyAddOwnAggregates : propertyAddOwnAggregates,
  propertyAddOwnAssociates : propertyAddOwnAssociates,
  propertyAddOwnRestricts : propertyAddOwnRestricts,


  // getter / setter generator

  setterMapCollection_gen : setterMapCollection_gen,
  setterFriend_gen : setterFriend_gen,
  setterCopyable_gen : setterCopyable_gen,
  setterBufferFrom_gen : setterBufferFrom_gen,


  // prototype

  protoMake : protoMake,
  protoExtend : protoExtend,

  protoComplementInstance : protoComplementInstance,

  protoUnitedInterface : protoUnitedInterface, /* experimental */

  protoAppend : protoAppend, /* experimental */
  protoHas : protoHas, /* experimental */
  protoOwning : protoOwning, /* experimental */
  protoArchy : protoArchy, /* experimental */


  // var

  ClassFacility : ClassFacility,

}

_global_.wProto = Proto;

_.mapExtend( Self, Proto );

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
{
  module[ 'exports' ] = Self;
}

})();
