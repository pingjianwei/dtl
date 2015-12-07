-module(dtl_compat).

-export_type([compat_dict/0]).

-export([float_to_list/2]).

-ifdef(float_to_list_1).
float_to_list(F, _Opts) ->
    io_lib:format("~.2f", [F]).
-else.
float_to_list(F, Opts) ->
    erlang:float_to_list(F, Opts).
-endif.

-ifdef(dict_0).
-type compat_dict() :: dict().
-else.
-type compat_dict() :: dict:dict().
-endif.
