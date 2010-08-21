%% @author Nadia Mohedano Troyano <nadiamt@gmail.com>
%% @copyright 2010 Nadia Mohedano Troyano

%% @doc Callbacks for the homerl application.

-module(homerl_app).
-behaviour(application).

-export([start/2, stop/1]).

-include("homerl.hrl").

start(_, _) ->
    homerl_sup:start_link().

stop(_) ->
    ok.
