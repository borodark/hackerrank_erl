-module(solution).
-export([main/0]).

main() ->

    { ok, [N,K]} = io:fread("", "~d~d"), % N - array size, 
    A = read_array(N,[]),
    RemoveDups = fun Remove_dups([]) -> []; Remove_dups([H|T]) -> [H | [X || X <- Remove_dups(T), X /= H]] end, 
    NonDivisibleSubset = RemoveDups([X|| X <- A, Y <- A, X/=Y, (X+Y) rem K =/= 0]),
    ok = io:format("~p~n", [length(NonDivisibleSubset)]),
    erlang:halt().
    
read_array(0,Rc) -> lists:reverse(Rc);
read_array(N,Rc) -> 
   {ok, [X]} = io:fread("", "~d"),
   read_array(N-1, [X | Rc]).