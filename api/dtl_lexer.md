

# Module dtl_lexer #
* [Description](#description)
* [Data Types](#types)
* [Function Index](#index)
* [Function Details](#functions)


Template tokenizing functions.


<a name="types"></a>

## Data Types ##




### <a name="type-token">token()</a> ###



<pre><code>
token() = {<a href="#type-token_type">token_type()</a>, binary()}
</code></pre>





### <a name="type-token_type">token_type()</a> ###



<pre><code>
token_type() = text | var | block | comment
</code></pre>


<a name="index"></a>

## Function Index ##


<table width="100%" border="1" cellspacing="0" cellpadding="2" summary="function index"><tr><td valign="top"><a href="#tokenize-1">tokenize/1</a></td><td>Traverses the provided template source code, generating a list
of tokens describing the basic structure.</td></tr></table>


<a name="functions"></a>

## Function Details ##

<a name="tokenize-1"></a>

### tokenize/1 ###


<pre><code>
tokenize(Src::binary()) -&gt; [<a href="#type-token">token()</a>]
</code></pre>

<br></br>


Traverses the provided template source code, generating a list
of tokens describing the basic structure.
