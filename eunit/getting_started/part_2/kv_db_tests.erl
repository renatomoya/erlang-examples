-module(kv_db_tests).

-include_lib("eunit/include/eunit.hrl").

all_test_() ->
  [?_assertEqual([], kv_db:new()),
   put_one_test(),
   put_same_key_test(),
   put_new_key_test(),
   get_non_existent_key_test(),
   get_existent_key_test(),
   delete_non_existent_key_test(),
   delete_first_existent_key_test(),
   delete_last_existent_key_test()].

put_test_() ->
  [put_one_test(),
   put_same_key_test(),
   put_new_key_test()].

get_test_() ->
  [get_non_existent_key_test(),
   get_existent_key_test()].

delete_test_() ->
  [delete_non_existent_key_test(),
   delete_first_existent_key_test(),
   delete_last_existent_key_test()].

put_one_test() ->
  Db0 = kv_db:new(),
  Db1 = kv_db:put(color, "red", Db0),
  ?_assertEqual([{color, "red"}], Db1).

put_same_key_test() ->
  Db0 = kv_db:new(),
  Db1 = kv_db:put(color, "red", Db0),
  Db2 = kv_db:put(color, "blue", Db1),
  ?_assertEqual([{color, "blue"}], Db2).

put_new_key_test() ->
  Db0 = kv_db:new(),
  Db1 = kv_db:put(color, "red", Db0),
  Db2 = kv_db:put(number, 7, Db1),
  ?_assertEqual([{color, "red"}, {number, 7}], Db2).

get_non_existent_key_test() ->
  Db0 = kv_db:new(),
  ?_assertEqual({error, "Key not found: color"}, kv_db:get(color, Db0)).

get_existent_key_test() ->
  Db0 = kv_db:new(),
  Db1 = kv_db:put(color, "red", Db0),
  ?_assertEqual("red", kv_db:get(color, Db1)).

delete_non_existent_key_test() ->
  Db0 = kv_db:new(),
  ?_assertEqual({error, "Key not found: color"}, kv_db:delete(color, Db0)).

delete_first_existent_key_test() ->
  Db0 = kv_db:new(),
  Db1 = kv_db:put(color, "red", Db0),
  Db2 = kv_db:put(number, 7, Db1),
  Db3 = kv_db:delete(color, Db2),
  ?_assertEqual([{number, 7}], Db3).

delete_last_existent_key_test() ->
  Db0 = kv_db:new(),
  Db1 = kv_db:put(color, "red", Db0),
  Db2 = kv_db:put(number, 7, Db1),
  Db3 = kv_db:delete(number, Db2),
  ?_assertEqual([{color, "red"}], Db3).
