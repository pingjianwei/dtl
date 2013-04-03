

# Module dtl #
* [Description](#description)
* [Function Index](#index)
* [Function Details](#functions)


Core API functions, some convenient shortcuts.

<a name="index"></a>

## Function Index ##


<table width="100%" border="1" cellspacing="0" cellpadding="2" summary="function index"><tr><td valign="top"><a href="#render-1">render/1</a></td><td>Creates and renders the template with the provided name.</td></tr><tr><td valign="top"><a href="#render-2">render/2</a></td><td>Creates and renders the template with the provided name.</td></tr><tr><td valign="top"><a href="#setting-1">setting/1</a></td><td>Find some setting, defaults to <code>undefined</code>.</td></tr><tr><td valign="top"><a href="#setting-2">setting/2</a></td><td>Find some setting, or return the provided default.</td></tr></table>


<a name="functions"></a>

## Function Details ##

<a name="render-1"></a>

### render/1 ###


<pre><code>
render(Name::list()) -&gt; {ok, binary()} | {error, atom()}
</code></pre>

<br></br>


Creates and renders the template with the provided name.
<a name="render-2"></a>

### render/2 ###


<pre><code>
render(Name::list(), PList::[{term(), term()}]) -&gt; {ok, binary()} | {error, atom()}
</code></pre>

<br></br>


Creates and renders the template with the provided name.
<a name="setting-1"></a>

### setting/1 ###


<pre><code>
setting(Name::atom()) -&gt; term()
</code></pre>

<br></br>


Find some setting, defaults to `undefined`.
<a name="setting-2"></a>

### setting/2 ###


<pre><code>
setting(Name::atom(), Default::term()) -&gt; term()
</code></pre>

<br></br>


Find some setting, or return the provided default.
