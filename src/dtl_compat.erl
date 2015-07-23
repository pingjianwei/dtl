-module(dtl_compat).

-export_type([compat_dict/0]).

-ifdef(dict_0).
-type compat_dict() :: dict().
-else.
-type compat_dict() :: dict:dict().
-endif.
