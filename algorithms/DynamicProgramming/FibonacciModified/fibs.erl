%%%----------------------------------------------------------------------------
%%% $ erl -noshell -s fibs main 40
%%% TRANSLATED ARRAY:    102334155   0.001755 seconds
%%% TRANSLATED LIST:     102334155   0.000048 seconds
%%% REVERSE ORDER LIST:  102334155   0.000004 seconds
%%% MINIMAL ARITHMETIC:  102334155   0.000001 seconds
%%% NAIVE RECURSIVE:     102334155   8.383385 seconds
%%%----------------------------------------------------------------------------


-module(fibs).
-export([main/1]).


main([Arg|_]) ->
    N = list_to_integer(atom_to_list(Arg)),
    MainPid = self(),
    FibFuns = [
        fun() -> {'NAIVE RECURSIVE',    fib_rec_naive(N)} end,
        fun() -> {'TRANSLATED ARRAY',   fib_arr(N)} end,
        fun() -> {'TRANSLATED LIST',    fib_list_naive(N)} end,
        fun() -> {'REVERSE ORDER LIST', fib_list(N)} end,
        fun() -> {'MINIMAL ARITHMETIC', fib_arith(N)} end
    ],

    lists:foreach(
        fun(FibFun) ->
            spawn(
                fun() ->
                    TBeg = now(),
                    {Type, Fib} = FibFun(),
                    TEnd = now(),
                    TDiff = (timer:now_diff(TEnd, TBeg) / 1000000),
                    IoList = [Type, Fib, TDiff],
                    io:format("~s: \t ~b \t ~f seconds ~n", IoList),
                    MainPid ! done
                end
            )
        end,
        FibFuns
    ),

    wait_n_halt(length(FibFuns)).


%%-----------------------------------------------------------------------------
wait_n_halt(0) -> halt();
wait_n_halt(N) ->
    receive
        done -> wait_n_halt(N - 1)
    end.


%%-----------------------------------------------------------------------------
%% Naive tail-recursive.
%%-----------------------------------------------------------------------------
fib_rec_naive(0) -> 0;
fib_rec_naive(1) -> 1;
fib_rec_naive(N) -> fib_rec_naive(N - 1) * fib_rec_naive(N - 1) + fib_rec_naive(N - 2).


%%-----------------------------------------------------------------------------
%% Naive translation of mutable array-style.
%%-----------------------------------------------------------------------------
fib_arr(0) -> 0;
fib_arr(1) -> 1;
fib_arr(N) ->
    Begin = 0,
    End = N + 1,
    fib_arr(N, End, 2, array:from_list(lists:seq(Begin, End))).

fib_arr(N, End, I, Fibs) when I == End -> array:get(N, Fibs);
fib_arr(N, End, I, Fibs) ->
    Fib = array:get(I-1, Fibs) + array:get(I-2, Fibs),
    fib_arr(N, End, I+1, array:set(I, Fib, Fibs)).


%%-----------------------------------------------------------------------------
%% Naive translation of mutable array-style, but using list structure.
%%-----------------------------------------------------------------------------
fib_list_naive(0) -> 0;
fib_list_naive(1) -> 1;
fib_list_naive(N) ->
    fib_list_naive(N + 2, 3, [0, 1]).

fib_list_naive(End, I, Fibs) when I == End -> lists:last(Fibs);
fib_list_naive(End, I, Fibs) ->
    Fib = lists:nth(I-1, Fibs) + lists:nth(I-2, Fibs),
    fib_list_naive(End, I+1, Fibs++[Fib]).


%%-----------------------------------------------------------------------------
%% Idiomatic use of the list (in reverse order).
%% Credit: yrashk (Yurii Rashkovskii)
%%-----------------------------------------------------------------------------
fib_list(0) -> 0;
fib_list(1) -> 1;
fib_list(N) ->
    fib_list(N + 1, [1,0]).

fib_list(End, [H|_]=L) when length(L) == End -> H;
fib_list(End, [A,B|_]=L) ->
    fib_list(End, [A+B|L]).


%%-----------------------------------------------------------------------------
%% Minimal arithmetic.
%% Credit: richcarl (Richard Carlsson)
%%-----------------------------------------------------------------------------
fib_arith(N) when N > 0 -> fib_arith(N, 0, 1).

fib_arith(0, F1, _F2) -> F1;
fib_arith(N, F1,  F2) -> fib_arith(N - 1, F2, F1 + F2*F2).
