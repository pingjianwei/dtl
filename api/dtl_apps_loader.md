

# Module dtl_apps_loader #
* [Description](#description)
* [Function Index](#index)
* [Function Details](#functions)


App directories loader.
__Behaviours:__ [`dtl_loader`](dtl_loader.md).
<a name="description"></a>

## Description ##
Searches the "priv" directory in each
configured application.<a name="index"></a>

## Function Index ##


<table width="100%" border="1" cellspacing="0" cellpadding="2" summary="function index"><tr><td valign="top"><a href="#is_usable-0">is_usable/0</a></td><td>Callback to test if this module is usable.</td></tr><tr><td valign="top"><a href="#load_template_source-1">load_template_source/1</a></td><td>Searches configured applications' "priv" directories for the
named template.</td></tr><tr><td valign="top"><a href="#load_template_source-2">load_template_source/2</a></td><td>Searches configured applications' "priv" directories for the
named template.</td></tr></table>


<a name="functions"></a>

## Function Details ##

<a name="is_usable-0"></a>

### is_usable/0 ###


<pre><code>
is_usable() -&gt; true
</code></pre>

<br></br>


Callback to test if this module is usable.
<a name="load_template_source-1"></a>

### load_template_source/1 ###


<pre><code>
load_template_source(Name::list()) -&gt; {ok, binary(), list()} | {error, not_found}
</code></pre>

<br></br>


Searches configured applications' "priv" directories for the
named template. Returns the files contents if found, or a
not_found error otherwise.
<a name="load_template_source-2"></a>

### load_template_source/2 ###


<pre><code>
load_template_source(Name::list(), Dirs::[list()]) -&gt; {ok, binary(), list()} | {error, not_found}
</code></pre>

<br></br>


Searches configured applications' "priv" directories for the
named template. Returns the files contents if found, or a
not_found error otherwise.
