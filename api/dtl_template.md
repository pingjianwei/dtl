

# Module dtl_template #
* [Description](#description)
* [Data Types](#types)
* [Function Index](#index)
* [Function Details](#functions)


Core template data type and functions.

<a name="description"></a>

## Description ##
Controls high-level
template operations.
<a name="types"></a>

## Data Types ##




### <a name="type-template">template()</a> ###


__abstract datatype__: `template()`

<a name="index"></a>

## Function Index ##


<table width="100%" border="1" cellspacing="0" cellpadding="2" summary="function index"><tr><td valign="top"><a href="#is_template-1">is_template/1</a></td><td>Test if a term is a template or not.</td></tr><tr><td valign="top"><a href="#new-1">new/1</a></td><td>Compiles the provided template source, returning the compiled
representation, suitable for use with other functions in this
module.</td></tr><tr><td valign="top"><a href="#nodelist-1">nodelist/1</a></td><td>Get the template's nodes.</td></tr><tr><td valign="top"><a href="#render-2">render/2</a></td><td>Renders the provided template with the context (stub).</td></tr></table>


<a name="functions"></a>

## Function Details ##

<a name="is_template-1"></a>

### is_template/1 ###


<pre><code>
is_template(Tpl::term()) -&gt; boolean()
</code></pre>

<br></br>


Test if a term is a template or not.
<a name="new-1"></a>

### new/1 ###


<pre><code>
new(Str::binary()) -&gt; <a href="#type-template">template()</a>
</code></pre>

<br></br>


Compiles the provided template source, returning the compiled
representation, suitable for use with other functions in this
module.
<a name="nodelist-1"></a>

### nodelist/1 ###


<pre><code>
nodelist(Tpl::<a href="#type-template">template()</a>) -&gt; [<a href="dtl_node.md#type-tnode">dtl_node:tnode()</a>]
</code></pre>

<br></br>


Get the template's nodes.
<a name="render-2"></a>

### render/2 ###


<pre><code>
render(Tpl::<a href="#type-template">template()</a>, Ctx::<a href="dtl_context.md#type-context">dtl_context:context()</a>) -&gt; {ok, binary(), <a href="dtl_context.md#type-context">dtl_context:context()</a>} | {error, atom()}
</code></pre>

<br></br>


Renders the provided template with the context (stub).
