( function _ProtoLike_test_s_( ) {

'use strict';

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

  var _global = _global_; var _ = _global_.wTools;

  _.include( 'wTesting' );

  if( !_.isIncluded( 'wProto' ) )
  {
    require( '../../abase/layer3/Proto.s' );
    require( '../../abase/layer3/ProtoLike.s' );
  }

}

var _global = _global_; var _ = _global_.wTools;

// --
// test
// --

function isLike( test )
{
  var self = this;

  var Base1 = _.like().end;
  var Base2 = _.like().end;
  var Mid = _.like( Base1,Base2 ).end;

  test.description = 'Base1 class like itself';
  var is = _.construction.isLike( Base1,Base1 );
  test.shouldBe( is );

  test.description = 'Mid class like itself';
  var is = _.construction.isLike( Mid,Mid );
  test.shouldBe( is );

  test.description = 'Mid class like one of parent';
  var is = _.construction.isLike( Mid,Base1 );
  test.shouldBe( is );
  var is = _.construction.isLike( Mid,Base2 );
  test.shouldBe( is );

  /* */

  test.description = 'base instance like base class';
  debugger;
  var base1 = Base1.constructor();
  debugger;
  var is = _.construction.isLike( base1,Base1 );
  test.shouldBe( is );

  test.description = 'base instance like another base class';
  var base1 = Base1.constructor();
  var is = _.construction.isLike( base1,Base2 );
  test.shouldBe( !is );

  test.description = 'mid instance like one of class';
  var mid = Mid.constructor();
  var is = _.construction.isLike( mid,Mid );
  test.shouldBe( is );
  var is = _.construction.isLike( mid,Base1 );
  test.shouldBe( is );
  var is = _.construction.isLike( mid,Base2 );
  test.shouldBe( is );

}

// --
// proto
// --

var Self =
{

  name : 'ProtoLike',
  silencing : 1,

  tests :
  {

    isLike : isLike,

  },

}

//

Self = wTestSuit( Self );
if( typeof module !== 'undefined' && !module.parent )
_.Tester.test( Self.name );

} )( );
