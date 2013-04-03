

# Module dtl_file #
* [Description](#description)
* [Function Index](#index)
* [Function Details](#functions)


Functions for dealing with files and filesystems.

<a name="index"></a>

## Function Index ##


<table width="100%" border="1" cellspacing="0" cellpadding="2" summary="function index"><tr><td valign="top"><a href="#abspath-1">abspath/1</a></td><td>Returns the absolute path of the provided relative path,
prepending the current working directory if the path is not
already absolute, resolving "." and ".." path components in the
process.</td></tr><tr><td valign="top"><a href="#safe_path-2">safe_path/2</a></td><td>Returns the first path if the second (root) path is its ancestor.</td></tr></table>


<a name="functions"></a>

## Function Details ##

<a name="abspath-1"></a>

### abspath/1 ###


<pre><code>
abspath(Path::list()) -&gt; list()
</code></pre>

<br></br>


Returns the absolute path of the provided relative path,
prepending the current working directory if the path is not
already absolute, resolving "." and ".." path components in the
process.
<a name="safe_path-2"></a>

### safe_path/2 ###


<pre><code>
safe_path(Path::list(), Root::list()) -&gt; list() | undefined
</code></pre>

<br></br>


Returns the first path if the second (root) path is its ancestor.
Returns `undefined` if the second path is not an ancestor of the
first.
