( function _ProtoLike_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../../abase/layer3/Proto.s' );
  require( '../../abase/layer3/ProtoLike.s' );

  try
  {
    require( '../../Base.s' );
  }
  catch( err )
  {
    require( 'wTools' );
  }

  var _ = wTools;

  _.include( 'wTesting' );

}

var _ = wTools;

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
  // sourceFilePath : _.diagnosticLocation().full,

  tests :
  {

    isLike : isLike,

  },

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
_.Tester.test( Self.name );

} )( );
