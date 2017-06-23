# Django Template Language

[![Travis CI](https://api.travis-ci.org/oinksoft/dtl.png?branch=master)](https://travis-ci.org/oinksoft/dtl)

A full-featured port of the Django template engine to Erlang.

Tested and supported for Erlang/OTP versions R15B03, R16B03, 17.1, 18.3, 19.3,
and 20.0.

API Documentation: [http://oinksoft.github.io/dtl/](http://oinksoft.github.io/dtl/)

1. [Introduction](#1-introduction)
2. [Installation](#2-installation)
3. [Configuration](#3-configuration)
4. [Basic Usage](#4-basic-usage)
5. [Syntax](#5-syntax)
6. [Context and Context Processors](#6-context-and-context-processors)
7. [Built-in Tags and Filters](#7-built-in-tags-and-filters)
8. [Loader Modules](#8-loader-modules)
9. [Custom Tags and Filters](#9-custom-tags-and-filters)
10. [Getting Help](#10-supportgetting-help)
11. [Roadmap](#11-roadmap)


## 1. Introduction

This project is an effort to fully implement the Django template engine
in Erlang. I hope to create a feature-complete port, using the same data
types and striving for parity with the Python API and the base
filter/tag set included in Django.


## 2. Installation

To install the latest version, add this to your dependency list in
rebar.config:

```erlang
{dtl, ".*", {git, "git://github.com/oinksoft/dtl.git", {branch, "master"}}}
```

and run `rebar get-deps`, then `rebar compile`. Refer to the [rebar
documentation](https://github.com/basho/rebar) if this is unclear.

The `dtl` application must be started for the engine to work at all.
Include this in your application so that it is run before you use `dtl`:

```erlang
ok = application:start(dtl).
```

Right now this might seem funny because DTL is mostly a library
application, but it is needed for application config to work. It also
allows DTL to have some optimizations in the future via its own
services.


## 3. Configuration

These are the application-wide environment variables. Set them like you
do any other application options.

Name|Type|Default|Description
---|---|---|---
`apps`|`[atom()]`|`[]`|A list of application names that will be searched in left-to-right order by `dtl_apps_loader` if enabled.
`context_processors`|`[{module(), atom()}]`|`[]`|List of `{Mod, Fun}` tuples that are called in left-to-right order to populate all new `dtl_context:context()` records.
`debug`|`boolean()`|`false`|Set `true` to enable debugging aids, `false` otherwise.
`empty_term_replacement`|`binary()`|`<<>>`|Binary that will replace any `undefined` terms in templates. `<<"None">>` and `<<"undefined">>` are also good ones.
`settings_module`|`module()`|`dtl_app_config_settings`|Module used to look up settings, must implement `dtl_settings`.
`template_dirs`|`[list()]`|`["priv/templates"]`|Template directories that `dtl_fs_loader` (if enabled) will search, from left. Paths can be absolute or relative.
`template_loaders`|`[module()]`|`[dtl_fs_loader, dtl_apps_loader]`|List of modules implementing the `dtl_loader` interface. These are used to look up templates at runtime.

At the lowest level, these settings are managed by application env vars.
The defaults in the above table are all defined at this level.

Users can look up settings with `dtl:setting/1`:

```erlang
Apps = dtl:setting(apps).
```

It is not a good idea to change settings at runtime, but use a custom
settings module if you need this functionality and still be aware of
potential race conditions.


### 3.1 Settings Modules

_Most users won't need to use this. The default settings module (application
env) is suitable for most uses._

Settings modules are modules that implement the `dtl_settings`
behaviour. This module defines one callback, `setting/0`. They are
useful when automating tests that involve toggling DTL configuration.

`dtl_app_config_settings`, the default settings module, simply proxies
settings lookups to application env variable lookups. It's a very good
idea for user-defined settings modules to defer to
`dtl_app_config_settings` for settings that they do not define. Here is
an example of a settings module that overrides the `template_dirs`
setting:

```erlang
-module(news_settings).
-behaviour(dtl_settings).

-export([setting/2]).

setting(template_dirs, _Default) ->
    ["/tmp/templates"];
setting(Key, Default) ->
    dtl_app_config_settings:setting(Key, Default).
```

You can see another example with `dtl_ets_settings`, which is only used
for DTL tests.


## 4. Basic usage

See [6. Context and Context Processors](#6-context-and-context-processors)
for information on setting context variables in your templates, and
[8. Loader Modules](#8-loader-modules) for information on where to store
your template files.

Render a template:

```erlang
{ok, Html} = dtl:render("index.html", #{
    title => "The World Wide Web",
    visitor_count => 12
}).
```

Property lists are also supported, if your version of Erlang does not support
maps.

```erlang
{ok, Html} = dtl:render("index.html", [
    {title, "The World Wide Web"},
    {visitor_count, 12}
]).
```

Create a template from a string, create a plain context with one item
set, and render it:

```erlang
Source = "My name is {{ name }}.",
{ok, Tpl} = dtl_template:new(Source),
Ctx = dtl_context:new([
    {name, "Lawrence"}
]),
{ok, <<"My name is Lawrence">>} = dtl_template:render(Tpl, Ctx).
```

Find a template and render it:

```erlang
Tpl = dtl_loader:get_template("index.html"),
{ok, Html} = dtl_template:render(Tpl),
```

Render the first of several found templates:

```erlang
Tpl = dtl_loader:select_template(["index.html", "index.htm"]),
{ok, Html} = dtl_template:render(Tpl),
```

## 5. Syntax

Template syntax is identical to that of the [Django template
language](https://docs.djangoproject.com/en/dev/topics/templates/).
Please report any observable differences as bugs.


## 6. Context and Context Processors

Contexts are the primary means of transmitting data from application
code to Django templates. Any value that is accessible on a context
will be accessible in any template into which the context is loaded:

```erlang
Ctx = dtl_context:new([
    {foo, "Foo"},
    {bar, "Bar"}
]),
{ok, Bin} = dtl:render(Tpl, Ctx).
```

`dtl:render/2` automatically wraps its context argument, so you need not provide
a context explicitly as in the last example:

```erlang
{ok, Bin} = dtl:render(Tpl, #{foo => "Foo", bar => "Bar"}).
```

### 6.1. Context Processors

A user may specify a list of {Mod, Fun} tuples which will be called, in
order, when initializing a new context. Each function should return a
property list (maps support is in the works).

Here is an example context processor:

```erlang
process_time() ->
    Time = calendar:local_time(),
    [{Year, Month, Day}, {Hours, Minutes, Seconds}] = Time,
    [{date, io_lib:format("~p-~p-~p", [Year, Month, Day])},
     {time, io_lib:format("~p:~p:~p", [Hours, Minutes, Seconds])}].
```

Context processors are specified in application config.

```erlang
application:set_env(dtl, context_processors, [{my_app, process_time}]).
```

Now, a template could access `time` and `date` variables.


## 7. Built-in Tags and Filters

The target is to implement all default template tags and filters. Below are tables showing the current development status of these items.

Documentation on how to use these tags and filters can be found at
https://docs.djangoproject.com/en/dev/ref/templates/builtins/


### 7.1 Tags

Name|Implemented
---|---
`autoescape`|Yes
`block`|Yes
`comment`|Yes
`csrf_token`|Won't support
`cycle`|Yes
`debug`|No
`extends`|Yes
`filter`|No
`firstof`|Yes
`for`|Yes
`for ... empty`|Yes
`if`|Yes
`ifchanged`|Yes
`ifequal`|Yes
`ifnotequal`|Yes
`include`|Yes
`load`|Yes
`now`|No
`regroup`|No
`spaceless`|No
`ssi`|No
`templatetag`|Yes
`url`|Won't support
`verbatim`|Yes
`widthratio`|No
`with`|No


### 7.2 Filters

Name|Implemented
---|---
`add`|Yes
`addslashes`|Yes
`capfirst`|Yes
`center`|Yes
`cut`|No
`date`|No
`default`|No
`default_if_none`|No
`dictsort`|No
`dictsortreversed`|No
`divisibleby`|No
`escape`|Yes
`escapejs`|Yes
`filesizeformat`|No
`first`|No
`fix_ampersands`|No
`floatformat`|No
`force_escape`|No
`get_digit`|No
`iriencode`|No
`join`|Yes
`last`|No
`length`|Yes
`length_is`|No
`linebreaks`|No
`linebreaksbr`|No
`linenumbers`|No
`ljust`|No
`lower`|Yes
`make_list`|No
`phone2numeric`|No
`pluralize`|No
`pprint`|Yes
`random`|No
`removetags`|No
`rjust`|No
`safe`|Yes
`safeseq`|No
`slice`|No
`slugify`|No
`stringformat`|No
`striptags`|No
`time`|No
`timesince`|No
`timeuntil`|No
`title`|No
`truncatechars`|No
`truncatewords`|No
`truncatewords_html`|No
`unordered_list`|No
`upper`|Yes
`urlencode`|No
`urlize`|No
`urlizetrunc`|No
`wordcount`|No
`wordwrap`|No
`yesno`|No


## 8. Loader Modules

DTL comes with two template loader modules, which are described here:

`dtl_fs_loader`: This loader tries each of the configured
    `template_dirs`, in order, to see if the named template exists in
    one of them. Only templates contained in one of these directories
    will be found.

`dtl_apps_loader`: This loader searches in "templates" in the "priv"
    directory of each app specified with the `apps` configuration
    option.  That is, "index.html" would be searched for at
    foo/priv/templates/index.html if `foo` were included in the `apps`
    configuration option.

You can also implement your own loaders. Here is an HTTP loader:

```erlang
-module(http_loader).
-behaviour(dtl_loader).

-define(BASE_URL, "http://example.com/?img_name=").

-export([is_usable/0,
         load_template_source/1,
         load_template_source/2]).

%% A loader must implement is_usable/0. This callback is so that
%% loaders that are only useful in certain environments (say, a
%% memcached-backed loader) are not used.
%%
%% For instance, this function could test to see if ?BASE_URL's host
%% is reachable.
is_usable() -> true.

%% A loader must implement load_template_source/1 and
%% load_template_source/2. This is to match the Django API, where a
%% `dirs' argument must be accepted even for loaders that are not
%% concerned with this detail.
%%
%% This function should return a {ok, Content, DisplayName} triple
%% where Content is the template string and DisplayName is a name
%% for the found template, which will be used in debugging outputs.
%%
%% It should return {error, not_found} if the template is not found.
%% Any other error return will immediately halt the lookup process.
load_template_source(Name) -> load_template_source(Name, []).
load_template_source(Name, _Dirs) ->
    %% Assume our application has already started `inets'.
    Url = ?BASE_URL ++ Name,
    %% Anything other than a 200 response is "not found".
    case httpc:request(Url) of
        {ok, {_Proto, 200, _Msg}, _Headers, Body} ->
            {ok, Body, Url};
        _ -> {error, not_found};
    end.
```


## 9. Custom Tags and Filters

Custom tags and filters are defined in a "Library," which is a simple
callback module that implements the `dtl_library` behaviour. A library
simply defines `registered_tags/0` and `registered_filters/0`, each of
which return a list of function names, the likes of which are described
in the sections below.

## 9.1. Custom Tags

`registered_tags` returns a list of `dtl_library:tag_spec()`:

`NodeFunction`: `NodeFunction` is the name of a function that returns
    a `dtl_node:tnode()`. This may be a `dtl_node:unode()`, a list, or a
    binary.

```erlang
-behaviour(dtl_library).
-export([registered_filters/0,
         registered_tags/0,
         color_orange/2,
         render_color_orange/2]).

registered_filters() -> [].
regisered_tags() -> [color_orange].

%% This function extracts the number of repititions from the tag
%% token and saves this in the new node's state.
%%
%% {% color_orange 1 %} Hello {% endcolor_orange %} ->
%% <div class="orange"> Hello </div>
color_orange(Parser, Token) ->
    [<<NBin/binary>>] = dtl_token:split_contents(Token),
    N = list_to_integer(binary_to_list(NBin)),
    {Nodes, Parser2} = dtl_parser:parse("endcolor_orange"),
    Node = dtl_node:new("color_orange", {?MODULE, render_color_orange}),
    Node2 = dtl_node:set_nodelist(Node, Nodes),
    Node3 = dtl_node:set_state(Node2, N),
    {Node3, dtl_parser:delete_first_token(Parser2)}.

%% Renders the tag contents N times inside an orange block.
render_color_orange(Node, Ctx) ->
    N = dtl_node:state(Node),
    Nodes = dtl_node:nodelist(Node),
    ["<div class=\"orange\">",
        [dtl_node:render_list(Nodes) || X <- lists:seq(1, N)],
     "</div>"].
```

`{{dtl_tag, inclusion_tag, TemplateName}, ContextFunction}`: This is an
    example of a tag wrapper, which may be provided as a `{module(),
    tuple(), term()}` triple as the first element of a tag spec. For
    `inclusion_tag`, TemplateName is the name of the template this tag
    includes. `ContextFunction` is a function that can inject data into
    this template by returning a `dtl_context()` or a proplist. It
    receives any arguments passed to the inclusion tag as positional and
    keyword argument lists.

```erlang
-behaviour(dtl_library).
-export([registered_filters/0,
         registered_tags/0,
         pretty_box/2]).
registered_filters() -> [].
regisered_tags() -> [{{dtl_tag, inclusion_tag, "pretty-box.html"}, pretty_box}].

%%%% pretty-box.html:
%% <div class="so" style="color: {{ color }}">
%%   <div class="many">
%%     <div class="lovely">
%%       <div class="elements">
%%         <h1>{{ title }}</h1>
%%       </div>
%%     </div>
%%   </div>
%% </div>

%% Renders a pretty box with the provided title and optional color.
%%     {% pretty_box "March" color="#f90" %}
pretty_box([Title], Options) ->
    Color = proplists:get_value(color, Options, "#fc0"),
    [{color, Color},
     {title, Title}].
```

Simple tag works for most cases, where the custom tag returns a list or binary.
The following is a named simple tag:

```erlang
my_simple_tag(Parser, _Token) ->
    {ok, dtl_node("my_simple_tag", fun (Node, Ctx) ->
         %% Render ...
     end, Parser)}.
```

See `dtl_default_library` and `dtl_tag_tests` for more examples.


## 9.2. Custom Filters

Custom filters are functions that can accept a list of colon-separated
arguments. They must return a tagged list, binary, or iolist, in the
form `{ok, Out}`:

```erlang
-behaviour(dtl_library).
-export([registered_filters/0,
         registered_tags/0]).
%% Filters.
-export([add/2,
         reverso/1]).

registered_filters() -> [reverso].
regisered_tags() -> [].

%% @doc Reverses its input: {{ "Cat"|reverso }} -> "taC".
reverso(Bin) ->
    {ok, list_to_binary(lists:reverse(binary_to_list(Text)))}.

%% @doc Adds to the first number: {{ 1|add:2 }} -> "3".
add(X, [Y]) ->
    {ok, integer_to_list(X + Y)}.
```

## 10. Getting Help

Please report issues at
[the Github issue queue](https://github.com/oinksoft/dtl/issues).


## 11. Roadmap

* Default tags and filters.
* Performance optimizations (cache parsed templates in ETS, etc.).
* Debug lexer and parser, better error handling.
* I18n support.
* OTP version?
