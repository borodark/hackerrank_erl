% Non Divisable subsets
-module(solution).
-export([main/0]).

main() ->

    { ok, [_,K]} = io:fread("", "~d~d"), % N - array size, 
    ToBe = io:get_line(""),
    Tokens = string:tokens(ToBe," \n"),
    A = lists:map( fun(X) -> list_to_integer(X) end, Tokens), 
    Result = select(K,A,[]),
    ok = io:format("~p~n", [length(Result)]),
    % ok = io:format("~p~n", [Result])
   erlang:halt().

select(_,[],Rc ) -> Rc; % if no elements left to go - return Accumulator 
select(K,[Head|Tail], Rc) ->
 % return list of those garantied not to be devisable by K if added to Head
 % add Head to the Rc as safe to be added to the one left to go 
 % eventualy
 RejectedByHead = [X || X <- Tail, (X + Head) rem K =:= 0, X /= Head],
 % check if rejected is to keep - 
 Left = [X || X <- Tail, (X + Head) rem K /= 0, X /= Head],
 % returns empty list if Head is divisable to all elements
 % hence if Left is empty the Head not to be added
 RejectedFromLeft = [X || X <- Left, Y <- RejectedByHead, (X + Y) rem K =:= 0, X /= Y],

 ok = io:format("RejectedByHead -> ~p~n", [RejectedByHead]),   
 ok = io:format("RejectedFromLeft -> ~p~n", [RejectedFromLeft]),   
 ok = io:format("Left -> ~p~n", [Left]),
 ok = io:format("Head -> ~p~n", [Head]),
 ok = io:format("Rc -> ~p~n", [Rc]),
 {LeftToProcess, SafeToAdd} = decide(RejectedFromLeft,RejectedByHead,Head,Left),
 select(K,LeftToProcess,lists:flatten([SafeToAdd|Rc])).
 % 
% the simplest case - the Head is ok with Left
% RejectedFromLeft,RejectedByHead are empty 
decide([],[],Head,Left) -> {Left,Head};
% if rejected from Left if empty means Head has to be rejected
% Rejected By Head added to Rc -  
decide([],RejectedByHead,_,Left) -> {Left,RejectedByHead};
% what if rejected From Left is not empty ? 
decide(RejectedFromLeft,RejectedByHead,Head,Left) -> {Left,Head}.
