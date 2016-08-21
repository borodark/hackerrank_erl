% Non Divisable subsets
-module(solution).
-export([main/0]).

main() ->

    { ok, [N,K]} = io:fread("", "~d~d"), % N - array size, 
    ToBe = io:get_line(""),
    Tokens = string:tokens(ToBe," \n"),
    A = lists:map( fun(X) -> list_to_integer(X) end, Tokens), 
    ok = io:format("~p~n", [A]),

    NonDivisibleSubset = [X|| X <- A, X =/= Arg ],
    ok = io:format("~p~n", [NonDivisibleSubset]),
    erlang:halt().
    
%read_array(0,Rc) -> lists:reverse(Rc);
%read_array(N,Rc) -> 
%   {ok, [X]} = io:fread("", "~d"),
%   read_array(N-1, [X | Rc]).
