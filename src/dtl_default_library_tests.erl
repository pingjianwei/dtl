%% Copyright (c) 2013- Thomas Allen <thomas@oinksoft.com>
%%
%% Permission is hereby granted, free of charge, to any person obtaining
%% a copy of this software and associated documentation files (the
%% "Software"), to deal in the Software without restriction, including
%% without limitation the rights to use, copy, modify, merge, publish,
%% distribute, sublicense, and/or sell copies of the Software, and to
%% permit persons to whom the Software is furnished to do so, subject to
%% the following conditions:
%%
%% The above copyright notice and this permission notice shall be
%% included in all copies or substantial portions of the Software.
%%
%% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
%% EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
%% MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
%% NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
%% BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
%% ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
%% CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
%% SOFTWARE.

%% @doc Default template tag and filter tests.
-module(dtl_default_library_tests).

-behaviour(dtl_library).

-export([registered_filters/0,
         registered_tags/0]).

-export([make_cat/1,
         render_item/2,
         wc/2,
         wc_render/2]).

-include("test.hrl").
-include_lib("eunit/include/eunit.hrl").

%% dtl_library (for {% load %} tests).
registered_filters() -> [make_cat].
registered_tags() -> [render_item, wc].

%%
%% Filters
%%

make_cat(_) -> {ok, <<"Cat">>}.

%%
%% Tags
%%
wc(Parser, _Token) ->
    {ok, Nodes, Parser2} = dtl_parser:parse(Parser, [endwc]),
    Node = dtl_node:new("wc", {?MODULE, wc_render}),
    Node2 = dtl_node:set_nodelist(Node, Nodes),
    {ok, Node2, dtl_parser:delete_first_token(Parser2)}.

wc_render(Node, Ctx) ->
    Out = dtl_node:render(dtl_node:nodelist(Node), Ctx),
    In = binary_to_list(iolist_to_binary(Out)),
    Wc = case re:run(In, "(?:^|\\b)\\w+(?:\\b|$)", [global]) of
        nomatch -> 0;
        {match, Ms} -> length(Ms)
    end,
    list_to_binary(integer_to_list(Wc)).

render_item(Parser, Token) ->
    [_, RawItem] = dtl_parser:split_token(Token),
    Item = dtl_filter:parse(RawItem, Parser),
    {ok, dtl_node:new("render_item", fun (_Node, Ctx) ->
        Label = dtl_context:fetch(Ctx, item_label),
        {ok, N, _Safe} = dtl_filter:resolve_expr(Item, Ctx),
        ItemVal = list_to_binary(integer_to_list(N)),
        <<"<p>", Label/binary, ": ", ItemVal/binary, "</p>">>
     end), Parser}.

load_tag_test_() ->
    ?COMPARE_TEMPLATES([
        {Out, <<"{% load dtl_default_library_tests %}", In/binary>>} ||
            {Out, In} <- [{<<"Cat">>, <<"{{ dog|make_cat }}">>},
                             {<<"2">>,
                              <<"{% wc %} Two words {% endwc %}">>}]
        ], dtl_context:new([{dog, <<"Dog">>}])).

block_tag_test() ->
    {ok, Expected} = dtl_loader:find_template("block-out.html"),
    {ok, Out} = dtl:render("block.html"),
    {ok, Expected2} = dtl_loader:find_template("block-out2.html"),
    {ok, Out2} = dtl:render("block2.html"),
    {ok, Expected3} = dtl_loader:find_template("block-out3.html"),
    {ok, Out3} = dtl:render("block3.html"),
    {ok, Expected4} = dtl_loader:find_template("block-out4.html"),
    {ok, Out4} = dtl:render("block4.html", [
        {items, [1, 2, 3, 4]},
        {item_label, <<"Item">>}
    ]),
    ?assertEqual(Expected, Out),
    ?assertEqual(Expected2, Out2),
    ?assertEqual(Expected3, Out3),
    ?assertEqual(Expected4, Out4).

filter_test_() ->
    Ctx = dtl_context:new([
        {abc, <<"abc">>},
        {cat, <<"Cat">>},
        {quotes, <<"'\"\\">>},
        {tag, <<"<p>">>},
        {test, <<"'test'">>},
        {l, [1, 2, 3]}
    ]),
    ?COMPARE_TEMPLATES([
        {<<"\\&#39;\\&quot;\\\\">>, <<"{{ quotes|addslashes }}">>},
        {<<"Trout">>, <<"{{ \"trout\"|capfirst }}">>},
        {<<"abc">>, <<"{{ \"ABC\"|lower }}">>},
        {<<"ABC">>, <<"{{ \"abc\"|upper }}">>},
        {<<"1. &lt;p&gt;">>, <<"1. {{ tag }}">>},
        {<<"2. <p>">>, <<"2. {{ tag|safe }}">>},
        {<<"3. &lt;p&gt;">>, <<"3. {{ tag|safe|escape }}">>},
        {<<"4. <p>">>, <<"4. {% autoescape off %}{{ tag }}{% endautoescape %}">>},
        {<<"5. &lt;p&gt;">>, <<"5. {% autoescape off %}{{ tag|escape }}{% endautoescape %}">>},
        {<<"var s = '\\u0027test\\u0027';">>, <<"var s = '{{ test|escapejs }}';">>},
        {<<"3">>, <<"{{ l|length }}">>},
        {<<"[1,2,3]">>, <<"{{ l|pprint }}">>}
    ], Ctx).

comment_tag_test_() ->
    Tests = [{<<>>, <<"{% comment %} Stuff {% endcomment %}">>}],
    Ctx = dtl_context:new(),
    ?COMPARE_TEMPLATES(Tests, Ctx).

if_tag_test_() ->
    Tests = [{<<"true">>, <<"{% if 1 > 0 %}true{% endif %}">>},
             {<<"Else">>, <<"{% if 1 < 0 %}If{% else %}Else{% endif %}">>},
             {<<"eq">>, <<"{% if 2 =:= 2 %}eq{% endif %}">>},
             {<<"eq">>, <<"{% if a == b %}eq{% endif %}">>},
             {<<"1">>, <<"{% if 1 %}1{% endif %}">>},
             {<<>>, <<"{% if a == c %}eq{% endif %}">>},
             {<<"The weather is sunny.">>,
              <<"{% if weather %}The weather is {{ weather }}.{% endif %}">>},
             {<<"neq">>, <<"{% if 2 =/= 3 %}neq{% endif %}">>}],
    Ctx = dtl_context:new([{a, a},
                           {b, a},
                           {c, b},
                           {weather, <<"sunny">>}]),
    ?COMPARE_TEMPLATES(Tests, Ctx).

ifequal_tag_test_() ->
    Tests = [{<<"true">>, <<"{% ifequal 1 1 %}true{% endifequal %}">>},
             {<<"false">>,
              <<"{% ifnotequal 1 1 %}true{% else %}false{% endifnotequal %}">>},
             {<<"false">>,
              <<"{% ifequal a c %}true{% else %}false{% endifequal %}">>},
             {<<"true">>, <<"{% ifnotequal a c %}true{% endifnotequal %}">>},
             {<<"true">>, <<"{% ifequal a a %}true{% endifequal %}">>}],
    Ctx = dtl_context:new([{a, a},
                           {b, a},
                           {c, b}]),
    ?COMPARE_TEMPLATES(Tests, Ctx).

forloop_test_() ->
    Tests = [{<<"1234">>, <<"{% for n in l %}{{ n }}{% endfor %}">>},
             {<<"0123">>, <<"{% for n in l %}{{ forloop.counter0 }}{% endfor %}">>},
             {<<"Empty">>, <<"{% for n in l2 %}{{ n }}{% empty %}Empty{% endfor %}">>},
             {<<"1">>, <<"{% for n in l3 %}{{ n }}{% empty %}Empty{% endfor %}">>},
             {<<"Empty2">>, <<"{% for n in l99 %}{{ n }}{% empty %}Empty2{% endfor %}">>},
             {<<"1,2:3,4">>, <<"{% for x, y in l4 %}{{ x }},{{ y }}{% if not forloop.last %}:{% endif %}{% endfor %}">>},
             {<<"123">>, <<"{% for n in l %}{% if not forloop.last %}{{ n }}{% endif %}{% endfor %}">>},
             {<<"4321">>, <<"{% for n in l %}{{ forloop.revcounter }}{% endfor %}">>},
             {<<"3210">>, <<"{% for n in l %}{{ forloop.revcounter0 }}{% endfor %}">>},
             {<<"1">>, <<"{% for n in l %}{% if forloop.first %}{{ n }}{% endif %}{% endfor %}">>}],
    Ctx = dtl_context:new([{l, [1, 2, 3, 4]},
                           {l2, []},
                           {l3, [1]},
                           {l4, [[1, 2],
                                 [3, 4]]},
                           {a, <<"A">>}]),
    ?COMPARE_TEMPLATES(Tests, Ctx).

ifchanged_test_() ->
    Tests = [{<<"123">>, <<"{% for n in l %}{% ifchanged %}{{ n }}{% endifchanged %}{% endfor %}">>},
             {<<"1...2..3">>, <<"{% for n in l2 %}{% ifchanged %}{{ n }}{% else %}.{% endifchanged %}{% endfor %}">>}],
    Ctx = dtl_context:new([{l, [1, 1, 2, 2, 3, 3, 3]},
                           {l2, [1, 1, 1, 1, 2, 2, 2, 3]}]),
    ?COMPARE_TEMPLATES(Tests, Ctx).

verbatim_test_() ->
    Tests = [{<<"{{ x }}">>, <<"{% verbatim %}{{ x }}{% endverbatim %}">>}],
    Ctx = dtl_context:new([{x, 1}]),
    ?COMPARE_TEMPLATES(Tests, Ctx).

cycle_test_() ->
    Tests = [{<<"abab">>, <<"{% for n in l %}{% cycle \"a\" \"b\" %}{% endfor %}">>},
             {<<"cdcd">>, <<"{% for n in l %}{% cycle c d %}{% endfor %}">>}],
    Ctx = dtl_context:new([{l, [0, 0, 0, 0]},
                           {c, "c"},
                           {d, "d"}]),
    ?COMPARE_TEMPLATES(Tests, Ctx).

firstof_test_() ->
    Tests = [{<<1>>, <<"{% firstof false false 1 2 %}">>},
             {<<"Hello">>, <<"{% firstof a b c d %}">>}],
    Ctx = dtl_context:new([{a, false},
                           {b, false},
                           {c, "Hello"},
                           {d, "Hi"}]),
    ?COMPARE_TEMPLATES(Tests, Ctx).

include_test_() ->
    Tests = [{<<"1\n">>, <<"{% include \"included.html\" %}">>},
             {<<"1\n">>, <<"{% include template %}">>}],
    Ctx = dtl_context:new([{template, "included.html"},
                           {o, 1}]),
    ?COMPARE_TEMPLATES(Tests, Ctx).

templatetag_test_() ->
    ?COMPARE_TEMPLATES(
        [{Out, list_to_binary(io_lib:format("{% templatetag ~p %}", [Tag]))} ||
         {Out, Tag} <- [{<<"{%">>, openblock},
                        {<<"%}">>, closeblock},
                        {<<"{{">>, openvariable},
                        {<<"}}">>, closevariable},
                        {<<"{">>,  openbrace},
                        {<<"}">>,  closebrace},
                        {<<"{#">>, opencomment},
                        {<<"#}">>, closecomment}]],
        dtl_context:new()).
