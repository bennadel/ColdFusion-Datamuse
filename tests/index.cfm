<cfscript>
	
	// The Datamuse API is a very flexible API. As such, these tests are just here to
	// make sure the core logic of the client works - this is not intended to be a full
	// or exhaustive integration test.

	datamuse = new lib.DatamuseClient();

	try {

		wordResults = datamuse.getWords(
			rel_rhy = "happy",
			qe = "rel_rhy",
			md = "s",
			max = 2
		);

		assert( arrayLen( wordResults ) == 2 );
		assert( wordResults[ 1 ].word == "happy" );
		assert( isNumeric( wordResults[ 1 ].numSyllables ) );
		assert( wordResults[ 2 ].word != "happy" );
		assert( isNumeric( wordResults[ 2 ].numSyllables ) );

		suggestionResults = datamuse.getSuggestions(
			s = "banan",
			max = 3
		);

		assert( arrayLen( suggestionResults ) == 3 );
		assert( suggestionResults[ 1 ].word == "banana" );
		assert( suggestionResults[ 2 ].word == "bananas" );

		writeOutput( "<p>Tests have PASSED!</p>" );
		
	} catch ( any error ) {

		writeOutput( "<p>Tests have FAILED!</p>" );
		writeDump( error );

	}

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	if ( ! isNull( wordResults ) ) {

		writeDump( wordResults );

	}

	if ( ! isNull( suggestionResults ) ) {

		writeDump( suggestionResults );

	}

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	/**
	* I throw an error if the given value is a Falsey.
	* 
	* @value I am the Truthy being tested.
	* @output false
	*/
	function assert( required boolean value ) {

		if ( ! value ) {

			throw( type = "FailedAssertion" );

		}

	}

</cfscript>
