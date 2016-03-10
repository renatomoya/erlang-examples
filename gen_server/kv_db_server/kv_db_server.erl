-module(kv_db_server).
-behaviour(gen_server).

-export([start_link/0, init/1, handle_call/3, handle_cast/2,
         handle_info/2, terminate/2, code_change/3]).
-export([put/2, get/1, delete/1, ls/0]).

% public functions

-spec put(atom(), term()) -> [{atom(), term()},...].
put(Key, Value) ->
  gen_server:call(?MODULE, {put, Key, Value}).

-spec get(atom()) -> term() | {'error', string()}.
get(Key) ->
  gen_server:call(?MODULE, {get, Key}).

-spec delete(atom()) -> [{atom(), term()},...] | nil() | {'error', string()}.
delete(Key) ->
  gen_server:call(?MODULE, {delete, Key}).

-spec ls() -> [{atom(), term()},...] | nil().
ls() ->
  gen_server:call(?MODULE, ls).

% server callbacks

start_link() ->
  gen_server:start_link({local, kv_db_server}, ?MODULE, [], []).

init(_Args) ->
  {ok, kv_db:new()}.

handle_call({put, Key, Value}, _From, State) ->
  NewState = kv_db:put(Key, Value, State),
  {reply, NewState, NewState};
handle_call({get, Key}, _From, State) ->
  {reply, kv_db:get(Key, State), State};
handle_call({delete, Key}, _From, State) ->
  NewState = kv_db:delete(Key, State),
  {reply, NewState, NewState};
handle_call(ls, _From, State) ->
  {reply, State, State}.

handle_cast(_Request, State) ->
  {noreply, State}.

handle_info(_Info, State) ->
  {noreply, State}.

terminate(_Reason, _State) ->
  ok.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.
