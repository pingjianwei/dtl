

# Module dtl_filter #
* [Description](#description)
* [Data Types](#types)
* [Function Index](#index)
* [Function Details](#functions)


Functions for running and creating template filters.

<a name="description"></a>

## Description ##
See Django
docs for what a filter is ...
<a name="types"></a>

## Data Types ##




### <a name="type-expr">expr()</a> ###


__abstract datatype__: `expr()`




### <a name="type-filter">filter()</a> ###



<pre><code>
filter() = {<a href="#type-filter_fun">filter_fun()</a>, [<a href="#type-filter_arg">filter_arg()</a>]}
</code></pre>





### <a name="type-filter_arg">filter_arg()</a> ###



<pre><code>
filter_arg() = {boolean(), term()}
</code></pre>





### <a name="type-filter_fun">filter_fun()</a> ###



<pre><code>
filter_fun() = {module(), atom()}
</code></pre>


<a name="index"></a>

## Function Index ##


<table width="100%" border="1" cellspacing="0" cellpadding="2" summary="function index"><tr><td valign="top"><a href="#parse-2">parse/2</a></td><td>Parses the contents of a variable node into a filter expression
record: [str|var]\|filter_name[:(str|var)...].</td></tr><tr><td valign="top"><a href="#resolve_expr-2">resolve_expr/2</a></td><td></td></tr></table>


<a name="functions"></a>

## Function Details ##

<a name="parse-2"></a>

### parse/2 ###


<pre><code>
parse(Token::binary(), Parser::<a href="dtl_parser.md#type-parser">dtl_parser:parser()</a>) -&gt; <a href="#type-expr">expr()</a>
</code></pre>

<br></br>


Parses the contents of a variable node into a filter expression
record: [str|var]\|filter_name[:(str|var)...]
<a name="resolve_expr-2"></a>

### resolve_expr/2 ###


<pre><code>
resolve_expr(Expr::<a href="#type-expr">expr()</a>, Ctx::<a href="dtl_context.md#type-context">dtl_context:context()</a>) -&gt; term()
</code></pre>

<br></br>



