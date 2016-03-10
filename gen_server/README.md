# gen_server

## Example 1: Key-Value In-Memory database

This example wraps a in-memory key-value database module (`kv_db`) in a `gen_server` module (`kv_db_server`) and provides a public interface so you can interact with the database state.

```
$ cd gen_server/kv_db_server && erl
Erlang/OTP 18 [erts-7.2.1] [source] [64-bit] [smp:8:8] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]

Eshell V7.2.1  (abort with ^G)
1> c(kv_db).
{ok,kv_db}
2> c(kv_db_server).
{ok,kv_db_server}
3> kv_db_server:start().
{ok,<0.45.0>}
4> kv_db_server:put(color, "red").
[{color,"red"}]
5> kv_db_server:put(my_list, [1,2,3]).
[{color,"red"},{my_list,[1,2,3]}]
6> kv_db_server:get(color).
"red"
7> kv_db_server:delete(my_list).
[{color,"red"}]
8> kv_db_server:ls().
[{color,"red"}]
```
