%% @author Nadia Mohedano Troyano <nadiamt@gmail.com>
%% @copyright 2010 Nadia Mohedano Troyano

-module(homerl_db.erl).

-include_lib("../include/homerl.hrl").

-export([init/0, 
	 write_apartment/1, 
	 read_apartment/1, 
	 delete_apartment/1
	]).

init() ->
    dets:open_file(?TABLE, []).    

write_apartment(Data) ->
    dets:insert(?TABLE, Data).

read_apartment(Id) ->
    dets:lookup(?TABLE, Id).

delete_apartment(Id) ->
    dets:delete(?TABLE, Id).






