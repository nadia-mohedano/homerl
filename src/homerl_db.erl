%% @author Nadia Mohedano Troyano <nadiamt@gmail.com>
%% @copyright 2010 Nadia Mohedano Troyano

-module(homerl_db.erl).

%-include_lib("../include/homerl.hrl").

-export([init/2, 
	 write_apartment/2, 
	 read_apartment/2, 
	 delete_apartment/2
	]).

init(Table, []) ->
    dets:open_file(Table, []).    

write_apartment(Table, Data) ->
    dets:insert(Table, Data).

read_apartment(Id, Table) ->
    dets:lookup(Table, Id).

delete_apartment(Table, Id) ->
    dets:delete(Table, Id).






