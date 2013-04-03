

# Module dtl_library #
* [Description](#description)
* [Data Types](#types)
* [Function Index](#index)
* [Function Details](#functions)


Libraries are containers of template tags and filters.
__This module defines the `dtl_library` behaviour.__
<br></br>
 Required callback functions: `registered_filters/0`, `registered_tags/0`.
<a name="description"></a>

## Description ##
Custom
DTL tags and filters must be implemented in a module that
implements the `dtl_library` behaviour.
<a name="types"></a>

## Data Types ##




### <a name="type-filter_spec">filter_spec()</a> ###



<pre><code>
filter_spec() = <a href="#type-name">name()</a>
</code></pre>





### <a name="type-library">library()</a> ###



<pre><code>
library() = dict()
</code></pre>





### <a name="type-name">name()</a> ###



<pre><code>
name() = atom()
</code></pre>





### <a name="type-tag_spec">tag_spec()</a> ###



<pre><code>
tag_spec() = <a href="#type-name">name()</a> | {{module(), atom()}, <a href="#type-name">name()</a>} | {{module(), atom(), term()}, <a href="#type-name">name()</a>}
</code></pre>


<a name="index"></a>

## Function Index ##


<table width="100%" border="1" cellspacing="0" cellpadding="2" summary="function index"><tr><td valign="top"><a href="#add_filters-2">add_filters/2</a></td><td>Update the filters dict with all filters registered to the
specified <code>dtl_library</code> callback module.</td></tr><tr><td valign="top"><a href="#add_tags-2">add_tags/2</a></td><td>Update the tags dict with all tags registered to the specified
<code>dtl_library</code> callback module.</td></tr><tr><td valign="top"><a href="#search_collection-2">search_collection/2</a></td><td>Search for a tag or filter in the given library dict.</td></tr></table>


<a name="functions"></a>

## Function Details ##

<a name="add_filters-2"></a>

### add_filters/2 ###


<pre><code>
add_filters(Mod::atom(), Filters::dict()) -&gt; dict()
</code></pre>

<br></br>


Update the filters dict with all filters registered to the
specified `dtl_library` callback module.
<a name="add_tags-2"></a>

### add_tags/2 ###


<pre><code>
add_tags(Mod::atom(), Tags::dict()) -&gt; dict()
</code></pre>

<br></br>


Update the tags dict with all tags registered to the specified
`dtl_library` callback module.
<a name="search_collection-2"></a>

### search_collection/2 ###


<pre><code>
search_collection(Coll::<a href="#type-library">library()</a>, Name::<a href="#type-name">name()</a>) -&gt; <a href="dtl_tag.md#type-tag">dtl_tag:tag()</a> | <a href="dtl_filter.md#type-filter">dtl_filter:filter()</a> | nomatch
</code></pre>

<br></br>


Search for a tag or filter in the given library dict.
