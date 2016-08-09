-module(solution).
-export([main/0]).

main() ->

    { ok, [N]} = io:fread("", "~d"),
    %io:format("N is ~p~n",[N]),
    NbyNMatrix = read_2darray(N,N,"~d"), % io:format("~p~n",A).
    Rc = calculateAbsoluteDifferenceofDiagonals(N,NbyNMatrix,[0,0],N),
    io:format("~p~n",[Rc]).

calculateAbsoluteDifferenceofDiagonals(0,_,[PrS,SecS],_) -> abs(PrS - SecS);

calculateAbsoluteDifferenceofDiagonals(CurrentRowIndex, Matrix,Accumulator,MxSize) -> 
    % Process a row, receive new values of accumulators
    % recurcive call with decreased current row index while adding received values to accumulator  
    CurrentRow = lists:nth(MxSize - CurrentRowIndex + 1, Matrix),
    [P,S] = processCurrentRow(CurrentRowIndex,CurrentRow,Accumulator,MxSize),
    % print debug
    % io:format("P and S  are ~p ~p ~n",[P,S]),
    calculateAbsoluteDifferenceofDiagonals(CurrentRowIndex - 1, Matrix,[P,S],MxSize). 
    

processCurrentRow(CurrentIndex, CurrentRow, [PrS,SecS], MatrixSize) ->
    SecDiagonalElement = lists:nth(CurrentIndex, CurrentRow),    
    PrimaryDiagonalElement = lists:nth(MatrixSize - CurrentIndex +1, CurrentRow),
    [PrS + PrimaryDiagonalElement , SecS + SecDiagonalElement].

% change to use of tuples 
read_array(0,_) -> [];
read_array(N,D) -> 
   {ok, [X]} = io:fread("", D),
   [X | read_array(N-1,D)], .

read_2darray(0,_,_) -> [];
read_2darray(N,M,D) ->
   Q=read_array(M,D),
   [Q | read_2darray(N-1,M,D)].

