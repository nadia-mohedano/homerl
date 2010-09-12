%%% @author Nadia Mohedano Troyano <nadiamt@gmail.com>
%%% @copyright (C) 2010, Nadia Mohedano Troyano

-module(homerl_server).

-behaviour(gen_server).

%% API
-export([read_websites/0
	]).

%% gen_server callbacks
-export([start_link/0, init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

-include_lib("../include/homerl.hrl").

-define(SERVER, ?MODULE).

-record(state, {}).


start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

read_websites() ->
    gen_server:call(?SERVER, read_websites, infinity).

    

%%====================================================================
%% gen_server callbacks
%%====================================================================
init([]) ->
    {ok, #state{}}.

handle_call(read_websites, _From, State) ->
    do_read_websites(State);
handle_call(_Request, _From, State) ->
    {reply, error, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.


%%%===================================================================
%%% Internal functions
%%%===================================================================
do_read_websites(State) ->
    Res = [Mod:parse(Uri, Areas) || 
	      {Mod, Uri, Areas} <- homerl_app:get_env(websites, [])],
    {reply, Res, State}.
