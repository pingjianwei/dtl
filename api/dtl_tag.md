

# Module dtl_tag #
* [Description](#description)
* [Data Types](#types)
* [Function Index](#index)
* [Function Details](#functions)


Tags are functions that return callbacks which in turn return
nodelists (see `dtl_node`).

<a name="description"></a>

## Description ##
They are used to transform templates
in ways that filters cannot because they can consume tokens,
whereas filters only replace the explicitly filtered content
(see `dtl_filter`).
<a name="types"></a>

## Data Types ##




### <a name="type-tag">tag()</a> ###



<pre><code>
tag() = {module(), <a href="dtl_library.md#type-name">dtl_library:name()</a>} | {{module(), atom()}, {module(), <a href="dtl_library.md#type-name">dtl_library:name()</a>}, term()}
</code></pre>


<a name="index"></a>

## Function Index ##


<table width="100%" border="1" cellspacing="0" cellpadding="2" summary="function index"><tr><td valign="top"><a href="#inclusion_tag-5">inclusion_tag/5</a></td><td></td></tr><tr><td valign="top"><a href="#render_inclusion_tag-2">render_inclusion_tag/2</a></td><td></td></tr><tr><td valign="top"><a href="#run-3">run/3</a></td><td></td></tr></table>


<a name="functions"></a>

## Function Details ##

<a name="inclusion_tag-5"></a>

### inclusion_tag/5 ###


<pre><code>
inclusion_tag(Name::list(), Mod::module(), Fun::atom(), Parser::<a href="dtl_parser.md#type-parser">dtl_parser:parser()</a>, Token::binary()) -&gt; {ok, <a href="dtl_node.md#type-tnode">dtl_node:tnode()</a>, <a href="dtl_parser.md#type-parser">dtl_parser:parser()</a>}
</code></pre>

<br></br>



<a name="render_inclusion_tag-2"></a>

### render_inclusion_tag/2 ###


<pre><code>
render_inclusion_tag(Node::<a href="dtl_node.md#type-tnode">dtl_node:tnode()</a>, Ctx::<a href="dtl_context.md#type-context">dtl_context:context()</a>) -&gt; {[binary()], <a href="dtl_context.md#type-context">dtl_context:context()</a>}
</code></pre>

<br></br>



<a name="run-3"></a>

### run/3 ###


<pre><code>
run(X1::<a href="#type-tag">tag()</a>, Parser::<a href="dtl_parser.md#type-parser">dtl_parser:parser()</a>, Token::binary()) -&gt; {ok, <a href="dtl_node.md#type-tnode">dtl_node:tnode()</a>, <a href="dtl_parser.md#type-parser">dtl_parser:parser()</a>} | {error, atom()}
</code></pre>

<br></br>



