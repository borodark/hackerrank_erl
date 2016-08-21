-module(solution).
-export([main/0]).

main() ->

    { ok, [T1,T2, Tn]} = io:fread("", "~d~d~d"), % N - array size, 
    FiboTn = %fib_rec_naive(Tn),%
    fib_arith(Tn, T1,T2),
    ok = io:format("~p~n",[FiboTn]),
    erlang:halt().
    


%%-----------------------------------------------------------------------------
%% Naive tail-recursive.
%%-----------------------------------------------------------------------------
fib_rec_naive(0) -> %io:format("~p~n",[0]), 
    0;
fib_rec_naive(1) -> %io:format("~p~n",[1]), 
    1;
fib_rec_naive(N) -> Rc = fib_rec_naive(N - 1) + fib_rec_naive(N - 2),
		%	io:format("~p~n",[Rc]), 
		    Rc .


%%-----------------------------------------------------------------------------
%% Minimal arithmetic.
%% Credit: richcarl (Richard Carlsson)
%%-----------------------------------------------------------------------------
%fib_arith(, 0, 1) when N > 0 -> fib_arith(N, 0, 0).

%fib_arith(N, 0, 1) when N > 0 -> fib_arith(N, 0, 1);


fib_arith(1, F1, _F2) -> F1;
fib_arith(N, F1,  F2) -> %ok = io:format("~p ~p ~p~n", [N, F1 , F2]),
    fib_arith(N - 1, F2, F1 + F2*F2).
			 
			 
