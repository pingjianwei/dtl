

# Module dtl_loader #
* [Description](#description)
* [Function Index](#index)
* [Function Details](#functions)


Template loader interface.
__This module defines the `dtl_loader` behaviour.__
<br></br>
 Required callback functions: `is_usable/0`, `load_template_source/1`, `load_template_source/2`.
<a name="description"></a>

## Description ##



Template loaders should implement the `dtl_loader` behaviour'
and its interface:



is_usable() -> boolean().



Return `true` if the loader can or should be used in the
current environment, and `false` otherwise. You may want to
cache this value if it is expensive to compute. DTL does
not cache this result, under the assumption that a usable
loader may become unusable if runtime conditions change.



load_template_source(list()) ->
{ok, binary()} | {error,atom()}.
load_template_source(list(), [list()]) ->
{ok, binary()} | {error,atom()}.



The `load_template_source` callbacks are used to locate
templates. The first argument to this function is the name
of the requested template. The second argument can in most
cases be ignored, it is the list of configured template
directories, used by `dtl_fs_loader`.


This module's functions all operate, in order, on the list of
template loaders configured in this application's environment
variable, `template_loaders`. Functions will try each loader
until one returns a template successfully.<a name="index"></a>

## Function Index ##


<table width="100%" border="1" cellspacing="0" cellpadding="2" summary="function index"><tr><td valign="top"><a href="#find_template-1">find_template/1</a></td><td>Try to load the named template with each configured loader
module.</td></tr><tr><td valign="top"><a href="#find_template-2">find_template/2</a></td><td></td></tr><tr><td valign="top"><a href="#get_template-1">get_template/1</a></td><td>Finds a template and compiles it, returning the compiled
representation.</td></tr><tr><td valign="top"><a href="#select_template-1">select_template/1</a></td><td>Returns the first of several requested templates that a loader
module finds, in its compiled representation.</td></tr></table>


<a name="functions"></a>

## Function Details ##

<a name="find_template-1"></a>

### find_template/1 ###


<pre><code>
find_template(Name::list()) -&gt; {ok, binary()} | {error, not_found | no_loaders | atom()}
</code></pre>

<br></br>


Try to load the named template with each configured loader
module.
<a name="find_template-2"></a>

### find_template/2 ###


<pre><code>
find_template(Name::list(), Dirs::[list()]) -&gt; {ok, binary()} | {error, not_found | no_loaders | atom()}
</code></pre>

<br></br>



<a name="get_template-1"></a>

### get_template/1 ###


<pre><code>
get_template(Name::list()) -&gt; <a href="dtl_template.md#type-template">dtl_template:template()</a> | {error, not_found | atom()}
</code></pre>

<br></br>


Finds a template and compiles it, returning the compiled
representation.
<a name="select_template-1"></a>

### select_template/1 ###


<pre><code>
select_template(Names::[list()]) -&gt; {ok, <a href="dtl_template.md#type-template">dtl_template:template()</a>} | {error, not_found | atom()}
</code></pre>

<br></br>


Returns the first of several requested templates that a loader
module finds, in its compiled representation.
