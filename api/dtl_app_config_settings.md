

# Module dtl_app_config_settings #
* [Description](#description)
* [Function Index](#index)
* [Function Details](#functions)


Base settings module.
__Behaviours:__ [`dtl_settings`](dtl_settings.md).
<a name="description"></a>

## Description ##
Simply proxies to application env vars.<a name="index"></a>

## Function Index ##


<table width="100%" border="1" cellspacing="0" cellpadding="2" summary="function index"><tr><td valign="top"><a href="#setting-2">setting/2</a></td><td>Returns the requested setting based on the value of the same key
in <code>dtl</code> application config.</td></tr></table>


<a name="functions"></a>

## Function Details ##

<a name="setting-2"></a>

### setting/2 ###


<pre><code>
setting(Key::atom(), Default::term()) -&gt; term()
</code></pre>

<br></br>


Returns the requested setting based on the value of the same key
in `dtl` application config.
