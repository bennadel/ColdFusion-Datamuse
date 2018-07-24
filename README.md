
# Datamuse API Client For ColdFusion

by [Ben Nadel][bennadel]

**Version 0.0.0**

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

_To do..._


[bennadel]: https://www.bennadel.com
[datamuse]: https://www.datamuse.com/api/
