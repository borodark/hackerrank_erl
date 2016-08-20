-module(solution).
-export([main/0]).

main() ->
    
    { ok, [N,K,Q]} = io:fread("", "~d~d~d"), % N - array size, 
					     % K - number of elements to rotate, 
					     % Q - number of indexes in output
 %io:format("Starting! ~p ~n",[calendar:local_time()]),    
    A = read_array(N,[]), % read array to be rotated 
  %  io:format("Array Read! ~p ~n",[A]),
   % io:format("Array Read! ~p ~n",[calendar:local_time()]),
    M =  read_array(Q,[]), % read the indexes of elements of rotated array to be displayed in output
   % io:format("Read done! ~p ~n",[calendar:local_time()]),

  % Rotate array K times   
  % just split K elements from tail and move to head
    {Head,Tail} = lists:split(N-K, A),
    % io:format("Split Done! ~p ~n",[calendar:local_time()]),
    Rotated = lists:flatten([Tail|Head]),
    % io:format("Join + flatten Done!  ~p ~n",[calendar:local_time()]),
    % take index values from M list and print element at index from Rotated   
    % remember list indexed form 1 in erlang so use lists:nths(M[i] + 1) 
    [ok = io:format("~p~n",[lists:nth(X+1,Rotated)])|| X <- M ]
    % io:format("~p|~p|~p~n",[N,K,Q]),
    % io:format("~p~n",[A]),
    % io:format("~p~n",[M]),
    % , io:format("~p~n",[Rotated])
, erlang:halt().

 
read_array(0,Rc) -> lists:reverse(Rc);
read_array(N,Rc) -> 
   {ok, [X]} = io:fread("", "~d"),
   read_array(N-1, [X | Rc]).
