-module(solution).
-export([main/0]).

main() ->
    

    { ok, [N,K,Q]} = io:fread("", "~d~d~d"),
    A = read_array(N),
    M =  read_array(Q),
    io:format("~p|~p|~p~n",[N,K,Q]),
    io:format("~p~n",[A]),
    io:format("~p~n",[M]).

% change to use of tuples 
read_array(0) -> [];
read_array(N) -> 
   {ok, [X]} = io:fread("", "~d"),
   [X | read_array(N-1)].
