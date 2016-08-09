-module(solution).
-export([main/0]).

main() ->

    { ok, [N]} = io:fread("", "~d"),
    Arr = read_array(N),
    Pos = (length([ X || X <- Arr, X > 0]) + 0.0)/(N+0.0),
    Neg = (length([ X || X <- Arr, X < 0]) + 0.0)/(N+0.0),
    Zeros = (length([ X || X <- Arr, X =:= 0]) + 0.0)/(N+0.0),
    io:format("~f~n",[Pos]),
    io:format("~f~n",[Neg]),
    io:format("~f~n",[Zeros]).

read_array(0) -> [];
read_array(N) -> 
   {ok, [X]} = io:fread("","~d"),
   [X | read_array(N-1)].
