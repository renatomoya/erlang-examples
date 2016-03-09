-module(kv_db_tests).

-include_lib("eunit/include/eunit.hrl").

new_test() ->
  ?assertEqual([], kv_db:new()).
