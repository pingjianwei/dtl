

# Module dtl_node #
* [Description](#description)
* [Data Types](#types)
* [Function Index](#index)
* [Function Details](#functions)


Functions for working with template nodes.

<a name="description"></a>

## Description ##

Nodes are the core
building block of templates, and templates are rendered by
recursively rendering nodelists, which in turn render nodes.


Definitions of core node types (text, variable, etc.).
<a name="types"></a>

## Data Types ##




### <a name="type-renderer">renderer()</a> ###



<pre><code>
renderer() = {module(), atom()} | function() | undefined
</code></pre>





### <a name="type-tnode">tnode()</a> ###



<pre><code>
tnode() = <a href="#type-unode">unode()</a> | binary() | list()
</code></pre>





### <a name="type-unode">unode()</a> ###


__abstract datatype__: `unode()`

<a name="index"></a>

## Function Index ##


<table width="100%" border="1" cellspacing="0" cellpadding="2" summary="function index"><tr><td valign="top"><a href="#get_nodes_by_type-2">get_nodes_by_type/2</a></td><td>Get all nodes with a given name within a certain node.</td></tr><tr><td valign="top"><a href="#get_nodes_by_type_from_list-2">get_nodes_by_type_from_list/2</a></td><td>Get all nodes with a given name within a node list.</td></tr><tr><td valign="top"><a href="#name-1">name/1</a></td><td>Get the node's name (all nodes have names), or "text" for a
list/binary node.</td></tr><tr><td valign="top"><a href="#new-1">new/1</a></td><td>Create a new node with no renderer.</td></tr><tr><td valign="top"><a href="#new-2">new/2</a></td><td>Create a new node with a renderer.</td></tr><tr><td valign="top"><a href="#new_var-1">new_var/1</a></td><td>Variable node initializer.</td></tr><tr><td valign="top"><a href="#nodelist-1">nodelist/1</a></td><td>Get a node's child nodes.</td></tr><tr><td valign="top"><a href="#render-2">render/2</a></td><td>Renders a single node.</td></tr><tr><td valign="top"><a href="#render_list-2">render_list/2</a></td><td>Renders a list of nodes.</td></tr><tr><td valign="top"><a href="#render_var-2">render_var/2</a></td><td>Variable node renderer.</td></tr><tr><td valign="top"><a href="#set_nodelist-2">set_nodelist/2</a></td><td>Set a node's child nodes.</td></tr><tr><td valign="top"><a href="#set_renderer-2">set_renderer/2</a></td><td>Set a node's renderer.</td></tr><tr><td valign="top"><a href="#set_state-2">set_state/2</a></td><td>Set a node's state.</td></tr><tr><td valign="top"><a href="#state-1">state/1</a></td><td>Get a node's state.</td></tr></table>


<a name="functions"></a>

## Function Details ##

<a name="get_nodes_by_type-2"></a>

### get_nodes_by_type/2 ###


<pre><code>
get_nodes_by_type(Node::<a href="#type-tnode">tnode()</a>, Type::atom()) -&gt; [<a href="#type-unode">unode()</a>]
</code></pre>

<br></br>


Get all nodes with a given name within a certain node.
<a name="get_nodes_by_type_from_list-2"></a>

### get_nodes_by_type_from_list/2 ###


<pre><code>
get_nodes_by_type_from_list(Nodes::[<a href="#type-tnode">tnode()</a>], Type::atom()) -&gt; [<a href="#type-unode">unode()</a>]
</code></pre>

<br></br>


Get all nodes with a given name within a node list.
<a name="name-1"></a>

### name/1 ###


<pre><code>
name(Node::<a href="#type-tnode">tnode()</a>) -&gt; list()
</code></pre>

<br></br>


Get the node's name (all nodes have names), or "text" for a
list/binary node.
<a name="new-1"></a>

### new/1 ###


<pre><code>
new(Name::list()) -&gt; <a href="#type-unode">unode()</a>
</code></pre>

<br></br>


Create a new node with no renderer.
<a name="new-2"></a>

### new/2 ###


<pre><code>
new(Name::list(), Renderer::<a href="#type-renderer">renderer()</a>) -&gt; <a href="#type-unode">unode()</a>
</code></pre>

<br></br>


Create a new node with a renderer.
<a name="new_var-1"></a>

### new_var/1 ###


<pre><code>
new_var(FilterExpr::<a href="dtl_filter.md#type-expr">dtl_filter:expr()</a>) -&gt; <a href="#type-tnode">tnode()</a>
</code></pre>

<br></br>


Variable node initializer.
<a name="nodelist-1"></a>

### nodelist/1 ###


<pre><code>
nodelist(Node::<a href="#type-unode">unode()</a>) -&gt; [<a href="#type-tnode">tnode()</a>]
</code></pre>

<br></br>


Get a node's child nodes.
<a name="render-2"></a>

### render/2 ###


<pre><code>
render(Node::<a href="#type-tnode">tnode()</a>, Ctx::<a href="dtl_context.md#type-context">dtl_context:context()</a>) -&gt; binary() | {binary(), <a href="dtl_context.md#type-context">dtl_context:context()</a>}
</code></pre>

<br></br>


Renders a single node.
<a name="render_list-2"></a>

### render_list/2 ###


<pre><code>
render_list(NodeList::[<a href="#type-tnode">tnode()</a>], Ctx::<a href="dtl_context.md#type-context">dtl_context:context()</a>) -&gt; {ok, [binary()], <a href="dtl_context.md#type-context">dtl_context:context()</a>}
</code></pre>

<br></br>


Renders a list of nodes.
<a name="render_var-2"></a>

### render_var/2 ###


<pre><code>
render_var(Unode::<a href="#type-tnode">tnode()</a>, Ctx::<a href="dtl_context.md#type-context">dtl_context:context()</a>) -&gt; binary()
</code></pre>

<br></br>


Variable node renderer.
<a name="set_nodelist-2"></a>

### set_nodelist/2 ###


<pre><code>
set_nodelist(Node::<a href="#type-unode">unode()</a>, Nodes::[<a href="#type-tnode">tnode()</a>]) -&gt; <a href="#type-unode">unode()</a>
</code></pre>

<br></br>


Set a node's child nodes.
<a name="set_renderer-2"></a>

### set_renderer/2 ###


<pre><code>
set_renderer(Node::<a href="#type-unode">unode()</a>, Renderer::<a href="#type-renderer">renderer()</a>) -&gt; <a href="#type-unode">unode()</a>
</code></pre>

<br></br>


Set a node's renderer.
<a name="set_state-2"></a>

### set_state/2 ###


<pre><code>
set_state(Node::<a href="#type-unode">unode()</a>, State::term()) -&gt; <a href="#type-unode">unode()</a>
</code></pre>

<br></br>


Set a node's state.
<a name="state-1"></a>

### state/1 ###


<pre><code>
state(Node::<a href="#type-unode">unode()</a>) -&gt; term()
</code></pre>

<br></br>


Get a node's state.
