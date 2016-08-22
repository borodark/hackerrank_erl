% Non Divisable subsets
-module(solution).
-export([main/0]).

main() ->

    { ok, [_,K]} = io:fread("", "~d~d"), % N - array size, 
    ToBe = io:get_line(""),
    Tokens = string:tokens(ToBe," \n"),
    A = lists:map( fun(X) -> list_to_integer(X) end, Tokens), 
    Result = select(K,A,[]),
    ok = io:format("~p~n", [length(Result)])
    , erlang:halt()
.
    
select(_,[],Rc ) -> Rc; % if no elements left to go - return Accumulator 
select(K,ListToGo, Rc) ->
    [Head|Tail] = ListToGo,
 % ok = io:format("~p",[Tail]),
 % return list of those garantied not to be devisable by K if added to Head
 % add Head to the Rc as safe to be added to the one left to go 
 % eventualy 
 select(K,[X || X <- Tail, (X + Head) rem K > 0, X =/= Head], [Head|Rc]).
  % returns empty list if Head is divisable - safe to add to Rc?
