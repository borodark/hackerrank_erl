-module(solution).
-export([main/0]).

main() ->
    
    { ok, [N,K,Q]} = io:fread("", "~d~d~d"), % N - array size, 
					     % K - number of elements to rotate, 
					     % Q - number of indexes in output
    A = read_array(N), % read array to be rotated 
    M =  read_array(Q), % read the indexes of elements of rotated array to be displayed in output
  % Rotate array K times   
  % just split K elements from tail and move to head
    {Head,Tail} = lists:split(N-K, A),
    Rotated = lists:flatten([Tail|Head]),
    % take index values from M list and print element at index from Rotated   
    % remember list indexed form 1 in erlang so use lists:nths(M[i] + 1) 
    [ok = io:format("~p~n",[lists:nth(X+1,Rotated)])|| X <- M ]
    % io:format("~p|~p|~p~n",[N,K,Q]),
    % io:format("~p~n",[A]),
    % io:format("~p~n",[M]),
    % , io:format("~p~n",[Rotated])
.

 
read_array(0) -> [];
read_array(N) -> 
   {ok, [X]} = io:fread("", "~d"),
   [X | read_array(N-1)].
