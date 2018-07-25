component
	output = false
	hint = "I provide a low-level HTTP client for the Datamuse API."
	{

	/**
	* I initialize the Datamuse API client with the given settings.
	* 
	* @apiKey I am the API key used to authenticate the HTTP requests.
	* @timeout I am the timeout (in seconds) used to manage the HTTP requests.
	* @output false
	*/
	public any function init(
		string apiKey = "",
		numeric timeout = 5
		) {

		setApiKey( apiKey );
		setTimeout( timeout );

	}

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I make a request to the /sug end-point in Datamuse.
	* 
	* For documentation on parameters, see: https://www.datamuse.com/api/
	* @output false
	*/
	public array function getSuggestions(
		required string s,
		string v = "",
		numeric max = 10
		) {

		return( makeRequest( "sug", filterOutEmptyValues( arguments ) ) );

	}


	/**
	* I make a request to the /words end-point in Datamuse.
	* 
	* For documentation on parameters, see: https://www.datamuse.com/api/
	* @output false
	*/
	public array function getWords(
		string ml = "",
		string sl = "",
		string sp = "",
		string rel_jja = "",
		string rel_jjb = "",
		string rel_syn = "",
		string rel_trg = "",
		string rel_ant = "",
		string rel_spc = "",
		string rel_gen = "",
		string rel_com = "",
		string rel_par = "",
		string rel_bga = "",
		string rel_bgb = "",
		string rel_rhy = "",
		string rel_nry = "",
		string rel_hom = "",
		string rel_cns = "",
		string v = "",
		string topics = "",
		string lc = "",
		string rc = "",
		numeric max = 10,
		string md = "",
		string qe = ""
		) {

		return( makeRequest( "words", filterOutEmptyValues( arguments ) ) );

	}


	/**
	* I set the Datamuse API key to be sent with each request.
	* 
	* CAUTION: At this time, the API key does not get applied (I am waiting on a response
	* from Datamuse on how to actually implement the API key).
	* 
	* @newApiKey I am the Datamuse API key.
	* @output false
	*/
	public void function setApiKey( required string newApiKey ) {

		apiKey = newApiKey;

	}


	/**
	* I set the timeout (in seconds) for the HTTP request.
	* 
	* @newTimeout I am the timeout (in seconds) to be applied to the HTTP request.
	* @output false
	*/
	public void function setTimeout( required numeric newTimeout ) {

		timeout = newTimeout;

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I return a collection that contains only the defined, non-empty, simple values
	* contained within the given data structure.
	* 
	* @data I am the collection being filtered.
	* @output false
	*/
	private struct function filterOutEmptyValues( required struct data ) {

		var filtered = {};

		for ( var key in data ) {

			// Skip if null.
			if ( ! structKeyExists( data, key ) ) {

				continue;

			}

			var value = data[ key ];

			// Skip if complex or empty.
			if ( ! isSimpleValue( value ) || ! len( value ) ) {

				continue;

			}

			filtered[ key ] = value;

		}

		return( filtered );

	}


	/**
	* I make the HTTP request to the Datamuse API.
	* 
	* @resource I am the end-point being accessed.
	* @urlParams I am the collection of key-value pairs to add to the search-string.
	* @output false
	*/
	private array function makeRequest(
		required string resource,
		required struct urlParams
		) {

		var apiRequest = new Http(
			method = "GET",
			url = "https://api.datamuse.com/#resource#",
			getAsBinary = "yes",
			timeout = timeout
		);

		for ( var key in urlParams ) {

			apiRequest.addParam(
				type = "url",
				name = lcase( key ),
				value = urlParams[ key ]
			);

		}

		var apiResponse = apiRequest.send().getPrefix();

		// NOTE: Even though we are using "getAsBinary" in the HTTP request, the
		// fileContent will only be binary if the request is successful. If, for example,
		// the request fails to connect, the fileContent may contain a plain string with
		// something like, "Connection Failure," in it.
		var fileContent = isSimpleValue( apiResponse.fileContent )
			? apiResponse.fileContent
			: charsetEncode( apiResponse.fileContent, "utf-8" )
		;

		if ( ! reFind( "200", apiResponse.statusCode ) ) {

			throw(
				type = "Datamuse.HttpError",
				message = "HTTP request returned with a non-200 status code.",
				detail = "HTTP Status Code: #apiResponse.statusCode#"
				extendedInfo = "HTTP File Content: #fileContent#"
			);

		}

		try {

			return( deserializeJson( fileContent ) );

		} catch ( any error ) {

			throw(
				type = "Datamuse.ContentError",
				message = "Content could not be deserialized.",
				detail = "HTTP File Content: #fileContent#",
				extendedInfo = "Root Error Message: #error.message#"
			);

		}

	}

}
