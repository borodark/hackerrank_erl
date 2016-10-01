% Find the maximum total from top to bottom in triangle.txt 
% (right click and 'Save Link/Target As...'), a 
% 15K text file containing a triangle with one-hundred rows.
-module(solution).
-export([main/0]).

main() ->

    Triangle = readLines(io:get_line(""),[]),
    
    ok = io:format("There are ~p lines in File~n", [length(Triangle)]),
    ok = io:format("~w~n", [Triangle]),
    erlang:halt().

readLines(eof, Triangle) -> %lists:reverse(Triangle);
    Triangle;
readLines(Line, Triangle) ->

    Tokens = string:tokens(Line," \n"),
    NumbersList = lists:map( fun(X) -> list_to_integer(X) end, Tokens), 
%    io:format("~p~n",[NumbersList]),
    readLines(io:get_line(""),
	     [NumbersList|Triangle]
	    ).

