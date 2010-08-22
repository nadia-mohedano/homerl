-module(homerl_parser_husman).

-export([parse/1]).


parse({ok, {_, _, Html}}) ->
    Rooms = parse_rooms(Html),
    Sqm = parse_sqm(Html),
    RefNr = parse_refnr(Html),
    Price = parse_price(Html),
    {Rooms, Sqm, RefNr, Price}.
    
parse_rooms(Html) ->
    {Pos, Len} = run_regexp(Html, "<th>Rum:</th><td>([0-9])</td>"),
    list_to_integer(string:substr(Html, Pos + 1, Len)).

parse_sqm(Html) ->    
    {Pos, Len} = run_regexp(Html, "<th>Boarea:</th><td>(.*)</td>"),
    list_to_integer(get_numeric_characters(string:substr(Html, Pos + 1, Len))).
    
parse_refnr(Html) ->
    {Pos, Len} = run_regexp(Html, "<th>Ref.nr:</th><td>([0-9]*)</td>"),
    string:substr(Html, Pos + 1, Len).

parse_price(Html) ->
    {Pos, Len} = run_regexp(Html, "<th>Pris:</th><td>(.*)</td>"),
    list_to_integer(get_numeric_characters(string:substr(Html, Pos + 1, Len))).

run_regexp(Str, RegExp) ->
    {match, [_, {Pos, Len}]} = re:run(Str, RegExp),
    {Pos, Len}.

get_numeric_characters(Str) ->
    [X || X <- Str, X >= $0, X =< $9].
