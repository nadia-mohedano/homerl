-module(homerl_fetcher).

-export([read_website/2]).


read_website(Mod, Url) ->
    Html = httpc:request(Url),
    Mod:parse(Html).
