

# Module dtl_fs_loader #
* [Description](#description)
* [Function Index](#index)
* [Function Details](#functions)


File system template loader.
__Behaviours:__ [`dtl_loader`](dtl_loader.md).
<a name="description"></a>

## Description ##
Searches directories for templates.<a name="index"></a>

## Function Index ##


<table width="100%" border="1" cellspacing="0" cellpadding="2" summary="function index"><tr><td valign="top"><a href="#is_usable-0">is_usable/0</a></td><td>Callback to test if this module is usable.</td></tr><tr><td valign="top"><a href="#load_from_directory-2">load_from_directory/2</a></td><td>Searches the provided directory for the named file, reading its
contents if found.</td></tr><tr><td valign="top"><a href="#load_template_source-1">load_template_source/1</a></td><td>Searches configured template directories for the named template.</td></tr><tr><td valign="top"><a href="#load_template_source-2">load_template_source/2</a></td><td>Searches the specified directories for the named template
(rather than the application's configured directory list).</td></tr></table>


<a name="functions"></a>

## Function Details ##

<a name="is_usable-0"></a>

### is_usable/0 ###


<pre><code>
is_usable() -&gt; true
</code></pre>

<br></br>


Callback to test if this module is usable.
<a name="load_from_directory-2"></a>

### load_from_directory/2 ###


<pre><code>
load_from_directory(Dir::list(), Name::list()) -&gt; {ok, binary(), list()} | {error, not_found}
</code></pre>

<br></br>


Searches the provided directory for the named file, reading its
contents if found. An error of `not_found` will be returned in
all failure cases.
<a name="load_template_source-1"></a>

### load_template_source/1 ###


<pre><code>
load_template_source(Name::list()) -&gt; {ok, binary(), list()} | {error, no_template_dirs | not_found}
</code></pre>

<br></br>


Searches configured template directories for the named template.
Returns the file's contents if found, and its path, or an error
if there was one.
<a name="load_template_source-2"></a>

### load_template_source/2 ###


<pre><code>
load_template_source(Name::list(), Dirs::[list()]) -&gt; {ok, binary(), list()} | {error, no_template_dirs | not_found}
</code></pre>

<br></br>



Searches the specified directories for the named template
(rather than the application's configured directory list). If
the provided list is empty, we use the configured list of these.


If the template is not found, this returns a `not_found` error.
