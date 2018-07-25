
# Datamuse API Client For ColdFusion

by [Ben Nadel][bennadel]

**Version 1.0.0**

The [Datamuse API][datamuse] is a word-finding engine for Developers. It
provides a very flexible API for locating words that adhere to a given set of
constraints. For example, you can find words that rhyme with `happy` and start
with the letter `s`. In addition to finding words, you can also get word
metadata such as the number of syllables, frequency of usage, and definitions.

This **DatamuseClient.cfc** ColdFusion library is a **thin wrapper** around the
underlying HTTP request. It does not add any semantic abstractions - it only
makes the request a bit easier to assemble and execute.


## Methods

In addition to the constructor, there is a method per API end-point. Each of
the end-point methods accepts arguments that mirror the arguments defined on
the [Datamuse API][datamuse] site. To _be honest_, I don't fully understand all
of the arguments - see the Datamuse documentation for more insight.

* `init( [apiKey [, timeout]] )`
  * `apiKey` - I am the high-consumption API key.
  * `timeout` - I am the HTTP timeout (in seconds) to apply to the HTTP
   underlying HTTP request object.

* `getWords( [all arguments optional] )`
  * `ml` - Means like term.
  * `sl` - Sounds like term.
  * `sp` - Spelled like term.
  * `rel_jja`
  * `rel_jjb`
  * `rel_syn` - Synonyms for term.
  * `rel_trg`
  * `rel_ant` - Antonyms for term.
  * `rel_spc`
  * `rel_gen`
  * `rel_com`
  * `rel_par`
  * `rel_bga`
  * `rel_bgb`
  * `rel_rhy` - Perfect rhymes for term.
  * `rel_nry` - Near rhymes for term.
  * `rel_hom`
  * `rel_cns`
  * `v`
  * `topics`
  * `lc`
  * `rc`
  * `max` - Max number of results (defaults to 10).
  * `md` - Metadata for term.
  * `qe` - Query echo for term.

* `getSuggestions( s [,v [, max]] )`
  * `s` - The term being searched.
  * `v`
  * `max` - Max number of results (defaults to 10).

**NOTE**: The Datamuse API is free for most use-cases. But, you can request an
API Key for high-volume consumption. Unfortunately, at this time, the API Key
does not get applied to the HTTP request in this client because ... I am still
trying to figuring out how it gets applied. The API Key is not documented well.


## Examples

The Datamuse API is very flexible. And, allows a number of the parameters to
work in conjunction with each other. This lets you get very specific with the
search, like finding words that start with "s", are 5-letters long, and rhyme
with "daft". The following are some examples of what you might want to do:

```cfm
<cfscript>
	// Get words that start with the string "st" and are 5 letters long.
	words = new lib.DatamuseClient().getWords(
		sp = "st???"
	);
</cfscript>
```

This returns the following words:

* `state`
* `stick`
* `stand`
* `stock`
* `style`
* `stone`
* `store`
* `study`
* `steel`
* `story`

```cfm
<cfscript>
	// Get words that start with "s" and end with "y".
	words = new lib.DatamuseClient().getWords(
		sp = "s*y"
	);
</cfscript>
```

This returns the following words:

* `strategy`
* `say`
* `study`
* `serendipity`
* `story`
* `security`
* `society`
* `savvy`
* `synergy`
* `survey`

```cfm
<cfscript>
	// Get words that start with "s" and rhyme with "bad".
	words = new lib.DatamuseClient().getWords(
		rel_rhy = "bad",
		sp = "s*"
	);
</cfscript>
```

This returns the following words:

* `sad`
* `scad`
* `shad`
* `strad`
* `sociedad`
* `sinbad`
* `soledad`
* `stalingrad`
* `scantily clad`
* `sketch pad`

```cfm
<cfscript>
	// Get words that mean something similar to "awesome".
	words = new lib.DatamuseClient().getWords(
		ml = "awesome"
	);
</cfscript>
```

This returns the following words:

* `amazing`
* `awful`
* `impressive`
* `awing`
* `awe-inspiring`
* `unbelievable`
* `fantastic`
* `incredible`
* `wonderful`
* `terrific`

```cfm
<cfscript>
	// Get words that are synonyms to "insane" and are 4-letters long.
	words = new lib.DatamuseClient().getWords(
		rel_syn = "insane",
		sp = "????"
	);
</cfscript>
```

This returns the following words:

* `wild`
* `sick`
* `daft`
* `nuts`
* `amok`
* `loco`
* `bats`

```cfm
<cfscript>
	// Get the number of syllables in "countenance".
	// --
	// NOTE: There is no "end point" for syllable count. So, in order to get it, we're
	// going to use the Query Echo parameter, which will echo the value in the given 
	// parameter (sp) as the first item in the result. We can then use the metadata
	// parameter (md) to tell Datamuse to return the (s) syllable count in the result.
	words = new lib.DatamuseClient().getWords(
		sp = "countenance",
		qe = "sp",
		md = "s",
		max = 1
	);
</cfscript>
```

This returns the following words:

* `countenance` with syllable count metadata, `3`.

```cfm
<cfscript>
	// Get word suggesions for "bla".
	words = new lib.DatamuseClient().getSuggestions(
		s = "bla"
	);
</cfscript>
```

This returns the following words:

* `black`
* `blancard`
* `blanford`
* `blanket`
* `blast`
* `blazen`
* `blatant`
* `blade`
* `blaze`
* `blank`

Hopefully you can see the flexibility provided by the Datamuse API.


[bennadel]: https://www.bennadel.com
[datamuse]: https://www.datamuse.com/api/
