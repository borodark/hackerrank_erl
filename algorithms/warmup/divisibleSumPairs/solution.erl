-module(solution).
-export([main/0]).

main() ->

    { ok, [N,K]} = io:fread("", "~d~d"), % N - array size, 
    DivisibleSumPairs = fun F([],_,Rc) -> Rc;  
			    F(Array,Divisor,Rc) -> [H|T] = Array, F(T,K,Rc+length([ X || X <-T, (H + X) rem Divisor =:=0])) end ,
    A = read_array(N,[]), 
    ok = io:format("~p~n", [DivisibleSumPairs(A,K,0)]).
    
read_array(0,Rc) -> lists:reverse(Rc);
read_array(N,Rc) -> 
   {ok, [X]} = io:fread("", "~d"),
   read_array(N-1, [X | Rc]).
