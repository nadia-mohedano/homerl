-module(homerl_parser_husman).

-export([parse/2]).

parse(Url, Areas) ->
    io:format("parse started~n"),
    lists:flatten(parse(Url, Areas, [])).

parse(Url, [{Area, Code} | T], Acc) ->
    io:format("~p ~p~n", [Area, Code]),
    AreaHtml = homerl_fetcher:get_html(
		 Url ++ "Sok-objekt/?firmanr=" ++ Code ++ "&page=1"),
    {match, ObjektPos} = 
	re:run(AreaHtml, "/Objekt/\\?objectid\\=OBJ[0-9]*\\_[0-9]*", [global]),
    Apartments = [parse_apartment(
		    homerl_fetcher:get_html(
		      Url ++ string:substr(AreaHtml, Pos + 1, Len)),
		    Area, Code) || [{Pos, Len}] <- ObjektPos],
    parse(Url, T, [Apartments | Acc]);
parse(_Url, [], Acc) ->
    Acc.

parse_apartment(Html, Area, Code) ->
    io:format("~p ~p ", [Area, Code]),
    Rooms = parse_field(Html, "<th>Rum:</th><td>(.*)</td>", [$.]),
    Sqm = parse_field(Html, "<th>Boarea:</th><td>(.*)</td>", [$.]),
    RefNr = parse_field(Html, "<th>Ref.nr:</th><td>([0-9]*)</td>", []),
    Price = parse_field(Html, "<th>Pris:</th><td>(.*)</td>", []),
    io:format("~p ~p ~p ~p ~n~n", [Rooms, Sqm, RefNr, Price]),
    {Area, Code, Rooms, Sqm, RefNr, Price}.
    
parse_field(Html, RegExp, XtraChars) ->
    case run_regexp(Html, RegExp) of
	{Pos, Len} ->
	    to_int_or_float(get_numeric_characters(
			      string:substr(Html, Pos + 1, Len), XtraChars));
	nomatch -> 
	    no_info
    end.

run_regexp(Str, RegExp) ->
    case re:run(Str, RegExp) of
	{match, [_, {Pos, Len}]} -> {Pos, Len};
	nomatch -> nomatch
    end.

get_numeric_characters(Str0, XtraChars) ->
    Str = replace_commas_with_dots(Str0),
    AllowedChars = XtraChars ++ lists:seq($0, $9),
    [X || X <- Str, lists:member(X, AllowedChars)].

replace_commas_with_dots(Str) ->
    lists:reverse(replace_commas_with_dots(Str, [])).
replace_commas_with_dots([$,|T], Acc) ->
    replace_commas_with_dots(T, [$.|Acc]);
replace_commas_with_dots([Ch|T], Acc) ->
    replace_commas_with_dots(T, [Ch|Acc]);
replace_commas_with_dots([], Acc) ->
    Acc.

to_int_or_float(Str) ->
    try list_to_integer(Str)
    catch 
	_:_ -> list_to_float(Str)
    end.
	     
