-module(kv_db_tests).

-include_lib("eunit/include/eunit.hrl").

new_test() ->
  ?assertEqual([], kv_db:new()).

put_test() ->
  Db0 = kv_db:new(),
  Db1 = kv_db:put(color, "red", Db0),

  ?assertEqual([{color, "red"}], Db1),

  Db2 = kv_db:put(color, "blue", Db1),

  ?assertEqual([{color, "blue"}], Db2),

  Db3 = kv_db:put(number, 7, Db2),

  ?assertEqual([{color, "blue"},{number, 7}], Db3).

get_test() ->
  Db0 = kv_db:new(),

  ?assertEqual({error, "Key not found: color"}, kv_db:get(color, Db0)),

  Db1 = kv_db:put(color, "red", Db0),

  ?assertEqual("red", kv_db:get(color, Db1)).

delete_test() ->
  Db0 = kv_db:new(),

  ?assertEqual({error, "Key not found: color"}, kv_db:delete(color, Db0)),

  Db1 = kv_db:put(color, "red", Db0),
  Db2 = kv_db:put(number, 7, Db1),

  ?assertEqual([{color, "red"}, {number, 7}], Db2),

  Db3 = kv_db:delete(color, Db2),

  ?assertEqual([{number, 7}], Db3),

  Db4 = kv_db:put(color, "red", Db3),

  Db5 = kv_db:delete(number, Db4),

  ?assertEqual([{color, "red"}], Db5),
  ?assertEqual([], kv_db:delete(color, Db5)).
