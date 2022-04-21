/**
 * My BDD Test
 */
component extends="coldbox.system.testing.BaseTestCase" appMapping="/root" {

	/*********************************** LIFE CYCLE Methods ***********************************/

	// executes before all suites+specs in the run() method
	function beforeAll(){
		super.beforeAll();
	}

	// executes after all suites+specs in the run() method
	function afterAll(){
		super.afterAll();
	}

	/*********************************** BDD SUITES ***********************************/

	function run(){
		// all your suites go here.
		describe( "Debugger Module", function(){
			beforeEach( function( currentSpec ){
				setup();
				debuggerService = getWireBox().getInstance( "DebuggerService@cbdebugger" );
				timer           = getWireBox().getInstance( "Timer@cbdebugger" );
			} );

			it( "should register components", function(){
				expect( timer ).toBeComponent();
				expect( debuggerService ).toBeComponent();
			} );

			it( "should run integration and time it", function(){
				timer.timeIt( "integrationtest", function(){
					var event = execute(
						event         = "main.index",
						renderResults = true
					);
					expect( timer.getTimers() ).notToBeEmpty( "Timers should not be empty" );
					expect( debuggerService.getProfilerStorage() ).notToBeEmpty( "profiler storage should not be empty" );
					expect( debuggerService.getTracers() ).notToBeEmpty( "Tracers should not be empty" );
				} );

				debug( timer.getTimers() );
				debug( debuggerService.getProfilerStorage() );
				debug( debuggerService.getTracers() );
			} );
		} );
	}

}
