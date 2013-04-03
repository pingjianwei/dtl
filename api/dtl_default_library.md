

# Module dtl_default_library #
* [Description](#description)
* [Function Index](#index)
* [Function Details](#functions)


Default tags and templates.
__Behaviours:__ [`dtl_library`](dtl_library.md).
<a name="index"></a>

## Function Index ##


<table width="100%" border="1" cellspacing="0" cellpadding="2" summary="function index"><tr><td valign="top"><a href="#if-2">'if'/2</a></td><td>If/elif/else/endif tag.</td></tr><tr><td valign="top"><a href="#addslashes-1">addslashes/1</a></td><td>Adds backslash prefix to single quotes, double quotes, and
backslashes.</td></tr><tr><td valign="top"><a href="#block-2">block/2</a></td><td>Create or override a named section of a template.</td></tr><tr><td valign="top"><a href="#capfirst-1">capfirst/1</a></td><td>Capitalizes the first character of the input.</td></tr><tr><td valign="top"><a href="#comment-2">comment/2</a></td><td>Comment tag.</td></tr><tr><td valign="top"><a href="#extends-2">extends/2</a></td><td>Inherit one template from another.</td></tr><tr><td valign="top"><a href="#for-2">for/2</a></td><td></td></tr><tr><td valign="top"><a href="#if_and-3">if_and/3</a></td><td></td></tr><tr><td valign="top"><a href="#if_eq-3">if_eq/3</a></td><td></td></tr><tr><td valign="top"><a href="#if_exact_eq-3">if_exact_eq/3</a></td><td></td></tr><tr><td valign="top"><a href="#if_exact_neq-3">if_exact_neq/3</a></td><td></td></tr><tr><td valign="top"><a href="#if_gt-3">if_gt/3</a></td><td></td></tr><tr><td valign="top"><a href="#if_gte-3">if_gte/3</a></td><td></td></tr><tr><td valign="top"><a href="#if_in-3">if_in/3</a></td><td></td></tr><tr><td valign="top"><a href="#if_lt-3">if_lt/3</a></td><td></td></tr><tr><td valign="top"><a href="#if_lte-3">if_lte/3</a></td><td></td></tr><tr><td valign="top"><a href="#if_neq-3">if_neq/3</a></td><td></td></tr><tr><td valign="top"><a href="#if_not-2">if_not/2</a></td><td></td></tr><tr><td valign="top"><a href="#if_not_in-3">if_not_in/3</a></td><td></td></tr><tr><td valign="top"><a href="#if_or-3">if_or/3</a></td><td></td></tr><tr><td valign="top"><a href="#ifchanged-2">ifchanged/2</a></td><td></td></tr><tr><td valign="top"><a href="#ifequal-2">ifequal/2</a></td><td></td></tr><tr><td valign="top"><a href="#ifnotequal-2">ifnotequal/2</a></td><td></td></tr><tr><td valign="top"><a href="#load-2">load/2</a></td><td>Loads tag: <code>{% load library_name %}</code> where <code>library_name</code> is a
module implementing the <code>dtl_library</code> interface.</td></tr><tr><td valign="top"><a href="#lower-1">lower/1</a></td><td>Converts upper to lowercase.</td></tr><tr><td valign="top"><a href="#registered_filters-0">registered_filters/0</a></td><td></td></tr><tr><td valign="top"><a href="#registered_tags-0">registered_tags/0</a></td><td></td></tr><tr><td valign="top"><a href="#render_block-2">render_block/2</a></td><td></td></tr><tr><td valign="top"><a href="#render_extends-2">render_extends/2</a></td><td></td></tr><tr><td valign="top"><a href="#render_for-2">render_for/2</a></td><td></td></tr><tr><td valign="top"><a href="#render_if-2">render_if/2</a></td><td></td></tr><tr><td valign="top"><a href="#render_ifchanged-2">render_ifchanged/2</a></td><td></td></tr><tr><td valign="top"><a href="#render_ifequal-2">render_ifequal/2</a></td><td></td></tr><tr><td valign="top"><a href="#upper-1">upper/1</a></td><td>Converts lowercase to uppercase.</td></tr></table>


<a name="functions"></a>

## Function Details ##

<a name="if-2"></a>

### 'if'/2 ###

`if(Parser, Token) -> any()`

If/elif/else/endif tag.
<a name="addslashes-1"></a>

### addslashes/1 ###


<pre><code>
addslashes(Bin::binary()) -&gt; binary()
</code></pre>

<br></br>


Adds backslash prefix to single quotes, double quotes, and
backslashes. {{ "'\"\\" }} -> "\\'\\\"\\\\".
<a name="block-2"></a>

### block/2 ###


<pre><code>
block(Parser::<a href="dtl_parser.md#type-parser">dtl_parser:parser()</a>, Token::binary()) -&gt; {ok, <a href="dtl_node.md#type-unode">dtl_node:unode()</a>, <a href="dtl_parser.md#type-parser">dtl_parser:parser()</a>} | {error, {badarg, block_tag} | {block_redefined, binary()}}
</code></pre>

<br></br>


Create or override a named section of a template.
<a name="capfirst-1"></a>

### capfirst/1 ###


<pre><code>
capfirst(Bin::binary()) -&gt; binary()
</code></pre>

<br></br>


Capitalizes the first character of the input.
{{ "pig"|capfirst }} -> "Pig".
<a name="comment-2"></a>

### comment/2 ###

`comment(Parser, Token) -> any()`

Comment tag. Everything between {% comment %} and
{% endcomment %} is dropped from the document.
<a name="extends-2"></a>

### extends/2 ###


<pre><code>
extends(Parser::<a href="dtl_parser.md#type-parser">dtl_parser:parser()</a>, Token::binary()) -&gt; {ok, <a href="dtl_node.md#type-unode">dtl_node:unode()</a>, <a href="dtl_parser.md#type-parser">dtl_parser:parser()</a>} | {error, {template_not_found, binary()} | {badarg, extends_tag} | multiple_extends_tags}
</code></pre>

<br></br>


Inherit one template from another. Child template must define
all content in {% block Name %} tags, which will override any block
with the same name in parent templates.
<a name="for-2"></a>

### for/2 ###

`for(Parser, Token) -> any()`


<a name="if_and-3"></a>

### if_and/3 ###

`if_and(X, Y, Ctx) -> any()`


<a name="if_eq-3"></a>

### if_eq/3 ###

`if_eq(X, Y, Ctx) -> any()`


<a name="if_exact_eq-3"></a>

### if_exact_eq/3 ###

`if_exact_eq(X, Y, Ctx) -> any()`


<a name="if_exact_neq-3"></a>

### if_exact_neq/3 ###

`if_exact_neq(X, Y, Ctx) -> any()`


<a name="if_gt-3"></a>

### if_gt/3 ###

`if_gt(X, Y, Ctx) -> any()`


<a name="if_gte-3"></a>

### if_gte/3 ###

`if_gte(X, Y, Ctx) -> any()`


<a name="if_in-3"></a>

### if_in/3 ###

`if_in(X, Y, Ctx) -> any()`


<a name="if_lt-3"></a>

### if_lt/3 ###

`if_lt(X, Y, Ctx) -> any()`


<a name="if_lte-3"></a>

### if_lte/3 ###

`if_lte(X, Y, Ctx) -> any()`


<a name="if_neq-3"></a>

### if_neq/3 ###

`if_neq(X, Y, Ctx) -> any()`


<a name="if_not-2"></a>

### if_not/2 ###

`if_not(X, Ctx) -> any()`


<a name="if_not_in-3"></a>

### if_not_in/3 ###

`if_not_in(X, Y, Ctx) -> any()`


<a name="if_or-3"></a>

### if_or/3 ###

`if_or(X, Y, Ctx) -> any()`


<a name="ifchanged-2"></a>

### ifchanged/2 ###

`ifchanged(Parser, Token) -> any()`


<a name="ifequal-2"></a>

### ifequal/2 ###

`ifequal(Parser, Token) -> any()`


<a name="ifnotequal-2"></a>

### ifnotequal/2 ###

`ifnotequal(Parser, Token) -> any()`


<a name="load-2"></a>

### load/2 ###


<pre><code>
load(Parser::<a href="dtl_parser.md#type-parser">dtl_parser:parser()</a>, Token::binary()) -&gt; {ok, <a href="dtl_node.md#type-unode">dtl_node:unode()</a>, <a href="dtl_parser.md#type-parser">dtl_parser:parser()</a>} | {error, {missing_library, binary()} | load_tag_syntax_error}
</code></pre>

<br></br>


Loads tag: `{% load library_name %}` where `library_name` is a
module implementing the `dtl_library` interface.
<a name="lower-1"></a>

### lower/1 ###


<pre><code>
lower(Bin::binary()) -&gt; binary()
</code></pre>

<br></br>


Converts upper to lowercase. {{ "FOO"|lower }} -> "foo".
<a name="registered_filters-0"></a>

### registered_filters/0 ###

`registered_filters() -> any()`


<a name="registered_tags-0"></a>

### registered_tags/0 ###

`registered_tags() -> any()`


<a name="render_block-2"></a>

### render_block/2 ###


<pre><code>
render_block(Node::<a href="dtl_node.md#type-unode">dtl_node:unode()</a>, Ctx::<a href="dtl_context.md#type-context">dtl_context:context()</a>) -&gt; {[binary()], <a href="dtl_context.md#type-context">dtl_context:context()</a>}
</code></pre>

<br></br>



<a name="render_extends-2"></a>

### render_extends/2 ###


<pre><code>
render_extends(Node::<a href="dtl_node.md#type-unode">dtl_node:unode()</a>, Ctx::<a href="dtl_context.md#type-context">dtl_context:context()</a>) -&gt; {binary(), <a href="dtl_context.md#type-context">dtl_context:context()</a>}
</code></pre>

<br></br>



<a name="render_for-2"></a>

### render_for/2 ###

`render_for(Node, Ctx) -> any()`


<a name="render_if-2"></a>

### render_if/2 ###

`render_if(Node, Ctx) -> any()`


<a name="render_ifchanged-2"></a>

### render_ifchanged/2 ###

`render_ifchanged(Node, Ctx) -> any()`


<a name="render_ifequal-2"></a>

### render_ifequal/2 ###

`render_ifequal(Node, Ctx) -> any()`


<a name="upper-1"></a>

### upper/1 ###


<pre><code>
upper(Bin::binary()) -&gt; binary()
</code></pre>

<br></br>


Converts lowercase to uppercase. {{ "foo"|upper }} -> "FOO".
