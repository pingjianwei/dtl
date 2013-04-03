

# Module dtl_string #
* [Description](#description)
* [Function Index](#index)
* [Function Details](#functions)


String utilities.

<a name="index"></a>

## Function Index ##


<table width="100%" border="1" cellspacing="0" cellpadding="2" summary="function index"><tr><td valign="top"><a href="#escape_re-1">escape_re/1</a></td><td>Escape an input string for use within a regular expression (so
that all characters are interpreted literally).</td></tr><tr><td valign="top"><a href="#safe_list_to_atom-1">safe_list_to_atom/1</a></td><td>Run <code>list_to_atom</code> without exceptions.</td></tr><tr><td valign="top"><a href="#smart_split-1">smart_split/1</a></td><td>Splits on spaces, except within quoted characters "" and ''.</td></tr></table>


<a name="functions"></a>

## Function Details ##

<a name="escape_re-1"></a>

### escape_re/1 ###


<pre><code>
escape_re(Patt::list()) -&gt; list()
</code></pre>

<br></br>


Escape an input string for use within a regular expression (so
that all characters are interpreted literally). Every character
will be escaped except for alphanumeric characters and '_'.
<a name="safe_list_to_atom-1"></a>

### safe_list_to_atom/1 ###


<pre><code>
safe_list_to_atom(L::list()) -&gt; atom() | error
</code></pre>

<br></br>


Run `list_to_atom` without exceptions.
<a name="smart_split-1"></a>

### smart_split/1 ###


<pre><code>
smart_split(Subj::binary()) -&gt; [binary()]
</code></pre>

<br></br>


Splits on spaces, except within quoted characters "" and ''.
