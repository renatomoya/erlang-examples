-module(kv_db).

-type db() :: [].
-type results() :: nonempty_list({Key::atom(), Value::term()}).
-type err() :: {'error', string()}.

-export_type([db/0, results/0, err/0]).

% -spec new() -> db().

% -spec put(Key::atom(), Value::term(), Db::db()) -> results() | err().

% -spec get(Key::atom(), Db::db()) -> term() | err().

% -spec delete(Key::atom(), Db::db()) -> (results() | nil()) | err().
