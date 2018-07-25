<cfscript>

	datamuse = new lib.DatamuseClient();

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	// Get words that start with the string "st" and are 5 letters long.
	words = datamuse.getWords(
		sp = "st???"
	);

	writeOutput( "<p>Words like <code>st???</code></p>" );
	writeDump( var = words, format = "text" );

	// ------------------------------------------------------------------------------- //
	writeOutput( "<hr />" );
	// ------------------------------------------------------------------------------- //

	// Get words that start with "s" and end with "y".
	words = datamuse.getWords(
		sp = "s*y"
	);

	writeOutput( "<p>Words like <code>s*y</code></p>" );
	writeDump( var = words, format = "text" );

	// ------------------------------------------------------------------------------- //
	writeOutput( "<hr />" );
	// ------------------------------------------------------------------------------- //

	// Get words that start with "s" and rhyme with "bad".
	words = datamuse.getWords(
		rel_rhy = "bad",
		sp = "s*"
	);

	writeOutput( "<p>Words like <code>s*</code> that rhyme with <code>bad</code></p>" );
	writeDump( var = words, format = "text" );

	// ------------------------------------------------------------------------------- //
	writeOutput( "<hr />" );
	// ------------------------------------------------------------------------------- //

	// Get words that mean something similar to "awesome".
	words = datamuse.getWords(
		ml = "awesome"
	);

	writeOutput( "<p>Words like mean something similar to <code>awesome</code></p>" );
	writeDump( var = words, format = "text" );

	// ------------------------------------------------------------------------------- //
	writeOutput( "<hr />" );
	// ------------------------------------------------------------------------------- //

	// Get words that are synonyms to "insane" and are 4-letters long.
	words = datamuse.getWords(
		rel_syn = "insane",
		sp = "????"
	);

	writeOutput( "<p>Words that are synonyms for <code>insane</code> and are 4-letters long</p>" );
	writeDump( var = words, format = "text" );

	// ------------------------------------------------------------------------------- //
	writeOutput( "<hr />" );
	// ------------------------------------------------------------------------------- //

	// Get the number of syllables in "countenance".
	// --
	// NOTE: There is no "end point" for syllable count. So, in order to get it, we're
	// going to use the Query Echo parameter, which will echo the value in the given 
	// parameter (sp) as the first item in the result. We can then use the metadata
	// parameter (md) to tell Datamuse to return the (s) syllable count in the result.
	words = datamuse.getWords(
		sp = "countenance",
		qe = "sp",
		md = "s",
		max = 1
	);

	writeOutput( "<p>Get the number of syllables in <code>countenance</code></p>" );
	writeDump( var = words, format = "text" );

	// ------------------------------------------------------------------------------- //
	writeOutput( "<hr />" );
	// ------------------------------------------------------------------------------- //

	// Get word suggesions for "bla".
	words = datamuse.getSuggestions(
		s = "bla"
	);

	writeOutput( "<p>Words that are suggested for <code>bla</code></p>" );
	writeDump( var = words, format = "text" );

</cfscript>
