

# Module dtl_context #
* [Description](#description)
* [Data Types](#types)
* [Function Index](#index)
* [Function Details](#functions)


Functions for dealing with template contexts.

<a name="description"></a>

## Description ##
Template contexts
are the primary way of transmitting data from application code
to templates.

<a name="types"></a>

## Data Types ##




### <a name="type-context">context()</a> ###


__abstract datatype__: `context()`

<a name="index"></a>

## Function Index ##


<table width="100%" border="1" cellspacing="0" cellpadding="2" summary="function index"><tr><td valign="top"><a href="#fetch-2">fetch/2</a></td><td>Looks up a value on all context stacks, in top-to-bottom order.</td></tr><tr><td valign="top"><a href="#fetch-3">fetch/3</a></td><td>Looks up a value on all context stacks, in top-to-bottom order,
returning the default value if none is found.</td></tr><tr><td valign="top"><a href="#new-0">new/0</a></td><td>Creates a new template context with no data.</td></tr><tr><td valign="top"><a href="#new-1">new/1</a></td><td>Creates a new template context with the provided data.</td></tr><tr><td valign="top"><a href="#pop-1">pop/1</a></td><td>Pops a dict off of the context stack.</td></tr><tr><td valign="top"><a href="#push-1">push/1</a></td><td>Pushes a new dict on the context stack.</td></tr><tr><td valign="top"><a href="#render_context-1">render_context/1</a></td><td>Return the template rendering context from the provided context.</td></tr><tr><td valign="top"><a href="#render_fetch-2">render_fetch/2</a></td><td>Render contexts have different scope rules: Only look at the
head of the context stack.</td></tr><tr><td valign="top"><a href="#render_fetch-3">render_fetch/3</a></td><td>Same as render_fetch/2, but returns the default value if the key
is not defined on the context.</td></tr><tr><td valign="top"><a href="#set-2">set/2</a></td><td>Set many values at once on the context.</td></tr><tr><td valign="top"><a href="#set-3">set/3</a></td><td>Sets a value on the context.</td></tr><tr><td valign="top"><a href="#set_ref-3">set_ref/3</a></td><td>Directly set a variable on the first context stack where it is
stored.</td></tr><tr><td valign="top"><a href="#set_render_context-2">set_render_context/2</a></td><td>Sets the template rendering on the provided context.</td></tr><tr><td valign="top"><a href="#update-2">update/2</a></td><td>Set many values on a context at once.</td></tr></table>


<a name="functions"></a>

## Function Details ##

<a name="fetch-2"></a>

### fetch/2 ###


<pre><code>
fetch(Ctx::<a href="#type-context">context()</a>, K::term()) -&gt; term() | undefined
</code></pre>

<br></br>


Looks up a value on all context stacks, in top-to-bottom order.
<a name="fetch-3"></a>

### fetch/3 ###


<pre><code>
fetch(Ctx::<a href="#type-context">context()</a>, K::term(), Def::term()) -&gt; term()
</code></pre>

<br></br>


Looks up a value on all context stacks, in top-to-bottom order,
returning the default value if none is found.
<a name="new-0"></a>

### new/0 ###


<pre><code>
new() -&gt; <a href="#type-context">context()</a>
</code></pre>

<br></br>


Creates a new template context with no data.
<a name="new-1"></a>

### new/1 ###


<pre><code>
new(Ctx::list() | <a href="#type-context">context()</a>) -&gt; <a href="#type-context">context()</a>
</code></pre>

<br></br>


Creates a new template context with the provided data.
<a name="pop-1"></a>

### pop/1 ###


<pre><code>
pop(Ctx::<a href="#type-context">context()</a>) -&gt; <a href="#type-context">context()</a>
</code></pre>

<br></br>


Pops a dict off of the context stack.
<a name="push-1"></a>

### push/1 ###


<pre><code>
push(Ctx::<a href="#type-context">context()</a>) -&gt; <a href="#type-context">context()</a>
</code></pre>

<br></br>


Pushes a new dict on the context stack.
<a name="render_context-1"></a>

### render_context/1 ###


<pre><code>
render_context(Ctx::<a href="#type-context">context()</a>) -&gt; <a href="#type-context">context()</a> | undefined
</code></pre>

<br></br>


Return the template rendering context from the provided context.
<a name="render_fetch-2"></a>

### render_fetch/2 ###


<pre><code>
render_fetch(Ctx::<a href="#type-context">context()</a>, K::term()) -&gt; term() | undefined
</code></pre>

<br></br>



Render contexts have different scope rules: Only look at the
head of the context stack. End users shouldn't have much reason
to use this function.


Returns `undefined` if the key is not defined on the render
context.
<a name="render_fetch-3"></a>

### render_fetch/3 ###


<pre><code>
render_fetch(Ctx::<a href="#type-context">context()</a>, K::term(), Def::term()) -&gt; term()
</code></pre>

<br></br>


Same as render_fetch/2, but returns the default value if the key
is not defined on the context.
<a name="set-2"></a>

### set/2 ###


<pre><code>
set(Ctx::<a href="#type-context">context()</a>, PList::[{term(), term()}]) -&gt; <a href="#type-context">context()</a>
</code></pre>

<br></br>


Set many values at once on the context.
<a name="set-3"></a>

### set/3 ###


<pre><code>
set(Ctx::<a href="#type-context">context()</a>, K::term(), V::term()) -&gt; <a href="#type-context">context()</a>
</code></pre>

<br></br>


Sets a value on the context.
<a name="set_ref-3"></a>

### set_ref/3 ###


<pre><code>
set_ref(Ctx::<a href="#type-context">context()</a>, K::term(), V::term()) -&gt; <a href="#type-context">context()</a>
</code></pre>

<br></br>


Directly set a variable on the first context stack where it is
stored.
<a name="set_render_context-2"></a>

### set_render_context/2 ###


<pre><code>
set_render_context(Ctx::<a href="#type-context">context()</a>, RenderCtx::<a href="#type-context">context()</a> | undefined) -&gt; <a href="#type-context">context()</a>
</code></pre>

<br></br>


Sets the template rendering on the provided context.
<a name="update-2"></a>

### update/2 ###


<pre><code>
update(Ctx::<a href="#type-context">context()</a>, PList::[{term(), term()}]) -&gt; <a href="#type-context">context()</a>
</code></pre>

<br></br>


Set many values on a context at once.
