-module(homerl_fetcher).

-export([get_html/1]).


get_html(Url) ->
    {ok, {_, _, Html}} = httpc:request(Url),
    Html.

